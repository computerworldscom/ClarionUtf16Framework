    Include('c25_DataTypes.clw'),Once
    Include('c25_Equates_Sqlite3.clw'),Once
    Include('c25_NanoSyncClass.inc'),once
    Include('StringTheory.inc'),once

Sqlite3Class        Class(),type, Module('c25_Sqlite3Class.clw'), Link('c25_Sqlite3Class.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                               Procedure()
Destruct                                Procedure()

Connect                                 Procedure(String _connString, <String _sqlOpenFlags>),Long,proc

ConnString                              String(2048)
ConnectionString                        String(1024)

                End

