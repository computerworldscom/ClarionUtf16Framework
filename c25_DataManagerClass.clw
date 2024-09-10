        Member

        Include('c25_DataManagerClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
                        Include('c25_WinApiPrototypes.inc')

                        Module('c25DataManager.dll')
                            C25CreateQueue(<string _name>, <string _json>),PASCAL,*QUEUE
                            C25GetQueue(<long _dataTableId> , <string _dataTableName>),PASCAL,*QUEUE
                        End
                    End

c25_DataManagerClass.Destruct                                       Procedure()

    Code

c25_DataManagerClass.Construct      Procedure()

ClassStarter &c25_ClassStarter
Code
        
    Self.ClassTypeName = 'c25_DataManagerClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    
    
!    INCLUDE('SetCWM.clw')

    !Self.DllLoaderClass                     &= Self.ProgramHandlerClass.DllLoaderClass
    
!    Self.BitConverterClass                  &= NEW c25_BitConverterClass()
!    Self.DataTableClasses                   &= NEW DataTableClasses_TYPE()
!    Self.MetaReflectionClass                &= NEW c25_DataReflectionClass()
!    Self.NanoClock                          &= NEW c25_NanoSyncClass()
!    Self.ObjectClass                        &= NEW c25_ObjectClass()
!    Self.Result                             &= NEW c25_ResultClass()


c25_DataManagerClass.CreateDataTableInstance                        Procedure(<string _tableNameOrJsonDef>, <string _columnsJsonDef>, <bool _replaceExistingTable>) !<string _name>, <bool _disposeIfExist>)

DataTableClassTemp          &c25_DataTableClass
DataTableName               cstring(128)
DataTable                   QUEUE,PRE(DataTable)
Id                              LONG,NAME('Id')
Name                            CSTRING(128),NAME('Name')
ColumnsCount                    LONG,NAME('ColumnsCount')
RowsCount                       DECIMAL(21,0),NAME('RowsCount')
AutoCreate                      BYTE(1),NAME('AutoCreate')
Advanced                        BYTE(false),NAME('Advanced')
Extended                        BYTE,NAME('Extended')
InitialCapacity                 DECIMAL(21,0),NAME('InitialCapacity')
DataTableMemId                  LONG,NAME('DataTableMemId')
RowAllocationSize               LONG,NAME('RowAllocationSize')
MesOnlyWinHandle                LONG,NAME('MesOnlyWinHandle')
ThreadHandle                    LONG,NAME('ThreadHandle')
                            END
    Code

        If omitted(_tableNameOrJsonDef) = False
            If Instring('<07Bh>',_tableNameOrJsonDef,1,1) < 1
                DataTableName = Clip(Left(_tableNameOrJsonDef))
            Else
                Self.BitConverterClass.JsonStringToQueue(_tableNameOrJsonDef, DataTable)
                DataTableName = DataTable.Name
                If DataTable.DataTableMemId <> 0
                    ! todo modify table
                    !Message('DataTable.DataTableMemId <> 0')
                    !Return DataTable.DataTableMemId
                End
            End
        Else
            DataTableName = 'table' & Self.NanoClock.GetSysTime()
        End
        Clear(Self.DataTableClasses)
        Self.DataTableClassesSeedMemoryId           = Self.DataTableClassesSeedMemoryId + 1
        Self.DataTableClasses.MemoryId              = Self.DataTableClassesSeedMemoryId
        DataTableClassTemp                          &= NEW c25_DataTableClass()
        DataTableClassTemp.MemoryId                 = Self.DataTableClasses.MemoryId
        DatatableClassTemp.Name                     &= Self.BitConverterClass.BinaryCopy(DataTableName)
        Self.DataTableClasses.WindowHandle          = DataTableClassTemp.MessageOnlyWindowClass.OpenWindow()
        Self.DataTableClasses.Ptr                   = Address(DataTableClassTemp)
        Self.DataTableClasses.Name                  &= Self.BitConverterClass.BinaryCopy(DataTableClassTemp.Name)
        Add(Self.DataTableClasses)
        DataTableClassTemp                          &= NULL
        Return Self.DataTableClasses.MemoryId

c25_DataManagerClass.GetDataTableMesOnlyWinHandle                   Procedure(<long _id>, <string _name>)

    Code

        If Self.DataTableClasses &= NULL
            Return 0
        End
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.DataTableClasses,I#)
            If Errorcode() <> 0
                Return 0
            END
            If omitted(_id) = False And _id <> 0
                If Self.DataTableClasses.MemoryId = _id
                    Return Self.DataTableClasses.WindowHandle
                End
            End
            If OMITTED(_name) = False
                If Self.DataTableClasses.Name &= NULL
                    CYCLE
                END
                If Lower(Left(Clip(Self.DataTableClasses.Name))) <> Lower(Left(Clip(_name)))
                    CYCLE
                END
                Return Self.DataTableClasses.WindowHandle
            End
        End
        Return 0
        
c25_DataManagerClass.GetDataTableThreadHandle                       Procedure(<long _dataTableId>, <string _dataTableName>)

DataTableInstance       &c25_DataTableClass

    Code

        DataTableInstance &= (Self.GetDataTableInstance(_dataTableId, _dataTableName))
        If DataTableInstance &= NULL
            Message('error, c25_DataManagerClass.GetDataTableThreadHandle, DataTableInstance &= NULL')
            Return 0
        End
        If DataTableInstance.MessageOnlyWindowClass &= NULL
            Return 0
        End
        Return DataTableInstance.MessageOnlyWindowClass.ThreadHandle

c25_DataManagerClass.CreateQueue                                    Procedure(<Int32 _dataTableId>, <string _dataTableName>, <string _jsonClarion>, <string _jsonClarionExtended>)

DataTableInstance   &c25_DataTableClass
MyQ                 &QUEUE

    CODE

        !Message('c25_DataManagerClass.CreateQueue, _dataTableId : ' & _dataTableId & ', name: ' & _dataTableName)
        
        If omitted(_jsonClarion) and omitted(_jsonClarionExtended)
            return 0
        End
        
        If omitted(_jsonClarion) = FALSE
            If Len(Clip(_jsonClarion)) < 2
                Return 0
            END
        End
        
        DataTableInstance &= (Self.GetDataTableInstance(_dataTableId, _dataTableName))
        If DataTableInstance &= NULL
            Message('error, c25_DataManagerClass.CreateQueue, DataTableInstance &= NULL')
            Return 0
        End
        If Omitted(_jsonClarion) = False
            
            DataTableInstance.JsonClarionStructureString.Start()
            DataTableInstance.JsonClarionStructureString.Append(_jsonClarion)
            DataTableInstance.JsonClarionStructure.Load(DataTableInstance.JsonClarionStructureString)
            
            
            DataTableInstance.JsonToClarionFields()
            DataTableInstance.ClarionFieldsToColumnsCollection()
            DataTableInstance.CalculateDLLProperties()
            DataTableInstance.CreateDllQueueDeclaration()

            c25_SendMessageTimeoutA(Self.GetCreateQueueWinHandle(), Self.ProgramHandlerClass.CWM_CreateQueue, SendMesCreateQueueClass:DataTable, Address(DataTableInstance), c25_SMTO_ABORTIFHUNG, 30000, Address(Self.ReturnVal))

            MyQ &= C25GetQueue(DataTableInstance.MemoryId)
            If MyQ &= NULL
                Message('error c25_DataManagerClass.CreateQueue')
            Else
                !Message('myq ok')
            END

            !Message('hier DataTableInstance.CreateSqliteMemoryTable()')
            DataTableInstance.CreateSqliteMemoryTable()
            DataTableInstance.QInfo = Self.ProgramHandlerClass.QueueCreateClass.GetQInfo(DataTableInstance.MemoryId)

            DataTableInstance.ClarionFieldsOut &= NEW ClarionFields_TYPE()
            DataTableInstance.DataReflectionClass.Analyze(MyQ, DataTableInstance.ClarionFieldsOut)

            I# = 0
            Loop
                I# = I# + 1
                Get(DataTableInstance.Columns,I#)
                If Errorcode() <> 0
                    BREAK
                End
                Get(DataTableInstance.ClarionFieldsOut,I#)
                If Errorcode() <> 0
                    BREAK
                End
                If DataTableInstance.Columns.DataColumn &= NULL
                    Message('error DataTableInstance.Columns.DataColumn &= NULL')
                End
                DataTableInstance.Columns.DataColumn.ClaQStor_OffsetStart = DataTableInstance.ClarionFieldsOut.Offset
                DataTableInstance.Columns.DataColumn.ClaQStor_OffsetEnd = DataTableInstance.ClarionFieldsOut.OffsetEnd
                DataTableInstance.Columns.DataColumn.ClaQStor_OffsetSize = DataTableInstance.Columns.DataColumn.ClaQStor_OffsetEnd - DataTableInstance.Columns.DataColumn.ClaQStor_OffsetStart
            End

            DataTableInstance.ClaQueue &=  MyQ
            DataTableInstance.ClaQueueByteArray &= NEW STRING(Size(DataTableInstance.ClaQueue))
            DataTableInstance.ClaQueueByteArrayNew &= NEW STRING(Size(DataTableInstance.ClaQueue))
            Clear(DataTableInstance.ClaQueue)
            DataTableInstance.ClaQueueByteArray = DataTableInstance.ClaQueue
            DataTableInstance.ClaQueueByteArrayNew = DataTableInstance.ClaQueue
            DataTableInstance.ClarionFieldsCountOut = Records(DataTableInstance.ClarionFieldsOut)
            DataTableInstance.JsonOut &= Self.BitConverterClass.BinaryCopy(Self.BitConverterClass.QToJson(DataTableInstance.ClarionFieldsOut,,true))
            MyQ &= Null
        End
        !Message('exit c25_DataManagerClass.CreateQueue')
        Return 0

c25_DataManagerClass.GetCreateQueueWinHandle                        Procedure()

    CODE

        Return Self.ProgramHandlerClass.QueueCreateClass.MessageOnlyWindowClass.WindowHandle

c25_DataManagerClass.GetClaListboxFormatString                      Procedure(<long _dataTableId>, <string _dataTableName>)

DataTableInstance                               &c25_DataTableClass

    CODE

        DataTableInstance &= (Self.GetDataTableInstance(_dataTableId, _dataTableName))
        If DataTableInstance &= NULL
            Message('error GetClaListboxFormatString, DataTableInstance &= NULL')
            Return 0
        End
        If NOT DataTableInstance &= NULL
            If DataTableInstance.ClaListboxFormatString &= NULL

                Self.BitConverterClass.St1.Start()
                I# = 0
                LOOP
                    I# = I# + 1
                    Get(DataTableInstance.ClarionFieldsOut,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    Self.BitConverterClass.St1.Append('80L(2)|M~' & Clip(DataTableInstance.ClarionFieldsOut.Name) & '~L(0)@s20@')
                End
                If Self.BitConverterClass.St1.Length() > 0
                    DataTableInstance.ClaListboxFormatString &= NEW STRING(Self.BitConverterClass.St1.Length())
                    DataTableInstance.ClaListboxFormatString =  Self.BitConverterClass.St1.GetValue()
                    Return DataTableInstance.ClaListboxFormatString
                End
            End
        Else
            Return DataTableInstance.ClaListboxFormatString
        End
        Return ''

c25_DataManagerClass.GetDataTableStructure                          Procedure(<long _dataTableId>, <string _dataTableName>)

DataTableInstance   &c25_DataTableClass

    CODE

        DataTableInstance &= (Self.GetDataTableInstance(_dataTableId, _dataTableName))
        If DataTableInstance &= NULL
            Message('error GetDataTableStructure, DataTableInstance &= NULL')
            Return 0
        End
        If NOT DataTableInstance.JsonOut &= NULL
            Return DataTableInstance.JsonOut
        Else

        End
        Return ''

c25_DataManagerClass.GetDataTableInstancePtr                        Procedure(<long _id>, <string _name>)

    Code

        If Self.DataTableClasses &= NULL
            Return 0
        End
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.DataTableClasses,I#)
            If Errorcode() <> 0
                Return 0
            END
            If omitted(_id) = False And _id <> 0
                If Self.DataTableClasses.MemoryId = _id
                    If Self.DataTableClasses.Ptr = 0
                        Message('error Self.DataTableClasses.Ptr = 0')
                    End
                    Return Self.DataTableClasses.Ptr
                End
            End
            If OMITTED(_name) = False
                If Self.DataTableClasses.Name &= NULL
                    CYCLE
                END
                If Lower(Clip(Self.DataTableClasses.Name)) <> Lower(Clip(_name))
                    CYCLE
                END
                If Self.DataTableClasses.Ptr = 0
                    Message('error Self.DataTableClasses.Ptr = 0')
                End
                Return Self.DataTableClasses.Ptr
            End
        End
        Return 0

c25_DataManagerClass.GetDataTable_Id                                Procedure(string _name)

    Code

        If Self.DataTableClasses &= NULL
            Return 0
        End

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.DataTableClasses,I#)
            If Errorcode() <> 0
                Return 0
            END
            If Self.DataTableClasses.Name &= NULL
                CYCLE
            END
            If Lower(Clip(Self.DataTableClasses.Name)) <> Lower(Clip(_name))
                CYCLE
            END
            Return Self.DataTableClasses.MemoryId
        End
        Return 0

c25_DataManagerClass.DataTable_Exist                                Procedure(<string _name>, <bool _disposeIfExist>)

DataTable                                                               &c25_DataTableClass

    Code

        If Self.DataTableClasses &= NULL
            Return 0
        End
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.DataTableClasses,I#)
            If Errorcode() <> 0
                Return 0
            END
            If OMITTED(_name) = False
                If Self.DataTableClasses.Name &= NULL
                    CYCLE
                END
                If Lower(Clip(Self.DataTableClasses.Name)) <> Lower(Clip(_name))
                    CYCLE
                END
                If _disposeIfExist = TRUE
                    DataTable &= (Self.DataTableClasses.Ptr)
                    Delete(Self.DataTableClasses)
                    Dispose(DataTable)
                End
                Return True
            End
        End
        Return 0

c25_DataManagerClass.GetDataTableInstance                           Procedure(<Int32 _dataTableId>, <string _dataTableName>)

    CODE

        If Self.DataTableClasses &= NULL
            Return 0
        End
        If OMITTED(_dataTableId) = False
            I# = 0
            LOOP
                I# = I# + 1
                Get(Self.DataTableClasses,I#)
                If Errorcode() <> 0
                    Break
                END
                If OMITTED(_dataTableId) = FALSE And _dataTableId <> 0
                    If Self.DataTableClasses.MemoryId = _dataTableId
                        !Message('c25_DataManagerClass.GetDataTableInstance returning Self.DataTableClasses.Ptr ' & Self.DataTableClasses.Ptr)
                        Return Self.DataTableClasses.Ptr
                    End
                End
            End
        End
        
        If OMITTED(_dataTableName) = False !Or OMITTED(_dataTableId) = FALSE
            I# = 0
            LOOP
                I# = I# + 1
                Get(Self.DataTableClasses,I#)
                If Errorcode() <> 0
                    Break
                END
                If OMITTED(_dataTableName) = False And Size(_dataTableName) > 0
                    If Self.DataTableClasses.Name &= NULL
                        CYCLE
                    END
                    If Lower(Left(Clip(Self.DataTableClasses.Name))) <> Lower(Left(Clip(_dataTableName)))
                        CYCLE
                    END
                    If Self.DataTableClasses.Ptr = 0
                        Message('error Self.DataTableClasses.Ptr = 0')
                    End
                    Return Self.DataTableClasses.Ptr
                End
            End
        End
        Message('not found c25_DataManagerClass.GetDataTableInstance ' & _dataTableName)
        Return 0

c25_DataManagerClass.CreateListboxFormatString                      Procedure(<Int32 _dataTableId>, <string _dataTableName>)

DataTable &c25_DataTableClass

    CODE

        If OMITTED(_dataTableId) = False
            DataTable &= (Self.GetDataTableInstance(_dataTableId))
        ElsIf OMITTED(_dataTableName) = False
            DataTable &= (Self.GetDataTableInstance(,_dataTableName))
        End
        If DataTable &= NULL
            Return ''
        END

        Return ''

c25_DataManagerClass.SetColumnValue                                 Procedure(<bool _async>, string _dataTableNameOrId, string _rowIndex, string _columnNameOrOrdinal, <ByteArray _value>)

dataTable       &c25_DataTableClass
dataCell            &c25_DataCellClass
ReturnVal       Int32

CODE

!    dataTable &= (Self.GetDataTableInstance(,_dataTableNameOrId))
!    If dataTable &= NULL
!        If Numeric(_dataTableNameOrId)
!            ID# = _dataTableNameOrId
!            dataTable &= (Self.GetDataTableInstance(ID#))
!        End
!    End
!    If dataTable &= NULL
!        Return -3
!    END
!
!    dataCell &= NEW c25_DataCellClass()
!
!    Self.SetCellDataColumnInfo(dataTable, dataCell, _columnNameOrOrdinal)
!
!    If omitted(_async) = False And _async = True
!        dataCell.ASyncCall = TRUE
!    End
!    If omitted(_value) = True Or Size(_value) < 1
!        dataCell.ValueObject.IsNULL = True
!    Else
!        dataCell.ValueObject.BufferSize = Size(_value)
!        If dataCell.ValueObject.BufferSize > 0
!            dataCell.ValueObject.Buffer &= NEW STRING(Size(_value))
!            dataCell.ValueObject.Buffer = _value
!        End
!    End
!
!    dataCell.SetRowIndex(_rowIndex)
!
!    Self.NanoClock.StartStopwatch()
!    Loop 1 Times
!        dataCell.SetRowIndex(_rowIndex)
!        c25_SendMessageTimeoutA(DataTable.MessageOnlyWindowClass.WindowHandle, Self.CWM_SetColumnValue, Self.CurrentDataTableId, Address(dataCell), c25_SMTO_ABORTIFHUNG + c25_SMTO_BLOCK, 30000, Address(ReturnVal))
!        If dataCell.ASyncCall = False
!            If not dataCell &= null
!                Dispose(dataCell)
!            End
!        End
!    End
    Return 0

c25_DataManagerClass.GetColumnValue                                 Procedure(<bool _async>, string _dataTableNameOrId, string _rowIndex, string _columnNameOrOrdinal, <*PtrInt32 _returnPtr>, <*Int32 _returnSizeLo>, <*Int32 _returnSizeHi>)

dataTable       &c25_DataTableClass
dataCell        &c25_DataCellClass
ReturnVal       Int32

CODE

!    dataTable &= (Self.GetDataTableInstance(,_dataTableNameOrId))
!    If dataTable &= NULL
!        If Numeric(_dataTableNameOrId)
!            ID# = _dataTableNameOrId
!            dataTable &= (Self.GetDataTableInstance(ID#))
!        End
!    End
!    If DataTable &= NULL
!        Return -3
!    END
!    dataCell &= NEW c25_DataCellClass()
!
!    Self.SetCellDataColumnInfo(dataTable, dataCell, _columnNameOrOrdinal)
!    If dataCell.DataColumn &= NULL
!        Return ''
!    End
!
!    Self.NanoClock.StartStopwatch()
!    Loop 1 Times
!        dataCell.SetRowIndex(_rowIndex)
!        c25_SendMessageTimeoutA(DataTable.MessageOnlyWindowClass.WindowHandle, Self.CWM_GetColumnValue, Self.CurrentDataTableId, Address(dataCell), c25_SMTO_ABORTIFHUNG + c25_SMTO_BLOCK, 30000, Address(ReturnVal))
!
!        If not dataCell.ValueObject.StringValue &= null
!            If Size(dataCell.ValueObject.StringValue) > 0
!                Self.ReturnString &= Self.BitConverterClass.BinaryCopy(dataCell.ValueObject.StringValue)
!            End
!        End
!        Dispose(dataCell)
!        return Self.ReturnString
!    End
    Return ''

c25_DataManagerClass.RemoveDataRow                                  Procedure(<bool _async>, string _dataTableNameOrId, string _rowIndex)

dataTable       &c25_DataTableClass
ReturnVal       Int32
RowIndex64      Like(UINT64)

CODE

    dataTable &= (Self.GetDataTableInstance(,_dataTableNameOrId))
    If dataTable &= NULL
        If Numeric(_dataTableNameOrId)
            ID# = _dataTableNameOrId
            dataTable &= (Self.GetDataTableInstance(ID#))
        End
    End
    If DataTable &= NULL
        Return -3
    END
    RowIndex64 = Self.BitConverterClass.IntegerStringToUInt64(_rowIndex)
    Self.NanoClock.StartStopwatch()
    Loop 1 Times
        c25_SendMessageTimeoutA(DataTable.MessageOnlyWindowClass.WindowHandle, Self.CWM_DeleteDataRow, Self.CurrentDataTableId, Address(RowIndex64), c25_SMTO_ABORTIFHUNG + c25_SMTO_BLOCK, 30000, Address(ReturnVal))
    End
    Return ''

c25_DataManagerClass.SetCellDataColumnInfo                          Procedure(*c25_DataTableClass _dataTable, *c25_DataCellClass _dataCell, *string _columnNameOrOrdinal)

    CODE

    I# = 0
    LOOP
        I# = I# + 1
        Get(_dataTable.Columns,I#)
        If Errorcode() <> 0
            BREAK
        End
        If _dataTable.Columns.DataColumn &= NULL
            Message('error DataTable.Columns.DataColumn &= NULL')
            CYCLE
        END
        If lower(_dataTable.Columns.DataColumn.Name) <> lower(_columnNameOrOrdinal)
            CYCLE
        End
        _dataCell.DataColumn &= _dataTable.Columns.DataColumn
        _dataCell.DataTable &= _dataTable
        BREAK
    End

c25_DataManagerClass.DataRowAddNew                                  Procedure(<bool _async>, string _dataTableNameOrId)

dataTable           &c25_DataTableClass
ReturnVal           Int32
UniqueIdentifier    cstring(21)

CODE

    dataTable &= (Self.GetDataTableInstance(,_dataTableNameOrId))
    If dataTable &= NULL
        If Numeric(_dataTableNameOrId)
            ID# = _dataTableNameOrId
            dataTable &= (Self.GetDataTableInstance(ID#))
        End
    End
    If DataTable &= NULL
        Return -3
    END
    Loop 1 Times
        c25_SendMessageTimeoutA(DataTable.MessageOnlyWindowClass.WindowHandle, Self.CWM_DataRowAddNew, Self.CurrentDataTableId, Address(UniqueIdentifier), c25_SMTO_ABORTIFHUNG + c25_SMTO_BLOCK, 30000, Address(ReturnVal))
    End

    Return UniqueIdentifier

c25_DataManagerClass.AddClarionQRowsToDataRows                      Procedure(<bool _async>, string _dataTableNameOrId, *queue _qSource, <long _fromIndex>, <long _untilIndex>, <bool _updateRowIdSource>)

dataTable           &c25_DataTableClass
ReturnVal           Int32
UniqueIdentifier    cstring(21)
LastRowId long
CODE

    If _qSource &= NULL
        Return 0
    END

    dataTable &= (Self.GetDataTableInstance(,_dataTableNameOrId))
    If dataTable &= NULL
        If Numeric(_dataTableNameOrId)
            ID# = _dataTableNameOrId
            dataTable &= (Self.GetDataTableInstance(ID#))
        End
    End
    If DataTable &= NULL
        Return -3
    END

    I# = 0
    T# = Records(_qSource)

    Loop T# TIMES
        I# = I# + 1
        Get(_qSource,I#)
        LastRowId = dataTable.AddClarionQueueRowToQ3Blob(_qSource)
!        If omitted(_updateRowIdSource) = False And _updateRowIdSource = TRUE
!            C25_Memcpy(Address(_qSource),Address(LastRowId),4)
!        End
    End
    Return LastRowId

c25_DataManagerClass.AddClarionQRowToDataRow                        Procedure(<bool _async>, string _dataTableNameOrId, *queue _qSource, <bool _updateRowIdSource>)

dataTable           &c25_DataTableClass
ReturnVal           Int32
UniqueIdentifier    cstring(21)
LastRowId long
CODE

    If _qSource &= NULL
        Return 0
    END
    dataTable &= (Self.GetDataTableInstance(,_dataTableNameOrId))
    If dataTable &= NULL
        If Numeric(_dataTableNameOrId)
            ID# = _dataTableNameOrId
            dataTable &= (Self.GetDataTableInstance(ID#))
        End
    End
    If DataTable &= NULL
        Return -3
    END
    LastRowId = dataTable.AddClarionQueueRowToQ3Blob(_qSource)
    If omitted(_updateRowIdSource) = False And _updateRowIdSource = TRUE
        C25_Memcpy(Address(_qSource),Address(LastRowId),4)
    End
    Return LastRowId

c25_DataManagerClass.ExportDataRows                                 Procedure(<bool _async>, string _dataTableNameOrId, string _databaseType, string _formatType, string _exportTarget)

dataTable           &c25_DataTableClass
ReturnVal           Int32
UniqueIdentifier    cstring(21)
LastRowId                               long

CODE

    dataTable &= (Self.GetDataTableInstance(,_dataTableNameOrId))
    If dataTable &= NULL
        If Numeric(_dataTableNameOrId)
            ID# = _dataTableNameOrId
            dataTable &= (Self.GetDataTableInstance(ID#))
        End
    End
    If DataTable &= NULL
        Return -3
    End

    Message('_exportTarget  ' & _exportTarget)

    !DataTable.SqliteClass.Connect('file:' & Clip(Self.Name) & '?mode=memory')
    DataTable.SqliteClass.StoreToDisk(_exportTarget)

    Return 0

c25_DataManagerClass.GetDataTableProperty                           Procedure(string _dataTableNameOrId, string _property)

DataTable                   &c25_DataTableClass
DataTablePropertyId         Long

CODE
        
    DataTable &= (Self.GetDataTableInstancePtr(_dataTableNameOrId))
    If DataTable &= NULL
        Return ''
    End
    
    DataTablePropertyId = Self.MetaReflectionClass.DataTableProperty2DataTablePropertyEnum(_property)
!    Case DataTablePropertyId
!    Of DataTablePropertyEnum:AutoAddHiddenUtf16Columns               EQUATE
!    Of DataTablePropertyEnum:AutoAddStyleColumns                     EQUATE
!    Of DataTablePropertyEnum:AWE_Extensions                          EQUATE
!    Of DataTablePropertyEnum:BackwardsCompatible                     EQUATE
!    Of DataTablePropertyEnum:ChangeTracking                          EQUATE
!    Of DataTablePropertyEnum:CompressionType                         EQUATE
!    Of DataTablePropertyEnum:Conn_AuthentificationMethod             EQUATE
!    Of DataTablePropertyEnum:Conn_Collation                          EQUATE
!    Of DataTablePropertyEnum:Conn_ConnectionTimeout                  EQUATE
!    Of DataTablePropertyEnum:Conn_Database                           EQUATE
!    Of DataTablePropertyEnum:Conn_Encrypted                          EQUATE
!    Of DataTablePropertyEnum:Conn_ExecutionTimeout                   EQUATE
!    Of DataTablePropertyEnum:Conn_Instancename                       EQUATE
!    Of DataTablePropertyEnum:Conn_Language                           EQUATE
!    Of DataTablePropertyEnum:Conn_NetworkPacketSize                  EQUATE
!    Of DataTablePropertyEnum:Conn_NetworkProtocol                    EQUATE
!    Of DataTablePropertyEnum:Conn_ProductName                        EQUATE
!    Of DataTablePropertyEnum:Conn_ProductVersion                     EQUATE
!    Of DataTablePropertyEnum:Conn_ServerName                         EQUATE
!    Of DataTablePropertyEnum:Conn_SPID                               EQUATE
!    Of DataTablePropertyEnum:Conn_UserName                           EQUATE
!    Of DataTablePropertyEnum:Connection_Database                     EQUATE
!    Of DataTablePropertyEnum:Connection_Server                       EQUATE
!    Of DataTablePropertyEnum:Connection_String                       EQUATE
!    Of DataTablePropertyEnum:Connection_User                         EQUATE
!    Of DataTablePropertyEnum:CreationTime                            EQUATE
!    Of DataTablePropertyEnum:DataSpace                               EQUATE
!    Of DataTablePropertyEnum:Default_Collation                       EQUATE
!    Of DataTablePropertyEnum:Description_CreatedDate                 EQUATE
!    Of DataTablePropertyEnum:Description_Name                        EQUATE
!    Of DataTablePropertyEnum:Description_Schema                      EQUATE
!    Of DataTablePropertyEnum:Description_SystemObject                EQUATE
!    Of DataTablePropertyEnum:IndexSpace                              EQUATE
!    Of DataTablePropertyEnum:Lock_Escalation                         EQUATE
!    Of DataTablePropertyEnum:ModificationTime                        EQUATE
!    Of DataTablePropertyEnum:Name                                    EQUATE
!    Of DataTablePropertyEnum:Options_ANSI_NULLs                      EQUATE
!    Of DataTablePropertyEnum:Options_Durability                      EQUATE
!    Of DataTablePropertyEnum:Options_MemoryOptimized                 EQUATE
!    Of DataTablePropertyEnum:Options_QuotedIdentifier                EQUATE
!    Of DataTablePropertyEnum:RowCount                                EQUATE
!    Of DataTablePropertyEnum:TableIsReplicated                       EQUATE
!    Of DataTablePropertyEnum:TrackColumnsUpdated                     EQUATE
!    Of DataTablePropertyEnum:TransactionLocked                       EQUATE
!    Of DataTablePropertyEnum:TransactionLockFromThreadHandle         EQUATE
!    Of DataTablePropertyEnum:TransactionLockTimeout                  EQUATE
!    Of DataTablePropertyEnum:TransactionLockTypeEnum                 EQUATE
!        
    DataTable &= NULL
    Return ''


c25_DataManagerClass.SetDataTableProperty                          Procedure(string _dataTableNameOrId, string _property, string _value, <long _propertyDataTypeEnum>)

DataTable                   &c25_DataTableClass
DataTablePropertyId         Long


CODE
        
    DataTable &= (Self.GetDataTableInstancePtr(_dataTableNameOrId))
    If DataTable &= NULL
        Return ''
    End
    DataTablePropertyId = Self.MetaReflectionClass.DataTableProperty2DataTablePropertyEnum(_property)    
    
        
    DataTable &= NULL
    Return ''

