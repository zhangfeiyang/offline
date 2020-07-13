#!/bin/bash
source /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/junoenv
source /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/cmt/setup.sh
cd /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/
python /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/tut_detsim.py --no-gdml --evtmax 1000 --seed 10030 --user-output /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/Anchor/K40/evt_10030.root gendecay --nuclear K40 --volume pAnchor
python /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/tut_detsim.py --no-gdml --evtmax 1000 --seed 10030 --user-output /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/Anchor/Th232/evt_10030.root gendecay --nuclear Th232 --volume pAnchor
python /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/tut_detsim.py --no-gdml --evtmax 1000 --seed 10030 --user-output /junofs/production/public/users/zhangfy/offline_bgd/Examples/Tutorial/share/Anchor/U238/evt_10030.root gendecay --nuclear U238 --volume pAnchor
