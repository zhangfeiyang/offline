import types

class TestConfig:

  defaults = {
               'verbose' : False,
               'genLog' : False,
               'logFileName' : None,
               'maxTime' : None,
               'maxVIR' : None,
               'parser' : True,
               'CPUMonitor' : False,
               'RESMonitor' : False,
               'VIRMonitor' : False,
               'timeInterval' : 0.5,
               'shell' : True,
               'fatalPattern' : None,
               'plotRef' : None,
               'cmpOutput' : 'plotcmp.root',
               'histTestMeth' : 'Kolmogorov',
               'histTestCut' : 0.9
             }

  def __init__(self):
    self.config = dict([(k,v) for (k,v) in TestConfig.defaults.items()])

  def update(self, **kwa):
    self.config.update(kwa)

  def setAttr(self, name, value):
    assert type(name) == types.StringType, "ERROR: attribute must be of String type!"
    self.config[name] = value

  def getAttr(self, name):
    if self.config.has_key(name):
      return self.config[name]
    return None
