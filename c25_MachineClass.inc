    INCLUDE('c25_DATABASEHANDLERCLASS.INC'),ONCE
    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('c25_EQUATES_SQLITE3.CLW'),ONCE
    INCLUDE('c25_LOGGERCLASS.INC'),ONCE
    INCLUDE('c25_TRUEREFLECTIONCLASS.INC'),ONCE
    INCLUDE('c25_TYPES.CLW'),ONCE
    INCLUDE('CWSYNCHC.INC'),ONCE
    INCLUDE('ERRORS.CLW'),ONCE
    INCLUDE('JFILES.INC'),ONCE
    INCLUDE('MAXQUEUE.INC'),ONCE
    INCLUDE('REFLECTION.INC'),ONCE
    INCLUDE('STRINGTHEORY.INC'),ONCE

MachineClass                 Class(),Type, Module('c25_MachineClass.clw'), Link('c25_MachineClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                   Procedure()
Destruct                                                    Procedure()

ReferenceFullMachineQ                                       Procedure(),bool,proc
FullMachineQ                                                &MachineQ_TYPE

Logger                                                      &LoggerClass

Machine                                                     Group(Machine_TYPE),Pre(Machine)
                                                            End
include('Hardware_DVDATA.clw'),once
                                                           
BiosBoardCpu                                                &BiosBoardCpu_TYPE
BiosBoardCpuPages                                           &BiosBoardCpuPages_TYPE
BiosPage000                                                 &BiosPage000_TYPE
BiosPage001                                                 &BiosPage001_TYPE
BiosPage002                                                 &BiosPage002_TYPE
BiosPage003                                                 &BiosPage003_TYPE
BiosPage004                                                 &BiosPage004_TYPE
BiosPage005                                                 &BiosPage005_TYPE
BiosPage006                                                 &BiosPage006_TYPE
BiosPage007                                                 &BiosPage007_TYPE
BiosPage008                                                 &BiosPage008_TYPE
BiosPage009                                                 &BiosPage009_TYPE
BiosPage010                                                 &BiosPage010_TYPE
BiosPage011                                                 &BiosPage011_TYPE
BiosPage012                                                 &BiosPage012_TYPE
BiosPage013                                                 &BiosPage013_TYPE
BiosPage014                                                 &BiosPage014_TYPE
BiosPage015                                                 &BiosPage015_TYPE
BiosPage016                                                 &BiosPage016_TYPE
BiosPage017                                                 &BiosPage017_TYPE
BiosPage018                                                 &BiosPage018_TYPE
BiosPage019                                                 &BiosPage019_TYPE
BiosPage020                                                 &BiosPage020_TYPE
BiosPage021                                                 &BiosPage021_TYPE
BiosPage022                                                 &BiosPage022_TYPE
BiosPage023                                                 &BiosPage023_TYPE
BiosPage024                                                 &BiosPage024_TYPE
BiosPage025                                                 &BiosPage025_TYPE
BiosPage026                                                 &BiosPage026_TYPE
BiosPage027                                                 &BiosPage027_TYPE
BiosPage028                                                 &BiosPage028_TYPE
BiosPage029                                                 &BiosPage029_TYPE
BiosPage030                                                 &BiosPage030_TYPE
BiosPage031                                                 &BiosPage031_TYPE
BiosPage032                                                 &BiosPage032_TYPE
BiosPage033                                                 &BiosPage033_TYPE
BiosPage034                                                 &BiosPage034_TYPE
BiosPage035                                                 &BiosPage035_TYPE
BiosPage036                                                 &BiosPage036_TYPE
BiosPage037                                                 &BiosPage037_TYPE
BiosPage038                                                 &BiosPage038_TYPE
BiosPage039                                                 &BiosPage039_TYPE
BiosPage040                                                 &BiosPage040_TYPE
BiosPage041                                                 &BiosPage041_TYPE
BiosPage042                                                 &BiosPage042_TYPE
BiosPage043                                                 &BiosPage043_TYPE
BiosPage044                                                 &BiosPage044_TYPE
BiosPage045                                                 &BiosPage045_TYPE
BiosPage046                                                 &BiosPage046_TYPE
BiosPage126                                                 &BiosPage126_TYPE
BiosPage127                                                 &BiosPage127_TYPE
BiosPages                                                   &BiosPages_TYPE
BiosPageXXX                                                 &BiosPageXXX_TYPE
BiosRaw                                                     &BiosRaw_TYPE
BiosSections                                                &BiosSections_TYPE
BiosTypes                                                   &BiosTypes_TYPE
Buffer                                                      &String
Buffer2MB                                                   String(2000000)
Buffer2MBAddress                                            Long
Buffer4K                                                    String(4096)
BufferAddress                                               Long
CreateHardwareObjects                                       Procedure(),Long,PROC
CRLF                                                        String(2)
DbEngineType                                                Long
DevicePropDef                                               &DevicePropDef_TYPE
DeviceProperties                                            &DeviceProperties_TYPE
DevicePropertyGuids                                         &DevicePropertyGuids_TYPE
Devices                                                     &Device_TYPE
DisposeHardwareObjects                                      Procedure(),Long,PROC
DPK_BASE_STRING_LIST                                        &DPK_BASE_STRING_LIST_TYPE()
FreeBios                                                    Procedure(),Long,PROC
GetBiosFromMachine                                          Procedure(<Long _machineId>),String,PROC
GetBiosPage001Count                                         Procedure(),Long
GetDevicesFromMachine                                       Procedure(<Long _machineId>),String,PROC
GetMachine                                                  Procedure(<Long _id>),String,proc
GetWinObjectsFromMachine                                    Procedure(<Long _machineId>),String,PROC
Id                                                          Long
Init                                                        Procedure(<Long _machineId>,<Long _connHandle>,<Long _dbEngineType>),Long,proc
js1                                                         &JSONClass()
MachineId                                                   Long
MachineAsQueue                                              &Machine_TYPE
NanoClock                                                   &NanoSyncClass()
Sqlite34                                                    &Sqlite34Class()
st1                                                         &StringTheory()
st2                                                         &StringTheory()
st3                                                         &StringTheory()
st4                                                         &StringTheory()
st5                                                         &StringTheory()
stLog                                                       &StringTheory()
stSpecials                                                  &StringTheory()
SystemClasses                                               &SystemClasses_TYPE
TrueReflection                                              &TrueReflectionClass
WinApi                                                      &WinApi32Class()
WinObject                                                   &WinObject_TYPE
Zero                                                        String(1)
Zero2                                                       String(2)
                                                        End

