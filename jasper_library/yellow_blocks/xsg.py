from yellow_block import YellowBlock

class xsg(YellowBlock):
    def initialize(self):
        '''
        Things the toolflow has to know. eg, clocks needed/provided
        '''
        self.platform.user_clk_rate = self.clk_rate
        if self.platform.name == 'skarab':
            self.requires.append(self.clk_src)  # we need something to provide the clock we plan to use
            self.provides.append('user_clk')
        else:
            self.requires.append(self.clk_src)
            self.requires.append(self.clk_src+'90')
            self.requires.append(self.clk_src+'180')
            self.requires.append(self.clk_src+'270')

            self.provides.append('user_clk')
            self.provides.append('user_clk90')
            self.provides.append('user_clk180')
            self.provides.append('user_clk270')

    def gen_children(self):
        this_block_params = self.blk.copy()
        this_block_params['tag'] = 'xps:'+self.platform.name
        return [YellowBlock.make_block(this_block_params, self.platform)]

    def modify_top(self,top):
        if self.platform.name == 'skarab':
            top.add_signal('user_clk')
            top.assign_signal('user_clk', self.clk_src)
        else:
            top.add_signal('user_clk')
            top.add_signal('user_clk90')
            top.add_signal('user_clk180')
            top.add_signal('user_clk270')

            top.assign_signal('user_clk',   self.clk_src)
            top.assign_signal('user_clk90', self.clk_src+'90')
            top.assign_signal('user_clk180',self.clk_src+'180')
            top.assign_signal('user_clk270',self.clk_src+'270')
