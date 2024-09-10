    Include('c25_NanoSyncClass.inc'),Once
    Include('c25_DataTypes.clw'),Once
    Include('c25_WinApi32Class.inc'),Once
    Include('c25_Sqlite3Class.inc'),Once
    Include('c25_TrueReflectionClass.inc'),Once
    Include('c25_NanoSyncClass.inc'),Once
    Include('cwsynchc.inc'),Once
    Include('errors.clw'),Once
    Include('jFiles.inc'),Once
    Include('StringTheory.inc'),Once

RandomQSumClass            Class(),type, Module('c25_RandomQSumClass.clw'), Link('c25_RandomQSumClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_),STATIC

Construct                       Procedure()
Destruct                        Procedure()
Init                            Procedure(),Long,PROC
Start                           Procedure(),Long,PROC
Reset                           Procedure(),Long,PROC
SetDefaults                     Procedure(),Long,proc

                            End

