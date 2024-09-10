    Include('StringTheory.inc'),once
    Include('jFiles.inc'),once
    Include('cwsynchc.inc'),Once
    Include('errors.clw'),Once
    Include('c25_Equates_Sqlite3.clw'),Once
    Include('c25_TYPES.clw'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_TrueReflectionClass.inc'),once
    Include('c25_NanoSyncClass.inc'),once

LogClass                        Class(),Type, Module('c25_LogClass.clw'), Link('c25_LogClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                           Procedure()
Destruct                            Procedure()
CRLF                                String(2)
NanoSync                            &NanoSyncClass()
LogInfoDimQ                         &LogInfoDim_TYPE
LogInfoArray                        Group(LogInfo_TYPE),Pre(LogInfoArray),DIM(1024)
                                    End
WinApi                              &WinApi32Class()
CreateNewLog                        Procedure(<String _uniqueName>, <String _filenameUtf8>, <String _pathUtf8>, <Byte _append>, <Byte _deleteOldLog>, <String _flushInterval>, <String _flushIntervalUnits>, <String _extraJson>),String,PROC
GetByUniqueName                     Procedure(String _uniqueName),Long,PROC
GetByIndex                          Procedure(Long _index),String,PROC
AddLine                             Procedure(String _uniqueLogName, String _line),String,proc
                                End

