    Member

        Include('c25_WorkerThreadsClass.inc'),Once
        Include('C25_DUMMY.CLW'),Once
        Include('C25_DUMMY.CLW'),Once

                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
                            Module('c25_WorkerThreadsClass.clw')
WorkerThread                     Procedure(Long _paramA, Long _paramB),Long
                            End
                        End

c25WorkerThreadsClass.Construct              Procedure()

    Code

        Self.SelfAddress                     = Address(Self)

c25WorkerThreadsClass.Init              Procedure(Long _paramA)

    Code

        Clear(WinHandlesArray)
        Clear(Self.WorkerThreadInfoArray)

        Self.WorkerThreadInfoArrayMax       = Maximum(Self.WorkerThreadInfoArray,1)
        Self.NanoSync                       &= NEW NanoSyncClass()

        Self.st1                            &= NEW StringTheory()
        Self.st1.Start()
        Self.WinApi                         &= NEW WinApi32Class()
        Self.Sqlite34                        &= NEW Sqlite34Class()

        Self.WorkerThreadInfoArray[1].Used = True
        Self.WorkerThreadInfoArray[1] = Self.StartWorkerThread(1, 'MasterWorkerThread')
        Self.WorkerThreadInfoArray[1].Used = True
        c25_sleepex(20,0)

        Self.InitReady = True
        Return Self.InitReady

c25WorkerThreadsClass.GetWorkerWinHandle    Procedure(<Long _index>,<String _name>)

    Code

        If omitted(_index) = False
            If _index > 0 And _index < Maximum(Self.WorkerThreadInfoArray,1) + 1
                Return Self.WorkerThreadInfoArray[_index].WinHandle
            End
        End
        If omitted(_name) = False
            M# = Maximum(Self.WorkerThreadInfoArray,1)
            I# = 0
            LOOP M# Times
                I# = I# + 1
                If Self.WorkerThreadInfoArray[I#].Used = True
                    If Upper(_name) <> Self.WorkerThreadInfoArray[I#].NameUpper
                        CYCLE
                    End
                    Return Self.WorkerThreadInfoArray[I#].WinHandle
                End
            End
        End
        Return 0

c25WorkerThreadsClass.GetWorkerInstancePtr    Procedure(<Long _index>,<String _name>)

    Code

        If omitted(_index) = False
            If _index > 0 And _index < Maximum(Self.WorkerThreadInfoArray,1) + 1
                Return c25_GetWindowlongA(Self.WorkerThreadInfoArray[_index].WinHandle,GWL_USERDATA)
            End
        End
        If omitted(_name) = False
            M# = Maximum(Self.WorkerThreadInfoArray,1)
            I# = 0
            LOOP M# Times
                I# = I# + 1
                If Self.WorkerThreadInfoArray[I#].Used = True
                    If Upper(_name) <> Self.WorkerThreadInfoArray[I#].NameUpper
                        CYCLE
                    End
                    Return c25_GetWindowlongA(Self.WorkerThreadInfoArray[I#].WinHandle,GWL_USERDATA)
                End
            End
        End
        Return 0

c25WorkerThreadsClass.CreateNewWorkerThread Procedure(<String _name>)

    Code

        M# = Maximum(Self.WorkerThreadInfoArray,1)
        I# = 0
        LOOP M# Times
            I# = I# + 1
            If Self.WorkerThreadInfoArray[I#].Used = 0
                Clear(Self.WorkerThreadInfoArray[I#])
                Self.WorkerThreadInfoArray[I#].Used = True
                If OMITTED(_name) = False
                    Self.WorkerThreadInfoArray[I#] = Self.StartWorkerThread(I#, _name)
                Else
                    Self.WorkerThreadInfoArray[I#] = Self.StartWorkerThread(I#)
                End
                Self.WorkerThreadInfoArray[I#].Used = True
                Return I#
            End
        End
        Return 0

c25WorkerThreadsClass.Destruct       Procedure()

    Code

c25WorkerThreadsClass.GetRealThreadHandle Procedure()

    Code

    Return Self.WinApi.GetThreadHandle()

c25WorkerThreadsClass.GetSelfAddress       Procedure()

    Code

        Self.SelfAddress = Address(Self)
        Return Self.SelfAddress

c25WorkerThreadsClass.StartWorkerThread                  Procedure(Long _index, <String _name>)

WorkerThreadInfo                Group(WorkerThreadInfo_TYPE),Pre(WorkerThreadInfo)
                                End

    Code

        Clear(CurrentWorkerThreadInfo)
        If OMITTED(_name) = False
            WorkerThreadInfo.Name &= Self.WinApi.AnsiToAnsi(_name)
        Else
            WorkerThreadInfo.Name &= Self.WinApi.AnsiToAnsi(Self.NanoSync.GetSysTime())
        End
        WorkerThreadInfo.NameUpper         &= Self.WinApi.AnsiToAnsi(Upper(WorkerThreadInfo.Name))
        WorkerThreadInfo.PtrA               = Address(Self)
        CurrentWorkerThreadInfo             = WorkerThreadInfo

        WorkerThreadInfo.ThreadHandle       = c25_CreateThread(0, 010000h, Address(WorkerThread), _index, 0,Address(WorkerThreadInfo.ThreadId))

        LOOP
            c25_sleepex(100,0)
            If CurrentWorkerThreadInfo.WinHandle <> 0
                WorkerThreadInfo.WinHandle = CurrentWorkerThreadInfo.WinHandle
                WorkerThreadInfo.PtrB = CurrentWorkerThreadInfo.PtrB
                WorkerThreadInfo.Used = True
                BREAK
            End
        End
        Return WorkerThreadInfo

WorkerThread                    Procedure(Long _paramA, Long _paramB)

                                MAP
                                    WndProcWorker(Long WinHandle, ULong Message, ULong WParam, Long LParam),Long,pascal
                                End

NanoSync                        &NanoSyncClass()
ApiWndClassExA                  GROUP(ApiWndClassExA_TYPE),Pre(ApiWndClassExA)
                                End
ApiWndClassEx_ClassName         String(245)
ApiWindowNameA                  String(255)
WindowStyle                     Long
!WS_BORDER                       EQUATE(000800000h)
!WS_DLGFRAME                     EQUATE(000400000h)
!WS_GROUP                        EQUATE(000020000h)
!WS_HSCROLL                      EQUATE(000100000h)
!WS_MAXIMIZE                     EQUATE(001000000h)
!WS_MAXIMIZEBOX                  EQUATE(000010000h)
!WS_MINIMIZE                     EQUATE(020000000h)
!WS_MINIMIZEBOX                  EQUATE(000020000h)
!WS_OVERLAPPED                   EQUATE(000000000h)
!WS_POPUP                        EQUATE(080000000h)
!WS_SYSMENU                      EQUATE(000080000h)
!WS_TABSTOP                      EQUATE(000010000h)
!WS_THICKFRAME                   EQUATE(000040000h)
!WS_VISIBLE                      EQUATE(010000000h)
!WS_VSCROLL                      EQUATE(000200000h)
!WS_CAPTION                      EQUATE(WS_BORDER + WS_DLGFRAME)
!WS_POPUPWINDOW                  EQUATE(WS_POPUP + WS_BORDER + WS_SYSMENU)
GetMessageReturn                Long
WinMsgAddress                   Long
InputContextHandle              Long
TimerIDEvent                    Long
WinMes                          group,pre(WinMes)
hwnd                                Long,Name('hwnd')
message                             ULong,Name('message')
wParam                              ULong,Name('wParam')
lParam                              Long,Name('lParam')
time                                Long,Name('time')
pt_xpos                             Long,Name('pt_xpos')
pt_ypos                             Long,Name('pt_ypos')
lPrivate                            Long,Name('lPrivate')
                                End
WorkerThreadObject              &c25WorkerThreadClass()
WinHandle                       Long

    Code

        c25_Attachthreadtoclarion(True)

        WorkerThreadObject                      &= NEW c25WorkerThreadClass()
        WorkerThreadObject.Init()

        ApiWndClassEx_ClassName                 = 'ClaWin11WorkerThread' & _paramB & Chr(0)
        Clear(ApiWndClassExA)
        ApiWndClassExA.Size                     = Size(ApiWndClassExA)
        ApiWndClassExA.Style                    = 0
        ApiWndClassExA.WndProcPtr                = Address(WndProcWorker)
        ApiWndClassExA.ClsExtra                 = 8
        ApiWndClassExA.WndExtra                 = 4
        ApiWndClassExA.Instance                 = system{prop:appInstance}
        ApiWndClassExA.Icon                     = 0
        ApiWndClassExA.Cursor                   = 0
        ApiWndClassExA.Background             = 0
        ApiWndClassExA.szMenuName               = 0
        ApiWndClassExA.szClassName              = Address(ApiWndClassEx_ClassName)
        ApiWndClassExA.IconSm                   = 0

        Atom#                                   = c25_RegisterClassExA(Address(ApiWndClassExA))

        ApiWindowNameA                          = 'ClaWin11WorkerThread' & _paramB & Chr(0)
        WindowStyle                             =  WS_POPUPWINDOW
        WinHandle                               = c25_CreateWindowExA(0, Address(ApiWndClassEx_ClassName),Address(ApiWindowNameA), WindowStyle, |
        -1000, |
        Random(400,600), |
        200, |
        500, |
        0, |
        0, |
        system{prop:appInstance}, |
            0)

        WorkerThreadObject.WinHandle = WinHandle

        c25_SetwindowlongA(WinHandle,GWL_USERDATA,Address(WorkerThreadObject))

        NanoSync                    &= NEW NanoSyncClass()
        WinMsgAddress                = Address(WinMes)

        CurrentWorkerThreadInfo.PtrB = Address(WorkerThreadObject)

        If _paramB > 0 And _paramB < Maximum(WinHandlesArray,1) + 1
            WinHandlesArray[_paramB] = WinHandle
        End
        CurrentWorkerThreadInfo.WinHandle = WinHandle

        TimerIDEvent = c25_SetTimer(WinHandle, 0, 100, 0)

        c25_UpdateWindow(WinHandle)
        c25_ShowWindow(WinHandle,0)

        loop
            GetMessageReturn = c25_GetMessage(WinMsgAddress, 0,0,0)
            If GetMessageReturn = 0
                Break
            End
            If GetMessageReturn = -1
                CYCLE
            End
            c25_TranslateMessage(WinMsgAddress)
            c25_DispatchMessage(WinMsgAddress)
        End
        Return 0

WndProcWorker                 Procedure(Long _winHandle, ULong _winMes, ULong _wParam, Long _lParam)

WndProcWorkerThreadPtr  Long
WndProcWorkerThread     &c25WorkerThreadClass
I                       Long
M                       Long
stLog                   &StringTheory

    Code

        If _winHandle <> 0
            M = Maximum(WinHandlesArray,1)
            I = 0
            Loop M TIMES
                I = I + 1
                If WinHandlesArray[I] = _winHandle

                    WndProcWorkerThreadPtr = c25_GetWindowlongA(_winHandle,GWL_USERDATA)
                    If WndProcWorkerThreadPtr <> 0
                        WndProcWorkerThread &= (WndProcWorkerThreadPtr)

                        R# = WndProcWorkerThread.WndProc_Process(_winHandle, _winMes, _wParam, _lParam)
                        Return R#
                    End
                    BREAK
                End
            End
        End

        Return c25_DefWindowProcA(_winHandle, _winMes, _wParam, _lParam)

