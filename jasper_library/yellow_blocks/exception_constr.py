from .yellow_block import YellowBlock
import logging

from constraints import RawConstraint

class exception_constr(YellowBlock):
    """

    """

    def gen_constraints(self):

        const = []
        # For some reason, self.fullpath != self.blk['fullpath']
        # when YellowBlock.gen_constraints is called from toolflow.generate_consts
        modelname = self.blk['fullpath'].split('/', 1)[0]
        parent_cell = '{0}_inst/{0}_struct'.format(modelname)
        get_exception_constr_net = 'get_nets -of_objects [get_cells {}/*] ' \
                                    '-filter {{NAME =~ *{}*}}'.format(parent_cell, self.name)

        # Creating RawConstraint as the syntax will specify *through* the YellowBlock's net
        # rather than a source and destination
        if self.constraint_type == 'False Path Constraint':
            set_false_path_constraint_str = 'set_false_path ' \
                                '-through [{}]'.format(get_exception_constr_net)

            const.append(RawConstraint(set_false_path_constraint_str))
        elif self.constraint_type == 'Multicycle Constraint':
            multicycle_setup_constraint_str = 'set_multicycle_path -setup -through ' \
                                    '[{}] {}'.format(get_exception_constr_net, self.num_clock_cycles)
            
            multicycle_hold_constraint_str = 'set_multicycle_path -hold -through ' \
                                    '[{}] {}'.format(get_exception_constr_net, (self.num_clock_cycles-1))

            const.append(RawConstraint(multicycle_setup_constraint_str))
            const.append(RawConstraint(multicycle_hold_constraint_str))

        return const
        

    
