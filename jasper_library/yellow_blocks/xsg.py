from .yellow_block import YellowBlock

class xsg(YellowBlock):
    """
    An xsg YellowBlock class, representing a CASPER "platform" block. I.e., the block
    which specifies which platform you are compiling for, and which clock (or other)
    compile-time settings you want to use.

    Uses 2 attributes from the front end block configuration (in addition to the "platform"
    attribute which all YellowBlocks have access to):
    "clk_rate" (float): The clock rate, in MHz, the compile is targeting for the DSP pipeline.
    "clk_src" (string): The clock source (eg. "sys_clk", "adc0_clk", etc.) used to run the DSP pipeline.

    This block is a little unlike other YellowBlocks -- it has 3 jobs:

    1) Add a requirement -- "self.requires.append(...)" -- for a block in the design to provide
       -- "self.provides.append(...)" -- four clock phases:
           self.clk_src
           self.clk_src + "90"
           self.clk_src + "180"
           self.clk_src + "270"
       Probably, these clocks will be provided by the platform-specific block instantiated as a child
       of this block (see 3. below). Whichever block provides them must create signals with these names
       in the top-level verilog.

    2) Create wires in the top-level verilog desing, and assign the above clock signals to the new names:
       "user_clk"
       "user_clk90"
       "user_clk180"
       "user_clk270"
       This allows modules in the design to use these clock names, without requiring any knowledge about
       where they are coming from (eg. sys_clk, an ADC clock, etc).
       NOTE: Since this block instantiates clocks with these names, you MUST NOT use user_clkX signals
       elsewhere in your design.

    3) Instantiate a child YellowBlock, with identical parameters to this block, but with the class name
       self.platform.name.
       This is probably the instance you want to use to generate your custom clocks (eg, sys_clk, sys_clk90, ...),
       so this block should add these signals to top-level verilog, and also "provide" them using the
       YellowBlock.provides mechanism.

    """
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
