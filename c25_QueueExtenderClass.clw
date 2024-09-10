        Member

    Include('c25_QueueExtenderClass.inc'),Once

                    MAP
                            Include('CWUTIL.inc'),once
                            Include('i64.inc')
                            Include('c25_WinApiPrototypes.inc')
                            Module('c25_QueueExtenderClass.clw')
HandlerThread                   Procedure(Long _paramA, Long _paramB),Long
                            End
                    End

c25_QueueExtenderClass.Destruct                        Procedure()

    Code



c25_QueueExtenderClass.Construct                       Procedure()

Code

    Message('not obselate c25_QueueExtenderClass ?')
    
    Self.DataReflection &= NEW c25_DataReflectionClass()
    Self.RegisterWMs()
    Self.BitConverter &= NEW c25_BitConverterClass()
    Self.MessageQueueOnly = True

    Self.ExtraWindowSpace   &= NEW ExtraWindowSpace_TYPE
    Self.WindowMessage      &= NEW WindowMessage_TYPE
    Self.WndClassExA        &= NEW WndClassExA_TYPE

    Self.DllLoader          &= NEW C25_DllLoaderClass()
    Self.QueuesExtend       &= NEW QueuesExtend_TYPE()
    Self.StDllBytesOld      &= NEW StringTheory()
    Self.StDllBytesNew      &= NEW StringTheory()

    Self.DataTables         &= NEW DataTables_TYPE()
    Self.DataTableColumns   &= NEW DataTableColumns_TYPE()

    Self.Start()




c25_QueueExtenderClass.CreateDataTable Procedure()

DataTableInstance   &c25_DataTableClass

CODE

    DataTableInstance &= NEW c25_DataTableClass()
    Clear(Self.DataTables)

    Return Address(DataTableInstance)


c25_QueueExtenderClass.ApplyQueueStructure  Procedure(<*DataTableColumns_TYPE _dataTableColumns>)

DataTableColumns                                    &DataTableColumns_TYPE

QFields                                             Queue,Pre(QFields)
Id                                                      long
Name                                                    cstring(128)
NameProp                                                cstring(260)
NameLen                                                 Long
DataTypeEnum                                            long
SizeBytes                                               Long
Characters                                              long
Places                                                  long
IsReference                                             byte
Dim1                                                    long
Dim2                                                    long
Dim3                                                    long
Dim4                                                    long
                                                    END

FieldSegments                                       Long
NewStructBytesLength                                Long
NewStructBytesLengthStr4                            STRING(4)
OrgStructBytesLength                                Long
OrgStructBytesLengthStr4                            STRING(4)
Output                                              STRING(512)
SomeByte                                            Byte
SomeChar                                            STRING(1)
StringRef                                           &STRING
TestChar                                            STRING(1)

Code

    DataTableColumns &= _dataTableColumns





    FieldSegments = 2 ! if NAME = 3

    Self.StDllBytesNew.Start()
    I# = 0
    LOOP
        I# = I# + 1
        Get(QFields,I#)
        If Errorcode() <> 0
            BREAK
        End
        Self.StDllBytesNew.Append(Chr(QFields.DataTypeEnum))

        Case QFields.DataTypeEnum
        Of ClaDataType_BYTE            !EQUATE(1)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 1
        Of ClaDataType_SHORT           !EQUATE(2)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 2
        Of ClaDataType_USHORT          !EQUATE(3)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 2
        Of ClaDataType_DATE            !EQUATE(4)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 4
        Of ClaDataType_TIME            !EQUATE(5)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 4
        Of ClaDataType_LONG            !EQUATE(6)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 4
        Of ClaDataType_ULONG           !EQUATE(7)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 4
        Of ClaDataType_SREAL           !EQUATE(8)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 4
        Of ClaDataType_REAL            !EQUATE(9)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            NewStructBytesLength = NewStructBytesLength + 8
        Of ClaDataType_DECIMAL         !EQUATE(10)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            If not (QFields.Characters%2) ! isEven
                BytesNeeded# = (QFields.Characters+2) / 2
            Else
                BytesNeeded# = (QFields.Characters+1) / 2
            End
            Self.StDllBytesNew.Append(Self.GetFieldLenToString(BytesNeeded#))
            NewStructBytesLength = NewStructBytesLength + QFields.SizeBytes
            Self.StDllBytesNew.Append(Chr(QFields.Places))
        Of ClaDataType_PDECIMAL        !EQUATE(11)
        Of ClaDataType_UNKNOWN12       !EQUATE(12)
        Of ClaDataType_BFLOAT4         !EQUATE(13)
        Of ClaDataType_BFLOAT8         !EQUATE(14)
        Of ClaDataType_ANY             !EQUATE(15)
        Of ClaDataType_UNKNOWN16       !EQUATE(16)
        Of ClaDataType_UNKNOWN17       !EQUATE(17)
        Of ClaDataType_STRING          !EQUATE(18)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            Self.StDllBytesNew.Append(Chr(32))
            Self.StDllBytesNew.Append(Self.GetFieldLenToString(QFields.Characters))
            NewStructBytesLength = NewStructBytesLength + QFields.Characters
        Of ClaDataType_CSTRING         !EQUATE(19)
            Self.StDllBytesNew.Append(Chr(FieldSegments))
            Self.StDllBytesNew.Append(Chr(32))
            Self.StDllBytesNew.Append(Self.GetFieldLenToString(QFields.Characters))
            NewStructBytesLength = NewStructBytesLength + QFields.Characters
        Of ClaDataType_PSTRING         !EQUATE(20)
        Of ClaDataType_MEMO            !EQUATE(21)
        Of ClaDataType_GROUP           !EQUATE(22)
        Of ClaDataType_UNKNOWN23       !EQUATE(23)
        Of ClaDataType_UNKNOWN24       !EQUATE(24)
        Of ClaDataType_UNKNOWN25       !EQUATE(25)
        Of ClaDataType_UNKNOWN26       !EQUATE(26)
        Of ClaDataType_BLOB            !EQUATE(27)
        Of ClaDataType_UNKNOWN28       !EQUATE(28)
        Of ClaDataType_UNKNOWN29       !EQUATE(29)
        Of ClaDataType_UNKNOWN30       !EQUATE(30)
        Of ClaDataType_REFERENCE       !EQUATE(31)
        Of ClaDataType_BSTRING         !EQUATE(42)
        Of ClaDataType_ASTRING         !EQUATE(43)
        Of ClaDataType_KEY             !EQUATE(58)

        End

        QFields.Id = I#
        Self.StDllBytesNew.Append(QFields.Name)

        Self.StDllBytesNew.Append(Chr(0))

    End
    Self.StDllBytesNew.Append(Chr(5))
    Self.StDllBytesNew.Append(Chr(0))
    Self.StDllBytesNew.Append(Chr(0))
    Self.StDllBytesNew.Append(Chr(0))
    Self.StDllBytesNew.Append(Chr(112))
    Self.StDllBytesNew.Append(Chr(16))
    Self.StDllBytesNew.Append(Chr(64))
    Self.StDllBytesNew.Append(Chr(0))

    Self.StDllBytesNew.Append(All(Chr(0),1024 - Self.StDllBytesNew.Length() - 70-2))

    Self.StDllBytesNew.Insert(1,All(Chr(0),82))
    Self.StDllBytesNew.SetSlice(70,71,'AA')
    Self.StDllBytesNew.SaveFile('m:\output.txt')
    Self.StDllBytesNew.RemoveFromPosition(1,82)

    C25_Memcpy(Address(OrgStructBytesLength),Self.StartDataSectionAddress+70,4)
    C25_Memcpy(Address(OrgStructBytesLengthStr4),Self.StartDataSectionAddress+70,4)










    Return 0









c25_QueueExtenderClass.GetInt32ToString  Procedure(long _Characters)

Int4                                            ulong
IntStr4                                         string(4),over(Int4)

CODE

    Int4 = _Characters

    Return IntStr4


c25_QueueExtenderClass.GetFieldLenToString  Procedure(long _Characters)

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


c25_QueueExtenderClass.LoadMetaLibrary      Procedure()


StartOffset     Long
NewByte         byte
ModuleHandle                                    Long
DLLHandle                                       long

st &StringTheory

CODE



    If Self.DllBytes &= NULL
        Self.DllBytes &= NEW DllBytes_TYPE()
    Else
        Free(Self.DllBytes)
    END

    If Self.StDllBytes &= null
        Self.StDllBytes &= NEW StringTheory()
    END
    Self.StDllBytes.Start()

    Clear(Self.ModuleInfo)
    DLLHandle = Self.DllLoader.LoadDllIntoMemory('QueueMeta001.dll', ,'QueueExtender')
    ModuleHandle = Self.DllLoader.GetModuleHandle('QueueExtender')
    R# = C25_GetmoduleInformation(c25_getcurrentprocess(), DLLHandle, Address(Self.ModuleInfo), Size(Self.ModuleInfo))
    StartOffset = Self.ModuleInfo.BaseOfDll

    I# = -1
    A# = Address(Self.DllBytes.Byte)
    LOOP Self.ModuleInfo.SizeOfImage TIMES
        I# = I# + 1
        Clear(Self.DllBytes)
        C25_Memcpy(A#, StartOffset + I#,1)
        Self.DllBytes.Pos = I#
        Self.DllBytes.Char = Chr(Self.DllBytes.Byte)
        Self.DllBytes.Hex = ByteToHex(Self.DllBytes.Byte, True)
        Self.DllBytes.Address = StartOffset + I#
        Self.DllBytes.AddressInHex = LongToHex(Self.DllBytes.Address,True)
        Self.DllBytes.OriginalByte = Self.DllBytes.Byte
        Self.DllBytes.OriginalChar = Self.DllBytes.Char
        Add(Self.DllBytes)
        Self.StDllBytes.Append(Self.DllBytes.Char)
    End

    Self.StartField001 = Self.StDllBytes.FindChar('Field001')
    Self.StartField001Address = StartOffset + Self.StartField001 -3

    Self.StartDataSection        = 0
    Self.StartDataSectionAddress = 0

    I# = Self.StartField001
    LOOP
        I# = I# - 1
        If I# < 1
            BREAK
        End
        If Self.StDllBytes.Sub(I#, 4) = '!CLA'
            Self.StartDataSection = I#
            BREAK
        End
    End
    Self.StartDataSectionAddress = StartOffset + Self.StartDataSection-1



    return 0










c25_QueueExtenderClass.RegisterWMs                             Procedure()

RegMesStringA   String(250)

Code

    RegMesStringA = 'WM_C25CloseApp' & Chr(0)
    Self.WM_C25CloseApp = c25_RegisterWindowMessageA(Address(RegMesStringA))
    RegMesStringA = 'WM_C25Special' & Chr(0)
    Self.WM_C25Special = c25_RegisterWindowMessageA(Address(RegMesStringA))
    Return 0

c25_QueueExtenderClass.Start                            Procedure()

Code

    Self.InitWindow('QueueExtenderWindow')
    Self.OpenWindow()


c25_QueueExtenderClass.Stop                            Procedure()

    Code

c25_QueueExtenderClass.Proc_000275_WM_TIMER                    Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

TitleA cstring(250)

Code

        TitleA = Clip(Self.Name) & ' ' & Clock()
        c25_SetWindowTextA(_windowHandle, Address(TitleA))

c25_QueueExtenderClass.InitWindow                              Procedure(<String _name>, <string _function>)

Code

    If Omitted(_name) = False
        If Len(Clip(_name)) > 0
            Self.Name &= New String(Len(_name))
            Self.Name = _name
        End
    Else
        Self.Name &= New String(Len(Clip('unknown')))
        Self.Name = 'unknown'
    End

    Self.TitleA &= NEW String(100)
    Self.TitleA = Self.Name

    Clear(Self.WndClassExA)
    Self.WndClassExA.Size                               = Size(Self.WndClassExA)
    Self.WndClassExA.Style                              = 0
    Self.WndClassExA.WndProcPtr                          = 0
    Self.WndClassExA.ClsExtra                           = 8
    Self.WndClassExA.WndExtra                           = Size(Self.ExtraWindowSpace)
    Self.WndClassExA.Instance                           = System{Prop:AppInstance}
    Self.WndClassExA.Icon                               = 0
    Self.WndClassExA.Cursor                             = 0
    Self.WndClassExA.Background                         = 0
    Self.WndClassExA.MenuName                           = 0
    Self.WndClassExA.ClassName                          = 0
    Self.WndClassExA.IconSm                             = 0

    Self.WndClassEx_ClassName                           = 'c25_QueueExtenderClass' & Chr(0)

    Self.WindowNameA                                    = Clip(Self.TitleA) & Chr(0)
    Self.WindowStyle                                    = C25_WS_POPUPWINDOW
    Self.WindowStyle                                    = C25_WS_OVERLAPPEDWINDOW

    If omitted(_function) = False
    End

    Return 0

c25_QueueExtenderClass.OpenWindow                              Procedure()

Code

    Self.ThreadHandle = c25_CreateThread(0, 010000h, Address(HandlerThread), Address(Self), 0, Address(Self.ThreadId))
    Loop
        c25_SleepEx(20,0)
        If Self.IsActive <> 0
            Break
        End
    End
    Return Self.WindowHandle


c25_QueueExtenderClass.CloseDown                              Procedure()

Code

    If Self.WindowHandle <> 0
        C25_PostMessageA(Self.WindowHandle, C25_Wm_Quit, 0, 0)
    End


c25_QueueExtenderClass.Proc_WM_C25CloseApp                     Procedure(long _windowHandle,ulong _message, ulong _wParam, long _lParam)

Code

    C25_PostMessageA(_windowHandle, C25_Wm_Close, 0, 0)

c25_QueueExtenderClass.Proc_WM_C25Special               Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

CreateBaseLayer &CreateBaseLayer_TYPE
JsonObject      &JSONClass

Code


    Self.ReturnWndProc.Processed = True
    Self.ReturnWndProc.ReturnVal = 0

c25_QueueExtenderClass.WndProc_Process                         Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

Code

    Clear(Self.ReturnWndProc)

    If _message > 1 And _message < 1024

    Else
        Case _message
        Of Self.WM_C25Special
            Self.Proc_WM_C25Special(_windowHandle, _message, _wParam, _lParam)
        Of Self.WM_C25CloseApp
            Self.Proc_WM_C25CloseApp(_windowHandle, _message, _wParam, _lParam)
            Self.ReturnWndProc.Processed = TRUE
            Self.ReturnWndProc.ReturnVal = 0
        End
    End
    Return Self.ReturnWndProc

HandlerThread                                             Procedure(Long _paramA, Long _paramB)

    Map
        QueueExtenderWndProcWorker(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),Long ,Pascal
        GetMessageNameFromId(ULong _id),String
    End

WindowHandler                                       &c25_QueueExtenderClass()
WindowHandle                                        Long
WindowNameA                                         String(255)
WndClassEx_ClassName                                String(245)
WndClassExA                                         Group(WndClassExA_TYPE),Pre(WndClassExA)
                                                    End
WindowMessage                                       Group(WindowMessage_TYPE),Pre(WindowMessage)
                                                    End
WindowMessageAddress                                Long
UserDataLongIn                                      Long
T                                                   Long
StLog                                               &StringTheory

Code

    c25_AttachThreadToClarion(True)

    WindowHandler                              &= (_paramB)

    WindowHandler.WndClassExA.WndProcPtr        = Address(QueueExtenderWndProcWorker)
    WndClassExA                                 = WindowHandler.WndClassExA
    WindowNameA                                 = WindowHandler.WindowNameA
    WndClassEx_ClassName                        = WindowHandler.WndClassEx_ClassName
    WndClassExA.ClassName                       = Address(WndClassEx_ClassName)
    WndClassExA.WndExtra                        = 60

    c25_UnregisterClassA(Address(WndClassEx_ClassName), 0)
    WindowHandler.AtomWindowClassExA            = c25_RegisterClassExA(Address(WndClassExA))
    WindowHandler.MessageQueueOnly              = True
    If WindowHandler.MessageQueueOnly
        WindowHandle = c25_CreateWindowExA(0, Address(WndClassEx_ClassName),Address(WindowNameA), WindowHandler.WindowStyle, 400,400,400,400,c25_HWND_MESSAGE  ,0, System{Prop:AppInstance},0)
    End

    WindowHandler.WindowHandle              = WindowHandle

    WindowHandler.ExtraWindowSpace.Size                         = Size(WindowHandler.ExtraWindowSpace)
    WindowHandler.ExtraWindowSpace.ExtraWindowSpaceGuid         = C25_ExtraWindowSpaceGuid
    WindowHandler.ExtraWindowSpace.WindowHandle                 = WindowHandle
    WindowHandler.ExtraWindowSpace.WindowHandlerClassPtr        = Address(WindowHandler)

    T = WindowHandler.ExtraWindowSpace.Size + 4

    Loop
        T = T - 4
        If T < 0
            Break
        End
        Peek(Address(WindowHandler.ExtraWindowSpace) + T, UserDataLongIn)
        c25_SetWindowLongA(WindowHandle, T, UserDataLongIn)
    End

    WindowMessageAddress                            = Address(WindowMessage)

    c25_ShowWindow(WindowHandle,True)

    WindowHandler.IsActive = True
    Loop
        Case c25_GetMessage(WindowMessageAddress, 0, 0, 0)
        Of 0
            WindowHandler.Destruct()
            Break
        Of -1
            Cycle
        End
        c25_TranslateMessage(WindowMessageAddress)
        c25_DispatchMessage(WindowMessageAddress)
    End
    Return 0

QueueExtenderWndProcWorker                           Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

HandlerWorker                           &c25_QueueExtenderClass
WndProc                                 Group,Pre(WndProc)
WindowExtraSize                             Long
UserDataLongOut                             Long
T                                           Long
                                        End
ReturnWndProc                           GROUP,Pre(ReturnWndProc)
Processed                                   BOOL
ReturnVal                                   Long
                                        End
WinUserData                             Group(ExtraWindowSpace_TYPE),Pre(WinUserData)
                                        End
LogLine                                 String(512)
StLogLocal                              &StringTheory
LogMessages                             BOOL

Code

    LogMessages = True
    Clear(ReturnWndProc)

    WndProc.WindowExtraSize = c25_GetClassLongA(_windowHandle, C25_GCL_CBWNDEXTRA)

    If WndProc.WindowExtraSize > 0
        If c25_GetWindowLongA(_windowHandle, 0) = 60
            WndProc.T = WndProc.WindowExtraSize + 4
            Loop
                WndProc.T = WndProc.T - 4
                If WndProc.T < 0
                    Break
                End
                WndProc.UserDataLongOut = c25_GetWindowLongA(_windowHandle, WndProc.T)
                Poke(Address(WinUserData)+ WndProc.T, WndProc.UserDataLongOut)
            End
            If WinUserData.ExtraWindowSpaceGuid = C25_ExtraWindowSpaceGuid
                If WinUserData.WindowHandlerClassPtr <> 0
                    HandlerWorker &= (WinUserData.WindowHandlerClassPtr)
                End
            End
        End
    End

    If HandlerWorker &= NULL
        Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)
    End
    Clear(HandlerWorker.ReturnWndProc)
    Clear(ReturnWndProc)

    If _windowHandle = HandlerWorker.WindowHandle
        HandlerWorker.WndProc_Process(_windowHandle, _message, _wParam, _lParam)
        ReturnWndProc = HandlerWorker.ReturnWndProc
    End
    HandlerWorker &= Null
    If ReturnWndProc.Processed = 0
        Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)
    Else
        Return ReturnWndProc.ReturnVal
    End
    Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)

Include('c25_GetMessageNameFromId.clw')


