def to_int_list(s):
    '''
    take a string like '[0,1,2,3]'
    and return a list of integers
    '''
    s = str(s)

    try:
        return map(int,s.rstrip(']').lstrip('[').split(','))
    except ValueError:
        return map(int,s.rstrip(']').lstrip('[').split())

def write_file(fn,str):
    '''
    write string 'str' to filename 'fn'
    '''
    fh = open(fn,'w')
    fh.write(str)
    fh.close()

class SkarabLedError(ValueError):
    pass