def to_int_list(str):
    '''
    take a string like '[0,1,2,3]'
    and return a list of integers
    '''
    return map(int,str.rstrip(']').lstrip('[').split(','))

def write_file(fn,str):
    '''
    write string 'str' to filename 'fn'
    '''
    fh = open(fn,'w')
    fh.write(str)
    fh.close()
