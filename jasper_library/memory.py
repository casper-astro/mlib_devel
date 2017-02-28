class Register(object):
    def __init__(self, name, nbytes=4, offset=0, mode='r'):
        self.name = name
        self.nbytes = nbytes
        self.offset = offset
        self.mode = mode
