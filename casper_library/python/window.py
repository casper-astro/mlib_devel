from math import sin, cos, pi

# These window functions duplicated from numpy, because
# importing numpy here breaks MATLAB ?!?

def hanning(M):
  if M < 1:
    return []
  if M == 1:
    return [1.0]
  nlist = range(0, M)
  return [(0.5 - 0.5*cos(2.0*pi*n/(M-1))) for n in nlist]

def blackman(M):
  if M < 1:
    return []
  if M == 1:
    return [1.0]
  nlist = range(0, M)
  return [(0.42 - 0.5*cos(2.0*pi*n/(M-1)) + 0.08*cos(4.0*pi*n/(M-1))) for n in nlist]

def hamming(M):
  if M < 1:
    return []
  if M == 1:
    return [1.0]
  nlist = range(0, M)
  return [(0.54 - 0.46*cos(2.0*pi*n/(M-1))) for n in nlist]

def window(wintype, N):
  """
  Try to replicate MATLAB's `window` function.
  Inputs:
    wintype (string) : window type, eg. "hann", "hamming", etc
    N (int)          : Number of window points requested
  This function will try to call numpy.`wintype`(N) to generate the
  desired window.
  """
  # Remap names where we know MATLAB and numpy differ
  # map is {MATLAB name : numpy name}
  remap = {
    "hann" : "hanning",
  }
  wintype = remap.get(wintype, wintype)
  try:
    winmethod = globals()[wintype]
  except KeyError:
    raise RuntimeError("Couldn't find window method '%s'" % wintype)
    return
  #try:
  #  winmethod = getattr(numpy, wintype)
  #except AttributeError:
  #  print("Couldn't find window method numpy.%s" % wintype)
  #  return
  if callable(winmethod):
    return winmethod(N)
  else:
    raise RuntimeError("Attribute numpy.%s is not callable" % wintype)
    return

def sinc(xlist):
  if not isinstance(xlist, list):
      return sinc([xlist])[0]
  rv = []
  for x in xlist:
    try:
      rv += [sin(pi*x) / (pi*x)]
    except ZeroDivisionError:
      rv += [1.0]
  return rv
