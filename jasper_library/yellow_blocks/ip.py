from yellow_block import YellowBlock

class ip(YellowBlock):
    def initialize(self):
        self.ips = [{'path':self.lib_path, 
                     'name':self.ip_name,
                     'module_name':self.ip_name+'_ip',
                     'vendor':'User_Company',
                     'library':'SysGen',
                     'version':'1.0',
                     }]
        
