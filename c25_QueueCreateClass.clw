        Member

    Include('c25_QueueCreateClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
                        Include('c25_WinApiPrototypes.inc')

                        Module('c25DataManager.dll')
                            CreateQueueDll(),*QUEUE,Pascal
                        End
                    End

c25_QueueCreateClass.Destruct                                       Procedure()

    Code

c25_QueueCreateClass.Construct                                      Procedure()

ClassStarter &c25_ClassStarter

Code

    Self.ClassTypeName = 'c25_QueueCreateClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    
    
c25_QueueCreateClass.Init                                      Procedure()

Code
    
    
    Self.DLLDataReflectionClass             &= Self.ProgramHandlerClass.DLLDataReflectionClass
    Self.DllLoader                          &= NEW c25_DllLoaderClass()
    
    Self.BitConverterClass                  &= NEW c25_BitConverterClass()
    Self.DataReflectionClass                &= NEW c25_DataReflectionClass()

    Self.MessageOnlyWindowClass             &= NEW c25_MessageOnlyWindowClass()
    Self.MessageOnlyWindowClass.InitWindow(c25ClassTypes:QueueCreateClassType , Address(Self))
    Self.MessageOnlyWindowClass.OpenWindow()

    Self.StDllBytesDefault                  &= NEW StringTheory()
    Self.StDllBytesNew                      &= NEW StringTheory()
    Self.StDllBytes                         &= NEW StringTheory()
    Self.ProcessHeapHandle                  = c25_GetProcessHeap()
    Self.ObjectClass                        &= NEW c25_ObjectClass()
    Self.DllWriteSection                    &= NEW QDLLSections_TYPE()
    Clear(Self.DllWriteSection)
    Add(Self.DllWriteSection)
    Self.QInfo                              &= NEW Q_TYPE()

    Self.DllFileNameUtf8                    = 'QueueMeta001.dll'
    Self.ProductName                        = 'QueueExtender'

    Self.stStructure                        &= NEW StringTheory()
    Self.StDllBytesNew                      &= NEW StringTheory()
    Self.stLog                              &= NEW StringTheory()

    Self.NewLine                            = Chr(13) & Chr(10)

    Self.DataTableColumns                   &= NEW DataTableColumns_TYPE
    
    Self.LoadQDllIntoMemory(Self.DLLAddress, Self.DLLSize)

    Self.FieldMagic7Pos = Self.ObjectClass.FindInByteArray('FIELDMAGIC7',Self.DLLAddress, Self.DLLSize)
    If Self.FieldMagic7Pos = 0
        Message('error Self.FieldMagic7Pos = 0')
    END
    
    Return 0
    
    !fp_CreateQueueDll = self.DllLoader.LoadDllFunctionCall('QueueMeta001.dll', 'CreateQueueDll',,,'QueueExtender')


c25_QueueCreateClass.LoadQDllIntoMemory                             Procedure(*long _address, *long _size)

StartOffset                                 Long
NewByte                                     byte
GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS      equate(4)
GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT                            equate(2)

lphModule string(64000)
lpcbNeeded         Long
BaseName           cstring(2024)

st &StringTheory
Code

    st &= NEW StringTheory()
    st.Start()
    
    !return 0
!GetModuleHandleEx(
!    GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
!    (LPCTSTR)GetCurrentModule,
!    &hModule);
!
!  return hModule;    

    !Loop
        !B# = c25_EnumProcessModules(c25_GetCurrentProcess(), Address(lphModule), Size(lphModule), Address(lpcbNeeded))
        !Message('lpcbNeeded ' & lpcbNeeded)
!        If B# = 0
!            BREAK
!        End
    B# = c25_EnumProcessModules(c25_GetCurrentProcess(), Address(lphModule), Size(lphModule), Address(lpcbNeeded))
    !Message('lpcbNeeded ' & lpcbNeeded)
    
    Self.stLog.Start()
    
    P# = -4
    Loop lpcbNeeded / 4 TIMES
        P# = P# + 4
        C25_Memcpy(Address(Self.ModuleHandle), Address(lphModule) + P#,4)
        !Message('Self.ModuleHandle ' & Self.ModuleHandle)
        
        C25_GetModuleInformation(c25_GetCurrentProcess(), Self.ModuleHandle, Address(Self.ModuleInfo), Size(Self.ModuleInfo))
        
        !Self.ModuleInfo.
        _address = Self.ModuleInfo.BaseOfDll;
        _size = Self.ModuleInfo.SizeOfImage;
        !Message('EntryPoint ' & Self.ModuleInfo.EntryPoint)
        
        !Message('_address ' & _address)
        !Message('_size ' & _size)        
        !BREAK
        
        Clear(BaseName)
        c25_GetModuleFileNameExA(c25_GetCurrentProcess(), Self.ModuleHandle, Address(BaseName), Size(BaseName)-1)
        Self.stLog.Append(Clip(BaseName) & '<13,10>')
        
        st.SetValue(Clip(BaseName))
        If st.FindChars('c25DataManager.dll')
            BREAK
        End
    End
    Dispose(st)
    
    !Self.stLog.Replace(Chr(0)
    !SETCLIPBOARD(Self.stLog.GetValue())
    
    !Message(Self.stLog.GetValue())
    
    _address = Self.ModuleInfo.BaseOfDll;
    _size = Self.ModuleInfo.SizeOfImage;
    
    Clear(Self.ModuleInfo)
    
    
    !Message(Self.DllFileNameUtf8)
    
    !Self.DLLHandle = Self.DllLoader.LoadDllIntoMemory(Clip(Self.DllFileNameUtf8), ,Clip(Self.ProductName))
    
    !Self.ModuleHandle = Self.DllLoader.GetModuleHandle(Clip(Self.ProductName))
    !0{Prop:Instance
    
    !Message('Self.ModuleHandle ' & Self.ModuleHandle)
    
    !c25_GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT ,0,Address(Self.ModuleHandle))
    
    !Message('Self.ModuleHandle ' & Self.ModuleHandle)
    !Self.ModuleHandle = SYSTEM{PROP:AppInstance}
    !Message('Self.ModuleHandle ' & Self.ModuleHandle)
    
    
    !c25_GetModuleHandleEx 
    !c25_GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS, c25_GetCurrentModule
    !c25_GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS, c25_GetCurrentModule
    !Message(_ABCLinkMode_ & ', ' & _ABCDllMode_)
    !Message('DLL_MODE ' & DLL_MODE)
    
    !C25_GetModuleInformation(c25_GetCurrentProcess(), Self.DLLHandle, Address(Self.ModuleInfo), Size(Self.ModuleInfo))
    
!!!!    C25_GetModuleInformation(c25_GetCurrentProcess(), Self.ModuleHandle, Address(Self.ModuleInfo), Size(Self.ModuleInfo))
!!!!    
!!!!    !Self.ModuleInfo.
!!!!    _address = Self.ModuleInfo.BaseOfDll;
!!!!    _size = Self.ModuleInfo.SizeOfImage;
!!!!
!!!!    Message('_address ' & _address)
!!!!    Message('_size ' & _size)
    !Self.DLLHandle = Self.ModuleInfo.BaseOfDll
    Return Self.DLLHandle
    
    
    
    

c25_QueueCreateClass.LoadedDllToDllBytesQ                           Procedure()

I                       LONG
DllBytesByteAddress     LONG
StartOffset             LONG

    CODE

        Free(Self.DllBytes)
        Self.StDllBytes.Start()

        I = -1
        DllBytesByteAddress = Address(Self.DllBytes.Byte)
        StartOffset = Self.ModuleInfo.BaseOfDll
        Loop Self.ModuleInfo.SizeOfImage TIMES
            I = I + 1
            Clear(Self.DllBytes)
            C25_MemCpy(DllBytesByteAddress, StartOffset + I, 1)
            Self.DllBytes.Pos           = I
            Self.DllBytes.Char          = Chr(Self.DllBytes.Byte)
            Self.DllBytes.Hex           = ByteToHex(Self.DllBytes.Byte, True)
            Self.DllBytes.Address       = StartOffset + I
            Self.DllBytes.AddressInHex  = LongToHex(Self.DllBytes.Address,True)
            Self.DllBytes.OriginalByte  = Self.DllBytes.Byte
            Self.DllBytes.OriginalChar  = Self.DllBytes.Char
            Add(Self.DllBytes)

            Self.StDllBytes.Append(Self.DllBytes.Char)
        End
        Return 0



c25_QueueCreateClass.GetDllSectionInfo                              Procedure(<Int32 _sectionId>, <string _sectionName>)


CODE

    If Self.DllWriteSection &= NULL
        Message('error Self.DllWriteSection is null')
    End
    Clear(Self.DllWriteSection)
    If Self.DLLDataReflectionClass &= NULL
        Self.DLLDataReflectionClass &= Self.ProgramHandlerClass.DLLDataReflectionClass
    End
    If Self.DLLDataReflectionClass &= NULL
        Message('error Self.DLLDataReflectionClass is null')
        Return 0
    End
    If Self.DLLDataReflectionClass.QDLLSections &= NULL
        Message('error Self.DLLDataReflectionClass.QDLLSections &= NULL')
    End

    If OMITTED(_sectionId) = False
        Get(Self.DLLDataReflectionClass.QDLLSections, _sectionId)
        If Errorcode() = 0
            Self.DllWriteSection = Self.DLLDataReflectionClass.QDLLSections
        Else
            Message('error Get(Self.DLLDataReflectionClass.QDLLSections, _sectionId)')
        End
    End
    Return Self.DllWriteSection

c25_QueueCreateClass.CopyDllBytesToBuffer                           Procedure(<LONG _offset>, <LONG _length>)

Offset              LONG
LengthToCopy        LONG
MemAddressTarget    LONG
Tuple4              Group
v1                      LONG
v2                      ULONG
v3                      LONG
v4                      LONG
                    End

Test                string(4)

    CODE



        If omitted(_offset) = False
            Offset = _offset
        ELSE
            Offset = Self.ModuleInfo.BaseOfDll
        END
        If Offset = 0
            Return Tuple4
        End
        If omitted(_length) = False
            LengthToCopy = _length
        ELSE
            LengthToCopy = Self.ModuleInfo.SizeOfImage
        End

        MemAddressTarget = c25_HeapAlloc(Self.ProcessHeapHandle, c25_HEAP_ZERO_MEMORY, LengthToCopy)
        c25_Memcpy(MemAddressTarget, Offset, LengthToCopy)

        Tuple4.v1 = MemAddressTarget
        Tuple4.v2 = 0
        Tuple4.v3 = LengthToCopy

        Self.MagicFieldPos = Self.StDllBytes.FindChar('FIELDMAGIC7')
        Tuple4.v4 = Self.MagicFieldPos


        Return Tuple4


! obselate, moved to DataReeflection

!c25_QueueCreateClass.ApplyQueueStructure                            Procedure(<*DataTableColumns_TYPE _dataTableColumns>)
!
!DataTableColumns                                        &DataTableColumns_TYPE
!
!
!FieldSegments                                           Long
!RowTotalBytes                                           Long
!RowTotalBytesStr4                                       STRING(4),over(RowTotalBytes)
!
!OrgStructBytesLength                                    Long
!OrgStructBytesLengthStr4                                STRING(4)
!Output                                                  STRING(512)
!SomeByte                                                Byte
!SomeChar                                                STRING(1)
!StringRef                                               &STRING
!TestChar                                                    STRING(1)
!
!ShortValue                                                  Short
!StringOverShort                                             string(2),over(ShortValue)
!
!LongValue                                                  LONG
!StringOverLong                                             string(4),over(LongValue)
!
!
!
!Code
!
!
!
!
!    DataTableColumns &= _dataTableColumns
!
!    FieldSegments = 2
!
!    Self.stStructure.Start()
!    Self.StDllBytesNew.Start()
!    Self.stLog.Start()
!
!    Message('ApplyQueueStructure')
!
!
!    RowTotalBytes = 0
!    I# = 0
!    LOOP
!        I# = I# + 1
!        Get(DataTableColumns,I#)
!        If Errorcode() <> 0
!            BREAK
!        End
!        Case DataTableColumns.DataTypeEnum
!        Of DataTypeEnum:CLA_BYTE
!            RowTotalBytes = RowTotalBytes + 1
!        Of DataTypeEnum:CLA_SHORT
!            RowTotalBytes = RowTotalBytes + 2
!        Of DataTypeEnum:CLA_USHORT
!            RowTotalBytes = RowTotalBytes + 2
!        Of DataTypeEnum:CLA_DATE
!            RowTotalBytes = RowTotalBytes + 4
!        Of DataTypeEnum:CLA_TIME
!            RowTotalBytes = RowTotalBytes + 4
!        Of DataTypeEnum:CLA_LONG
!            RowTotalBytes = RowTotalBytes + 4
!        Of DataTypeEnum:CLA_ULONG
!            RowTotalBytes = RowTotalBytes + 4
!        Of DataTypeEnum:CLA_SREAL
!            RowTotalBytes = RowTotalBytes + 4
!        Of DataTypeEnum:CLA_REAL
!            RowTotalBytes = RowTotalBytes + 8
!        Of DataTypeEnum:CLA_DECIMAL
!            RowTotalBytes = RowTotalBytes + DataTableColumns.SizeBytes
!        Of DataTypeEnum:CLA_PDECIMAL
!        Of DataTypeEnum:CLA_UNKNOWN12
!        Of DataTypeEnum:CLA_BFLOAT4
!            RowTotalBytes = RowTotalBytes + 4
!        Of DataTypeEnum:CLA_BFLOAT8
!            RowTotalBytes = RowTotalBytes + 8
!        Of DataTypeEnum:CLA_ANY
!        Of DataTypeEnum:CLA_UNKNOWN16
!        Of DataTypeEnum:CLA_UNKNOWN17
!        Of DataTypeEnum:CLA_STRING
!            RowTotalBytes = RowTotalBytes + DataTableColumns.Characters
!        Of DataTypeEnum:CLA_CSTRING
!            RowTotalBytes = RowTotalBytes + DataTableColumns.Characters
!        Of DataTypeEnum:CLA_PSTRING
!        Of DataTypeEnum:CLA_MEMO
!        Of DataTypeEnum:CLA_GROUP
!        Of DataTypeEnum:CLA_UNKNOWN23
!        Of DataTypeEnum:CLA_UNKNOWN24
!        Of DataTypeEnum:CLA_UNKNOWN25
!        Of DataTypeEnum:CLA_UNKNOWN26
!        Of DataTypeEnum:CLA_BLOB
!        Of DataTypeEnum:CLA_UNKNOWN28
!        Of DataTypeEnum:CLA_UNKNOWN29
!        Of DataTypeEnum:CLA_UNKNOWN30
!        Of DataTypeEnum:CLA_REFERENCE
!        Of DataTypeEnum:CLA_BSTRING
!        Of DataTypeEnum:CLA_ASTRING
!        Of DataTypeEnum:CLA_KEY
!
!        End
!    End
!
!
!    ShortValue = RowTotalBytes
!
!    Self.StDllBytesNew.Append(StringOverShort)
!    Self.StDllBytesNew.Append(Chr(0))
!
!    ShortValue = Records(DataTableColumns)
!
!    Self.StDllBytesNew.Append(StringOverShort)
!    Self.StDllBytesNew.Append(Chr(0))
!
!    Self.stLog.Append('Records(DataTableColumns) : ' & Records(DataTableColumns) & Self.NewLine)
!    Self.stLog.Append('RowTotalBytes : ' & RowTotalBytes & Self.NewLine)
!
!
!    I# = 0
!    LOOP
!        I# = I# + 1
!        Get(DataTableColumns,I#)
!        If Errorcode() <> 0
!            BREAK
!        End
!        Self.stStructure.Append(Chr(DataTableColumns.DataTypeEnum))
!
!        Case DataTableColumns.DataTypeEnum
!        Of DataTypeEnum:CLA_BYTE
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_SHORT
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_USHORT
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_DATE
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_TIME
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_LONG
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_ULONG
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_SREAL
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_REAL
!            Self.stStructure.Append(Chr(FieldSegments))
!        Of DataTypeEnum:CLA_DECIMAL
!            Self.stStructure.Append(Chr(FieldSegments))
!            If not (DataTableColumns.Characters%2)
!                BytesNeeded# = (DataTableColumns.Characters+2) / 2
!            Else
!                BytesNeeded# = (DataTableColumns.Characters+1) / 2
!            End
!            Self.stStructure.Append(Self.GetFieldLenToString(BytesNeeded#))
!            Self.stStructure.Append(Chr(DataTableColumns.Places))
!        Of DataTypeEnum:CLA_PDECIMAL
!        Of DataTypeEnum:CLA_UNKNOWN12
!        Of DataTypeEnum:CLA_BFLOAT4
!        Of DataTypeEnum:CLA_BFLOAT8
!        Of DataTypeEnum:CLA_ANY
!        Of DataTypeEnum:CLA_UNKNOWN16
!        Of DataTypeEnum:CLA_UNKNOWN17
!        Of DataTypeEnum:CLA_STRING
!            Self.stStructure.Append(Chr(FieldSegments))
!            Self.stStructure.Append(Chr(32))
!            Self.stStructure.Append(Self.GetFieldLenToString(DataTableColumns.Characters))
!        Of DataTypeEnum:CLA_CSTRING
!            Self.stStructure.Append(Chr(FieldSegments))
!            Self.stStructure.Append(Chr(32))
!            Self.stStructure.Append(Self.GetFieldLenToString(DataTableColumns.Characters))
!        Of DataTypeEnum:CLA_PSTRING
!        Of DataTypeEnum:CLA_MEMO
!        Of DataTypeEnum:CLA_GROUP
!        Of DataTypeEnum:CLA_UNKNOWN23
!        Of DataTypeEnum:CLA_UNKNOWN24
!        Of DataTypeEnum:CLA_UNKNOWN25
!        Of DataTypeEnum:CLA_UNKNOWN26
!        Of DataTypeEnum:CLA_BLOB
!        Of DataTypeEnum:CLA_UNKNOWN28
!        Of DataTypeEnum:CLA_UNKNOWN29
!        Of DataTypeEnum:CLA_UNKNOWN30
!        Of DataTypeEnum:CLA_REFERENCE
!        Of DataTypeEnum:CLA_BSTRING
!        Of DataTypeEnum:CLA_ASTRING
!        Of DataTypeEnum:CLA_KEY
!        End
!        DataTableColumns.Id = I#
!        Self.stStructure.Append(DataTableColumns.Name)
!        Self.stStructure.Append(Chr(0))
!    End
!    Self.stStructure.Append(Chr(5))
!    Self.stStructure.Append(Chr(0))
!    Self.stStructure.Append(Chr(0))
!    Self.stStructure.Append(Chr(0))
!    Self.stStructure.Append(Chr(112))
!    Self.stStructure.Append(Chr(16))
!    Self.stStructure.Append(Chr(64))
!    Self.stStructure.Append(Chr(0))
!
!    Self.stLog.Append('Self.stStructure.Length : ' & Self.stStructure.Length() & Self.NewLine)
!
!    Self.stLog.SaveFile('m:\ApplyNewQ.txt')
!    Self.stStructure.SaveFile('m:\stStructure.txt')
!
!
!    Return 0

c25_QueueCreateClass.GetInt32ToString                               Procedure(long _Characters)

Int4                                            ulong
IntStr4                                         string(4),over(Int4)

CODE

    Int4 = _Characters

    Return IntStr4

c25_QueueCreateClass.GetFieldLenToString                            Procedure(long _Characters)

Int4                                            ulong
IntStr4                                         string(4),over(Int4)

CODE

    Int4 = _Characters

    If IntStr4[1 : 4] = Chr(0) & Chr(0) & Chr(0) & Chr(0)
        Return Chr(0)
    End
    If IntStr4[2 : 4] = Chr(0) & Chr(0) & Chr(0)
        Return IntStr4[1]
    End
    If IntStr4[3 : 4] = Chr(0) & Chr(0)
        Return IntStr4[1 : 2]
    End
    If IntStr4[4] = Chr(0)
        Return IntStr4[1 : 3]
    End
    Return '0'

c25_QueueCreateClass.WndProc_Process                                Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)

ValInt    Long

    CODE

        Case _message
        Of Self.ProgramHandlerClass.CWM_CreateQueue
            Case _wParam
            Of SendMesCreateQueueClass:DataTable

                Self.DataTable &= (_lParam) 

                !Message('will write block for Self.DataTable.Id ' & Self.DataTable.Id)
                Self.DataTable.WriteNewDLLBlock()

                Self.CreateQueue(Self.DataTable.MemoryId)
                !Message('tja')
                Self.DataTable &= null
                ReturnVal = 777
                PostProcess = 0
            End
        Of C25_WM_Timer
            PostProcess = true
        End

c25_QueueCreateClass.GetCreateQueue                                 Procedure(long _dataTableId)

    Code

        Self.QReturn &= CreateQueueDll()
        Self.QInfo.Id = _dataTableId
        Self.QInfo.Q &= Self.QReturn
        Add(Self.QInfo)
        Return Self.QReturn

c25_QueueCreateClass.CreateQueue                                    Procedure(long _dataTableId)

    Code


        Self.QReturn &= CreateQueueDll()     
        Self.QInfo.Id = _dataTableId
        Self.QInfo.TimeStamp = Self.ProgramHandlerClass.NanoClockClass.GetSysTime()
        Self.QInfo.Q &= Self.QReturn
        Add(Self.QInfo)
        Return 0
        
        
c25_QueueCreateClass.GetQInfo       Procedure(long _dataTableId)

    Code

        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.QInfo,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.QInfo.Id <> _dataTableId
                CYCLE
            End
            Return Self.QInfo
        END
        Clear(Self.QInfo)
        Return Self.QInfo

c25_QueueCreateClass.GetCreatedQueue                                Procedure(long _dataTableId)

    Code

        !Message('start c25_QueueCreateClass.GetCreatedQueue')
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.QInfo,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.QInfo.Id <> _dataTableId
                CYCLE
            End

            Self.QReturn &= Self.QInfo.Q
            
            !Message('end c25_QueueCreateClass.GetCreatedQueue Return Self.QReturn')
            Return Self.QReturn
        END
        !Message('end c25_QueueCreateClass.GetCreatedQueue Return NULL')
        Return NULL
        


!
!CreateQueueDll         Procedure()
!
!DummyQ                  &QUEUE
!
!    CODE
!
!        !Share(FileTest)
!       DummyQ &= NEW DummyQueue_TYPE()
!        Return DummyQ ! THIS WILL RETURN your 'own' defined queue, which will be normally different then the dummy queue
!        
!
