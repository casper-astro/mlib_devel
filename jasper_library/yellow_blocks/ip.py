from yellow_block import YellowBlock

class ip(YellowBlock):
    def initialize(self):
        self.ips = [{'path':self.lib_path, 
                     'name':self.ip_name,
                     'vendor':'User_Company',
                     'library':'Sysgen',
                     'version':'1.0',
                     }]
        
