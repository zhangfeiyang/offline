#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao
import Sniper
import Geometry
task = Sniper.Task("rectask")
geom = task.createSvc("RecGeomSvc")
geom.property("GeomFile").set("default")
geom.property("FastInit").set(True)
geom.initialize()

