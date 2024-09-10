    Include('errors.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('StringTheory.inc'), once
    Include('C25_DUMMY.CLW'), once
    Include('c25_NanoSyncClass.inc'),once
    Include('c25_TrueReflectionClass.inc'),once
    Include('c25_BytesHandlerClass.inc'),once

c25GlobalMemClass                   Class(),type, Module('c25_GlobalMemClass.clw'), Link('c25_GlobalMemClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                               Procedure()
Destruct                                Procedure(),virtual

BytesHandler                            &BytesHandlerClass
St1                                     &StringTheory
St2                                     &StringTheory
CreateOnce                              Procedure(),Long,proc
CreateSuperQueue                        Procedure(String _queueName, <*queue _q>, <bool _overwrite>),Long,PROC
DataExtracted                           Byte,Name('DataExtracted | Byte')
DevicePropDefQ                          &DevicePropDef_TYPE,Name('DevicePropDefQ | &DevicePropDef_TYPE')
DevicePropertyCodeQ                     &DevicePropertyCode_TYPE,Name('DevicePropertyCodeQ | &DevicePropertyCode_TYPE')
Dictionary                              &Dictionary_TYPE,Name('Dictionary | &Dictionary_TYPE')
FillClaQ                                Procedure(String _queueName, *queue _q),Long,PROC
GetClaQRecord                           Procedure(String _queueName, Long _index, <*queue _q>, <String _where>),String,proc
GetGlobalDictionaryValue                Procedure(String _key, <String _valueIfNull>),String
GlobalMemPtr                            Long
I                                       Long
Log                                     Byte
NanoSync                                &NanoSyncClass
P                                       Long
PutClaQRecord                           Procedure(String _queueName, Long _index, *queue _q),Long,proc
R                                       Long
RecordsClaQ                             Procedure(String _queueName),Long
RemoveGlobalDictionaryValue             Procedure(String _key, <Byte _caseSensitive>),String,proc
SetGlobalDictionaryValue                Procedure(String _key,String _value),String,proc
stLog                                   &StringTheory
SuperQueues                             &SuperQueues_TYPE
SuperQueuesSeedId                       Long
SystemClassesQ                          &SystemClasses_TYPE,Name('SystemClassesQ | &SystemClasses_TYPE')
T                                       Long
IsWhereField                            bool,dim(256)
WhereFieldOperator                      Byte,dim(256)
WhereValues                             &Dictionary_TYPE
Free_WhereValues                        Procedure()
!c25ClientServerPtr                      Long,dim(256)
                                    End

