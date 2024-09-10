                    Member
                        Include('c25_DatabaseHandlerClass.inc'), once

                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
DbAdapterThread                 Procedure(Long _paramA, Long _paramB),Long
                        End

c25DatabaseHandlerClass.Construct                           Procedure()

    Code

        Self.NanoSync               &= NEW NanoSyncClass()
        Self.c25EFObjects           &= NEW c25EFObject_TYPE
        Self.c25EFObjectsTree       &= NEW c25EFObject_TYPE
        Self.SelfAddress            = Address(Self)
        Self.InitReady              = True
        Self.MsSql                  &= NEW c25MsSqlClass()
        Self.WinApi                 &= NEW WinApi32Class()

        
        
c25DatabaseHandlerClass.GetSqlite34ConnHandle               Procedure(String _adapterName, String _sourceName, String _dbName)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Adapters,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Upper(clip(Self.Adapters.Name)) <> Upper(clip(_adapterName))
                CYCLE
            End
            I2# = 0
            LOOP
                I2# = I2# + 1
                Get(Self.Sources,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If OMITTED(_sourceName) = False
                    If Upper(clip(Self.Sources.Name)) <> Upper(clip(_sourceName))
                        CYCLE
                    End
                End

                If Self.Sources.Instance &= NULL
                    Message('Self.Sources.Instance &= NULL ' )
                    CYCLE
                End

                I3# = 0
                LOOP
                    I3# = I3# + 1
                    Get(Self.Databases,I3#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Upper(Self.Databases.Name) <> Upper(_dbName)
                        CYCLE
                    End
                    If Self.Databases.InstancePtr = 0
                        CYCLE
                    End
                    If Self.Databases.Instance &= NULL
                        CYCLE
                    End
                    If Self.Sources.Instance.Sqlite34ConnHandle = 0
                        Self.Sources.Instance.Sqlite34Connect(Self.Databases.Instance.DatabaseRecord)
                    End
                    Return Self.Sources.Instance.Sqlite34ConnHandle
                End
            End
        End
        Return 0

c25DatabaseHandlerClass.SaveQueue       Procedure(<String _eventId>,<Byte _async>,String _adapterName,String _sourceName,<String _databaseName>,<String _tableName>,<String _queueType>,<*Queue _queue>,<Long _queuePtr>,<Byte _skipUpdateId>)

AdapterWinHandle                        Long
c25DbQueueObject                        Group(c25DbQueueObject_TYPE),Pre(c25DbQueueObject)
                                        End
c25DbQueueObjectMem                     &String

    Code

        ReturnVal = 0
        AdapterWinHandle = Self.GetWinHandleByAdapterName(Clip(Left(_adapterName)))
        If AdapterWinHandle = 0
            Return ReturnVal
        End
        Clear(c25DbQueueObject)
        c25DbQueueObjectMem                 &= NEW String(Size(c25DbQueueObject))
        If omitted(_eventId) = False
            c25DbQueueObject.Id = _eventId
        Else
            c25DbQueueObject.Id = Self.NanoSync.GetSysTime()
        End
        c25DbQueueObject.SelfAddress        = Address(c25DbQueueObjectMem)
        If omitted(_queueType)
            c25DbQueueObject.QueueTypeStr       = _queueType
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

        c25DbQueueObject.AdapterName    &= Self.WinApi.AnsiToAnsi(_adapterName)
        c25DbQueueObject.SourceName     &= Self.WinApi.AnsiToAnsi(_sourceName)
        If omitted(_databaseName) = False
            c25DbQueueObject.DatabaseName     &= Self.WinApi.AnsiToAnsi(_databaseName)
        End
        If omitted(_tableName) = False
            c25DbQueueObject.TableName     &= Self.WinApi.AnsiToAnsi(_tableName)
        End
        c25DbQueueObject.RecordsCount = Records(c25DbQueueObject.Queue)

        c25DbQueueObjectMem = c25DbQueueObject

        P# = c25_PostMessageA(AdapterWinHandle,c25:SaveQueueToSqlite3,0,c25DbQueueObject.SelfAddress)
        Return ReturnVal

c25DatabaseHandlerClass.ExecuteScalar       Procedure(<String _eventId>, <Byte _async>, <Long _timeoutMMSecs>,<*Byte _isNull>, <*c25DbSqlObjectReturn_TYPE _c25DbSqlObjectReturn>, <Long _returnDataType>, <Long _targetPtr>, String _adapterName,String _sourceName,String _databaseName,<String _tableName>,<String _columnName>,String _sql)

    Code

        Self.AdapterWinHandle_TEMP = Self.GetWinHandleByAdapterName(Clip(Left(_adapterName)))
        If Self.AdapterWinHandle_TEMP = 0
            Return 0
        End
        Self.ReturnVal = 0
        Self.c25DbSqlObject &= NEW c25DbSqlObject_TYPE()
        Clear(Self.c25DbSqlObject)
        If omitted(_eventId) = False
            Self.c25DbSqlObject.Id = _eventId
        Else
            Self.c25DbSqlObject.Id = Self.NanoSync.GetSysTime()
        End

        Self.c25DbSqlObject.AdapterName          &= Self.WinApi.AnsiToAnsi(_adapterName)
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
            P# = c25_PostMessageA(Self.AdapterWinHandle_TEMP,c25:ExecuteScalar,0,Self.c25DbSqlObject.SelfAddress)
        Else
            P# = c25_SendMessageTimeoutA(Self.AdapterWinHandle_TEMP,c25:ExecuteScalar,0,Self.c25DbSqlObject.SelfAddress,SMTO_ABORTIFHUNG,30000, Address(Self.ReturnVal))
            If Self.c25DbSqlObject.UseSqlObjectReturn
                If omitted(_c25DbSqlObjectReturn) = False
                    _c25DbSqlObjectReturn.AdapterWinHandle = Self.AdapterWinHandle_TEMP ! usefull, to pass DatabaseHandler, and send directly to the correct AdapterWinhandle (faster and multithreaded)
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

c25DatabaseHandlerClass.GetWinHandleByAdapterName           Procedure(String _adapterName)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Adapters,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Upper(clip(Self.Adapters.Name)) <> Upper(clip(_adapterName))
                CYCLE
            End
            Return Self.Adapters.WinHandle
        End
        Return 0

c25DatabaseHandlerClass.GetAdapterByAdapterName           Procedure(String _adapterName, <Long _dbEngineType>)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Adapters,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Upper(clip(Self.Adapters.Name)) <> Upper(clip(_adapterName))
                CYCLE
            End
            If omitted(_dbEngineType) = False
                If Self.Adapters.DbEngineType <> _dbEngineType
                    CYCLE
                End
            End
            Return Self.Adapters.InstancePtr
        End
        Return 0

c25DatabaseHandlerClass.GetDbDatabaseBySourceName           Procedure(String _adapterName, String _sourceName, <Long _dbEngineType>)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Adapters,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Upper(clip(Self.Adapters.Name)) <> Upper(clip(_adapterName))
                CYCLE
            End
            If omitted(_dbEngineType) = False
                If Self.Adapters.DbEngineType <> _dbEngineType
                    CYCLE
                End
            End
            If Self.Adapters.Instance &= NULL
                CYCLE
            End
            If Self.Adapters.Instance.Sources &= NULL
                CYCLE
            End
            I2# = 0
            Loop
                I2# = I2# + 1
                Get(Self.Adapters.Instance.Sources,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Adapters.Instance.Sources.Name &= NULL
                    CYCLE
                End
                If Upper(Clip(Self.Adapters.Instance.Sources.Name)) <> Upper(Clip(_sourceName))
                    Cycle
                End
                If Self.Adapters.Instance.Sources.Instance &= NULL
                    CYCLE
                End
                If Self.Adapters.Instance.Sources.Instance.Databases &= NULL
                    CYCLE
                End
                I3# = 0
                Loop
                    I3# = I3# + 1
                    Get(Self.Adapters.Instance.Sources.Instance.Databases,I3#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Self.Adapters.Instance.Sources.Instance.Databases &= NULL
                        CYCLE
                    End
                    Return Self.Adapters.Instance.Sources.Instance.Databases
                End
            End
        End
        If Self.DatabasesTemp &= NULL
            Self.DatabasesTemp &= NEW c25DbDatabases_TYPE
        End
        Clear(Self.DatabasesTemp)
        Return Self.DatabasesTemp

c25DatabaseHandlerClass.SendAdapterMessage                  Procedure(String _adapterName, Long _mes)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Adapters,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Upper(Self.Adapters.Name) <> Upper(_adapterName)
                CYCLE
            End
            c25_PostMessageA(Self.Adapters.WinHandle, c25:TEST, 0, 0)
            Break
        End
        Return 0

c25DatabaseHandlerClass.Init                                Procedure(Long _paramA)

ThreadInfo          Group,Pre(ThreadInfo)
ThreadHandle            Long
ThreadId                Long
Ptr                     Long
                    End
stLog               &StringTheory

    Code

        Self.CRLF                                        = Chr(13)& Chr(10)
        Self.NanoSync                                    &= New NanoSyncClass()

        Self.Sqlite34                                    &= New Sqlite34Class()
        Self.Sqlite34Temp                                &= New Sqlite34Class()

        Self.TrueReflection                              &= NEW TrueReflectionClass()
        Self.NanoSync                                    &= NEW NanoSyncClass()
        Self.WinApi                                    &= NEW WinApi32Class()

        Self.Connections                                 &= NEW c25DbConnections_TYPE
        Self.ConnectionStrings                           &= NEW c25DbConnectionStrings_TYPE

        Self.Adapters                                    &= NEW c25DbAdapters_TYPE
        Self.Sources                                     &= NEW c25DbSources_TYPE
        Self.Databases                                   &= NEW c25DbDatabases_TYPE
        Self.Tables                                      &= NEW c25DbTables_TYPE
        Self.TableColumns                                &= NEW c25DbTableColumns_TYPE

        Self.st1                                         &= NEW StringTheory()
        Self.st2                                         &= NEW StringTheory()
        Self.st3                                         &= NEW StringTheory()
        Self.st4                                         &= NEW StringTheory()
        Self.st5                                         &= NEW StringTheory()

        Self.SetDefaultModel()

        I# = 0
        Loop
            I# = I# + 1
            Get(Self.Adapters,I#)
            If Errorcode() <> 0
                BREAK
            End
            Self.Adapters.Closed            = True
            Self.Adapters.ParentPtr         = Address(Self)
            Put(Self.Adapters)
            Self.ProcessNextAdapter = False
            DbHandlerPtr = Address(Self)
            DbAdapterIndex = I#

            ThreadInfo.ThreadHandle         = c25_CreateThread(0, 010000h, Address(DbAdapterThread), 777, 0,Address(ThreadInfo.ThreadId))
            Self.Adapters.ThreadHandle      = ThreadInfo.ThreadHandle
            Self.Adapters.ThreadId          = ThreadInfo.ThreadId
            Put(Self.Adapters)
            Loop
                c25_sleepex(150,0)
                If Self.ProcessNextAdapter = True
                    Self.Adapters.WinHandle     = Self.Adapters.Instance.AdaptersRecord.WinHandle
                    Self.Adapters.InstancePtr   = Address(Self.Adapters.Instance)
                    Self.Adapters.Instance     &= Self.Adapters.Instance
                    Put(Self.Adapters)
                    Break
                End
            End
        End
        InitReady# = True
        Loop
            c25_sleepex(150,0)
            InitReady# = True
            I# = 0
            Loop
                I# = I# + 1
                Get(Self.Adapters,I#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.Adapters.Id = 0
                    CYCLE
                End
                If Self.Adapters.Instance &= NULL
                    CYCLE
                End
                If Self.Adapters.Instance.AdaptersRecord.InitDone = 0
                    InitReady# = 0
                    BREAK
                    CYCLE
                End
            End
            If InitReady# = True
                BREAK
            End
        End

        c25_sleepex(2000,0)
        Self.EFMapMeta()
        Self.InitReady = True
        Return Self.InitReady

c25DatabaseHandlerClass.Destruct                            Procedure()

    Code

c25DatabaseHandlerClass.GetSelfAddress                      Procedure()

    Code

        Self.SelfAddress = Address(Self)
        Return Self.SelfAddress

c25DatabaseHandlerClass.WndProcTest                         Procedure()

    Code

    Return 0

c25DatabaseHandlerClass.EFMapMeta                           Procedure()

AdapterObject           &c25DbAdapterClass
SourceObject            &c25DbSourceClass
DatabaseObject          &c25DbDatabaseClass
TableObject             &c25DbTableClass
ColumnObject            &c25DbTableColumnClass
DataBasesQ              &c25DbDatabases_TYPE
SourceQ                 &c25DbSources_TYPE
TablesQ                 &c25DbTables_TYPE
ColumnsQ                &c25DbTableColumns_TYPE
PrintLog                Byte

    Code

        Self.st1.Start()
        If not Self.c25EFObjects &= null
            Free(Self.c25EFObjects)
        ELSE
            Self.c25EFObjects &= NEW c25EFObject_TYPE
        End

        If not Self.c25EFObjectsTree &= null
            Free(Self.c25EFObjectsTree)
        ELSE
            Self.c25EFObjectsTree &= NEW c25EFObject_TYPE
        End

        Clear(Self.c25EFObjectsTree)
        Self.c25EFObjectsTree.ModelName                 = ''
        Self.c25EFObjectsTree.ModelId                   = 0
        Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
        Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
        Self.c25EFObjectsTree.Line                      = 'ObjectsTree'
        Self.c25EFObjectsTree.LineIconId                = 0
        Self.c25EFObjectsTree.LineLevel                 = 0
        Self.c25EFObjectsTree.LineStyleId               = 0
        Add(Self.c25EFObjectsTree)

        Self.c25EFObjectsTree.ModelName                 = ''
        Self.c25EFObjectsTree.ModelId                   = 0
        Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
        Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
        Self.c25EFObjectsTree.Line                      = 'Adapters'
        Self.c25EFObjectsTree.LineIconId                = 0
        Self.c25EFObjectsTree.LineLevel                 = 1
        Self.c25EFObjectsTree.LineStyleId               = 0
        Add(Self.c25EFObjectsTree)

        I# = 0
        Loop
            I# = I# + 1
            Get(Self.Adapters,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Adapters.Instance &= NULL
                CYCLE
            End
            If Self.Adapters.Instance.Sources &= NULL
                CYCLE
            End
            AdapterObject &= Self.Adapters.Instance
            SourceQ &= AdapterObject.Sources

            Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
            Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
            Self.c25EFObjectsTree.ModelName                 = ''
            Self.c25EFObjectsTree.ModelId                   = 0
            Self.c25EFObjectsTree.AdapterId                 = AdapterObject.AdaptersRecord.Id
            Self.c25EFObjectsTree.AdapterName               = AdapterObject.AdaptersRecord.Name
            Self.c25EFObjectsTree.AdapterThreadHandle       = AdapterObject.AdaptersRecord.ThreadHandle
            Self.c25EFObjectsTree.AdapterInstancePtr        = Self.Adapters.InstancePtr
            Self.c25EFObjectsTree.AdapterInstance           &= AdapterObject
            Self.c25EFObjectsTree.Line                      = Left(Format(AdapterObject.AdaptersRecord.Id,@N_8) & '. ' & AdapterObject.AdaptersRecord.Name)
            Self.c25EFObjectsTree.LineIconId                = 0
            Self.c25EFObjectsTree.LineLevel                 = 2
            Self.c25EFObjectsTree.LineStyleId               = 0
            Add(Self.c25EFObjectsTree)

            Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
            Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
            Self.c25EFObjectsTree.ModelName                 = ''
            Self.c25EFObjectsTree.ModelId                   = 0
            Self.c25EFObjectsTree.Line                      = 'Sources'
            Self.c25EFObjectsTree.LineIconId                = 0
            Self.c25EFObjectsTree.LineLevel                 = 3
            Self.c25EFObjectsTree.LineStyleId               = 0
            Add(Self.c25EFObjectsTree)

            I2# = 0
            LOOP
                I2# = I2# + 1
                Get(SourceQ,I2#)
                If Errorcode() <> 0
                    BREAK
                End
                If SourceQ.Instance &= NULL
                    CYCLE
                End
                If SourceQ.Instance.Databases &= NULL
                    CYCLE
                End
                SourceObject &= SourceQ.Instance

                Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
                Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
                Self.c25EFObjectsTree.ModelName                 = ''
                Self.c25EFObjectsTree.ModelId                   = 0
                Self.c25EFObjectsTree.AdapterId                 = AdapterObject.AdaptersRecord.Id
                Self.c25EFObjectsTree.AdapterName               = AdapterObject.AdaptersRecord.Name
                Self.c25EFObjectsTree.AdapterThreadHandle       = AdapterObject.AdaptersRecord.ThreadHandle
                Self.c25EFObjectsTree.AdapterInstancePtr        = Self.Adapters.InstancePtr
                Self.c25EFObjectsTree.AdapterInstance           &= AdapterObject
                Self.c25EFObjectsTree.SourceId                  = SourceObject.SourceRecord.Id
                Self.c25EFObjectsTree.SourceName                = SourceObject.SourceRecord.Name
                Self.c25EFObjectsTree.SourceInstancePtr         = SourceQ.InstancePtr
                Self.c25EFObjectsTree.SourceInstance           &= SourceQ.Instance
                Self.c25EFObjectsTree.Line                      = Left(Format(SourceObject.SourceRecord.Id,@N_8) & '. ' & SourceObject.SourceRecord.Name)
                Self.c25EFObjectsTree.LineIconId                = 0
                Self.c25EFObjectsTree.LineLevel                 = 4
                Self.c25EFObjectsTree.LineStyleId               = 0
                Add(Self.c25EFObjectsTree)

                Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
                Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
                Self.c25EFObjectsTree.ModelName                 = ''
                Self.c25EFObjectsTree.ModelId                   = 0
                Self.c25EFObjectsTree.Line                      = 'Databases'
                Self.c25EFObjectsTree.LineIconId                = 0
                Self.c25EFObjectsTree.LineLevel                 = 5
                Self.c25EFObjectsTree.LineStyleId               = 0
                Add(Self.c25EFObjectsTree)

                DataBasesQ &= SourceObject.Databases
                I3# = 0
                LOOP
                    I3# = I3# + 1
                    Get(DataBasesQ,I3#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If DataBasesQ.Instance &= NULL
                        CYCLE
                    End
                    If DataBasesQ.Instance.Tables &= NULL
                        CYCLE
                    End
                    DatabaseObject &= DataBasesQ.Instance

                    Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
                    Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
                    Self.c25EFObjectsTree.ModelName                 = ''
                    Self.c25EFObjectsTree.ModelId                   = 0
                    Self.c25EFObjectsTree.AdapterId                 = AdapterObject.AdaptersRecord.Id
                    Self.c25EFObjectsTree.AdapterName               = AdapterObject.AdaptersRecord.Name
                    Self.c25EFObjectsTree.AdapterThreadHandle       = AdapterObject.AdaptersRecord.ThreadHandle
                    Self.c25EFObjectsTree.AdapterInstancePtr        = Self.Adapters.InstancePtr
                    Self.c25EFObjectsTree.AdapterInstance           &= AdapterObject
                    Self.c25EFObjectsTree.SourceId                  = SourceObject.SourceRecord.Id
                    Self.c25EFObjectsTree.SourceName                = SourceObject.SourceRecord.Name
                    Self.c25EFObjectsTree.SourceInstancePtr         = SourceQ.InstancePtr
                    Self.c25EFObjectsTree.SourceInstance           &= SourceQ.Instance
                    Self.c25EFObjectsTree.DatabaseId                = DatabaseObject.DatabaseRecord.Id
                    Self.c25EFObjectsTree.DatabaseName              = DatabaseObject.DatabaseRecord.Name
                    Self.c25EFObjectsTree.DatabaseInstancePtr       = DataBasesQ.InstancePtr
                    Self.c25EFObjectsTree.DatabaseInstance          &= DatabaseObject
                    Self.c25EFObjectsTree.Line                      = Left(Format(DatabaseObject.DatabaseRecord.Id,@N_8) & '. ' & DatabaseObject.DatabaseRecord.Name)
                    Self.c25EFObjectsTree.LineIconId                = 0
                    Self.c25EFObjectsTree.LineLevel                 = 6
                    Self.c25EFObjectsTree.LineStyleId               = 0
                    Add(Self.c25EFObjectsTree)

                    Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
                    Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
                    Self.c25EFObjectsTree.ModelName                 = ''
                    Self.c25EFObjectsTree.ModelId                   = 0
                    Self.c25EFObjectsTree.Line                      = 'Tables'
                    Self.c25EFObjectsTree.LineIconId                = 0
                    Self.c25EFObjectsTree.LineLevel                 = -7
                    Self.c25EFObjectsTree.LineStyleId               = 0
                    Add(Self.c25EFObjectsTree)
                    TablesQ &= DatabaseObject.Tables
                    I4# = 0
                    LOOP
                        I4# = I4# + 1
                        Get(TablesQ,I4#)
                        If Errorcode() <> 0
                            BREAK
                        End
                        If TablesQ.Instance &= NULL
                            CYCLE
                        End
                        TableObject &= TablesQ.Instance

                        Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
                        Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
                        Self.c25EFObjectsTree.ModelName                 = ''
                        Self.c25EFObjectsTree.ModelId                   = 0
                        Self.c25EFObjectsTree.AdapterId                 = AdapterObject.AdaptersRecord.Id
                        Self.c25EFObjectsTree.AdapterName               = AdapterObject.AdaptersRecord.Name
                        Self.c25EFObjectsTree.AdapterThreadHandle       = AdapterObject.AdaptersRecord.ThreadHandle
                        Self.c25EFObjectsTree.AdapterInstancePtr        = Self.Adapters.InstancePtr
                        Self.c25EFObjectsTree.AdapterInstance           &= AdapterObject
                        Self.c25EFObjectsTree.SourceId                  = SourceObject.SourceRecord.Id
                        Self.c25EFObjectsTree.SourceName                = SourceObject.SourceRecord.Name
                        Self.c25EFObjectsTree.SourceInstancePtr         = SourceQ.InstancePtr
                        Self.c25EFObjectsTree.SourceInstance           &= SourceQ.Instance
                        Self.c25EFObjectsTree.DatabaseId                = DatabaseObject.DatabaseRecord.Id
                        Self.c25EFObjectsTree.DatabaseName              = DatabaseObject.DatabaseRecord.Name
                        Self.c25EFObjectsTree.DatabaseInstancePtr       = DataBasesQ.InstancePtr
                        Self.c25EFObjectsTree.DatabaseInstance          &= DatabaseObject
                        Self.c25EFObjectsTree.TableId                   = TableObject.TablesRecord.Id
                        Self.c25EFObjectsTree.TableName                 = TableObject.TablesRecord.Name
                        Self.c25EFObjectsTree.TableInstancePtr          = TablesQ.InstancePtr
                        Self.c25EFObjectsTree.TableInstance             &= TableObject
                        Self.c25EFObjectsTree.Line                      = Left(Format(TableObject.TablesRecord.Id,@N_8) & '. ' & TableObject.TablesRecord.Name)
                        Self.c25EFObjectsTree.LineIconId                = 0
                        Self.c25EFObjectsTree.LineLevel                 = -8
                        Self.c25EFObjectsTree.LineStyleId               = 0
                        Add(Self.c25EFObjectsTree)

                        Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
                        Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
                        Self.c25EFObjectsTree.ModelName                 = ''
                        Self.c25EFObjectsTree.ModelId                   = 0
                        Self.c25EFObjectsTree.Line                      = 'Columns'
                        Self.c25EFObjectsTree.LineIconId                = 0
                        Self.c25EFObjectsTree.LineLevel                 = 9
                        Self.c25EFObjectsTree.LineStyleId               = 0
                        Add(Self.c25EFObjectsTree)

                        ColumnsQ &= TableObject.TableColumns
                        If Records(ColumnsQ) < 1
                            Self.st1.Append('TableObject.Columns records count = 0' & Self.CRLF)
                        End
                        I5# = 0
                        LOOP
                            I5# = I5# + 1
                            Get(ColumnsQ,I5#)
                            If Errorcode() <> 0
                                BREAK
                            End
                            If ColumnsQ.Instance &= NULL
                                Self.st1.Append('ColumnsQ.Instance &= NULL' & Self.CRLF)
                                CYCLE
                            End
                            ColumnObject &= ColumnsQ.Instance

                            Self.c25EFObjectsTreeIdSeed                     = Self.c25EFObjectsTreeIdSeed + 1
                            Self.c25EFObjectsTree.Id                        = Self.c25EFObjectsTreeIdSeed
                            Self.c25EFObjectsTree.ModelName                 = ''
                            Self.c25EFObjectsTree.ModelId                   = 0
                            Self.c25EFObjectsTree.AdapterId                 = AdapterObject.AdaptersRecord.Id
                            Self.c25EFObjectsTree.AdapterName               = AdapterObject.AdaptersRecord.Name
                            Self.c25EFObjectsTree.AdapterThreadHandle       = AdapterObject.AdaptersRecord.ThreadHandle
                            Self.c25EFObjectsTree.AdapterInstancePtr        = Self.Adapters.InstancePtr
                            Self.c25EFObjectsTree.AdapterInstance           &= AdapterObject
                            Self.c25EFObjectsTree.SourceId                  = SourceObject.SourceRecord.Id
                            Self.c25EFObjectsTree.SourceName                = SourceObject.SourceRecord.Name
                            Self.c25EFObjectsTree.SourceInstancePtr         = SourceQ.InstancePtr
                            Self.c25EFObjectsTree.SourceInstance           &= SourceQ.Instance
                            Self.c25EFObjectsTree.DatabaseId                = DatabaseObject.DatabaseRecord.Id
                            Self.c25EFObjectsTree.DatabaseName              = DatabaseObject.DatabaseRecord.Name
                            Self.c25EFObjectsTree.DatabaseInstancePtr       = DataBasesQ.InstancePtr
                            Self.c25EFObjectsTree.DatabaseInstance          &= DatabaseObject
                            Self.c25EFObjectsTree.TableId                   = TableObject.TablesRecord.Id
                            Self.c25EFObjectsTree.TableName                 = TableObject.TablesRecord.Name
                            Self.c25EFObjectsTree.TableInstancePtr          = TablesQ.InstancePtr
                            Self.c25EFObjectsTree.TableInstance             &= TableObject
                            Self.c25EFObjectsTree.ColumnId                  = ColumnObject.ColumnsRecord.Id
                            Self.c25EFObjectsTree.ColumnName                = ColumnObject.ColumnsRecord.Name
                            Self.c25EFObjectsTree.ColumnInstancePtr         = ColumnsQ.InstancePtr
                            Self.c25EFObjectsTree.ColumnInstance            &= ColumnObject
                            Self.c25EFObjectsTree.TableTypeName             = ''
                            Self.c25EFObjectsTree.TableType                 &= null

                            Self.c25EFObjectsTree.Line                      = Left(Format(ColumnObject.ColumnsRecord.Id,@N_8) & '. ' & ColumnObject.ColumnsRecord.Name)
                            Self.c25EFObjectsTree.LineIconId                = 0
                            Self.c25EFObjectsTree.LineLevel                 = 10
                            Self.c25EFObjectsTree.LineStyleId               = 0
                            Add(Self.c25EFObjectsTree)

                            ColumnObject &= NULL
                        End
                        ColumnsQ &= null
                        TableObject &= null
                    End
                    TablesQ &= null
                    DatabaseObject &= null
                End
            End
            AdapterObject &= null
        End
        Return 0

c25DatabaseHandlerClass.GetEFMapQType                       Procedure(String _typeName, <*queue _type>)

ThisType &queue ! leak?

    Code

        Case Upper(_typeName)
            include('c25EFMapTypes.clw')
        End
        If OMITTED(_type) = False
            _type &= ThisType
            Return NULL
        Else
            Return ThisType
        End
        Return null

c25DatabaseHandlerClass.SetDefaultModel                     Procedure()

JSon            &JSonClass()
ClarionFields   &ClarionFields_TYPE
AdaptersFlat    &c25DbAdaptersFlat_TYPE
SourcesFlat     &c25DbSourcesFlat_TYPE
DatabasesFlat   &c25DbDatabasesFlat_TYPE
TablesFlat      &c25DbTablesFlat_TYPE
test            cstring(1000)

    Code

        JSon &= NEW JsonClass()

        AdaptersFlat   &= NEW c25DbAdaptersFlat_TYPE()
        JSon.Start()
        JSon.SetTagCase(jF:CaseAsIs)
        Self.st1.Start()
        Self.st1.SetValue(Self.WinApi.GetGlobalDictionaryValue('Adapters.json'))
        JSon.Load(AdaptersFlat, Self.st1)

        I# = 0
        LOOP
            I# = I# + 1
            Get(AdaptersFlat,I#)
            If Errorcode() <> 0
                BREAK
            End
            Clear(Self.Adapters)
            Self.Adapters.Id                    = AdaptersFlat.Id
            Self.Adapters.Name                  &= Self.WinApi.AnsiToAnsi(AdaptersFlat.Name)
            Self.Adapters.ToStart               = AdaptersFlat.ToStart
            Self.Adapters.Starting              = AdaptersFlat.Starting
            Self.Adapters.Started               = AdaptersFlat.Started
            Self.Adapters.ToClose               = AdaptersFlat.ToClose
            Self.Adapters.Closing               = AdaptersFlat.Closing
            Self.Adapters.Closed                = AdaptersFlat.Closed
            Self.Adapters.ThreadId              = AdaptersFlat.ThreadId
            Self.Adapters.ThreadHandle          = AdaptersFlat.ThreadHandle
            Self.Adapters.Create                = AdaptersFlat.Create
            Self.Adapters.Creating              = AdaptersFlat.Creating
            Self.Adapters.Created               = AdaptersFlat.Created
            Self.Adapters.PrimaryConnHandle     = AdaptersFlat.PrimaryConnHandle
            Self.Adapters.DbEngineType          = AdaptersFlat.DbEngineType
            Self.Adapters.ParentPtr             = AdaptersFlat.ParentPtr
            Self.Adapters.WinHandle             = AdaptersFlat.WinHandle
            Self.Adapters.TimerIDEvent          = AdaptersFlat.TimerIDEvent
            Self.Adapters.InitDone              = AdaptersFlat.InitDone
            Self.Adapters.Instance              &= null
            Add(Self.Adapters)
        End
        Free(AdaptersFlat)
        Dispose(AdaptersFlat)

        SourcesFlat &= NEW c25DbSourcesFlat_TYPE()

        JSon.Start()
        JSon.SetTagCase(jF:CaseAsIs)
        Self.st1.Start()
        Self.st1.SetValue(Self.WinApi.GetGlobalDictionaryValue('Sources.json'))
        JSon.Load(SourcesFlat, Self.st1)

        I# = 0
        LOOP
            I# = I# + 1
            Get(SourcesFlat,I#)
            If Errorcode() <> 0
                BREAK
            End
            Self.Sources.Id                                                          = SourcesFlat.Id
            Self.Sources.Name                                                        &= Self.WinApi.AnsiToAnsi(SourcesFlat.Name)
            Self.Sources.Ordinal                                                     = SourcesFlat.Ordinal
            Self.Sources.Type                                                        = SourcesFlat.Type
            Self.Sources.DbAdapterId                                                 = SourcesFlat.DbAdapterId
            Self.Sources.DbConnectionStringId                                        = SourcesFlat.DbConnectionStringId
            Self.Sources.IsPrimary                                                   = SourcesFlat.IsPrimary
            Self.Sources.AttachToPrimary                                             = SourcesFlat.AttachToPrimary
            Self.Sources.OnDisk                                                      = SourcesFlat.OnDisk
            Self.Sources.LoadFromDisk                                                = SourcesFlat.LoadFromDisk
            Self.Sources.Instance                                                    &= null
            Self.Sources.InstancePtr                                                 = 0
            Self.Sources.DbAliasName                                                 &= Self.WinApi.AnsiToAnsi(SourcesFlat.DbAliasName)
            Self.Sources.Exists                                                      = SourcesFlat.Exists
            Self.Sources.DeleteAlways                                                = SourcesFlat.DeleteAlways
            Self.Sources.DeleteAsk                                                   = SourcesFlat.DeleteAsk
            Self.Sources.DeleteFailed                                                = SourcesFlat.DeleteFailed
            Self.Sources.DeleteErrorcode                                             = SourcesFlat.DeleteErrorcode
            Self.Sources.DeleteAskSolve                                              = SourcesFlat.DeleteAskSolve
            Self.Sources.CreateErrorcode                                             = SourcesFlat.CreateErrorcode
            Self.Sources.CreateAlways                                                = SourcesFlat.CreateAlways
            Self.Sources.CreateAsk                                                   = SourcesFlat.CreateAsk
            Self.Sources.CreateFailed                                                = SourcesFlat.CreateFailed
            Self.Sources.CreateAskSolve                                              = SourcesFlat.CreateAskSolve
            Self.Sources.Connect                                                     = SourcesFlat.Connect
            Self.Sources.ConnectFailed                                               = SourcesFlat.ConnectFailed
            Self.Sources.ConnectErrorcode                                            = SourcesFlat.ConnectErrorcode
            Self.Sources.ConnectAskSolve                                             = SourcesFlat.ConnectAskSolve
            Add(Self.Sources)
        End

        Free(SourcesFlat)
        Dispose(SourcesFlat)

        DatabasesFlat   &= NEW c25DbDatabasesFlat_TYPE()

        JSon.Start()
        JSon.SetTagCase(jF:CaseAsIs)
        Self.st1.Start()
        Self.st1.SetValue(Self.WinApi.GetGlobalDictionaryValue('Databases.json'))
        JSon.Load(DatabasesFlat, Self.st1)

        I# = 0
        LOOP
            I# = I# + 1
            Get(DatabasesFlat,I#)
            If Errorcode() <> 0
                BREAK
            End
            Self.Databases.Id                                                          = DatabasesFlat.Id
            Self.Databases.Name                                                        &= Self.WinApi.AnsiToAnsi(DatabasesFlat.Name)
            Self.Databases.DbEngineType                                                = DatabasesFlat.DbEngineType
            Self.Databases.DbConnectionStringId                                        = DatabasesFlat.DbConnectionStringId
            Self.Databases.InMemory                                                    = DatabasesFlat.InMemory
            Self.Databases.OnDisk                                                      = DatabasesFlat.OnDisk
            Self.Databases.UriAnsi                                                     &= Self.WinApi.AnsiToAnsi(DatabasesFlat.UriAnsi)
            Self.Databases.UriUtf8                                                     &= Self.WinApi.Utf8ToUtf8(DatabasesFlat.UriUtf8)
            Self.Databases.UriUtf16                                                    &= Self.WinApi.Utf16ToUtf16(DatabasesFlat.UriUtf16)
            Self.Databases.FileNameAnsi                                                &= Self.WinApi.AnsiToAnsi(DatabasesFlat.FileNameAnsi)
            Self.Databases.FileNameUtf8                                                &= Self.WinApi.Utf8ToUtf8(DatabasesFlat.FileNameUtf8)
            Self.Databases.FileNameUtf16                                               &= Self.WinApi.Utf16ToUtf16(DatabasesFlat.FileNameUtf16)
            Self.Databases.FullPathAnsi                                                &= Self.WinApi.AnsiToAnsi(DatabasesFlat.FullPathAnsi)
            Self.Databases.FullPathUtf8                                                &= Self.WinApi.Utf8ToUtf8(DatabasesFlat.FullPathUtf8)
            Self.Databases.FullPathUtf16                                               &= Self.WinApi.Utf16ToUtf16(DatabasesFlat.FullPathUtf16)
            Self.Databases.CreateAlways                                                = DatabasesFlat.CreateAlways
            Self.Databases.CreateIfNotExist                                            = DatabasesFlat.CreateIfNotExist
            Self.Databases.Instance                                                    &= null
            Self.Databases.InstancePtr                                                 = 0
            Self.Databases.SourcesId                                                   = DatabasesFlat.SourcesId

            Self.Databases.SqlOpenFlags.READONLY                = DatabasesFlat.SqlOpenFlags.READONLY! | Byte')
            Self.Databases.SqlOpenFlags.READWRITE               = DatabasesFlat.SqlOpenFlags.READWRITE! | Byte')
            Self.Databases.SqlOpenFlags.CREATE                  = DatabasesFlat.SqlOpenFlags.CREATE! | Byte')
            Self.Databases.SqlOpenFlags.DELETEONCLOSE           = DatabasesFlat.SqlOpenFlags.DELETEONCLOSE! | Byte')
            Self.Databases.SqlOpenFlags.EXCLUSIVE               = DatabasesFlat.SqlOpenFlags.EXCLUSIVE! | Byte')
            Self.Databases.SqlOpenFlags.AUTOPROXY               = DatabasesFlat.SqlOpenFlags.AUTOPROXY! | Byte')
            Self.Databases.SqlOpenFlags.URI                     = DatabasesFlat.SqlOpenFlags.URI! | Byte')
            Self.Databases.SqlOpenFlags.MEMORY                  = DatabasesFlat.SqlOpenFlags.MEMORY! | Byte')
            Self.Databases.SqlOpenFlags.MAIN_DB                 = DatabasesFlat.SqlOpenFlags.MAIN_DB! | Byte')
            Self.Databases.SqlOpenFlags.TEMP_DB                 = DatabasesFlat.SqlOpenFlags.TEMP_DB! | Byte')
            Self.Databases.SqlOpenFlags.TRANSIENT_DB            = DatabasesFlat.SqlOpenFlags.TRANSIENT_DB! | Byte')
            Self.Databases.SqlOpenFlags.MAIN_JOURNAL            = DatabasesFlat.SqlOpenFlags.MAIN_JOURNAL! | Byte')
            Self.Databases.SqlOpenFlags.TEMP_JOURNAL            = DatabasesFlat.SqlOpenFlags.TEMP_JOURNAL! | Byte')
            Self.Databases.SqlOpenFlags.SUBJOURNAL              = DatabasesFlat.SqlOpenFlags.SUBJOURNAL! | Byte')
            Self.Databases.SqlOpenFlags.SUPER_JOURNAL           = DatabasesFlat.SqlOpenFlags.SUPER_JOURNAL! | Byte')
            Self.Databases.SqlOpenFlags.NOMUTEX                 = DatabasesFlat.SqlOpenFlags.NOMUTEX! | Byte')
            Self.Databases.SqlOpenFlags.FULLMUTEX               = DatabasesFlat.SqlOpenFlags.FULLMUTEX! | Byte')
            Self.Databases.SqlOpenFlags.SHAREDCACHE             = DatabasesFlat.SqlOpenFlags.SHAREDCACHE! | Byte')
            Self.Databases.SqlOpenFlags.PRIVATECACHE            = DatabasesFlat.SqlOpenFlags.PRIVATECACHE! | Byte')
            Self.Databases.SqlOpenFlags.WAL                     = DatabasesFlat.SqlOpenFlags.WAL! | Byte')
            Self.Databases.SqlOpenFlags.NOFOLLOW                = DatabasesFlat.SqlOpenFlags.NOFOLLOW! | Byte')
            Self.Databases.SqlOpenFlags.EXRESCODE               = DatabasesFlat.SqlOpenFlags.EXRESCODE! | Byte')
            Self.Databases.SqlOpenFlags.PRAGMA_ENCODING         = DatabasesFlat.SqlOpenFlags.PRAGMA_ENCODING! | CSTRING')
            Self.Databases.SqlOpenFlags.PRAGMA_SYNCHRONOUS      = DatabasesFlat.SqlOpenFlags.PRAGMA_SYNCHRONOUS! | CString')
            Self.Databases.SqlOpenFlags.PRAGMA_JOURNAL_MODE     = DatabasesFlat.SqlOpenFlags.PRAGMA_JOURNAL_MODE! | CSTRING')
            Self.Databases.SqlOpenFlags.PRAGMA_TEMP_STORE       = DatabasesFlat.SqlOpenFlags.PRAGMA_TEMP_STORE! | CSTRING')
            Self.Databases.SqlOpenFlags.PRAGMA_LOCKING_MODE     = DatabasesFlat.SqlOpenFlags.PRAGMA_LOCKING_MODE! | CSTRING')
            Self.Databases.SqlOpenFlags.ForceEncoding           = DatabasesFlat.SqlOpenFlags.ForceEncoding! | Long')
            Self.Databases.SqlOpenFlags.DeleteFileAlways        = DatabasesFlat.SqlOpenFlags.DeleteFileAlways! | Byte')

            Self.Databases.CreateTables                                                = DatabasesFlat.CreateTables
            Self.Databases.TablesCreated                                               = DatabasesFlat.TablesCreated
            Self.Databases.Action                                                      = DatabasesFlat.Action
            Self.Databases.Created                                                     = DatabasesFlat.Created

            Self.Databases.MsSqlConnectionString                                       &= null
            Self.Databases.DropDatabaseScriptAnsi                                      &= null
            Self.Databases.CreateDatabaseScriptAnsi                                    &= null
            Self.Databases.DropTablesScriptAnsi                                        &= null
            Self.Databases.CreateTablesScriptAnsi                                      &= null
            Self.Databases.DropTablesIndexesScriptAnsi                                 &= null
            Self.Databases.CreateTablesIndexesScriptAnsi                               &= null

            Add(Self.Databases)
        End
        Free(DatabasesFlat)
        Dispose(DatabasesFlat)

        TablesFlat &= NEW c25DbTablesFlat_TYPE()

        JSon.Start()
        JSon.SetTagCase(jF:CaseAsIs)
        Self.st1.Start()
        Self.st1.SetValue(Self.WinApi.GetGlobalDictionaryValue('Tables.json'))
        JSon.Load(TablesFlat, Self.st1)

        I# = 0
        LOOP
            I# = I# + 1
            Get(TablesFlat,I#)
            If Errorcode() <> 0
                BREAK
            End
            Clear(Self.Tables)
            Self.Tables.Id                          = TablesFlat.Id
            Self.Tables.DatabaseId                  = TablesFlat.DatabaseId
            Self.Tables.ClarionQueueTypeName       &= Self.WinApi.AnsiToAnsi(TablesFlat.ClarionQueueTypeName)
            Self.Tables.ClarionQueueTypeRef        &= null
            Self.Tables.Name                       &= Self.WinApi.AnsiToAnsi(TablesFlat.Name)
            Self.Tables.QueueName                  &= Self.WinApi.AnsiToAnsi(TablesFlat.QueueName)
            Self.Tables.CreateScript               &= null
            Self.Tables.DropBeforeCreateScript      = TablesFlat.DropBeforeCreateScript
            Self.Tables.InstancePtr                 = 0
            Self.Tables.Instance                   &= null
            Self.Tables.PopulateFromClaQTypeRef    = TablesFlat.PopulateFromClaQTypeRef
            Self.Tables.DropTableIfExists          = TablesFlat.DropTableIfExists
            Self.Tables.CreateScriptMsSql          &= null
            Self.Tables.ClarionFields              &= null
            Add(Self.Tables)
            If Self.Tables.ClarionQueueTypeName &= NULL
                Message('error Self.Tables.ClarionQueueTypeName is null : ' & Self.Tables.Name)
                CYCLE
            End
            Self.Tables.ClarionQueueTypeRef &= Self.GetEFMapQType(Self.Tables.ClarionQueueTypeName)
            If Self.Tables.ClarionQueueTypeRef &= NULL
                Message('error Self.Tables.ClarionQueueTypeRef is null : ' & Self.Tables.Name)
                CYCLE
            End
            Put(Self.Tables)
        End

        Free(TablesFlat)
        Dispose(TablesFlat)

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Tables,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Tables.ClarionQueueTypeRef &= NULL
                Cycle
            End
            If not Self.TrueReflection &= null
                Dispose(Self.TrueReflection)
            End
            Self.TrueReflection             &= NEW TrueReflectionClass()
            Self.Tables.ClarionFields       &= NEW ClarionFields_TYPE()
            Self.Tables.ClarionFields       &= NEW ClarionFields_TYPE()
            Self.TrueReflection.Analyze(Self.Tables.ClarionQueueTypeRef, Self.Tables.ClarionFields)
            Put(Self.Tables)

            I2# = 0
            Loop
                I2# = I2# + 1
                Get(Self.Tables.ClarionFields, I2#)
                If Errorcode() <> 0
                    BREAK
                End
                Clear(Self.TableColumns)

                Self.TableColumns_SeedId                       = Self.TableColumns_SeedId + 1
                Self.TableColumns.Id                           = Self.TableColumns_SeedId
                Self.TableColumns.Ordinal                      = Self.Tables.ClarionFields.DisplayOrdinal
                If I2# = 1
                    Self.TableColumns.IsFirst = True
                Else
                    Self.TableColumns.IsFirst = 0
                End
                If I2# = Records(Self.Tables.ClarionFields)
                    Self.TableColumns.IsLast = True
                Else
                    Self.TableColumns.IsLast = 0
                End
                If Self.Tables.ClarionFields.IsAnsi
                    Self.TableColumns.EncodingTransformation    = st:EncodeAnsi
                End
                If Self.Tables.ClarionFields.IsUtf8
                    Self.TableColumns.EncodingTransformation    = st:EncodeUtf8
                End
                If Self.Tables.ClarionFields.IsUtf16
                    Self.TableColumns.EncodingTransformation    = st:EncodeUtf16
                End
                Self.TableColumns.TableName                         &= Self.WinApi.AnsiToAnsi(Self.Tables.Name)
                Self.TableColumns.TableId                           = Self.Tables.Id

                Self.TableColumns.BytesLength                       = Self.Tables.ClarionFields.SizeBytes
                Self.TableColumns.BytesLengthClarion                = Self.Tables.ClarionFields.SizeBytes
                Self.TableColumns.Characters                        = Self.Tables.ClarionFields.Characters
                Self.TableColumns.CharactersLength                  = Self.Tables.ClarionFields.Characters
                Self.TableColumns.CharactersLengthClarion           = Self.Tables.ClarionFields.SizeBytes
                Self.TableColumns.ClarionName                       &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.Name)
                Self.TableColumns.Collate                           &= Self.WinApi.AnsiToAnsi('NOCASE')
                Self.TableColumns.DataType                          &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.DataType)
                Self.TableColumns.DataTypeClarion                   &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.DataType)
                Self.TableColumns.Dimensions                        = Self.Tables.ClarionFields.Dimensions
                Self.TableColumns.DisplayOrdinal                    = Self.Tables.ClarionFields.DisplayOrdinal
                Self.TableColumns.Encoding                          &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.Encoding)
                Self.TableColumns.ExcludeInPrepare                  = Self.Tables.ClarionFields.ExcludeInPrepare
                Self.TableColumns.Index                             = Self.Tables.ClarionFields.Index
                Self.TableColumns.IsAnsi                            = Self.Tables.ClarionFields.IsAnsi
                Self.TableColumns.IsAutoIncrement                   = 0
                Self.TableColumns.IsBase64                          = Self.Tables.ClarionFields.IsBase64
                Self.TableColumns.IsBinary                          = Self.Tables.ClarionFields.IsBinary
                Self.TableColumns.IsGroup                           = Self.Tables.ClarionFields.IsGroup
                Self.TableColumns.IsHex                             = Self.Tables.ClarionFields.IsHex
                Self.TableColumns.IsPrimary                         = 0
                Self.TableColumns.IsQueue                           = Self.Tables.ClarionFields.IsQueue
                Self.TableColumns.IsRef                             = Self.Tables.ClarionFields.IsRef
                Self.TableColumns.IsStyle                           = Self.Tables.ClarionFields.IsStyle
                Self.TableColumns.IsUtf16                           = Self.Tables.ClarionFields.IsUtf16
                Self.TableColumns.IsUtf32                           = Self.Tables.ClarionFields.IsUtf32
                Self.TableColumns.IsUtf7                            = Self.Tables.ClarionFields.IsUtf7
                Self.TableColumns.IsUtf8                            = Self.Tables.ClarionFields.IsUtf8
                Self.TableColumns.Name                              &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.Name)
                Self.TableColumns.PropName                          &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.PropName)
                Self.TableColumns.NotExistInQueue                   = Self.Tables.ClarionFields.NotExistInQueue
                Self.TableColumns.Offset                            = Self.Tables.ClarionFields.Offset
                Self.TableColumns.OffsetBytesClarion                = Self.Tables.ClarionFields.Offset
                Self.TableColumns.OffsetEnd                         = Self.Tables.ClarionFields.OffsetEnd
                Self.TableColumns.OtherEncoding                     = Self.Tables.ClarionFields.OtherEncoding
                Self.TableColumns.ParamId                           = Self.Tables.ClarionFields.ParamId
                Self.TableColumns.Places                            = Self.Tables.ClarionFields.Places
                Self.TableColumns.Precision                         = Self.Tables.ClarionFields.Places
                Self.TableColumns.PtrAddress                        = Self.Tables.ClarionFields.PtrAddress
                Self.TableColumns.PtrAddressSize                    = Self.Tables.ClarionFields.PtrAddressSize
                Self.TableColumns.PtrSize                           = Self.Tables.ClarionFields.PtrSize
                Self.TableColumns.PtrSizeSize                       = Self.Tables.ClarionFields.PtrSizeSize
                Self.TableColumns.QTableFieldsQ_Index               = Self.Tables.ClarionFields.QTableFieldsQ_Index
                Self.TableColumns.Scale                             = 0
                Self.TableColumns.SizeBytes                         = Self.Tables.ClarionFields.SizeBytes
                Self.TableColumns.StructureName                     &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.StructureName)
                Self.TableColumns.StructurePrefix                   &= Self.WinApi.AnsiToAnsi(Self.Tables.ClarionFields.StructurePrefix)
                Self.TableColumns.TestValueLen                      = Self.Tables.ClarionFields.TestValueLen
                Add(Self.TableColumns)
            End
        End

        Return 0

        Include('c25_AdapterThread.clw'), once

