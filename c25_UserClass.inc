    Include('StringTheory.inc'),once
    Include('jFiles.inc'),once
    Include('cwsynchc.inc'),Once
    Include('errors.clw'),Once
    Include('c25_Equates_Sqlite3.clw'),Once
    Include('c25_TYPES.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_TrueReflectionClass.inc'),once
    Include('MaxQueue.Inc'),once
    Include('Reflection.Inc'),once
    Include('c25_DatabaseHandlerClass.inc'), once
    Include('c25_Equates_Itemized.clw'),once
    Include('c25_MachineClass.inc'),once

UserClass               Class(),Type, Module('c25_UserClass.clw'), Link('c25_UserClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                   Procedure()
Destruct                    Procedure()
AddBiosToTree               Procedure(Long _devicesGroupType, Long _level, <Byte _attachOnlyChildren>),Long,proc
AddBiosTEMPInTree           Procedure(Long _parentNodeId, Long _level, <Long _biosGroupType>),Long,proc
AddDeviceTEMPInTree         Procedure(Long _parentNodeId, Long _level, Long _devicesGroupType),Long,proc
AddDeviceToTree             Procedure(Long _devicesGroupType, Long _level, <Byte _attachOnlyChildren>),Long,proc
AddMachineToUserTree        Procedure(Long _machineObjectPtr, Long _startLevel, Long _parentNodeId),String,proc
AddWinObjectTEMPInTree      Procedure(Long _parentNodeId, Long _level),Long,proc
AddWinObjectToTree          Procedure(Long _level),String,proc
Buffer                      &String
ClarionFieldsLargeTree      &ClarionFields_TYPE
CreateUserTreeSection       Procedure(Long _userTreeSection, Long _startLevel, Long _parentNodeId),String,proc
CRLF                        String(2)
CurrentLevel                Long
CurrentNodeId               Long
CurrentParentNodeId         Long
DetectDeviceRootInstance    Procedure(),Long,proc
DetectTreeBrancheType       Procedure(),Long,proc
DeviceRootInstance          Long
DevicesTEMP                 &Device_TYPE
DictWinObjectTypes          &Dictionary_TYPE
FilterOnDevicesGroupType    Procedure(Long _devicesGroupType),Byte
FilterSkip                  Byte
GetWinObjectTypeByThisId    Procedure(*WinObject_TYPE _winObj, Long _thisId),String
Init                        Procedure(<Long _userId>),Long,proc
js1                         &JSONClass()
LargeTree                   &LargeTree_TYPE()
LastWinObjectParentId       Long
LineAnsi                    &String
LineAnsiUpper               &String
MachineId                   Long
MachineObjectTEMP           &MachineClass
NanoClock                   &NanoSyncClass()
NewNodeId                   Procedure(),Long
ParentWinObjectNameAnsi     &String
RecursiveAddChildDevice     Procedure(Long _parentNodeId, Long _parentInstance, Long _level, <Long _devicesGroupType>),Long,proc
RecursiveAddChildWinObject  Procedure(Long _parentNodeId, Long _parentId, Long _level),Long,proc
ReflectionCapesoft          &ReflectClass()
Sqlite34                    &Sqlite34Class
st1                         &StringTheory()
st2                         &StringTheory()
st3                         &StringTheory()
st4                         &StringTheory()
st5                         &StringTheory()
TopTreeBrancheType          Long
TreeBrancheType             Long
TrueReflection              &TrueReflectionClass
WinApi                      &WinApi32Class()
WinObjectRootThisId         Long
WinObjTEMP                  &WinObject_TYPE
BiosTEMP                    &BiosBoardCpu_TYPE
Zero                        String(1)
Zero2                       String(2)
BiosPageRowsCount           Procedure(Long _pageId),Long
BiosPageTitle               Procedure(Long _pageId),*String
                        End

