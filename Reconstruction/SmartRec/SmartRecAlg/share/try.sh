#python run.py --PreWindow 0 --PostWindow 0 > run_0_0.log &
#python run.py --PreWindow 5 --PostWindow 5 > run_5_5.log &
#python run.py --PreWindow -5 --PostWindow -5 > run_-5_-5.log &
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_0.root >  run_e-_long_nobug_fixed_000.log &
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_5.root >  run_e-_long_nobug_fixed_005.log &
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_10.root > run_e-_long_nobug_fixed_0010.log &
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_15.root > run_e-_long_nobug_fixed_0015.log &
#python run.py --InputFile chargecenter_calib_e-_0_0_10.root --EvtMax 10 --PreWindow 80 --PostWindow 200
#python run.py --InputFile chargecenter_calib_e-_0_0_10.root --EvtMax 10 --PreWindow 60 --PostWindow 200
#python run.py --InputFile chargecenter_calib_e-_0_0_10.root --EvtMax 10 --PreWindow 70 --PostWindow 200
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_0.root >  run_e-_long_nobug_fixed_withrec_000.log &
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_5.root >  run_e-_long_nobug_fixed_withrec_005.log &
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_10.root > run_e-_long_nobug_fixed_withrec_0010.log &
#time python run.py --ChargeCenterInput --InputFile chargecenter_calib_e-_0_0_15.root > run_e-_long_nobug_fixed_withrec_0015.log &
python run.py --evtmax 1 --input /storage/gpfs_data/juno/junofs/users/dingxf/SmartRec/SmartRecProject/Reconstruction/SmartRec/ChargeCenterAlg/share/test.root --output test.root --StaticGeometryLib
