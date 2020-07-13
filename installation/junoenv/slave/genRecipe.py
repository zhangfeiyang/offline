#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao

class GenRecipe(object):

  def __init__(self):
    self.pkg_to_install = """
       python boost cmake git gccxml xercesc qt4 
       cmt clhep ROOT hepmc geant4
       """.split()
        

  def gen_entity(self, f):
    f.write("""
<!DOCTYPE build [
  <!ENTITY junoenv "JUNOTOP=`pwd` bash junoenv/junoenv" >
  <!ENTITY setuplibs "export JUNOTOP=`pwd`;source bashrc.sh;" >
  <!ENTITY setupcmtlibssrc "source ExternalInterface/EIRelease/cmt/setup.sh;" >
  <!ENTITY setupcmtlibs "&setuplibs; &setupcmtlibssrc;" >
  <!ENTITY setupsnipersrc "source sniper/SniperRelease/cmt/setup.sh;" >
  <!ENTITY setupsniper "&setupcmtlibs; &setupsnipersrc;" >
]>""")

  def gen_header(self, f):
    f.write("""
<build xmlns:python="http://bitten.edgewall.org/tools/python"
       xmlns:svn="http://bitten.edgewall.org/tools/svn"
       xmlns:sh="http://bitten.edgewall.org/tools/sh">
""")

  def gen_tailer(self, f):
    f.write("""
</build>
""")

  def gen_get_junoenv(self, f):
    f.write("""
  <step id="checkout" description="Checkout junoenv from repository">
    <svn:checkout url="http://juno.ihep.ac.cn/svn/offline/trunk/installation/"
        path="${juno.path}" revision="${juno.revision}" />
  </step>
""")

  def gen_junoenv_libs(self, f):
    f.write("""
<!-- External Libraries -->
""")
    for pkg in self.pkg_to_install:
      f.write("""
  <step id="building%(pkg)s" description="Building %(pkg)s">
    <sh:exec 
      executable="bash"
      args=" -c &quot; &junoenv; libs all %(pkg)s &quot; "
      />
  </step>
"""%{"pkg":pkg})

  def gen_junoenv_env(self, f):
    f.write("""
<!-- Env -->
  <step id="createEnv" description="Creating Env" onerror="ignore">
    <sh:exec 
      executable="bash"
      args=" -c &quot; &junoenv; env &quot; "
      />
  </step>
""")

  def gen_junoenv_cmtlibs(self, f):
    f.write("""
<!-- CMT libs -->
  <step id="cmtLibs" description="Install cmtlibs">
    <sh:exec 
      executable="bash"
      args=" -c &quot; &setuplibs; &junoenv; cmtlibs &quot; "
      />
  </step>
""")

  def gen_junoenv_sniper(self, f):
    f.write("""
<!-- Sniper -->
  <step id="sniper" description="download and compile sniper">
    <sh:exec 
      executable="bash"
      args=" -c &quot; &setupcmtlibs; &junoenv; sniper &quot; "
      />
  </step>
""")

  def gen_junoenv_offline(self, f):
    f.write("""
<!-- Offline -->
  <step id="offline" description="download offline">
    <sh:exec 
      executable="bash"
      args=" -c &quot; &setupsniper; &junoenv; offline &quot; "
      />
  </step>
""")

  
  def write(self, fn):
    f = open(fn, "w")

    self.gen_entity(f)
    self.gen_header(f)

    self.gen_get_junoenv(f)
    # external libraries
    self.gen_junoenv_libs(f)
    # env
    self.gen_junoenv_env(f)
    # cmtlibs
    self.gen_junoenv_cmtlibs(f)
    # sniper
    self.gen_junoenv_sniper(f)
    # get offline
    self.gen_junoenv_offline(f)

    self.gen_tailer(f)

    f.close()

if __name__ == "__main__":
  gr = GenRecipe()

  gr.write("my.recipe.xml")
