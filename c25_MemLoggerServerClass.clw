    Member

    Include('c25_MemLoggerServerClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.clw'),Once

                            Module('c25_MemLoggerServerClass.clw')
c25LogWindowThread                 Procedure(Long _paramA, Long _paramB),Long
                            End
    End

c25MemLoggerServerClass.Construct                             Procedure()

Code

    Clear(Self.MappedFile)
    Self.MappedFile.FileNameA = 'Global\AllMyDrivesLogger' & Chr(0)

    Self.RegisterWM()
    Self.InitWindow('LogWindow')
    Self.OpenWindow()

c25MemLoggerServerClass.Destruct                              Procedure()

Code

c25MemLoggerServerClass.RegisterWM                            Procedure()

RegMesStringA   String(250)

Code

    RegMesStringA = 'WM_RequestLogServerWindowHandle' & Chr(0)
    Self.WM_RequestLogServerWindowHandle = c25_RegisterWindowMessageA(Address(RegMesStringA))

    RegMesStringA = 'WM_LogServerWindowHandle' & Chr(0)
    Self.WM_LogServerWindowHandle = c25_RegisterWindowMessageA(Address(RegMesStringA))

    RegMesStringA = 'WM_NewLogToServer' & Chr(0)
    Self.WM_NewLogToServer = c25_RegisterWindowMessageA(Address(RegMesStringA))

    Return 0

c25MemLoggerServerClass.OpenSharedMemory                      Procedure()

Code

    Self.MappedFile.FileHandle = c25_OpenFileMappingA(c25_FILE_MAP_ALL_ACCESS, False, Address(Self.MappedFile.FileNameA))
    If Self.MappedFile.FileHandle = 0
        Self.MappedFile.FileOpenError = C25_GetLastError()
        Return 0
    End
    Self.MappedFile.ClientHeaderSize = Size(

!    Self.MappedFileBufferHeaderHandle = c25_MapViewOfFile(Self.MappedFileHandle, c25_FILE_MAP_ALL_ACCESS, 0,0, 1024)
    Return 0
    
c25MemLoggerServerClass.CloseMappedFile                       Procedure()

Code

    If Self.MappedFileBufferHandle <> 0
       c25_UnmapViewOfFile(Self.MappedFileBufferHandle)
    End
    If Self.MappedFileHandle <> 0
       c25_CloseHandle(Self.MappedFileHandle)
    End
    Return 0
    
c25MemLoggerServerClass.InitWindow                            Procedure(<String _name>)

Code

    Self.StartXPos      = 500
    Self.StartYPos      = 200
    Self.StartWidth     = 400
    Self.StartHeight    = 300

    Clear(Self.WndClassExA)
    Self.WndClassExA.Size                               = Size(Self.WndClassExA)
    Self.WndClassExA.Style                              = 0
    Self.WndClassExA.WndProcPtr                          = 0
    Self.WndClassExA.ClsExtra                           = 8
    Self.WndClassExA.WndExtra                           = Size(Self.ExtraWindowSpace)
    Self.WndClassExA.Instance                           = System{Prop:AppInstance}
    Self.WndClassExA.Icon                               = 0
    Self.WndClassExA.Cursor                             = 0
    Self.WndClassExA.Background                       = 0
    Self.WndClassExA.MenuName                       = 0
    Self.WndClassExA.ClassName                      = 0
    Self.WndClassExA.IconSm                             = 0

    Self.WndClassEx_ClassName                           = 'c25MemLoggerServerClass' & Chr(0)

    Self.WindowNameA                                    = Clip(Self.TitleA) & Chr(0)
    Self.WindowStyle                                    =  WS_POPUPWINDOW
    !Self.WindowStyle = WS_OVERLAPPEDWINDOW
    Return 0

c25MemLoggerServerClass.OpenWindow                            Procedure()

Code

    Self.ThreadHandle = c25_CreateThread(0, 010000h, Address(c25LogWindowThread), Address(Self), 0, Address(Self.ThreadId))
    Loop
        c25_SleepEx(20,0)
        If Self.IsActive <> 0
            Break
        End
    End
    Return Self.WindowHandle


c25MemLoggerServerClass.WndProc_Process       Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

Code

    Clear(Self.ReturnWndProc)
    If _message > 1 And _message < 1024
        Case _message
        Of WM_TIMER
            If Self.LogServerWindowHandle = 0
                C25_PostMessageA(c25_HWND_BROADCAST, Self.WM_RequestLogServerWindowHandle, 0 , _windowHandle)
            End
            ! log on timer
            If Self.MappedFileHandle <> 0
                Self.MappedFileBufferHeaderHandle = c25_MapViewOfFile(Self.MappedFileHandle, c25_FILE_MAP_ALL_ACCESS, 0, 0, 2048)

                Clear(Self.LogStructure)
                Self.LogStructure.Length  = 0
                Self.LogStructure.Line    &= NEW String(Len('LOG WM_TIMER'))
                Self.LogStructure.Line    = 'LOG WM_TIMER'

                If not Self.LogStructureStr &= null
                    Dispose(Self.LogStructureStr)
                End
                Self.LogStructureStrSize = Size(Self.LogStructure.Length) + Size(Self.LogStructure.Line)
                Self.LogStructureStr &= NEW String(Self.LogStructureStrSize)
                Self.LogStructureStr = Self.LogStructure.Length & Self.LogStructure.Line
                
                Self.NewLogMessageOffset = 0
                c25_MemCpy(Self.MappedFileBufferHeaderHandle, Address(Self.LogStructureStr),Self.LogStructureStrSize )
                !Message(Self.LogServerWindowHandle & ', '  & Self.WM_NewLogToServer)
                
                Loop 1 Times
                    C25_PostMessageA(Self.LogServerWindowHandle, Self.WM_NewLogToServer,  Self.NewLogMessageOffset , Self.LogStructureStrSize)
                End
                !Self.MappedFileHandle = 0
            Else
                If Self.LogServerWindowHandle <> 0
                    !Message('Self.MappedFileHandle ' & Self.MappedFileHandle)
                End
            End
        End
    Else
        Case _message
        Of Self.WM_LogServerWindowHandle
            Self.LogServerWindowHandle = _lParam
            !Message('Self.LogServerWindowHandle ' & Self.LogServerWindowHandle)
            Self.OpenSharedMemory()
        Of c25:WM_NewLogToClient
            
        End
    End
    Return Self.ReturnWndProc


c25LogWindowThread                                  Procedure(Long _paramA, Long _paramB)

                                                    Map
                                                        WndProcWorker(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),Long ,Pascal
                                                        GetMessageNameFromId(ULong _id),String
                                                    End
WindowHandle                                        Long
WindowNameA                                         String(255)
WndClassEx_ClassName                                String(245)

WndClassExA                                         Group(WndClassExA_TYPE),Pre(WndClassExA)
                                                    End
WindowMessage                                       Group(WindowMessage_TYPE),Pre(WindowMessage)
                                                    End
WindowMessageAddress                                Long
c25MemLogger                                        &c25MemLoggerServerClass()
UserDataLongIn                                      Long
T                                                   Long
StLog                                               &StringTheory

Code

    c25_AttachThreadToClarion(True)

    StLog &= NEW StringTheory()
    StLog.Append('')
    StLog.SaveFile('m:\log\LogWindowMessages.clw',False)

    c25MemLogger                           &= (_paramB)
    c25MemLogger.WndClassExA.WndProcPtr      = Address(WndProcWorker)
    WndClassExA                                 = c25MemLogger.WndClassExA
    WindowNameA                                 = c25MemLogger.WindowNameA
    WndClassEx_ClassName                        = c25MemLogger.WndClassEx_ClassName
    WndClassExA.ClassName                   = Address(WndClassEx_ClassName)

    c25_UnregisterClassA(Address(WndClassEx_ClassName), 0)
    c25MemLogger.AtomWindowClassExA         = c25_RegisterClassExA(Address(WndClassExA))
    c25MemLogger.MessageQueueOnly = TRUE
    If c25MemLogger.MessageQueueOnly

        WindowHandle = c25_CreateWindowExA(0, Address(WndClassEx_ClassName),Address(WindowNameA), c25MemLogger.WindowStyle, 100,100,100,100,c25_HWND_MESSAGE  ,0, System{Prop:AppInstance},0)
    Else
        WindowHandle = c25_CreateWindowExA(0, Address(WndClassEx_ClassName),Address(WindowNameA), c25MemLogger.WindowStyle, c25MemLogger.StartXPos,c25MemLogger.StartYPos,c25MemLogger.StartWidth,c25MemLogger.StartHeight,0  ,0, System{Prop:AppInstance},0)
    End
    c25MemLogger.WindowHandle              = WindowHandle
    c25MemLogger.TimerIDEvent              = c25_SetTimer(WindowHandle, 0, 1000, 0)

    c25MemLogger.ExtraWindowSpace.Size                       = Size(c25MemLogger.ExtraWindowSpace)
    c25MemLogger.ExtraWindowSpace.ExtraWindowSpaceGuid       = ExtraWindowSpaceGuid
    c25MemLogger.ExtraWindowSpace.WindowHandle               = WindowHandle
    c25MemLogger.ExtraWindowSpace.WindowHandlerClassPtr      = Address(c25MemLogger)

    T = c25MemLogger.ExtraWindowSpace.Size + 4

    Loop
        T = T - 4
        If T < 0
            Break
        End
        Peek(Address(c25MemLogger.ExtraWindowSpace) + T, UserDataLongIn)
        c25_SetWindowLongA(WindowHandle, T, UserDataLongIn)
    End

    c25MemLogger.StLog &= NEW StringTheory()
    c25MemLogger.StLog.Start()

    WindowMessageAddress                            = Address(WindowMessage)

    c25_ShowWindow(WindowHandle,True)

    c25MemLogger.IsActive = True
    Loop
        Case c25_GetMessage(WindowMessageAddress, 0, 0, 0)
        Of 0
            Break
        Of -1
            Cycle
        End
        c25_TranslateMessage(WindowMessageAddress)
        c25_DispatchMessage(WindowMessageAddress)
    End
    Return 0


WndProcWorker                   Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

WindowHandler                   &c25MemLoggerServerClass
WndProc                         Group,Pre(WndProc)
WindowExtraSize                     Long
UserDataLongOut                     Long
T                                   Long
                                End
ReturnWndProc                   GROUP,Pre(ReturnWndProc)
Processed                           BOOL
ReturnVal                           Long
                                End
WinUserData                     Group(ExtraWindowSpace_TYPE),Pre(WinUserData)
                                End
LogLine                         String(512)
StLogLocal                      &StringTheory
LogMessages                     BOOL

Code

    LogMessages = True
    Clear(ReturnWndProc)

    WndProc.WindowExtraSize = c25_GetClassLongA(_windowHandle, GCL_CBWNDEXTRA)
    If WndProc.WindowExtraSize = 60
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
            If WinUserData.ExtraWindowSpaceGuid = ExtraWindowSpaceGuid
                If WinUserData.WindowHandlerClassPtr <> 0
                    WindowHandler &= (WinUserData.WindowHandlerClassPtr)
                End
            End
        End
    End

    If WindowHandler &= NULL
        If LogMessages
            StLogLocal &= NEW StringTheory
            StLogLocal.Start()
            LogLine = Format(_windowHandle,@N20) & ' ' & Format(_message,@N06)
            LogLine[30 : Size(LogLine)] = LongToHex(_message,False)
            LogLine[50 : Size(LogLine)] = GetMessageNameFromId(_message) & '**********'
            StLogLocal.Append(Clip(LogLine) & Chr(13) & Chr(10))
            StLogLocal.SaveFile('m:\log\LogWindowMessages.clw',True)
        End
        Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)
    End
    Clear(WindowHandler.ReturnWndProc)
    Clear(ReturnWndProc)

    If _windowHandle = WindowHandler.WindowHandle

        If LogMessages
            Case _message
            Of WM_PAINT
            Of WM_MOUSEFIRST
            OrOf WM_NCHITTEST
            OrOf WM_SETCURSOR
            Else
                WindowHandler.StLog.Start()
                LogLine = Format(_windowHandle,@N20) & ' ' & Format(_message,@N06)
                LogLine[30 : Size(LogLine)] = LongToHex(_message,False)
                LogLine[50 : Size(LogLine)] = GetMessageNameFromId(_message)
                WindowHandler.StLog.Append(Clip(LogLine) & Chr(13) & Chr(10) )
                WindowHandler.StLog.SaveFile('m:\log\LogWindowMessages.clw',True)
            End
        End
        WindowHandler.WndProc_Process(_windowHandle, _message, _wParam, _lParam)
        ReturnWndProc = WindowHandler.ReturnWndProc
    End
    WindowHandler &= Null
    If ReturnWndProc.Processed = 0
        Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)
    Else
        Return ReturnWndProc.ReturnVal
    End

    Return c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)

Include('c25_GetMessageNameFromId.clw')

