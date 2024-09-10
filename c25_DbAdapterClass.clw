                    Member
                        Include('c25_DbAdapterClass.inc'), once
                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
                            Module('c25_DbAdapterClass.clw')
                            End
                        End

c25DbAdapterClass.Construct                     Procedure()

    Code

        Self.CRLF                           = Chr(13) & Chr(10)
        Self.SelfAddress                    = Address(Self)
        Self.NanoSync                       &= NEW NanoSyncClass()
        Self.WinApi                         &= NEW WinApi32Class()
        Self.Sqlite34                       &= NEW Sqlite34Class()
        Self.Sources                        &= NEW c25DbSources_TYPE()
        Self.Databases                      &= NEW c25DbDatabases_TYPE()
        Self.Tables                         &= NEW c25DbTables_TYPE()
        Self.Columns                        &= NEW c25DbTableColumns_TYPE()
        Self.MsSql                          &= NEW c25MsSqlClass()
        Self.stLog                          &= NEW StringTheory()
        Self.Js1                            &= NEW JSONClass()
        Self.EventsQueue                    &= NEW c25DbEventsQueue_TYPE()
        Self.NetSCW                         &= NEW NetSCWQ_TYPE()
        Self.NetTcpInstances                &= NEW NetTcpInstancesQ_TYPE()        
        Self.GlobalMem                      &= Self.WinApi.GlobalMem

c25DbAdapterClass.Log       Procedure(String _line)

    Code

        Self.stLog.SetValue(Clip(_line) & Self.CRLF)
        Self.stLog.SaveFile(Self.stLogFileName,True)

        Return 0

c25DbAdapterClass.Destruct                      Procedure()

    Code

c25DbAdapterClass.GetSelfAddress                Procedure()

    Code

        Self.SelfAddress = Address(Self)
        Return Self.SelfAddress

c25DbAdapterClass.Init                          Procedure()

    Code

        If Self.AdaptersRecord.ParentPtr <> 0
            Self.DataBaseHandler &= (Self.AdaptersRecord.ParentPtr)
        ELSE
            Message('error in adapter.init, Self.AdaptersRecord.ParentPtr = 0')
            Return 0
        End
        Self.WinApi.SetGlobalDictionaryValue('AdapterWinHandle ' & Self.AdaptersRecord.Name,Self.AdaptersRecord.WinHandle)
        
        Self.ParseDataBaseHandlerQueues()

        Self.CreateScript(ScriptType:DropDatabase)
        Self.CreateScript(ScriptType:DropTables)
        Self.CreateScript(ScriptType:DropIndexes)

        Self.CreateScript(ScriptType:CreateDatabase)
        Self.CreateScript(ScriptType:CreateTables)
        Self.CreateScript(ScriptType:CreateIndexes)

        Self.PrepareAppDBs()

        Return True

c25DbAdapterClass.PrepareAppDBs                 Procedure(<Long _dbEngineType>)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Databases,I#)
            If Errorcode() <> 0
                BREAK
            End

            If Self.Databases.DbEngineType <> DbEngineType:Sqlite3
                CYCLE
            End
            c25_PostMessageA(Self.AdaptersRecord.WinHandle, c25:CreateDatabase, Self.Databases.Id,0)
            c25_PostMessageA(Self.AdaptersRecord.WinHandle, c25:CreateTables,   Self.Databases.Id,0)
            c25_PostMessageA(Self.AdaptersRecord.WinHandle, c25:CreateIndexes,  Self.Databases.Id,0)

        End
        c25_PostMessageA(Self.AdaptersRecord.WinHandle, c25:AdapterReady, Self.AdaptersRecord.Id,True)

        Return 0

c25DbAdapterClass.PrepareServerDBs                 Procedure(<Long _dbEngineType>, <Long _filter>)

st &StringTheory

    Code

        st &= NEW StringTheory()

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Databases,I#)
            If Errorcode() <> 0
                BREAK
            End

            If Self.Databases.DbEngineType <> _dbEngineType
                CYCLE
            End
            st.Start()
            st.Append(Self.Databases.CreateTablesScriptAnsi)
            st.SaveFile('M:\log\DatabasesCreateTablesScriptAnsi' & Self.Databases.Id & '.txt')

        End
        Return 0

c25DbAdapterClass.CreateSqlite3Tables           Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

ConnHandle                                      Long

    Code

        If not _c25DbDatabases.UriUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.UriUtf8, _c25DbDatabases.SqlOpenFlags)
        ElsIf not _c25DbDatabases.FullPathUtf16 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.FullPathUtf8, _c25DbDatabases.SqlOpenFlags)
        End
        If ConnHandle <> 0
            Self.Sqlite34.Exec(ConnHandle,_c25DbDatabases.CreateTablesScriptAnsi)
        End
        Self.Sqlite34.Disconnect()
        Return 0

c25DbAdapterClass.CreateMsSqlIndexes           Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

    Code

        Self.MsSql.Connect()
        Self.MsSql.SQLExecuteScript(Clip(_c25DbDatabases.CreateTablesIndexesScriptAnsi))
        Self.MsSql.SQLExecute()
        Self.MsSql.Disconnect()
        Return 0

c25DbAdapterClass.CreateSqlite3Indexes         Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

ConnHandle                                      Long

    Code

        If not _c25DbDatabases.UriUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.UriUtf8, _c25DbDatabases.SqlOpenFlags)
        ElsIf not _c25DbDatabases.FullPathUtf16 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.FullPathUtf8, _c25DbDatabases.SqlOpenFlags)
        End
        If ConnHandle <> 0
            Self.Sqlite34.Exec(ConnHandle,_c25DbDatabases.CreateTablesIndexesScriptAnsi)
        End
        Self.Sqlite34.Disconnect()
        Return 0

c25DbAdapterClass.CreateMsSqlTables             Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

    Code

        Message('c25DbAdapterClass.CreateMsSqlTables')

        Self.MsSql.Connect()
        Self.MsSql.SQLExecuteScript(Clip(_c25DbDatabases.CreateTablesScriptAnsi))
        Self.MsSql.SQLExecute()
        Self.MsSql.Disconnect()
        Return 0

c25DbAdapterClass.CreateSqlite3Database         Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

ConnHandle                                      Long
st1Json                                             &StringTheory()

    Code

        st1Json &= NEW StringTheory()
        Self.Js1.Start()
        Self.Js1.Save(_c25DbDatabases.SqlOpenFlags,st1Json)

        If not _c25DbDatabases.UriUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.UriUtf8, _c25DbDatabases.SqlOpenFlags)
        ElsIf not _c25DbDatabases.FullPathUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.FullPathUtf8, _c25DbDatabases.SqlOpenFlags)
        End
        Self.Sqlite34.Disconnect()
        Dispose(st1Json)
        Return 0

c25DbAdapterClass.CreateMsSqlDatabase           Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

    Code

        Self.MsSql.Connect()
        Self.MsSql.SQLExecuteScript(Clip(_c25DbDatabases.CreateDatabaseScriptAnsi))
        Self.MsSql.SQLExecute()
        Self.MsSql.Disconnect()
        Return 0

c25DbAdapterClass.ConnectMsSqlServer            Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

ConnHandle Long

    Code

        If omitted(_connStringOrUriUtf8) = False
            ConnHandle = Self.MsSql.Connect(_connStringOrUriUtf8)
        ElsIf not _c25DbDatabases.UriUtf8 &= null
            ConnHandle = Self.MsSql.Connect(_c25DbDatabases.UriUtf8)
        ElsIf not _c25DbDatabases.FullPathUtf8 &= null
            ConnHandle = Self.MsSql.Connect(_c25DbDatabases.FullPathUtf8)
        End
        Return ConnHandle

c25DbAdapterClass.ConnectSqlite3                Procedure(<c25DbDatabases_TYPE _c25DbDatabases>,<String _connStringOrUriUtf8>)

ConnHandle Long

    Code

        If omitted(_connStringOrUriUtf8) = False
            ConnHandle = Self.Sqlite34.Connect(_connStringOrUriUtf8)
        ElsIf not _c25DbDatabases.UriUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.UriUtf8, _c25DbDatabases.SqlOpenFlags)
        ElsIf not _c25DbDatabases.FullPathUtf8 &= null
            ConnHandle = Self.Sqlite34.Connect(_c25DbDatabases.FullPathUtf8, _c25DbDatabases.SqlOpenFlags)
        End
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Sources,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Sources.Id <> _c25DbDatabases.SourcesId
                CYCLE
            End
            If Self.Sources.IsPrimary
                Self.PrimarySqlite3ConnHandle = ConnHandle
            End
            BREAK
        End
        Return ConnHandle

c25DbAdapterClass.ConnectSqlite3BySourceName           Procedure(<String _name>, <c25DbSources_TYPE _c25DbDatabases>)

ConnHandle Long

    Code

        Return ConnHandle

c25DbAdapterClass.CreateScript                  Procedure(Long _scriptType)

ScriptFragment                          &StringTheory
Script                                  &StringTheory
DatabaseObject                          &c25DbDatabaseClass

    Code

        ScriptFragment    &= NEW StringTheory()
        Script            &= NEW StringTheory()
        ScriptFragment.Start()
        Script.Start()
        I1# = 0
        LOOP
            I1# = I1# + 1
            Get(Self.Sources,I1#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Sources.DbAdapterId <> Self.AdaptersRecord.Id
                CYCLE
            End
            I2# = 0
            LOOP
                I2# = I2# + 1
                Get(Self.Databases,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Databases.SourcesId <> Self.Sources.Id
                    CYCLE
                End
                DatabaseObject &= Self.Databases.Instance
                Case _scriptType
                Of ScriptType:DropDatabase
                    Case Self.Databases.DbEngineType
                    Of DbEngineType:Sqlite3

                    Of DbEngineType:MsSql
                        Script.Append('USE [master]' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('DROP DATABASE [' & Self.Databases.Name & ']' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                    End
                Of ScriptType:DropIndexes
                    Case Self.Databases.DbEngineType
                    Of DbEngineType:Sqlite3

                    Of DbEngineType:MsSql
                        Script.Append('USE [' & Self.Databases.Name & ']' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                    End
                Of ScriptType:DropTables
                    Case Self.Databases.DbEngineType
                    Of DbEngineType:Sqlite3

                    Of DbEngineType:MsSql
                        Script.Append('USE [' & Self.Databases.Name & ']' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                    End
                Of ScriptType:CreateIndexes
                    Case Self.Databases.DbEngineType
                    Of DbEngineType:Sqlite3

                    Of DbEngineType:MsSql
                        Script.Append('USE [' & Self.Databases.Name & ']' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                    End
                Of ScriptType:CreateTables
                    Case Self.Databases.DbEngineType
                    Of DbEngineType:Sqlite3

                    Of DbEngineType:MsSql
                        Script.Append('USE [' & Self.Databases.Name & ']' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                    End
                Of ScriptType:CreateDatabase
                    Case Self.Databases.DbEngineType
                    Of DbEngineType:Sqlite3
                        Script.Append('CREATE TABLE DUMMYTABLE (ROWID INTEGER PRIMARY KEY AUTOINCREMENT, SESSIONINPUTID    TEXT COLLATE NOCASE)' & Self.CRLF)
                        Script.Append('INSERT INTO DUMMYTABLE (SESSIONINPUTID) VALUES(''ABC'');' & Self.CRLF)
                        Script.Append('DROP TABLE DUMMYTABLE' & Self.CRLF)
                    Of DbEngineType:MsSql
                        Script.Append('USE [master]' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('CREATE DATABASE [' & Self.Databases.Name & ']' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('If (1 = FULLTEXTSERVICEPROPERTY(''IsFullTextInstalled''))' & Self.CRLF)
                        Script.Append('  begin' & Self.CRLF)
                        Script.Append('    EXEC [' & Self.Databases.Name & '].[dbo].[sp_fulltext_database] @action = ''enable''' & Self.CRLF)
                        Script.Append('  End' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET ANSI_NULL_DEFAULT OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET ANSI_NULLS OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET ANSI_PADDING OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET ANSI_WARNINGS OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET ARITHABORT OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET AUTO_CLOSE OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET AUTO_SHRINK ON ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET AUTO_UPDATE_STATISTICS ON ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET CURSOR_CLOSE_ON_COMMIT OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET CURSOR_DEFAULT  GLOBAL ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET CONCAT_NULL_YIELDS_NULL OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET NUMERIC_ROUNDABORT OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET QUOTED_IDENTIFIER OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET RECURSIVE_TRIGGERS OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET  DISABLE_BROKER ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET AUTO_UPDATE_STATISTICS_ASYNC OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET DATE_CORRELATION_OPTIMIZATION OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET TRUSTWORTHY OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET ALLOW_SNAPSHOT_ISOLATION OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET PARAMETERIZATION SIMPLE ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET READ_COMMITTED_SNAPSHOT OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET HONOR_BROKER_PRIORITY OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET RECOVERY FULL ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET  MULTI_USER ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET PAGE_VERIFY CHECKSUM  ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET DB_CHAINING OFF ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET TARGET_RECOVERY_TIME = 60 SECONDS ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET DELAYED_DURABILITY = DISABLED ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET ACCELERATED_DATABASE_RECOVERY = OFF  ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET QUERY_STORE = ON' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                        Script.Append('ALTER DATABASE [' & Self.Databases.Name & '] SET  READ_WRITE ' & Self.CRLF)
                        Script.Append('GO' & Self.CRLF)
                        Script.Append(Self.CRLF)
                    End
                End

                Case _scriptType
                Of ScriptType:CreateTables
                OrOf ScriptType:DropTables
                OrOf ScriptType:CreateIndexes
                OrOf ScriptType:DropIndexes
                    I3# = 0
                    LOOP
                        I3# = I3# + 1
                        Get(Self.Tables,I3#)
                        If Errorcode() <> 0
                            BREAK
                        End
                        If Self.Tables.DatabaseId <> Self.Databases.Id
                            CYCLE
                        End
                        Case Self.Databases.DbEngineType
                        Of DbEngineType:Sqlite3
                            Case _scriptType
                            Of ScriptType:CreateTables
                                Script.Append('CREATE TABLE If NOT EXISTS ' & Self.Tables.Name & ' ('  & Self.CRLF)
                                Script.Append('    [ROWID] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'  & Self.CRLF)
                            Of ScriptType:CreateIndexes
                                If Self.ColumnExist(Self.Tables.Id,'Id')
                                    Script.Append('CREATE INDEX If NOT EXISTS IDX_' & Self.Tables.Name & '_' & 'Id' & ' ON ' & Self.Tables.Name & ' (' & 'Id' & ');' & Self.CRLF)
                                    Script.Append(Self.CRLF)
                                End
                                If Self.ColumnExist(Self.Tables.Id,'MachineId')
                                    Script.Append('CREATE INDEX If NOT EXISTS IDX_' & Self.Tables.Name & '_' & 'MachineId' & ' ON ' & Self.Tables.Name & ' (' & 'MachineId' & ');' & Self.CRLF)
                                    Script.Append(Self.CRLF)
                                End
                                If Self.ColumnExist(Self.Tables.Id,'SessionId')
                                    Script.Append('CREATE INDEX If NOT EXISTS IDX_' & Self.Tables.Name & '_' & 'SessionId' & ' ON ' & Self.Tables.Name & ' (' & 'SessionId' & ');' & Self.CRLF)
                                    Script.Append(Self.CRLF)
                                End
                            Of ScriptType:DropIndexes
                            End
                        Of DbEngineType:MsSql
                            Case _scriptType
                            Of ScriptType:CreateTables
                                Script.Append('CREATE TABLE [dbo].[' & Self.Tables.Name & ']('  & Self.CRLF)
                                Script.Append('    [ROWID] [bigint] IDENTITY(1,1) NOT NULL,'  & Self.CRLF)
                            Of ScriptType:DropTables
                                Script.Append('If  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' & Self.Tables.Name & ']'') AND type in (N''U''))'  & Self.CRLF)
                                Script.Append('DROP TABLE [dbo].[' & Self.Tables.Name & ']'  & Self.CRLF)
                                Script.Append('GO'  & Self.CRLF)
                                Script.Append(Self.CRLF)
                            Of ScriptType:DropIndexes
                                If Self.ColumnExist(Self.Tables.Id,'Id')
                                    Script.Append('DROP INDEX [IX_' & Self.Tables.Name & '_Id] ON [dbo].[' & Self.Tables.Name & ']'  & Self.CRLF)
                                    Script.Append('GO'  & Self.CRLF)
                                    Script.Append(Self.CRLF)
                                End
                                If Self.ColumnExist(Self.Tables.Id,'MachineId')
                                    Script.Append('DROP INDEX [IX_' & Self.Tables.Name & '_MachineId] ON [dbo].[' & Self.Tables.Name & ']'  & Self.CRLF)
                                    Script.Append('GO'  & Self.CRLF)
                                    Script.Append(Self.CRLF)
                                End
                                If Self.ColumnExist(Self.Tables.Id,'SessionId')
                                    Script.Append('DROP INDEX [IX_' & Self.Tables.Name & '_SessionId] ON [dbo].[' & Self.Tables.Name & ']'  & Self.CRLF)
                                    Script.Append('GO'  & Self.CRLF)
                                    Script.Append(Self.CRLF)
                                End
                            Of ScriptType:CreateIndexes
                                If Self.ColumnExist(Self.Tables.Id,'Id')
                                    Script.Append('CREATE NONCLUSTERED INDEX [IX_' & Self.Tables.Name & '_Id] ON [dbo].[' & Self.Tables.Name & ']'  & Self.CRLF)
                                    Script.Append('('  & Self.CRLF)
                                    Script.Append('    [Id] ASC'  & Self.CRLF)
                                    Script.Append(')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]'  & Self.CRLF)
                                    Script.Append('GO'  & Self.CRLF)
                                End
                                If Self.ColumnExist(Self.Tables.Id,'MachineId')
                                    Script.Append('CREATE NONCLUSTERED INDEX [IX_' & Self.Tables.Name & '_MachineId] ON [dbo].[' & Self.Tables.Name & ']'  & Self.CRLF)
                                    Script.Append('('  & Self.CRLF)
                                    Script.Append('    [MachineId] ASC'  & Self.CRLF)
                                    Script.Append(')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]'  & Self.CRLF)
                                    Script.Append('GO'  & Self.CRLF)
                                End
                                If Self.ColumnExist(Self.Tables.Id,'SessionId')
                                    Script.Append('CREATE NONCLUSTERED INDEX [IX_' & Self.Tables.Name & '_SessionId] ON [dbo].[' & Self.Tables.Name & ']'  & Self.CRLF)
                                    Script.Append('('  & Self.CRLF)
                                    Script.Append('    [SessionId] ASC'  & Self.CRLF)
                                    Script.Append(')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]'  & Self.CRLF)
                                    Script.Append('GO'  & Self.CRLF)
                                End
                            End
                        End

                        Case _scriptType
                        Of ScriptType:CreateTables
                            Sort(Self.Columns,+Self.Columns.Id)
                            I5# = 0
                            Loop
                                I5# = I5# + 1
                                Get(Self.Columns, I5#)
                                If Errorcode() <> 0
                                    BREAK
                                End
                                If Self.Columns.TableId <> Self.Tables.Id
                                    CYCLE
                                End
                                Case Self.Databases.DbEngineType
                                Of DbEngineType:Sqlite3
                                    If Upper(Self.Columns.Name) <> 'ROWID'
                                        Case Upper(Self.Columns.DataType)
                                        Of 'Byte'
                                        OrOf 'UShort'
                                        OrOf 'Short'
                                        OrOf 'Long'
                                        OrOf 'ULong'
                                            Script.Append('    [' & Self.Columns.Name & '] '  & 'INTEGER' & ',' & Self.CRLF)
                                        Of 'DECIMAL'
                                            If Self.Columns.Characters < 21
                                                Script.Append('    [' & Self.Columns.Name & '] '  & 'BIGINT' & ',' & Self.CRLF)
                                            Else
                                                Script.Append('    [' & Self.Columns.Name & '] TEXT COLLATE NOCASE,' & Self.CRLF)
                                            End
                                        Else
                                            Script.Append('    [' & Self.Columns.Name & '] TEXT COLLATE NOCASE,' & Self.CRLF)
                                        End
                                    Else
                                        CYCLE
                                    End
                                Of DbEngineType:MsSql
                                    If Upper(Self.Columns.Name) <> 'ROWID'
                                        Case Upper(Self.Columns.DataType)
                                        Of 'Byte'
                                            Script.Append('    [' & Self.Columns.Name & '] '  & ' [tinyint] NULL' & ',' & Self.CRLF)
                                        Of 'UShort'
                                            Script.Append('    [' & Self.Columns.Name & '] '  & ' [int] NULL' & ',' & Self.CRLF)
                                        Of 'Short'
                                            Script.Append('    [' & Self.Columns.Name & '] '  & ' [smallint] NULL' & ',' & Self.CRLF)
                                        Of 'Long'
                                            Script.Append('    [' & Self.Columns.Name & '] '  & ' [int] NULL' & ',' & Self.CRLF)
                                        Of 'ULong'
                                            Script.Append('    [' & Self.Columns.Name & '] '  & ' [bigint] NULL' & ',' & Self.CRLF)
                                        Of 'DECIMAL'
                                            If Self.Columns.Characters < 21
                                                Script.Append('    [' & Self.Columns.Name & '] '  & ' [bigint] NULL' & ',' & Self.CRLF)
                                            Else
                                                Script.Append('    [' & Self.Columns.Name & '] '  & ' [decimal](21,0) NULL' & ',' & Self.CRLF)
                                            End
                                        Else
                                            If Self.Columns.Characters < 1
                                                Script.Append('    [' & Self.Columns.Name & '] [nvarchar](' & '450' & ') NULL' & ',' & Self.CRLF)
                                            Else
                                                Script.Append('    [' & Self.Columns.Name & '] [nvarchar](' & Self.Columns.Characters & ') NULL' & ',' & Self.CRLF)
                                            End
                                        End
                                    Else
                                        CYCLE
                                    End
                                End
                            End
                        End
                        Case _scriptType
                        Of ScriptType:CreateTables
                            Case Self.Databases.DbEngineType
                            Of DbEngineType:Sqlite3
                                Script.Crop(1, Script.Length() - 3)
                                Script.Append(');'  & Self.CRLF)
                                Script.Append(Self.CRLF )
                            Of DbEngineType:MsSql
                                Script.Append(' CONSTRAINT [PK_' & Self.Tables.Name & '] PRIMARY KEY CLUSTERED '  & Self.CRLF)
                                Script.Append('('  & Self.CRLF)
                                Script.Append('    [ROWID] ASC'  & Self.CRLF)
                                Script.Append(')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]'  & Self.CRLF)
                                Script.Append(') ON [PRIMARY]'  & Self.CRLF)
                                Script.Append('GO'  & Self.CRLF)
                                Script.Append(Self.CRLF)
                            End
                        End
                    End
                End
                If Script.Length() > 0
                    Case _scriptType
                    Of ScriptType:CreateIndexes
                        Self.Databases.CreateTablesIndexesScriptAnsi &= NEW String(Script.Length())
                        Self.Databases.CreateTablesIndexesScriptAnsi = Script.GetValue()
                        If not DatabaseObject &= null
                            DatabaseObject.DatabaseRecord.CreateTablesIndexesScriptAnsi &= NEW String(Script.Length())
                            DatabaseObject.DatabaseRecord.CreateTablesIndexesScriptAnsi = Script.GetValue()
                        End
                    Of ScriptType:DropIndexes
                        Self.Databases.DropTablesIndexesScriptAnsi &= NEW String(Script.Length())
                        Self.Databases.DropTablesIndexesScriptAnsi = Script.GetValue()
                        If not DatabaseObject &= null
                            DatabaseObject.DatabaseRecord.DropTablesIndexesScriptAnsi &= NEW String(Script.Length())
                            DatabaseObject.DatabaseRecord.DropTablesIndexesScriptAnsi = Script.GetValue()
                        End
                    Of ScriptType:DropTables
                        Self.Databases.DropTablesScriptAnsi &= NEW String(Script.Length())
                        Self.Databases.DropTablesScriptAnsi = Script.GetValue()
                        If not DatabaseObject &= null
                            DatabaseObject.DatabaseRecord.DropTablesScriptAnsi &= NEW String(Script.Length())
                            DatabaseObject.DatabaseRecord.DropTablesScriptAnsi = Script.GetValue()
                        End
                    Of ScriptType:CreateTables
                        Self.Databases.CreateTablesScriptAnsi &= NEW String(Script.Length())
                        Self.Databases.CreateTablesScriptAnsi = Script.GetValue()
                        If not DatabaseObject &= null
                            DatabaseObject.DatabaseRecord.CreateTablesScriptAnsi &= NEW String(Script.Length())
                            DatabaseObject.DatabaseRecord.CreateTablesScriptAnsi = Script.GetValue()
                        End
                    Of ScriptType:DropDatabase
                        Self.Databases.DropDatabaseScriptAnsi &= NEW String(Script.Length())
                        Self.Databases.DropDatabaseScriptAnsi = Script.GetValue()
                        If not DatabaseObject &= null
                            DatabaseObject.DatabaseRecord.DropDatabaseScriptAnsi &= NEW String(Script.Length())
                            DatabaseObject.DatabaseRecord.DropDatabaseScriptAnsi = Script.GetValue()
                        End
                    Of ScriptType:CreateDatabase
                        Self.Databases.CreateDatabaseScriptAnsi &= NEW String(Script.Length())
                        Self.Databases.CreateDatabaseScriptAnsi = Script.GetValue()
                        If not DatabaseObject &= null
                            DatabaseObject.DatabaseRecord.CreateDatabaseScriptAnsi &= NEW String(Script.Length())
                            DatabaseObject.DatabaseRecord.CreateDatabaseScriptAnsi = Script.GetValue()
                        End
                    End
                End
                Put(Self.Databases)
                DatabaseObject &= null
                Script.Start()
            End
        End
        Dispose(Script)
        Dispose(ScriptFragment)
        Return ''

c25DbAdapterClass.ColumnExist                   Procedure(Long _tableId, String _name)

    Code

        P# = Pointer(Self.Columns)
        I# = 0
        Loop
            I# = I# + 1
            Get(Self.Columns,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Columns.TableId <> _tableId
                CYCLE
            End
            If Upper(Self.Columns.Name) <> Upper(_name)
                CYCLE
            End
            Get(Self.Columns,P#)
            Return TRUE
        End
        Get(Self.Columns,P#)
        Return 0

c25DbAdapterClass.ParseDataBaseHandlerQueues    Procedure()

JSon                        &JSonClass
Source_Object               &c25DbSourceClass
Database_Object             &c25DbDatabaseClass
Table_Object                &c25DbTableClass
Column_Object               &c25DbTableColumnClass
DatabasesQ                  &c25DbDatabases_TYPE
SourcesQ                    &c25DbSources_TYPE
TablesQ                     &c25DbTables_TYPE
ColumnsQ                    &c25DbTableColumns_TYPE

    Code

        I1# = 0
        LOOP
            I1# = I1# + 1
            Get(Self.DataBaseHandler.Sources,I1#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.DataBaseHandler.Sources.DbAdapterId <> Self.AdaptersRecord.Id
                CYCLE
            End
            Self.Sources                    = Self.DataBaseHandler.Sources
            Self.Sources.Instance           &= NEW c25DbSourceClass()
            Self.Sources.InstancePtr        = Address(Self.Sources.Instance)

            Self.DataBaseHandler.Sources.Instance &= (Self.Sources.InstancePtr)
            Self.DataBaseHandler.Sources.InstancePtr = Self.Sources.InstancePtr
            Put(Self.DataBaseHandler.Sources)

            Source_Object                   &= (Self.Sources.InstancePtr)
            Source_Object.SourceRecord      = Self.Sources
            DatabasesQ                      &= NEW c25DbDatabases_TYPE()

            I2# = 0
            LOOP
                I2# = I2# + 1
                Get(Self.DataBaseHandler.Databases,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.DataBaseHandler.Databases.SourcesId <> Self.Sources.Id
                    CYCLE
                End
                DatabasesQ                          = Self.DataBaseHandler.Databases
                DatabasesQ.Instance                 &= NEW c25DbDatabaseClass()
                DatabasesQ.InstancePtr              = Address(DatabasesQ.Instance)

                Self.DataBaseHandler.Databases.Instance &= (DatabasesQ.InstancePtr)
                Self.DataBaseHandler.Databases.InstancePtr = DatabasesQ.InstancePtr
                Put(Self.DataBaseHandler.Databases)

                DatabasesQ.Instance.DatabaseRecord  = Self.DataBaseHandler.Databases
                DatabasesQ.Instance.Tables          &= NEW c25DbTables_TYPE()
                TablesQ                             &= DatabasesQ.Instance.Tables

                I3# = 0
                LOOP
                    I3# = I3# + 1
                    Get(Self.DataBaseHandler.Tables,I3#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Self.DataBaseHandler.Tables.DatabaseId <> Self.DataBaseHandler.Databases.Id
                        CYCLE
                    End
                    TablesQ                             = Self.DataBaseHandler.Tables
                    TablesQ.Instance                   &= NEW c25DbTableClass()
                    TablesQ.InstancePtr                 = Address(TablesQ.Instance)

                    Self.DataBaseHandler.Tables.Instance &= (TablesQ.InstancePtr)
                    Self.DataBaseHandler.Tables.InstancePtr = TablesQ.InstancePtr
                    Put(Self.DataBaseHandler.Tables)

                    ColumnsQ                           &= NEW c25DbTableColumns_TYPE()
                    TablesQ.Instance.TablesRecord       = Self.DataBaseHandler.Tables

                    I4# = 0
                    Loop
                        I4# = I4# + 1
                        Get(Self.DataBaseHandler.TableColumns, I4#)
                        If Errorcode() <> 0
                            BREAK
                        End
                        If Self.DataBaseHandler.TableColumns.TableId <> Self.DataBaseHandler.Tables.Id
                            CYCLE
                        End
                        ColumnsQ                         = Self.DataBaseHandler.TableColumns
                        ColumnsQ.Instance                &= NEW c25DbTableColumnClass()
                        ColumnsQ.InstancePtr             = Address(Self.Columns.Instance)

                        Self.DataBaseHandler.TableColumns.Instance &= (ColumnsQ.InstancePtr)
                        Self.DataBaseHandler.TableColumns.InstancePtr = ColumnsQ.InstancePtr
                        Put(Self.DataBaseHandler.TableColumns)

                        ColumnsQ.Instance.ColumnsRecord  = ColumnsQ
                        Add(ColumnsQ)
                        Self.Columns = ColumnsQ
                        Add(Self.Columns)
                    End
                    TablesQ.Instance.TableColumns   &= ColumnsQ
                    Add(TablesQ)

                    Self.Tables                     = TablesQ
                    Add(Self.Tables)
                End
                DatabasesQ.Instance.Tables &= TablesQ
                Add(DatabasesQ)

                Self.Databases = DatabasesQ
                Add(Self.Databases)
                TablesQ &= null
            End
            Self.Sources.Instance.DataBases &= DatabasesQ
            Add(Self.Sources)
            DatabasesQ &= NULL
        End
        Return 0

c25DbAdapterClass.DummyProc                     Procedure()

    Code

    Return 0

c25DbAdapterClass.WM_000016_WM_CLOSE       Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        c25_PostQuitMessage(_winHandle)
        Return 0

c25DbAdapterClass.WM_000275_WM_TIMER       Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        If Self.AdaptersRecord.WinHandle = _winHandle
            Self.WndMessageProcessed = TRUE
        End
        Return 0

c25DbAdapterClass.c25_AdapterReady  Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        If Self.AdaptersRecord.WinHandle = _winHandle
            Self.AdaptersRecord.InitDone    = True
            Self.WndMessageProcessed        = True
        End
        Return 0

c25DbAdapterClass.WM_SETFIELD           Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Return 0

c25DbAdapterClass.WM_TEST               Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        Return 0

c25DbAdapterClass.c25_CreateDatabases  Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.AdaptersRecord.WinHandle = _winHandle
            ReturnVal# = -1
            G# = 0
            Loop
                G# = G# + 1
                Get(Self.Databases,G#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Databases.Id <> _wParam
                    CYCLE
                End
                Case Self.Databases.DbEngineType
                Of DbEngineType:Sqlite3
                    Self.CreateSqlite3Database(Self.Databases)
                Of DbEngineType:MsSql
                    Self.CreateMsSqlDatabase(Self.Databases)
                End
                Break
            End
        End
        Return 0

c25DbAdapterClass.c25_CreateTables  Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.AdaptersRecord.WinHandle = _winHandle
            ReturnVal# = -1
            G# = 0
            Loop
                G# = G# + 1
                Get(Self.Databases,G#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Databases.Id <> _wParam
                    CYCLE
                End
                Case Self.Databases.DbEngineType
                Of DbEngineType:Sqlite3
                    Self.CreateSqlite3Tables(Self.Databases)
                Of DbEngineType:MsSql
                    Self.CreateMsSqlTables(Self.Databases)
                End
                Break
            End
        End
        Return 0

c25DbAdapterClass.c25_CreateIndexes     Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.AdaptersRecord.WinHandle = _winHandle
            ReturnVal# = -1
            G# = 0
            Loop
                G# = G# + 1
                Get(Self.Databases,G#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Databases.Id <> _wParam
                    CYCLE
                End
                Case Self.Databases.DbEngineType
                Of DbEngineType:Sqlite3
                    Self.CreateSqlite3Indexes(Self.Databases)
                Of DbEngineType:MsSql
                    Self.CreateMsSqlIndexes(Self.Databases)
                End
                Break
            End
        End
        Return 0

c25DbAdapterClass.c25_SaveQueueToSqlite3            Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

c25DbQueueObject                                    Group(c25DbQueueObject_TYPE),Pre(c25DbQueueObject)
                                                    End
c25DbQueueObjectMem                                 &String

st1 &StringTheory

    Code

        Self.WndMessageProcessed = True

        If _lParam = 0
            Return -1
        End

        c25_memcpy(Address(c25DbQueueObject),_lParam,Size(c25DbQueueObject))

        c25DbQueueObjectMem &= (_lParam)

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Sources,I#)
            If Errorcode() <> 0
                BREAK
            End
            If c25DbQueueObject.SourceName &= NULL
                Message('error c25DbQueueObject.SourceName')
                Return -1
            End
            If Self.Sources.Name &= NULL
                Message('error Self.Sources.Name &= NULL')
                Return -1
            End
            If Upper(Clip(Self.Sources.Name)) <> Upper(Clip(c25DbQueueObject.SourceName))
                CYCLE
            End
            I2# = 0
            LOOP
                I2# = I2# + 1
                Get(Self.Databases,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Databases.SourcesId <> Self.Sources.Id
                    CYCLE
                End

                If Upper(Clip(Self.Databases.Name)) <> Upper(Clip(c25DbQueueObject.DatabaseName))
                    CYCLE
                End
                If Self.Databases.Instance &= NULL
                    Cycle
                End
                If not c25DbQueueObject.Queue &= null
                    Self.Sources.Instance.QueueDataToSqliteTableEntity(Self.Databases.Instance.DatabaseRecord,,c25DbQueueObject.Queue, Clip(c25DbQueueObject.TableName), c25DbQueueObject.SkipUpdateId, ,_wParam)
                End
                Break
            End
            Break
        End
        Dispose(c25DbQueueObjectMem)
        If not st1 &= NULL
            Dispose(st1)
        End
        Return 0

c25DbAdapterClass.c25_Exec                  Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

c25DbSqlObject                              Group(c25DbSqlObject_TYPE),Pre(c25DbSqlObject)
                                            End
c25DbSqlObjectReturn                        &c25DbSqlObjectReturn_TYPE

!stLog                           &StringTheory

    Code

        Self.WndMessageProcessed = True
        ReturnVal = 0

        If _lParam = 0
            Return ReturnVal
        End
        c25_memcpy(Address(c25DbSqlObject),_lParam,Size(c25DbSqlObject))

!        stLog &= NEW StringTheory()
!        stLog.Start()
!
!        stLog.Append(c25DbSqlObject.Sql & Chr(13) & Chr(10))
!        stLog.SaveFile('m:\log\c25DbAdapterClass_c25_Exec.txt',true)

        If c25DbSqlObject.SourceName &= NULL
            Message('unexpected error, c25DbSqlObject.SourceName is null')
            Return 0
        End

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Sources,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Sources.Name &= NULL
                Message('error Self.Sources.Name &= NULL')
                Return ReturnVal
            End
            If c25DbSqlObject.SourceName &= NULL
                Message('error c25DbSqlObject.SourceName')
                Return ReturnVal
            End
            If Self.Sources.Name &= NULL
                Message('unexpected error, Self.Sources.Name is null')
                Return 0
            End
            If Upper(Clip(Self.Sources.Name)) <> Upper(Clip(c25DbSqlObject.SourceName))
                CYCLE
            End
            I2# = 0
            LOOP
                I2# = I2# + 1
                Get(Self.Databases,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Databases.SourcesId <> Self.Sources.Id
                    CYCLE
                End

                If Upper(Clip(Self.Databases.Name)) <> Upper(Clip(c25DbSqlObject.DatabaseName))
                    CYCLE
                End
                If Self.Databases.Instance &= NULL
                    Cycle
                End
                c25DbSqlObjectReturn &= NEW c25DbSqlObjectReturn_TYPE()
                Clear(c25DbSqlObjectReturn)
                R# = Self.Sources.Instance.Exec(Self.Databases.Instance.DatabaseRecord,,c25DbSqlObject.TableName ,c25DbSqlObject.Sql, ,c25DbSqlObjectReturn)
                ReturnVal = Address(c25DbSqlObjectReturn)

!        stLog.Append('passed on Self.Sources.Instance.Exec' & Chr(13) & Chr(10))
!        stLog.SaveFile('m:\log\c25DbAdapterClass_c25_Exec.txt',true)

                !Dispose(stLog)
                Return ReturnVal
            End
            Break
        End
        !Dispose(stLog)
        Return ReturnVal

c25DbAdapterClass.c25_ExecuteScalar             Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

c25DbSqlObject                              Group(c25DbSqlObject_TYPE),Pre(c25DbSqlObject)
                                            End
c25DbSqlObjectReturn                        &c25DbSqlObjectReturn_TYPE

    Code

        Self.WndMessageProcessed = True
        ReturnVal = 0

        If _lParam = 0
            Return ReturnVal
        End
        c25_memcpy(Address(c25DbSqlObject),_lParam,Size(c25DbSqlObject))

        If c25DbSqlObject.SourceName &= NULL
            Message('unexpected error, c25DbSqlObject.SourceName is null')
            Return 0
        End

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Sources,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Sources.Name &= NULL
                Message('error Self.Sources.Name &= NULL')
                Return ReturnVal
            End
            If c25DbSqlObject.SourceName &= NULL
                Message('error c25DbSqlObject.SourceName')
                Return ReturnVal
            End
            If Self.Sources.Name &= NULL
                Message('unexpected error, Self.Sources.Name is null')
                Return 0
            End
            If Upper(Clip(Self.Sources.Name)) <> Upper(Clip(c25DbSqlObject.SourceName))
                CYCLE
            End
            I2# = 0
            LOOP
                I2# = I2# + 1
                Get(Self.Databases,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Databases.SourcesId <> Self.Sources.Id
                    CYCLE
                End

                If Upper(Clip(Self.Databases.Name)) <> Upper(Clip(c25DbSqlObject.DatabaseName))
                    CYCLE
                End
                If Self.Databases.Instance &= NULL
                    Cycle
                End
                c25DbSqlObjectReturn &= NEW c25DbSqlObjectReturn_TYPE()
                Clear(c25DbSqlObjectReturn)
                R# = Self.Sources.Instance.ExecuteScalar(Self.Databases.Instance.DatabaseRecord,,c25DbSqlObject.TableName ,c25DbSqlObject.Sql, ,c25DbSqlObjectReturn)
                ReturnVal = Address(c25DbSqlObjectReturn)
                Return ReturnVal
            End
            Break
        End
        Return ReturnVal

c25DbAdapterClass.c25_EventsQueue           Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

c25DbEventsQueue        &c25DbEventsQueue_TYPE
MemString               &String,auto

    Code

        Case _wParam
        Of EventsQueueAction:Add
            If _lParam <> 0
                c25DbEventsQueue &= NEW c25DbEventsQueue_TYPE()
                Peek(_lParam,c25DbEventsQueue)
                MemString &= (_lParam)
                Dispose(MemString)
                Self.EventsQueue_Add(c25DbEventsQueue)
                Dispose(c25DbEventsQueue)
            End

        Of EventsQueueAction:Set
        Of EventsQueueAction:Get
            Return Self.EventsQueue
        Of EventsQueueAction:Delete
        End

        Return 0

c25DbAdapterClass.EventsQueue_Get               Procedure(<c25DbEventsQueue_TYPE _c25DbEventsQueue>, <String _eventId>, <String _nanoTimeStamp>)

    Code

        If omitted(_c25DbEventsQueue) = False
            I# = 0
            R# = Records(Self.EventsQueue)
            LOOP R# Times
                I# = I# + 1
                Get(Self.EventsQueue,I#)
                If Self.EventsQueue.Id <> _c25DbEventsQueue.Id
                    CYCLE
                End
                If Self.EventsQueue.NanoTimeStamp <> _c25DbEventsQueue.NanoTimeStamp
                    CYCLE
                End
                Return Self.EventsQueue
            End
        Else
        End
        Clear(Self.EventsQueue)
        Return Self.EventsQueue

c25DbAdapterClass.EventsQueue_Add               Procedure(<c25DbEventsQueue_TYPE _c25DbEventsQueue>, <String _eventId>, <Long _state>, <Long _extraPtr>)

    Code

        Clear(Self.EventsQueue)
        If omitted(_c25DbEventsQueue) = False
            Self.EventsQueue = _c25DbEventsQueue
        Else
            Self.EventsQueue.Id          = _eventId
            Self.EventsQueue.State       = _state
            Self.EventsQueue.ExtraPtr    = _extraPtr
        End
        Self.EventsQueue.NanoTimeStamp = Self.NanoSync.GetSysTime()
        Add(Self.EventsQueue,+Self.EventsQueue.Id)

        Return Self.EventsQueue.NanoTimeStamp

c25DbAdapterClass.EventsQueue_UpdateStatus      Procedure(<c25DbEventsQueue_TYPE _c25DbEventsQueue>, <String _eventId>, <Long _state>, <Long _extraPtr>)

    Code

        If omitted(_c25DbEventsQueue) = False
            I# = 0
            R# = Records(Self.EventsQueue)
            LOOP R# Times
                I# = I# + 1
                Get(Self.EventsQueue,I#)
                If Self.EventsQueue.Id <> _c25DbEventsQueue.Id
                    CYCLE
                End
                If Self.EventsQueue.NanoTimeStamp <> _c25DbEventsQueue.NanoTimeStamp
                    CYCLE
                End
                Self.EventsQueue = _c25DbEventsQueue
                Return Self.EventsQueue
            End
        Else
            Message('not yet implemented')
        End

c25DbAdapterClass.EventsQueue_GetStatus         Procedure(String _eventId, String _nanoTimeStamp, <Long _removeIfState>)

    Code

        Self.NanoTimeStampTEMP = _nanoTimeStamp
        Self.EventIdTEMP = _eventId

        I# = 0
        R# = Records(Self.EventsQueue)
        LOOP R# Times
            I# = I# + 1
            Get(Self.EventsQueue,I#)
            If Self.EventsQueue.NanoTimeStamp <> Self.NanoTimeStampTEMP
                CYCLE
            End
            If Self.EventsQueue.Id <> Self.EventIdTEMP
                CYCLE
            End
            If omitted(_removeIfState) = False
                If Self.EventsQueue.State = _removeIfState
                    State# = Self.EventsQueue.State
                    DELETE(Self.EventsQueue)
                    Return State#
                End
            End
            Return Self.EventsQueue.State
        End

        Return 0

c25DbAdapterClass.SaveQueue                     Procedure(<String _eventId>,<Byte _async>,String _sourceName,<String _databaseName>,<String _tableName>,<String _queueType>,<*Queue _queue>,<Long _queuePtr>,<Byte _skipUpdateId>,<Long _saveQueueToSqlite3Flags>)

c25DbQueueObject                        Group(c25DbQueueObject_TYPE),Pre(c25DbQueueObject)
                                        End
c25DbQueueObjectMem                     &String

    Code

        If omitted(_queuePtr) = False And _queuePtr <> 0
            Message('_queuePtr not yet implemented at c25DbAdapterClass.SaveQueue, use *Queue instead')
            Return -1
        End
        If _queue &= NULL
            Return -1
        End
        ReturnVal = 0
        Clear(c25DbQueueObject)
        c25DbQueueObjectMem                 &= NEW String(Size(c25DbQueueObject))
        If omitted(_eventId) = False
            c25DbQueueObject.Id = _eventId
        Else
            c25DbQueueObject.Id = Self.NanoSync.GetSysTime()
        End
        c25DbQueueObject.SelfAddress = Address(c25DbQueueObjectMem)
        If omitted(_queueType)
            c25DbQueueObject.QueueTypeStr = _queueType
        End
        If omitted(_queuePtr) = False And _queuePtr <> 0
            c25DbQueueObject.QueuePtr  = _queuePtr
        ELSE
            If omitted(_queue) = False
                c25DbQueueObject.QueuePtr = Address(_queue)
            End
        End
        If c25DbQueueObject.QueuePtr = 0
            Message('error c25DatabaseHandlerClass.SaveQueue, can not detect Queue, missing Ptr')
            Return -1
        End
        c25DbQueueObject.SkipUpdateId = _skipUpdateId
        If omitted(_queue) = False
            c25DbQueueObject.Queue &= _queue
        Else
            c25DbQueueObject.Queue &= (c25DbQueueObject.QueuePtr)
        End

        If c25DbQueueObject.Queue &= NULL
            Message('error c25DbQueueObject.Queue &= NULL')
        End
        c25DbQueueObject.SourceName     &= Self.WinApi.AnsiToAnsi(_sourceName)
        If omitted(_databaseName) = False
            c25DbQueueObject.DatabaseName     &= Self.WinApi.AnsiToAnsi(_databaseName)
        End
        If omitted(_tableName) = False
            c25DbQueueObject.TableName     &= Self.WinApi.AnsiToAnsi(_tableName)
        End
        c25DbQueueObject.RecordsCount = Records(c25DbQueueObject.Queue)

        c25DbQueueObjectMem = c25DbQueueObject

        If Clip(c25DbQueueObject.TableName) = 'BiosTypes'
        End

        Self.c25_SaveQueueToSqlite3(Self.AdaptersRecord.WinHandle,c25:SaveQueueToSqlite3,_saveQueueToSqlite3Flags,c25DbQueueObject.SelfAddress)

        Return ReturnVal

c25DbAdapterClass.Exec   Procedure(String _sql, String _sourceName,<String _databaseName>,<String _eventId>,<Byte _async>, <Long _timeoutMMSecs>,<*Byte _isNull>, <*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>, <Long _returnDataType>, <Long _targetPtr>,<String _tableName>,<String _columnName>)

    Code

        Self.ReturnVal = 0
        Self.c25DbSqlObject &= NEW c25DbSqlObject_TYPE()
        Clear(Self.c25DbSqlObject)
        If omitted(_eventId) = False
            Self.c25DbSqlObject.Id = _eventId
        Else
            Self.c25DbSqlObject.Id = Self.NanoSync.GetSysTime()
        End

        Self.c25DbSqlObject.AdapterName          &= Self.WinApi.AnsiToAnsi(Self.AdaptersRecord.Name)
        Self.c25DbSqlObject.SourceName           &= Self.WinApi.AnsiToAnsi(_sourceName)
        If omitted(_databaseName) = False
            Self.c25DbSqlObject.DatabaseName     &= Self.WinApi.AnsiToAnsi(_databaseName)
        End
        If omitted(_tableName) = False
            Self.c25DbSqlObject.TableName        &= Self.WinApi.AnsiToAnsi(_tableName)
        End
        Self.c25DbSqlObject.TargetPtr            = _targetPtr
        Self.c25DbSqlObject.ReturnDataType       = _returnDataType
        Self.c25DbSqlObject.UseSqlObjectReturn   = True

        Self.c25DbSqlObject.Sql                  &= Self.WinApi.BinaryCopy(_sql)
        Self.c25DbSqlObjectMem                   &= NEW String(Size(Self.c25DbSqlObject))

        Self.c25DbSqlObject.SelfAddress          = Address(Self.c25DbSqlObjectMem)
        Self.c25DbSqlObjectMem                   = Self.c25DbSqlObject

        If _async
            P# = c25_PostMessageA(Self.AdaptersRecord.WinHandle,c25:Exec,0,Self.c25DbSqlObject.SelfAddress)
        Else
            P# = c25_SendMessageTimeoutA(Self.AdaptersRecord.WinHandle,c25:Exec,0,Self.c25DbSqlObject.SelfAddress,SMTO_ABORTIFHUNG,30000, Address(Self.ReturnVal))
            If Self.c25DbSqlObject.UseSqlObjectReturn
                If omitted(_c25DbSqlObjectReturn) = False
                    _c25DbSqlObjectReturn.AdapterWinHandle = Self.AdaptersRecord.WinHandle ! usefull, to pass DatabaseHandler, and send directly to the correct AdapterWinhandle (faster and multithreaded)
                    If Self.ReturnVal <> 0
                        c25_memcpy(Address(_c25DbSqlObjectReturn),Self.ReturnVal,Size(_c25DbSqlObjectReturn))
                    End
                End
            End
        End
        If not Self.c25DbSqlObject &= null
            If not Self.c25DbSqlObject.AdapterName &= NULL
                Dispose(Self.c25DbSqlObject.AdapterName)
            End
            If not Self.c25DbSqlObject.SourceName &= NULL
                Dispose(Self.c25DbSqlObject.SourceName)
            End
             If not Self.c25DbSqlObject.DatabaseName &= NULL
                Dispose(Self.c25DbSqlObject.DatabaseName)
            End
             If not Self.c25DbSqlObject.TableName &= NULL
                Dispose(Self.c25DbSqlObject.TableName)
            End
             If not Self.c25DbSqlObject.Sql &= NULL
                Dispose(Self.c25DbSqlObject.Sql)
            End
            Dispose(Self.c25DbSqlObject)
        End
        If not Self.c25DbSqlObjectMem &= NULL
            Dispose(Self.c25DbSqlObjectMem)
        End

        Return 0

c25DbAdapterClass.ExecuteScalar                 Procedure(<String _eventId>,<Byte _async>, <Long _timeoutMMSecs>,<*Byte _isNull>, <*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>, <Long _returnDataType>, <Long _targetPtr>, String _sourceName,String _databaseName,<String _tableName>,<String _columnName>,<String _sql>)

    Code

        Self.ReturnVal = 0
        Self.c25DbSqlObject &= NEW c25DbSqlObject_TYPE()
        Clear(Self.c25DbSqlObject)
        If omitted(_eventId) = False
            Self.c25DbSqlObject.Id = _eventId
        Else
            Self.c25DbSqlObject.Id = Self.NanoSync.GetSysTime()
        End

        Self.c25DbSqlObject.AdapterName          &= Self.WinApi.AnsiToAnsi(Self.AdaptersRecord.Name)
        Self.c25DbSqlObject.SourceName           &= Self.WinApi.AnsiToAnsi(_sourceName)
        If omitted(_databaseName) = False
            Self.c25DbSqlObject.DatabaseName     &= Self.WinApi.AnsiToAnsi(_databaseName)
        End
        If omitted(_tableName) = False
            Self.c25DbSqlObject.TableName        &= Self.WinApi.AnsiToAnsi(_tableName)
        End
        Self.c25DbSqlObject.TargetPtr            = _targetPtr
        Self.c25DbSqlObject.ReturnDataType       = _returnDataType
        Self.c25DbSqlObject.UseSqlObjectReturn   = True

        Self.c25DbSqlObject.Sql                  &= Self.WinApi.BinaryCopy(_sql)
        Self.c25DbSqlObjectMem                   &= NEW String(Size(Self.c25DbSqlObject))

        Self.c25DbSqlObject.SelfAddress          = Address(Self.c25DbSqlObjectMem)
        Self.c25DbSqlObjectMem                   = Self.c25DbSqlObject

        If _async
            P# = c25_PostMessageA(Self.AdaptersRecord.WinHandle,c25:ExecuteScalar,0,Self.c25DbSqlObject.SelfAddress)
        Else
            P# = c25_SendMessageTimeoutA(Self.AdaptersRecord.WinHandle,c25:ExecuteScalar,0,Self.c25DbSqlObject.SelfAddress,SMTO_ABORTIFHUNG,30000, Address(Self.ReturnVal))
            If Self.c25DbSqlObject.UseSqlObjectReturn
                If omitted(_c25DbSqlObjectReturn) = False
                    _c25DbSqlObjectReturn.AdapterWinHandle = Self.AdaptersRecord.WinHandle ! usefull, to pass DatabaseHandler, and send directly to the correct AdapterWinhandle (faster and multithreaded)
                    If Self.ReturnVal <> 0
                        c25_memcpy(Address(_c25DbSqlObjectReturn),Self.ReturnVal,Size(_c25DbSqlObjectReturn))
                    End
                End
            End
        End
        If not Self.c25DbSqlObject &= null
            If not Self.c25DbSqlObject.AdapterName &= NULL
                Dispose(Self.c25DbSqlObject.AdapterName)
            End
            If not Self.c25DbSqlObject.SourceName &= NULL
                Dispose(Self.c25DbSqlObject.SourceName)
            End
             If not Self.c25DbSqlObject.DatabaseName &= NULL
                Dispose(Self.c25DbSqlObject.DatabaseName)
            End
             If not Self.c25DbSqlObject.TableName &= NULL
                Dispose(Self.c25DbSqlObject.TableName)
            End
             If not Self.c25DbSqlObject.Sql &= NULL
                Dispose(Self.c25DbSqlObject.Sql)
            End
            Dispose(Self.c25DbSqlObject)
        End
        If not Self.c25DbSqlObjectMem &= NULL
            Dispose(Self.c25DbSqlObjectMem)
        End

        Return 0

c25DbAdapterClass.c25_GetMachineById     Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

Machine             &MachineClass

    Code

        Self.WndMessageProcessed = True
        Machine &= NEW MachineClass()
        Conn# = Self.GetSqlConnHandleBySourceName('Hardware')
        If Conn# <> 0
            Machine.Init(_wParam, Conn#)
            Get(Machine.BiosPage000,1)
        End
        Return Address(Machine)
        
c25DbAdapterClass.c25_GetSqlite3ConnHandle     Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

!Machine             &MachineClass
SourceName    &String

    Code
        
        !Message('in c25_GetSqlite3ConnHandle')

        Self.WndMessageProcessed = True
!        Machine &= NEW MachineClass()
       ! Self.WinApi.StringRefPtrToString(_lParam)
       ! Message('_lParam ' & _lParam)
        
        !Message(Self.WinApi.StringRefPtrToString(_lParam))
        Conn# = Self.GetSqlConnHandleBySourceName('Hardware')
!        If Conn# <> 0
!            Machine.Init(_wParam, Conn#)
!            Get(Machine.BiosPage000,1)
!        End
!        Return Address(Machine)        
        Return Conn#

c25DbAdapterClass.c25_PrepareServerDBs     Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

Machine             &MachineClass

    Code

        Self.WndMessageProcessed = True
        Self.PrepareServerDBs(_wParam, _lParam)
        Return 0

c25DbAdapterClass.GetSqlConnHandleBySourceName        Procedure(String _sourceName)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Sources,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Sources.Name &= NULL
                Message('error Self.Sources.Name &= NULL')
                Return ReturnVal
            End
            If Self.Sources.Name &= NULL
                Message('unexpected error, Self.Sources.Name is null')
                Return 0
            End
            If Upper(Clip(Self.Sources.Name)) <> Upper(Clip(_sourceName))
                CYCLE
            End
            If Self.Sources.Instance &= NULL
                CYCLE
            End
            If Self.Sources.Instance.Sqlite34 &= NULL
                Cycle
            End
            If Self.Sources.Instance.Sqlite34.ConnHandle = 0
                Message('todo connect')
            End
            Return Self.Sources.Instance.Sqlite34.ConnHandle
        End
        Return ReturnVal

!c25DbAdapterClass.c25_SaveToFileServer            Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)
!
!!c25DbQueueObject                                    Group(c25DbQueueObject_TYPE),Pre(c25DbQueueObject)
!!                                                    End
!!c25DbQueueObjectMem                                 &String
!!st1 &StringTheory
!
!    Code
!
!        Self.WndMessageProcessed = True
!        
!        Self.Tuple2 = Self.FindFreeClientServerChannel()
!        
!        If Self.Tuple2.V1 = 0
!            Return -1 ! no free channel found
!        End
!        
!        
!        
!        c25_PostMessageA(Self.Tuple2.V1, c25:SendDataToSrv, 0 ,0)
!        
!        !Message('start c25DbAdapterClass.c25_SaveToFileServer')
!        
!!        If _lParam = 0
!!            Return -1
!!        End
!!
!!        c25_memcpy(Address(c25DbQueueObject),_lParam,Size(c25DbQueueObject))
!!
!!        c25DbQueueObjectMem &= (_lParam)
!!
!!        I# = 0
!!        LOOP
!!            I# = I# + 1
!!            Get(Self.Sources,I#)
!!            If Errorcode() <> 0
!!                BREAK
!!            End
!!            If c25DbQueueObject.SourceName &= NULL
!!                Message('error c25DbQueueObject.SourceName')
!!                Return -1
!!            End
!!            If Self.Sources.Name &= NULL
!!                Message('error Self.Sources.Name &= NULL')
!!                Return -1
!!            End
!!            If Upper(Clip(Self.Sources.Name)) <> Upper(Clip(c25DbQueueObject.SourceName))
!!                CYCLE
!!            End
!!            I2# = 0
!!            LOOP
!!                I2# = I2# + 1
!!                Get(Self.Databases,I2#)
!!                If Errorcode() <> 0
!!                    BREAK
!!                End
!!                If Self.Databases.SourcesId <> Self.Sources.Id
!!                    CYCLE
!!                End
!!
!!                If Upper(Clip(Self.Databases.Name)) <> Upper(Clip(c25DbQueueObject.DatabaseName))
!!                    CYCLE
!!                End
!!                If Self.Databases.Instance &= NULL
!!                    Cycle
!!                End
!!                If not c25DbQueueObject.Queue &= null
!!                    Self.Sources.Instance.QueueDataToSqliteTableEntity(Self.Databases.Instance.DatabaseRecord,,c25DbQueueObject.Queue, Clip(c25DbQueueObject.TableName), c25DbQueueObject.SkipUpdateId, ,_wParam)
!!                End
!!                Break
!!            End
!!            Break
!!        End
!!        Dispose(c25DbQueueObjectMem)
!!        If not st1 &= NULL
!!            Dispose(st1)
!!        End
!        Return 0
!        
!c25DbAdapterClass.FindFreeClientServerChannel   Procedure()
!
!    Code
!
!        Clear(Self.Tuple2)
!        I# = 0
!L301    Loop
!            I# = I# + 1
!            If Self.GlobalMem.GetClaQRecord('NetSCW',I#, Self.NetSCW) = -1
!                BREAK
!            End
!            If Self.NetSCW.WinHandle = 0
!                Cycle
!            End
!            I2# = 0
!            Loop
!                I2# = I2# + 1
!                If Self.GlobalMem.GetClaQRecord('NetTcpInstances',I2#, Self.NetTcpInstances) = -1
!                    BREAK
!                End
!                If Self.NetTcpInstances.NSCWId <> Self.NetSCW.Id
!                    Cycle
!                End
!                If Self.NetTcpInstances.Free = TRUE
!                    Self.Tuple2.V1 = Self.NetSCW.WinHandle
!                    Self.Tuple2.V2 = Self.NetTcpInstances.NetObjectId
!                    Break L301 
!                End
!            End
!        End
!        Return Self.Tuple2
        
c25DbAdapterClass.WndProc_Process               Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndProc_ReturnVal = 0

        Case _winMes
!        Of c25:SaveToFileServer
!            Self.WndProc_ReturnVal = Self.c25_SaveToFileServer(_winHandle,_winMes,_wParam,_lParam)        
        Of c25:GetSqlite3ConnHandle
            Self.WndProc_ReturnVal = Self.c25_GetSqlite3ConnHandle(_winHandle,_winMes,_wParam,_lParam)
        Of c25:PrepareServerDBs
            Self.WndProc_ReturnVal = Self.c25_PrepareServerDBs(_winHandle,_winMes,_wParam,_lParam)
        Of c25:GetMachineById
            Self.WndProc_ReturnVal = Self.c25_GetMachineById(_winHandle,_winMes,_wParam,_lParam)
        Of c25:EventsQueue
            Self.WndProc_ReturnVal = Self.c25_EventsQueue(_winHandle,_winMes,_wParam,_lParam)
        Of c25:Exec
            Self.WndProc_ReturnVal = Self.c25_Exec(_winHandle,_winMes,_wParam,_lParam)
        Of c25:ExecuteScalar
            Self.WndProc_ReturnVal = Self.c25_ExecuteScalar(_winHandle,_winMes,_wParam,_lParam)
        Of c25:SaveQueueToSqlite3 ! async todo: wparam ptr to synctime64 for promise
            Self.WndProc_ReturnVal = Self.c25_SaveQueueToSqlite3(_winHandle,_winMes,_wParam,_lParam)
        Of c25:AdapterReady
            Self.WndProc_ReturnVal = Self.c25_AdapterReady(_winHandle,_winMes,_wParam,_lParam)
        Of c25:CreateIndexes
            Self.WndProc_ReturnVal = Self.c25_CreateIndexes(_winHandle,_winMes,_wParam,_lParam)
        Of c25:CreateTables
            Self.WndProc_ReturnVal = Self.c25_CreateTables(_winHandle,_winMes,_wParam,_lParam)
        Of c25:CreateDatabase
            Self.WndProc_ReturnVal = Self.c25_CreateDatabases(_winHandle,_winMes,_wParam,_lParam)
        Of c25:TEST
            Self.WndProc_ReturnVal = Self.WM_TEST(_winHandle,_winMes,_wParam,_lParam)
        Of c25:SETFIELD
            Self.WndProc_ReturnVal = Self.WM_SETFIELD(_winHandle,_winMes,_wParam,_lParam)
        End

        If Self.WndMessageProcessed = 0
            Case _winMes
            Of WM_CLOSE
                Self.WndProc_ReturnVal = Self.WM_000016_WM_CLOSE(_winHandle,_winMes,_wParam,_lParam)
            Of WM_TIMER
                Self.WndProc_ReturnVal = Self.WM_000275_WM_TIMER(_winHandle,_winMes,_wParam,_lParam)
            ELSE
                Self.WndProc_ReturnVal = Self.DummyProc()
            End
        End
        If Self.WndMessageProcessed = TRUE
            Return Self.WndProc_ReturnVal
        End
        Return c25_DefWindowProcA(_winHandle, _winMes, _wParam, _lParam)

