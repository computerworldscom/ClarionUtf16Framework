        Member

    Include('c25_DataTableClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                        Module('c25DataManager.dll')
                            c25RegisterWM(long _messageName, long _messageNameLength),Long,C,Name('c25RegisterWM')
                        End
                    End


c25_DataTableClass.Destruct                                                 Procedure()

    Code

c25_DataTableClass.Construct                                                Procedure()

ClassStarter &c25_ClassStarter
Code

    Self.ClassTypeName = 'c25_WindowHandlerClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    
    Self.QueueCreateClass                       &= Self.ProgramHandlerClass.QueueCreateClass
    
    INCLUDE('SetCWM.clw')  

    Self.ProcessHeapHandle                       = c25_GetProcessHeap()
    
    Self.BitConverterClass                      &= NEW c25_BitConverterClass()
    Self.ClarionFieldsIn                        &= NEW ClarionFields_TYPE()
    Self.ClarionFieldsOut                       &= NEW ClarionFields_TYPE()
    Self.ClarionFieldsQ3                        &= NEW ClarionFields_TYPE()
    Self.Columns                                &= NEW DataColumnCollection_TYPE()
    Self.DataReflectionClass                    &= NEW c25_DataReflectionClass()
    Self.DllDataReflectionClass                 &= Self.ProgramHandlerClass.DllDataReflectionClass
    Self.JsonClarionStructure                   &= NEW JSONClass()
    Self.JsonClarionStructureString             &= NEW StringTheory()
    Self.MessageOnlyWindowClass                 &= NEW c25_MessageOnlyWindowClass()
    Self.NanoClockClass                         &= NEW c25_NanoSyncClass()
    Self.ObjectClass                            &= NEW c25_ObjectClass
    Self.ObjectClassDummy                       &= NEW c25_ObjectClass()
    Self.Q3                                     &= NEW Q3_TYPE()
    Self.QInfo                                  &= NEW Q_TYPE
    Self.SqliteClass                            &= NEW C25_SqliteClass()
    Self.stDLLQueueDeclaration                  &= NEW StringTheory()
    Self.stLogTryCreateColumns                  &= NEW StringTheory()
    
    Self.Rows &= NEW DataRow_TYPE()
    
    
    Self.MessageOnlyWindowClass.InitWindow(c25ClassTypes:DataTableClassType , Address(Self))
    Self.MessageOnlyWindowClass.OpenWindow()
    
    Self.AWEClass                               &= NEW c25_AWEClass()
    Self.AWEClass.CreateVirtualQueue()
    
    
c25_DataTableClass.SetRowCursor    Procedure(string _rowId)

CODE

    
    
    Return 0



c25_DataTableClass.ClaQueueToDataTable     Procedure(*queue _claQueue)

    
CODE
        
    Free(Self.ClarionFieldsIn)
        
    Self.DataReflectionClass.Analyze(_claQueue,  Self.ClarionFieldsIn)

        
    Return 0


c25_DataTableClass.WndProc_Process                                          Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, long ReturnVal, <*bool processNormal>)

ValInt              Long
Tuple2              Group,Pre(Typle2)
v1                      LONG
v2                      LONG
                    End
DataTable           &c25_DataTableClass
DataCell                &c25_DataCellClass
Result              &c25_ResultClass

Int32Val            Long
UInt64Val           Like(UINT64)
                                                                                    
DataRow             &c25_DataRowClass
UniqueIdentifier    cstring(21)

    CODE

        Case _message
        Of C25_WM_Timer
            processNormal = true
            ReturnVal = 0
        Of Self.CWM_SetTransactionLock
        Of Self.CWM_DataRowAddNew
            !Message('hier Self.CWM_DataRowAddNew')
            UniqueIdentifier = Self.DataRowAddNew()
            C25_Memcpy(_lParam,Address(UniqueIdentifier),Size(UniqueIdentifier))
        Of Self.CWM_SetColumnValue
            Self.CWM_SetColumnValueCount = Self.CWM_SetColumnValueCount + 1
            DataCell &= (_lParam)
            If  DataCell &= NULL
                Message('error cell is null')
            END
            If DataCell.ASyncCall
                C25_ReplyMessage(0)
            End
            Self.SetDataCellValue(DataCell)
            If DataCell.ASyncCall
                Dispose(DataCell)
            End
        Of Self.CWM_GetColumnValue
            DataCell &= (_lParam)
            Self.GetDataCellValue(DataCell)
        Of Self.CWM_DeleteDataRow
            C25_Memcpy(Address(UInt64Val),_lParam,8)
            Self.DeleteDataRow(UInt64Val)
        Of Self.ProgramHandlerClass.CWM_C25WinMes
            processNormal = False
        End

c25_DataTableClass.DataRowAddNew                                            Procedure()

!DataRow &c25_DataRowClass

Code

!    DataRow &= NEW c25_DataRowClass()
!    
!    Return DataRow.UniqueIdentifier
    Return 0
    
c25_DataTableClass.DeleteDataRow                                            Procedure(string _index64)   

IndexUInt64 LIKE(UINT64)

CODE 
    
    IndexUInt64 = _index64
    
    Get(Self.ClaQueue, IndexUInt64.Lo)
    If Errorcode() <> 0
        !_dataCell.Result.ValueObject.Message = 'error Get(Self.ClaQueue, RowIndex)'
    Else
        Delete(Self.ClaQueue)
        Message('deleted ' & IndexUInt64.Lo)
    End
    Return ''

    
c25_DataTableClass.SetDataCellValue                                         Procedure(*c25_DataCellClass _dataCell)

CODE

    If _dataCell &= NULL
        Message('error SetCellValue is null')
        Return 0
    END
    If _dataCell.ValueObject.ValueNumeric &= NULL
        _dataCell.ValueObject.ValueNumeric &= NEW ValueNumeric_TYPE()
    Else
        Clear(_dataCell.ValueObject.ValueNumeric)
    End
    
    
    Get(Self.ClaQueue, _dataCell.Index) ! changed todo check it was first int64.lo
    If Errorcode() <> 0
        !_dataCell.Result.ValueObject.Message = 'error Get(Self.ClaQueue, RowIndex)'
    Else
        Self.ClaQueueByteArray = Self.ClaQueue
        Case _dataCell.DataColumn.DataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            _dataCell.ValueObject.ValueNumeric.Int8Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.Int8Value),1)
        Of DataTypeEnum:CLA_SHORT
            _dataCell.ValueObject.ValueNumeric.Int16Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.Int16Value),2)
        Of DataTypeEnum:CLA_USHORT
            _dataCell.ValueObject.ValueNumeric.UInt16Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.UInt16Value),2)
        Of DataTypeEnum:CLA_DATE
            _dataCell.ValueObject.ValueNumeric.Int32Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.Int32Value),4)
        Of DataTypeEnum:CLA_TIME
            _dataCell.ValueObject.ValueNumeric.Int32Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.Int32Value),4)
        Of DataTypeEnum:CLA_LONG
            _dataCell.ValueObject.ValueNumeric.Int32Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.Int32Value),4)
        Of DataTypeEnum:CLA_ULONG
            _dataCell.ValueObject.ValueNumeric.UInt32Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.UInt32Value),4)
        Of DataTypeEnum:CLA_SREAL
            _dataCell.ValueObject.ValueNumeric.SRealValue = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.SRealValue),4)
        Of DataTypeEnum:CLA_REAL
            _dataCell.ValueObject.ValueNumeric.RealValue = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.SRealValue),8)
        Of DataTypeEnum:CLA_DECIMAL
            Return 0
        Of DataTypeEnum:CLA_PDECIMAL
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN12
            Return 0
        Of DataTypeEnum:CLA_BFLOAT4
            _dataCell.ValueObject.ValueNumeric.BFloat4Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.BFloat4Value),4)
        Of DataTypeEnum:CLA_BFLOAT8
            _dataCell.ValueObject.ValueNumeric.BFloat8Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.BFloat8Value),8)
        Of DataTypeEnum:CLA_ANY
            Return 8
        Of DataTypeEnum:CLA_UNKNOWN16
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN17
            Return 0
        Of DataTypeEnum:CLA_STRING
            C25_Memset(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, 32, _dataCell.DataColumn.ClaQStor_OffsetSize)
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.Buffer),_dataCell.ValueObject.BufferSize)
        Of DataTypeEnum:CLA_CSTRING
            C25_Memset(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, 0, _dataCell.DataColumn.ClaQStor_OffsetSize)
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.Buffer),_dataCell.ValueObject.BufferSize)
        Of DataTypeEnum:CLA_PSTRING
            Return 0
        Of DataTypeEnum:CLA_MEMO
            Return 0
        Of DataTypeEnum:CLA_GROUP
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN23
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN24
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN25
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN26
            Return 0
        Of DataTypeEnum:CLA_BLOB
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN28
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN29
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN30
            Return 0
        Of DataTypeEnum:CLA_REFERENCE
            Return 8
        Of DataTypeEnum:CLA_BSTRING
            Return 8 ! todo
        Of DataTypeEnum:CLA_ASTRING
            Return 0
        Of DataTypeEnum:CLA_KEY
            Return 0
!        Of DataTypeEnum:CLA_BOOL
!            Return 1
!        Of DataTypeEnum:CLA_BYTE
!            Return 1
!        Of DataTypeEnum:CLA_DATE
!            Return 4
!        Of DataTypeEnum:CLA_DECIMAL
!            Return 0
!        Of DataTypeEnum:CLA_INT64
!            Return 8
!        Of DataTypeEnum:CLA_LONG
!            Return 4
!        Of DataTypeEnum:CLA_REAL
!            Return 8
!        Of DataTypeEnum:CLA_SHORT
!            Return 2
!        Of DataTypeEnum:CLA_SREAL
!            Return 4
!        Of DataTypeEnum:CLA_STRING
!            Return 0
!        Of DataTypeEnum:CLA_TIME
!            Return 4
!        Of DataTypeEnum:CLA_UINT64
!            Return 8
!        Of DataTypeEnum:CLA_ULONG
!            Return 4
!        Of DataTypeEnum:CLA_USHORT
!            Return 2
        Of DataTypeEnum:CLAEXT_Dec20
            Return 11
        Of DataTypeEnum:CLAEXT_INT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_INT64STR8
            Return 8
        Of DataTypeEnum:CLAEXT_JSONInstance
            Return 8
        Of DataTypeEnum:CLAEXT_QUEUEREF
            Return 8
        Of DataTypeEnum:CLAEXT_STInstance
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGANSI
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGBINARY
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGJSON
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGREFANSI
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFBINARY
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF16
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF32
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF8
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGUTF16
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGUTF32
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGUTF8
            Return 0
        Of DataTypeEnum:CLAEXT_UINT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_UINT64STR8
            Return 8
        Of DataTypeEnum:MSSQL_BIGINT
            Return 8
        Of DataTypeEnum:MSSQL_BINARY
            Return 0
        Of DataTypeEnum:MSSQL_BIT
            Return 1
        Of DataTypeEnum:MSSQL_CHAR
            Return 0
        Of DataTypeEnum:MSSQL_DATETIME
            Return 0
        END
      
!        Int32Val = random(0,2^32)
!        C25_Memcpy(Address(Self.ClaQueueByteArray), Address(Int32Val), 4)
        
        !Self.ClaQueue = Self.ClaQueueByteArray
        Put(Self.ClaQueue)
    END
    Return 0

c25_DataTableClass.GetDataCellValue                                         Procedure(*c25_DataCellClass _dataCell)

CODE
    
    If _dataCell &= NULL
        Message('error GetDataCellValue is null')
        Return 0
    END
    If _dataCell.ValueObject &= NULL
        _dataCell.ValueObject &= NEW c25_ObjectClass
    End
    Get(Self.ClaQueue, _dataCell.Index) ! todo it was iunt64, so createdll something
    If Errorcode() <> 0
        Message('error Get(Self.ClaQueue, _dataCell.RowIndex64.Lo)')
!        If _dataCell.Result &= NULL
!            _dataCell.Result &= NEW c25_ResultClass()
!        End
!        _dataCell.Result.ValueObject.Message = 'error Get(Self.ClaQueue, RowIndex)'
    Else
        Self.ClaQueueByteArray = Self.ClaQueue
        Case _dataCell.DataColumn.DataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            _dataCell.ValueObject.ValueNumeric.Int8Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.Int8Value),1)
        Of DataTypeEnum:CLA_SHORT
            _dataCell.ValueObject.ValueNumeric.Int16Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.Int16Value),2)
        Of DataTypeEnum:CLA_USHORT
            _dataCell.ValueObject.ValueNumeric.UInt16Value = _dataCell.ValueObject.Buffer
            C25_Memcpy(Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart, Address(_dataCell.ValueObject.ValueNumeric.UInt16Value),2)
        Of DataTypeEnum:CLA_DATE
        OrOf DataTypeEnum:CLA_TIME
        OrOf DataTypeEnum:CLA_LONG
            C25_Memcpy(Address(_dataCell.ValueObject.ValueNumeric.Int32Value), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,4)
            _dataCell.ValueObject.StringValue &= Self.BitConverterClass.BinaryCopy(_dataCell.ValueObject.ValueNumeric.Int32Value)
        Of DataTypeEnum:CLA_ULONG
            C25_Memcpy(Address(_dataCell.ValueObject.ValueNumeric.UInt32Value), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,4)
            _dataCell.ValueObject.StringValue &= Self.BitConverterClass.BinaryCopy(_dataCell.ValueObject.ValueNumeric.UInt32Value)
        Of DataTypeEnum:CLA_SREAL
            C25_Memcpy(Address(_dataCell.ValueObject.ValueNumeric.SRealValue), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,4)
            _dataCell.ValueObject.StringValue &= Self.BitConverterClass.BinaryCopy(_dataCell.ValueObject.ValueNumeric.SRealValue)
        Of DataTypeEnum:CLA_REAL
            C25_Memcpy(Address(_dataCell.ValueObject.ValueNumeric.RealValue), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,8)
            _dataCell.ValueObject.StringValue &= Self.BitConverterClass.BinaryCopy(_dataCell.ValueObject.ValueNumeric.RealValue)
        Of DataTypeEnum:CLA_DECIMAL
            Return 0
        Of DataTypeEnum:CLA_PDECIMAL
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN12
            Return 0
        Of DataTypeEnum:CLA_BFLOAT4
            C25_Memcpy(Address(_dataCell.ValueObject.ValueNumeric.BFloat4Value), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,4)
            _dataCell.ValueObject.StringValue &= Self.BitConverterClass.BinaryCopy(_dataCell.ValueObject.ValueNumeric.BFloat4Value)
        Of DataTypeEnum:CLA_BFLOAT8
            C25_Memcpy(Address(_dataCell.ValueObject.ValueNumeric.BFloat8Value), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,8)
            _dataCell.ValueObject.StringValue &= Self.BitConverterClass.BinaryCopy(_dataCell.ValueObject.ValueNumeric.BFloat8Value)
        Of DataTypeEnum:CLA_ANY
            Return 8
        Of DataTypeEnum:CLA_UNKNOWN16
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN17
            Return 0
        Of DataTypeEnum:CLA_STRING
            _dataCell.ValueObject.StringValue &= NEW STRING(_dataCell.DataColumn.ClaQStor_OffsetSize)
            C25_Memcpy(Address(_dataCell.ValueObject.StringValue), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,_dataCell.DataColumn.ClaQStor_OffsetSize)
        Of DataTypeEnum:CLA_CSTRING
            _dataCell.ValueObject.StringValue &= NEW STRING(_dataCell.DataColumn.ClaQStor_OffsetSize)
            C25_Memcpy(Address(_dataCell.ValueObject.StringValue), Address(Self.ClaQueue) + _dataCell.DataColumn.ClaQStor_OffsetStart,_dataCell.DataColumn.ClaQStor_OffsetSize)
        Of DataTypeEnum:CLA_PSTRING
            Return 0
        Of DataTypeEnum:CLA_MEMO
            Return 0
        Of DataTypeEnum:CLA_GROUP
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN23
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN24
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN25
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN26
            Return 0
        Of DataTypeEnum:CLA_BLOB
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN28
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN29
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN30
            Return 0
        Of DataTypeEnum:CLA_REFERENCE
            Return 8
        Of DataTypeEnum:CLA_BSTRING
            Return 8 ! todo
        Of DataTypeEnum:CLA_ASTRING
            Return 0
        Of DataTypeEnum:CLA_KEY
            Return 0
!        Of DataTypeEnum:CLA_BOOL
!            Return 1
!        Of DataTypeEnum:CLA_BYTE
!            Return 1
!        Of DataTypeEnum:CLA_DATE
!            Return 4
!        Of DataTypeEnum:CLA_DECIMAL
!            Return 0
!        Of DataTypeEnum:CLA_INT64
!            Return 8
!        Of DataTypeEnum:CLA_LONG
!            Return 4
!        Of DataTypeEnum:CLA_REAL
!            Return 8
!        Of DataTypeEnum:CLA_SHORT
!            Return 2
!        Of DataTypeEnum:CLA_SREAL
!            Return 4
!        Of DataTypeEnum:CLA_STRING
!            Return 0
!        Of DataTypeEnum:CLA_TIME
!            Return 4
!        Of DataTypeEnum:CLA_UINT64
!            Return 8
!        Of DataTypeEnum:CLA_ULONG
!            Return 4
!        Of DataTypeEnum:CLA_USHORT
!            Return 2
        Of DataTypeEnum:CLAEXT_Dec20
            Return 11
        Of DataTypeEnum:CLAEXT_INT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_INT64STR8
            Return 8
        Of DataTypeEnum:CLAEXT_JSONInstance
            Return 8
        Of DataTypeEnum:CLAEXT_QUEUEREF
            Return 8
        Of DataTypeEnum:CLAEXT_STInstance
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGANSI
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGBINARY
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGJSON
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGREFANSI
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFBINARY
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF16
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF32
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF8
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGUTF16
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGUTF32
            Return 0
        Of DataTypeEnum:CLAEXT_STRINGUTF8
            Return 0
        Of DataTypeEnum:CLAEXT_UINT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_UINT64STR8
            Return 8
        Of DataTypeEnum:MSSQL_BIGINT
            Return 8
        Of DataTypeEnum:MSSQL_BINARY
            Return 0
        Of DataTypeEnum:MSSQL_BIT
            Return 1
        Of DataTypeEnum:MSSQL_CHAR
            Return 0
        Of DataTypeEnum:MSSQL_DATETIME
            Return 0
        END
    END
    Return 0
    
c25_DataTableClass.GetDummyQueueDll                                         Procedure()

MemAddress  LONG
MemSize  LONG

Test String(10000)
Tuple2              Group,Pre(Typle2)
v1                      LONG
v2                      LONG
                    End

    CODE



        MemSize = Records(Self.QueueCreateClass.DllBytes)
        MemAddress = c25_HeapAlloc(Self.ProcessHeapHandle, c25_HEAP_ZERO_MEMORY, MemSize)
        I# = 0
        LOOP MemSize Times
            I# = I# + 1
            Get(Self.QueueCreateClass.DllBytes,I#)
            c25_Memcpy(MemAddress + I# - 1, Address(Self.QueueCreateClass.DllBytes.Byte),1)
        End

        Tuple2.v1 = MemAddress
        Tuple2.v2 = MemSize

        Return Tuple2

c25_DataTableClass.GetCreateQueueClassWindowHandle   			            Procedure()

	Code
		
        If Self.CreateQueueWindowHandle <> 0
            Return Self.CreateQueueWindowHandle
        End
        If Self.ProgramHandlerClass &= NULL
            Return 0
        End
        If Self.QueueCreateClass &= NULL
            Return 0
        End
        Self.CreateQueueWindowHandle = Self.QueueCreateClass.MessageOnlyWindowClass.WindowHandle
        Return Self.CreateQueueWindowHandle

c25_DataTableClass.JsonToClarionFields                                      Procedure(<string _jsonString>)

    CODE
        
        !Message('start c25_DataTableClass.JsonToClarionFields')
        !Message('dat wel: ' &Self.JsonClarionStructureString.GetValue())
        

        If Self.ClarionFieldsIn &= NULL
            Message('error Self.ClarionFields is null')
        End
        Free(Self.ClarionFieldsIn)
        If Self.BitConverterClass &= NULL
            Message('error Self.BitConverterClass is null')
        Else
            !Message('ok Self.BitConverterClass is null')
        End
        Self.BitConverterClass.JsonStringToQueue(Self.JsonClarionStructureString.GetValue(), Self.ClarionFieldsIn)
        !Message('done Self.BitConverterClass.JsonStringToQueue, records Self.ClarionFieldsIn: ' & Records(Self.ClarionFieldsIn))
        
        Self.BitConverterClass.QToJson(Self.ClarionFieldsIn, 'm:\c25_DataTableClass_JsonToClarionFields.json')
        
        !Message('end c25_DataTableClass.JsonToClarionFields')

        Return True

c25_DataTableClass.WriteNewDLLBlock                                         Procedure()


CODE

    !Message('c25_DataTableClass.WriteNewDLLBlock')
    Self.stDLLQueueDeclaration.SaveFile('m:\stDLLQueueDeclarationNew.txt')
    
    If Self.QueueCreateClass &= NULL
        Message('error Self.QueueCreateClass is null')
    End
    Self.QueueCreateClass.GetDllSectionInfo(2)
    
    !Message('Self.QueueCreateClass.DLLAddress ' & Self.QueueCreateClass.DLLAddress)
    !Message('Self.QueueCreateClass.DllWriteSection.VirtualAddress ' & Self.QueueCreateClass.DllWriteSection.VirtualAddress)
    !Message('Self.stDLLQueueDeclaration.GetAddress() ' & Self.stDLLQueueDeclaration.GetAddress())
    
!    Self.FieldMagic7Pos = Self.ObjectClass.FindInByteArray('FIELDMAGIC7',Self.DLLAddress, Self.DLLSize)
!    If Self.FieldMagic7Pos = 0
!        Message('error Self.FieldMagic7Pos = 0')
!    END
!    
!    Message('Self.FieldMagic7Pos ' & Self.FieldMagic7Pos)
    !Message(Self.ProgramHandlerClass.QueueCreateClass.FieldMagic7Pos & ',' & Self.QueueCreateClass.DllWriteSection.VirtualAddress & ', ' & Self.QueueCreateClass.DLLAddress)
    
    !Message('fm7 ' & Self.ProgramHandlerClass.QueueCreateClass.FieldMagic7Pos - Self.QueueCreateClass.DllWriteSection.VirtualAddress)
    
    Offset# = Self.ProgramHandlerClass.QueueCreateClass.FieldMagic7Pos - Self.QueueCreateClass.DllWriteSection.VirtualAddress
!    
    !C25_Memcpy(Self.QueueCreateClass.DLLAddress + Self.QueueCreateClass.DllWriteSection.VirtualAddress + 70, Self.stDLLQueueDeclaration.GetAddress(), Self.stDLLQueueDeclaration.Length() ) ! todo execute in createqueue threa
    
    C25_Memcpy(Self.QueueCreateClass.DLLAddress + Self.QueueCreateClass.DllWriteSection.VirtualAddress + Offset# - 15, Self.stDLLQueueDeclaration.GetAddress(), Self.stDLLQueueDeclaration.Length() ) ! todo execute in createqueue threa
    Self.stDLLQueueDeclaration.Start()
    Self.stDLLQueueDeclaration.Append(All(Chr(0),Self.QueueCreateClass.DllWriteSection.VirtualSize))
    C25_Memcpy(Self.stDLLQueueDeclaration.GetAddress(),Self.QueueCreateClass.DLLAddress + Self.QueueCreateClass.DllWriteSection.VirtualAddress ,Self.QueueCreateClass.DllWriteSection.VirtualSize)
    
    Self.stDLLQueueDeclaration.SaveFile('m:\WrittenBlockX.txt')
    Return 0

c25_DataTableClass.CreateDllQueueDeclaration                                Procedure()

CODE

    If Self.DllDataReflectionClass &= NULL
        Message('error Self.DllDataReflectionClass &= NULL')
        Return 0
    End
    Self.stDLLQueueDeclaration.Start()
    Self.stDLLQueueDeclaration.Append(Self.BitConverterClass.GetBytesFromInt32(Self.DCC_RowAllocSize))
    Self.stDLLQueueDeclaration.Append(Self.BitConverterClass.GetBytesFromInt32(Self.DCC_Count))
    Self.stDLLQueueDeclaration.Append(Self.BitConverterClass.GetBytesFromInt32(Self.DCC_StructureLength))
    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.Columns,I#)
        If Errorcode() <> 0
            BREAK
        END
        If Self.Columns.DataColumn &= NULL
            CYCLE
        End
        If Self.Columns.DataColumn.Disabled
            CYCLE
        End
        Self.stDLLQueueDeclaration.Append(Self.Columns.DataColumn.ClaQStor_DllSetInfo)
        Self.stDLLQueueDeclaration.Append(Self.Columns.DataColumn.Name)
        Self.stDLLQueueDeclaration.Append(Self.Columns.DataColumn.ClaQStor_DllSetInfoTrailing)
    End
    Self.stDLLQueueDeclaration.Append(Chr(0)) !& Chr(0))
    Self.stDLLQueueDeclaration.Append(Chr(5))
    Self.stDLLQueueDeclaration.Append(Chr(0) & Chr(0) & Chr(0))
    Self.stDLLQueueDeclaration.SaveFile('m:\stDLLQueueDeclaration.txt')
    Return 0

c25_DataTableClass.CalculateDLLProperties                                   Procedure()

CODE

    Self.DCC_Count              = 0
    Self.DCC_RowAllocSize       = 0
    Self.DCC_StructureLength    = 0

    If Self.Columns &= NULL
        Message('error Self.Columns is null')
    End

    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.Columns,I#)
        If Errorcode() <> 0
            BREAK
        END
        If Self.Columns.DataColumn &= NULL
            CYCLE
        End
        If Self.Columns.DataColumn.Disabled
            CYCLE
        End
        Self.DCC_Count              = Self.DCC_Count + 1
        Self.DCC_RowAllocSize       = Self.DCC_RowAllocSize + Self.Columns.DataColumn.ClaQStor_DataAllocSize
        If Self.Columns.DataColumn.Name &= NULL
            Message('error Self.Columns.DataColumn.Name is null')
        End
        Self.DCC_StructureLength    = Self.DCC_StructureLength + Self.Columns.DataColumn.ClaQStor_DllSetInfoLength + Size(Self.Columns.DataColumn.Name) + Self.Columns.DataColumn.ClaQStor_DllSetInfoTrailingLength

    End
    Self.DCC_StructureLength    = Self.DCC_StructureLength + 14
    Return 0

c25_DataTableClass.ClarionFieldsToColumnsCollection                         Procedure(<ClarionFields_TYPE _clarionFields>)

CODE

    Self.DisposeColumnsCollection()
    If Self.BitConverterClass &= NULL
        Message('error Self.BitConverterClass is null')
    End
    If Self.BitConverterClass.St1 &= NULL
        Message('Self.BitConverterClass.st1 is null')
    End
    Self.BitConverterClass.St1.Start()

    If Self.ClarionFieldsIn &= NULL
        Message('error Self.ClarionFields is null')
        return 0
    End
    If Self.Columns &= NULL
        Message('error Self.Columns is null')
        return 0
    End
    Free(Self.Columns)

    Self.ColumnsIdSeed = 0
    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.ClarionFieldsIn,I#)
        If Errorcode() <> 0
            BREAK
        END
        Self.stLogTryCreateColumns.Append('I# Name : ' & Self.ClarionFieldsIn.Name & Chr(13) & Chr(10))
        Clear(Self.Columns)

        Self.ColumnsIdSeed              = Self.ColumnsIdSeed + 1
        Self.Columns.Id                 = Self.ColumnsIdSeed
        Self.Columns.Ordinal            = I#
        Self.Columns.DataColumn         &= NEW c25_DataColumnClass()
        Self.Columns.DataColumnPtr      = Address(Self.Columns.DataColumn)
        Add(Self.Columns)

        Self.Columns.DataColumn.AllowDBNull     = TRUE
        If Len(Clip(Self.ClarionFieldsIn.Name)) < 1
            Message('error Len(Clip(Self.ClarionFieldsIn.Name)) < 1')
        End

        Self.Columns.DataColumn.Caption         &= Self.BitConverterClass.BinaryCopy(CLip(Self.ClarionFieldsIn.Name))
        Self.Columns.DataColumn.Name            &= Self.BitConverterClass.BinaryCopy(Clip(Self.ClarionFieldsIn.Name))

        Self.BitConverterClass.StAppendLine(Self.BitConverterClass.St1, 'Self.Columns.DataColumn.Name ' & Self.Columns.DataColumn.Name )
        Self.BitConverterClass.StAppendLine(Self.BitConverterClass.St1, 'Self.Columns.DataColumn.Name Size ' & Size(Self.Columns.DataColumn.Name) )

        Self.Columns.DataColumn.DataTypeEnum = Self.ClarionFieldsIn.DataTypeEnum

        Case Self.Columns.DataColumn.DataTypeEnum
        Of DataTypeEnum:CLA_DECIMAL
        OrOf DataTypeEnum:CLA_PDECIMAL
        OrOf DataTypeEnum:CLA_DECIMAL
            Self.Columns.DataColumn.DataLength &= Self.BitConverterClass.BinaryCopy(Self.ClarionFieldsIn.Characters & ',' & Self.ClarionFieldsIn.Places)

        Else
            If Self.ClarionFieldsIn.Places <> 0
                Self.Columns.DataColumn.DataLength &= Self.BitConverterClass.BinaryCopy(Self.ClarionFieldsIn.Characters & ',' & Self.ClarionFieldsIn.Places)
            Else
                Self.Columns.DataColumn.DataLength &= Self.BitConverterClass.BinaryCopy(Self.ClarionFieldsIn.Characters)
                !Message('hier : ' & Self.Columns.DataColumn.DataLength)
            End
        End

        If Self.Columns.DataColumn.DataLength &= NULL
            Message('error Self.Columns.DataColumn.DataLength is null')
        End

        Self.Columns.DataColumn.DataType &= Self.BitConverterClass.BinaryCopy(Self.DataReflectionClass.GetDataTypeFromEnum(Self.ClarionFieldsIn.DataTypeEnum))

        If Self.Columns.DataColumn.DataType &= NULL
            Message('error Self.Columns.DataColumn.DataType &= NULL')
            break
        End
        Self.BitConverterClass.StAppendLine(Self.BitConverterClass.St1, Self.Columns.DataColumn.DataTypeEnum & ', Self.Columns.DataColumn.DataType: ' & Self.Columns.DataColumn.DataType)


        Self.Columns.DataColumn.TablePtr = Address(Self)

        Self.Columns.DataColumn.ClaQStor_DataTypeEnum = Self.DataReflectionClass.DataTypeEnumToClarionQStorageType(Self.Columns.DataColumn.DataTypeEnum)
        Self.Columns.DataColumn.ClaQStor_DataType &= Self.BitConverterClass.BinaryCopy(Self.DataReflectionClass.GetDataTypeFromEnum(Self.Columns.DataColumn.ClaQStor_DataTypeEnum))

        If Self.ClarionFieldsIn.Places > 0
            Self.Columns.DataColumn.ClaQStor_DataAllocSize = Self.DataReflectionClass.DataTypeEnumToClarionQStorageSize(Self.Columns.DataColumn.DataTypeEnum,Self.ClarionFieldsIn.Characters, Self.ClarionFieldsIn.Places)
        Else
            Self.Columns.DataColumn.ClaQStor_DataAllocSize = Self.DataReflectionClass.DataTypeEnumToClarionQStorageSize(Self.Columns.DataColumn.DataTypeEnum,Self.ClarionFieldsIn.Characters)
        End
        !Message('Self.Columns.DataColumn.ClaQStor_DataAllocSize  ' & Self.Columns.DataColumn.ClaQStor_DataAllocSize )


        Self.Columns.DataColumn.ClaQStor_DllSetInfo &= Self.BitConverterClass.BinaryCopy(Self.DataReflectionClass.DataTypeEnumToDllSetInfo(2, Self.Columns.DataColumn.ClaQStor_DataTypeEnum,Self.ClarionFieldsIn.Characters, Self.ClarionFieldsIn.Places))
        
        
        !Message(size(Self.Columns.DataColumn.ClaQStor_DllSetInfo) & ' ,' & Len(Self.Columns.DataColumn.ClaQStor_DllSetInfo))
        
        If Self.Columns.DataColumn.ClaQStor_DllSetInfo &= NULL
            Message('error Self.Columns.DataColumn.ClaQStor_DllSetInfo is null')
        End
        Self.Columns.DataColumn.ClaQStor_DllSetInfoLength = Size(Self.Columns.DataColumn.ClaQStor_DllSetInfo)


        Self.BitConverterClass.StAppendLine(Self.BitConverterClass.St1, 'ClaQStor_DllSetInfoLength: ' & Self.Columns.DataColumn.ClaQStor_DllSetInfoLength)

        Self.Columns.DataColumn.ClaQStor_DllSetInfoTrailing &= Self.BitConverterClass.BinaryCopy(Chr(0))
        Self.Columns.DataColumn.ClaQStor_DllSetInfoTrailingLength = Size(Self.Columns.DataColumn.ClaQStor_DllSetInfoTrailing)
        
        !Message('Self.Columns.DataColumn.DataLength ' & Self.Columns.DataColumn.DataLength)
        
    End
    Self.BitConverterClass.st1.SaveFile('m:\DataColumnInstances.txt')
    Return 0

c25_DataTableClass.GetRowsCount  			                                Procedure()

	Code
		
        If not Self.ClaQueue &= NULL
            Self.RowsCount = Records(Self.ClaQueue)
        ELSE
            Self.RowsCount = 0
        End
        Return Self.RowsCount

c25_DataTableClass.CreateColumnsCollection                                  Procedure()

    CODE

        Self.DisposeColumnsCollection()

c25_DataTableClass.CreateNewColumnOld                                       Procedure(<string _name>, <string _dataType>, <string _dataLength>, <bool _allowDBNull>, <string _value>, <long _valueLen>, <long _valuePtr>, <long _valueSize>)

DataColumnClass &c25_DataColumnClass

    CODE

        Clear(Self.Columns)

        Self.ColumnsIdSeed = Self.ColumnsIdSeed + 1
        Self.Columns.Id = Self.ColumnsIdSeed
        Self.Columns.Ordinal = Records(Self.Columns)

        DataColumnClass &= NEW c25_DataColumnClass()
        Self.Columns.DataColumn &= DataColumnClass

        If Omitted(_name) = False
            DataColumnClass.Caption &= Self.BitConverterClass.BinaryCopy(_name)
        End
        If Omitted(_dataType) = False
            DataColumnClass.DataType &= Self.BitConverterClass.BinaryCopy(_dataType)
            DataColumnClass.DataTypeEnum = Self.DataReflectionClass.GetDataTypeEnum(DataColumnClass.DataType)
        End
        If Omitted(_dataLength) = False
            DataColumnClass.DataLength &= Self.BitConverterClass.BinaryCopy(_dataLength)
        End
        If Omitted(_allowDBNull) = False
            DataColumnClass.AllowDBNull = _allowDBNull
        End

        Self.Columns.DefaultItem &= NEW c25_ObjectClass()
        If omitted(_dataType) = False
            DataColumnClass.DataType &= Self.BitConverterClass.BinaryCopy(_dataType)
            Self.Columns.DefaultItem.DataType &= Self.BitConverterClass.BinaryCopy(_dataType)
        End
        If omitted(_dataLength) = False
            DataColumnClass.DataLength &= Self.BitConverterClass.BinaryCopy(_dataLength)
            Self.Columns.DefaultItem.DataLength &= Self.BitConverterClass.BinaryCopy(_dataLength)
        End
        If omitted(_value) = False
            If omitted(_valueLen) = False And _valueLen > 0
                Self.Columns.DefaultItem.ValueSize = _valueLen
                Self.Columns.DefaultItem.ValuePtr = c25_HeapAlloc(Self.ProcessHeapHandle, c25_HEAP_ZERO_MEMORY, Self.Columns.DefaultItem.ValueSize)
                If Self.Columns.DefaultItem.ValueSize > Size(_value)
                    c25_Memcpy(Self.Columns.DefaultItem.ValuePtr, Address(_value),Size(_value)) ! implicitly padded with zero's
                ELSE
                    c25_Memcpy(Self.Columns.DefaultItem.ValuePtr, Address(_value),Self.Columns.DefaultItem.ValueSize)
                End
            Else
                Self.Columns.DefaultItem.ValueSize = Size(_value)
                If Self.Columns.DefaultItem.ValueSize > 0
                    Self.Columns.DefaultItem.ValuePtr = c25_HeapAlloc(Self.ProcessHeapHandle, c25_HEAP_ZERO_MEMORY, Self.Columns.DefaultItem.ValueSize)
                    c25_Memcpy(Self.Columns.DefaultItem.ValuePtr, Address(_value),Self.Columns.DefaultItem.ValueSize)
                End
            End
        ElsIf omitted(_valuePtr) = False And _valuePtr <> 0 And _valueSize > 0
            Self.Columns.DefaultItem.ValueSize = _valueSize
            Self.Columns.DefaultItem.ValuePtr = c25_HeapAlloc(Self.ProcessHeapHandle, c25_HEAP_ZERO_MEMORY, Self.Columns.DefaultItem.ValueSize)
            c25_Memcpy(Self.Columns.DefaultItem.ValuePtr, _valuePtr, Self.Columns.DefaultItem.ValueSize)
        End

        If Self.Columns.DefaultItem.ValuePtr = 0 And DataColumnClass.AllowDBNull = True
            Self.Columns.DefaultItem.IsNULL = True
        End

        DataColumnClass &= NULL

        Add(Self.Columns)
        Clear(Self.Columns)

c25_DataTableClass.DisposeColumnsCollection                                 Procedure()

    CODE

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.Columns,I#)
            If Errorcode() <> 0
                BREAK
            End
            If NOT Self.Columns.DefaultItem &= NULL
                Dispose(Self.Columns.DefaultItem)
                Self.Columns.DefaultItem &= NULL
            End
            Clear(Self.Columns) ! not really usefull
            Put(Self.Columns)
        End
        Free(Self.Columns)
        Self.ColumnsIdSeed = 0
        
c25_DataTableClass.CreateSqliteMemoryTable  Procedure()

CODE
        
    !Message('c25_DataTableClass.CreateSqliteMemoryTable')
    REMOVE('c:\' & Clip(Self.Name) & '.sqlite')

    !Self.SqliteConnHandle = Self.SqliteClass.Connect('file:MemDb' & Clip(_tableName) & '?mode=memory&cache=shared;Version=3')
    !'file:MemDbGlobal?mode=memory&cache=shared'
    
    !Self.SqliteConnHandle = Self.SqliteClass.Connect('file:U:\' & Clip(Self.Name) & '.sqlite')
    
    
    Self.SqliteConnHandle = Self.SqliteClass.Connect('file:' & Clip(Self.Name) & '?mode=memory') !&cache=shared')
    
    !Self.SqliteConnHandle = Self.SqliteClass.Connect('file:' & Clip(Self.Name) & '.sqlite')
    
    
!    Loop 77 TIMES
!        Self.Q3.RowId = Records(Self.Q3) + 1
!        Self.Q3.QRowBytes &= Self.BitConverterClass.BinaryCopy('allemachtig zeg')
!        Add(Self.Q3)
!    End
    
    
    Free(Self.ClarionFieldsQ3)
    
    Self.DataReflectionClass.Analyze(Self.Q3, Self.ClarionFieldsQ3)
    Self.DataReflectionClass.UpdateSqliteDataTypeEnum(Self.ClarionFieldsQ3)
    Self.DataReflectionClass.MapDataTypeTarget(Self.ClarionFieldsQ3)    
    Self.DataReflectionClass.SetDataTypeTarget(Self.ClarionFieldsQ3,'QRowBytes',DatatypeEnum:SQLITE_BLOB)
    Self.SqliteClass.CreateTableFromQueue(Self.Q3, 'Q3', True, True, ,Self.ClarionFieldsQ3)
    
    !Self.SqliteClass.QueueDataToSqliteTableEntity(Self.Q3, 'Q3',Self.ClarionFieldsQ3)
    
    !Self.SqliteClass.StoreToDisk('m:\datwerkt.sqlite')
    !Self.SqliteClass.Disconnect(Self.SqliteConnHandle)
    !Message(address(q
    !Self.SqliteClass.Disconnect(Self.SqliteConnHandle)
    
    Return Self.SqliteConnHandle

c25_DataTableClass.FlushClaQueue  Procedure()

CODE

    !Self.SqliteConnHandle = Self.SqliteClass.Connect('file:MemDb' & Clip(_tableName) & '?mode=memory&cache=shared;Version=3')
    
    Self.SqliteConnHandle = Self.SqliteClass.Connect('file:' & Clip(Self.Name) & '.sqlite')
    If Self.ClaQueue &= NULL
        Message('error flush cla q Self.ClaQueue &= NULL')
        Return 0
    End
    !Self.SqliteClass.QueueDataToSqliteTable(Self.ClaQueue, Clip(Self.Name))
    !Self.SqliteClass.Disconnect(Self.SqliteConnHandle)
    
    Return 0

    
c25_DataTableClass.AddQueueRow      Procedure(<*queue _q>, <ClarionFields_TYPE _clarionFields>)

CODE


    G# = 0
    Loop
        G# = G# + 1
        Get(Self.ClarionFieldsIn,G#)
        If errorcode() <> 0
            BREAK
        END
        Message('Self.ClarionFieldsIn ' & Self.ClarionFieldsIn.Name)
    End
    !Self.SqliteClass.SerializeToQ3Blob(Self.ClaQueue, Self.ClarionFieldsIn)
    Return ''
    
    
c25_DataTableClass.AddClarionQueueRowToQ3Blob     Procedure(*queue _qSource, <bool _isLast>)



CODE

!    Self.LastRowId = 0
!
!    If omitted(_isLast) = False And _isLast = True
!        Self.LastRowId = Self.SqliteClass.AddClarionQueueRowToQ3Blob( Address(_qSource), Size(_qSource), True)
!        !Self.SqliteClass.AddClarionQueueRowToQ3Blob( Address(_qSource), Size(_qSource), True)
!        !Self.SqliteClass.StoreToDisk('m:\Q3Backuup.sqlite')
!        !Self.SqliteClass.Disconnect(Self.SqliteConnHandle)
!        !Self.SqliteClass.Disconnect(Self.SqliteConnHandle)
!    ELSE
        Self.LastRowId = Self.SqliteClass.AddClarionQueueRowToQ3Blob( Address(_qSource), Size(_qSource))
    !End
    Return Self.LastRowId
    
    
    
    