----------> uses
# use SniperRelease v*  (no_version_directory)
#   use SniperPolicy v*  (no_version_directory)
#   use SniperKernel v*  (no_version_directory)
#     use SniperPolicy v*  (no_version_directory)
#     use Boost v* Externals (no_version_directory)
#       use Python v* Externals (no_version_directory)
#   use DataBuffer v* SniperUtil (no_version_directory)
#     use SniperKernel v*  (no_version_directory)
#   use HelloWorld v* Examples (no_version_directory)
#     use SniperKernel v*  (no_version_directory)
#   use RootWriter v* SniperSvc (no_version_directory)
#     use SniperKernel v*  (no_version_directory)
#     use ROOT v* Externals (no_version_directory)
#     use Boost v* Externals (no_version_directory)
#   use DummyAlg v* Examples (no_version_directory)
#     use SniperKernel v*  (no_version_directory)
#     use RootWriter v* SniperSvc (no_version_directory)
# use DetSimPolicy v* Simulation/DetSimV2 (no_version_directory)
#   use Geant4 v* Externals (no_version_directory)
#   use CLHEP v* Externals (no_version_directory)
#   use Xercesc v* Externals (no_version_directory)
# use DetSimAlg v* Simulation/DetSimV2 (no_version_directory)
#   use SniperRelease v*  (no_version_directory)
#   use DetSimPolicy v* Simulation/DetSimV2 (no_version_directory)
#   use G4Svc v* Simulation/DetSimV2 (no_version_directory)
#     use SniperPolicy v*  (no_version_directory)
#     use SniperKernel v*  (no_version_directory)
#     use DetSimPolicy v* Simulation/DetSimV2 (no_version_directory)
#
# Selection :
use CMT v1r26 (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Release/J17v1r1/ExternalLibs)
use Xercesc v0 Externals (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface)
use CLHEP v0 Externals (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface)
use Geant4 v0 Externals (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface)
use DetSimPolicy v0 Simulation/DetSimV2 (/junofs/production/public/users/zhangfy/offline_bgd)
use ROOT v0 Externals (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface)
use Python v0 Externals (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface)
use Boost v0 Externals (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface)
use SniperPolicy v0  (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper)
use SniperKernel v2  (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper)
use G4Svc v0 Simulation/DetSimV2 (/junofs/production/public/users/zhangfy/offline_bgd)
use RootWriter v0 SniperSvc (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper)
use DummyAlg v0 Examples (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper)
use HelloWorld v1 Examples (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper)
use DataBuffer v0 SniperUtil (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper)
use SniperRelease v2  (/cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper)
use DetSimAlg v0 Simulation/DetSimV2 (/junofs/production/public/users/zhangfy/offline_bgd)
----------> tags
CMTv1 (from CMTVERSION)
CMTr26 (from CMTVERSION)
CMTp0 (from CMTVERSION)
Linux (from uname) package [CMT] implies [Unix]
amd64_linux26 (from CMTCONFIG)
offline_no_config (from PROJECT) excludes [offline_config]
offline_root (from PROJECT) excludes [offline_no_root]
offline_cleanup (from PROJECT) excludes [offline_no_cleanup]
offline_scripts (from PROJECT) excludes [offline_no_scripts]
offline_prototypes (from PROJECT) excludes [offline_no_prototypes]
offline_with_installarea (from PROJECT) excludes [offline_without_installarea]
offline_without_version_directory (from PROJECT) excludes [offline_with_version_directory]
sniper_no_config (from PROJECT) excludes [sniper_config]
sniper_root (from PROJECT) excludes [sniper_no_root]
sniper_cleanup (from PROJECT) excludes [sniper_no_cleanup]
sniper_scripts (from PROJECT) excludes [sniper_no_scripts]
sniper_prototypes (from PROJECT) excludes [sniper_no_prototypes]
sniper_with_installarea (from PROJECT) excludes [sniper_without_installarea]
sniper_without_version_directory (from PROJECT) excludes [sniper_with_version_directory]
ExternalInterface_no_config (from PROJECT) excludes [ExternalInterface_config]
ExternalInterface_no_root (from PROJECT) excludes [ExternalInterface_root]
ExternalInterface_cleanup (from PROJECT) excludes [ExternalInterface_no_cleanup]
ExternalInterface_scripts (from PROJECT) excludes [ExternalInterface_no_scripts]
ExternalInterface_prototypes (from PROJECT) excludes [ExternalInterface_no_prototypes]
ExternalInterface_without_installarea (from PROJECT) excludes [ExternalInterface_with_installarea]
ExternalInterface_without_version_directory (from PROJECT) excludes [ExternalInterface_with_version_directory]
offline (from PROJECT)
x86_64 (from package CMT)
sl69 (from package CMT)
gcc447 (from package CMT)
Unix (from package CMT) excludes [WIN32 Win32]
----------> CMTPATH
# Add path /junofs/production/public/users/zhangfy/offline_bgd from initialization
# Add path /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/sniper from ProjectPath
# Add path /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalInterface from ProjectPath
