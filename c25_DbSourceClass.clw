    Member()

        Map
        End

        Include('c25_DbSourceClass.inc'), once

c25DbSourceClass.Construct              Procedure()

    Code

        Self.SelfAddress = Address(Self)

c25DbSourceClass.Destruct       Procedure()

    Code

c25DbSourceClass.GetSelfAddress       Procedure()

    Code

        Return Self.SelfAddress

c25DbSourceClass.QueueDataToSqliteTableEntity    Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>,*QUEUE _queue, String _tableName, <Byte _skipUpdateIds>, <Byte _keepOpen>, <Long _saveQueueToSqlite3Flags>)

TrueReflection  &TrueReflectionClass()
TableObject     &c25DbTableClass
    Code

        If Self.Sqlite34 &= NULL
            Self.Sqlite34 &= NEW Sqlite34Class()
        ELSE
        End

        If Self.Sqlite34.ConnHandle = 0
            If omitted(_c25DbDatabases) = False
                Self.Sqlite34Connect(_c25DbDatabases)
            ElsIf omitted(_connStringOrUriUtf8) = False
                Self.Sqlite34Connect(_connStringOrUriUtf8)
            End
        Else
        End
        If Self.Sqlite34.ConnHandle = 0
            Return -1
        End
        If Self.Databases &= NULL
            Return -1
        End
        If Self.Databases.Instance &= NULL
            Return -1
        End
        If Self.Databases.Instance.Tables &= NULL
            Return -1
        End
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Databases.Instance.Tables,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Databases.Instance.Tables &= NULL
                Return -1
            End
            If Clip(Upper(Self.Databases.Instance.Tables.Name)) <> Clip(Upper(_tableName))
                CYCLE
            End
            If Self.Databases.Instance.Tables.InstancePtr = 0
                Return -1
            End
            If Self.Databases.Instance.Tables.InstancePtr = 0
                CYCLE
            End
            BREAK
        End
        If Self.Databases.Instance &= NULL
        End
        If Self.Databases.Instance.Tables.ClarionFields &= NULL
            Return 0
        End
        If Records(Self.Databases.Instance.Tables.ClarionFields) < 0
            Return 0
        End
        Self.Sqlite34.QueueDataToSqliteTableEntity(_queue, Clip(_tableName),Self.Databases.Instance.Tables.ClarionFields,,_saveQueueToSqlite3Flags)
        Return 0

c25DbSourceClass.Exec       Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>, String _tableName, String _sql, <Long _targetPtr>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>)

TableObject                         &c25DbTableClass
!stLog                           &StringTheory

    Code

!        stLog &= NEW StringTheory()
!        stLog.Append(_sql & Chr(13) & Chr(10))
!        stLog.SaveFile('m:\log\sqlexec.txt',true)
!        Dispose(stLog)

        If Self.Sqlite34 &= NULL
            Self.Sqlite34 &= NEW Sqlite34Class()
        End

        If Self.Sqlite34.ConnHandle = 0
            If omitted(_c25DbDatabases) = False
                Self.Sqlite34Connect(_c25DbDatabases)
            ElsIf omitted(_connStringOrUriUtf8) = False
                Self.Sqlite34Connect(_connStringOrUriUtf8)
            End
        End
        If Self.Sqlite34.ConnHandle = 0
            Return -1
        End

        If Self.Databases.Instance &= NULL
            Return -1
        End

            ReturnVal = Self.Sqlite34.Exec(,_sql)

        Return ReturnVal

c25DbSourceClass.ExecuteScalar      Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>, String _tableName, String _sql, <Long _targetPtr>,<*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>)

TableObject                         &c25DbTableClass

    Code

        If Self.Sqlite34 &= NULL
            Self.Sqlite34 &= NEW Sqlite34Class()
        End

        If Self.Sqlite34.ConnHandle = 0
            If omitted(_c25DbDatabases) = False
                Self.Sqlite34Connect(_c25DbDatabases)
            ElsIf omitted(_connStringOrUriUtf8) = False
                Self.Sqlite34Connect(_connStringOrUriUtf8)
            End
        End
        If Self.Sqlite34.ConnHandle = 0
            Return -1
        End

        If Self.Databases.Instance &= NULL
            Return -1
        End
        If omitted(_c25DbSqlObjectReturn) = True
            ReturnVal = Self.Sqlite34.ExecuteScalar(_sql)
        Else
            ReturnVal = Self.Sqlite34.ExecuteScalar(_sql, _c25DbSqlObjectReturn)
        End
        Return ReturnVal

c25DbSourceClass.Sqlite34Connect    Procedure(<String _c25DbDatabases>,<String _connStringOrUriUtf8>)

ConnHandle                  Long
DatabaseRecord              Group(c25DbDatabases_TYPE),Pre(DatabaseRecord)
                            End

    Code

        If omitted(_c25dbDatabases) = False
            DatabaseRecord = _c25dbDatabases
        End

        If not Self.Sqlite34 &= NULL
            Self.Sqlite34.Disconnect()
        Else
            Self.Sqlite34 &= NEW Sqlite34Class()
        End

        If omitted(_connStringOrUriUtf8) = False
            ConnHandle = Self.Sqlite34.Connect(_connStringOrUriUtf8)
        ElsIf not DatabaseRecord.UriUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(DatabaseRecord.UriUtf8, DatabaseRecord.SqlOpenFlags)
        ElsIf not DatabaseRecord.FullPathUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(DatabaseRecord.FullPathUtf8, DatabaseRecord.SqlOpenFlags)
        End
        Self.Sqlite34ConnHandle = ConnHandle
        Return ConnHandle

