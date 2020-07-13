import types

class ProductionConfig:

  defaults = {
               'verbose' : False,
               'workDir' : None,    # Notes: the final path is:
               'workSubDir' : None, #   topDir / workDir / workSubDir / tag
               'topDir' : None,     #
               'external-input-dir': None, # allow user specify input from other directories
                                           # guess input file in this order:
                                           #  * EID / workDir / workSubDir / tag / detsim / detsim-xxx.root
                                           #  * EID           / workSubDir / tag / detsim / detsim-xxx.root
                                           #  * EID                        / tag / detsim / detsim-xxx.root
                                           #  * EID                              / detsim / detsim-xxx.root
                                           #  *                                    detsim / detsim-xxx.root
                                           #                                      |  this part is default  |
               'maxRetry' : 2,
               'optional' : False, # if optional is True and user don't use it in workflow, this step will be disabled.
               'batchType' : 'condor',
               'condorSched' : 'job@schedd01.ihep.ac.cn',
               'LSFQueue' : 'juno',
               'LSFMemoryLimit': 4000000,
               'benchmark': False,
               'ana' : True,
               'refDir' : None,
               'plotFile' : None,
               'cmpOutput' : None,
               'histTestMeth' : 'Kolmogorov',
               'histTestCut' : 0.9,
               'interval' : 10,
               'fatalPattern' : None,
               'log' : 'log.txt',
               'test' : False, 
               'initFile' : None,
               'temp' : True,
               'ignoreFailure': True,
               'maxTime': -1, # Time limit (s) of batch jobs. Job will be dropped once its running time exceeded. -1 means no limitation.
             }

  def __init__(self):
    self.config = dict([(k,v) for (k,v) in ProductionConfig.defaults.items()])

  def update(self, **kwa):
    self.config.update(kwa)

  def setAttr(self, name, value):
    assert type(name) == types.StringType, "ERROR: attribute must be of String type!"
    self.config[name] = value

  def getAttr(self, name):
    if self.config.has_key(name):
      return self.config[name]
    return None

