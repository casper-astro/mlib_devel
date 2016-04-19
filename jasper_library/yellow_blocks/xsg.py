from yellow_block import YellowBlock

class xsg(YellowBlock):
    def initialize(self):
        '''
        Things the toolflow has to know. eg, clocks needed/provided
        '''
        self.requires.append(self.clk_src) #we need something to provide the clock we plan to use
        self.requires.append(self.clk_src+'90')
        self.requires.append(self.clk_src+'180')
        self.requires.append(self.clk_src+'270')

        self.provides.append('user_clk')
        self.provides.append('user_clk90')
        self.provides.append('user_clk180')
        self.provides.append('user_clk270')

    def modify_top(self,top):
        top.add_signal('user_clk')
        top.add_signal('user_clk90')
        top.add_signal('user_clk180')
        top.add_signal('user_clk270')
        top.assign_signal('user_clk',   self.clk_src)
        top.assign_signal('user_clk90', self.clk_src+'90')
        top.assign_signal('user_clk180',self.clk_src+'180')
        top.assign_signal('user_clk270',self.clk_src+'270')
        
