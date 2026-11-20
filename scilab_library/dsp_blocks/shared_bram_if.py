from math import log2
from .dsp_block import DSPBlock


class shared_bram_if(DSPBlock):
    # The Simulink logic of the shared_bram yellow block, between the user
    # ports and the jasper bram (see xps_frontend/bram.py). Added by the
    # frontend, not placed by the user. Combinational, as in Simulink:
    #   calc_add:  data_width < 32: the low log2(32/data_width) address bits
    #              become (32/data_width-1) - bits, i.e. they are inverted;
    #              otherwise the address passes through.
    #   munge_in / munge_out: data_width > 32: the 32-bit words of data_in /
    #              data_out in reverse order (munge order [n-1 ... 0]);
    #              otherwise the data passes through.
    # Ports: addr, data_in, we, data_out (user side) and yb_addr, yb_data_in,
    # yb_we, yb_data_out (bram side). A user-side input with no link is tied
    # to 0.

    def initialize(self):
        self.aw = int(float(self.addr_width))
        self.dw = int(float(self.data_width))
        if self.dw > 32 and self.dw % 32:
            raise ValueError('%s: shared BRAM data width %d is not a multiple of 32 '
                             '(the Simulink munge needs whole 32-bit words)' % (self.fullname, self.dw))
        if self.dw < 32 and 32 % self.dw:
            raise ValueError('%s: shared BRAM data width %d does not divide 32' % (self.fullname, self.dw))

    def _connected(self, port):
        sig = self.fullname + '_' + port
        return any(link['dst_blk_name'] == self.unique_name and link['dst_port_name'] == sig
                   for link in self.link_info)

    def _addr_expr(self, sig):
        if self.dw >= 32:
            return sig
        nb = int(log2(32 // self.dw))
        if self.aw <= nb:
            return '~%s' % sig
        return '{%s[%d:%d], ~%s[%d:0]}' % (sig, self.aw - 1, nb, sig, nb - 1)

    def _word_swap_expr(self, sig):
        n = self.dw // 32
        if n <= 1:
            return sig
        return '{%s}' % ', '.join('%s[%d:%d]' % (sig, 32 * k + 31, 32 * k) for k in range(n))

    def modify_top(self, top):
        # the bram-side ports are parent ports (links to / from the bram)
        self._populate_parent_ports(top)
        f = self.fullname
        widths = {'addr': self.aw, 'data_in': self.dw, 'we': 1, 'data_out': self.dw}
        for port, w in widths.items():
            top.add_signal('%s_%s' % (f, port), width=w)
            top.add_signal('%s_yb_%s' % (f, port), width=w)
        for port in ('addr', 'data_in', 'we'):
            if not self._connected(port):
                top.assign_signal('%s_%s' % (f, port), "%d'd0" % widths[port])
        top.assign_signal(f + '_yb_addr', self._addr_expr(f + '_addr'))
        top.assign_signal(f + '_yb_data_in', self._word_swap_expr(f + '_data_in'))
        top.assign_signal(f + '_yb_we', f + '_we')
        top.assign_signal(f + '_data_out', self._word_swap_expr(f + '_yb_data_out'))
