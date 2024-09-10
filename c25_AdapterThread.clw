DbAdapterThread                 Procedure(Long _paramA, Long _paramB)

                                MAP
                                    WndProc(Long WinHandle, ULong Message, ULong WParam, Long LParam),Long,pascal
                                End

AdaptersRecord              Group(c25DbAdapters_TYPE),Pre(AdaptersRecord)
                            End
Adapter                     &c25DbAdapterClass()
NanoSync                    &NanoSyncClass()
ApiWndClassExA              GROUP(ApiWndClassExA_TYPE),Pre(ApiWndClassExA)
                            End
ClassName                   String(245)
WindowName                  String(255)
WindowStyle                 Long
GetMessageReturn            Long
WinMesAddress               Long
WinMes                      group,pre(WinMes)
hwnd                            Long,Name('hwnd')
message                         ULong,Name('message')
wParam                          ULong,Name('wParam')
lParam                          Long,Name('lParam')
time                            Long,Name('time')
pt_xpos                         Long,Name('pt_xpos')
pt_ypos                         Long,Name('pt_ypos')
lPrivate                        Long,Name('lPrivate')
                            End
DataBaseHandler             &c25DatabaseHandlerClass()
st                          &StringTheory
TimerIDEvent                Long
WinHandle                   Long
AppInstance                 Long

    Code

        c25_Attachthreadtoclarion(True)

        DataBaseHandler &= (DbHandlerPtr)
        Get(DataBaseHandler.Adapters,DbAdapterIndex)

        Adapter                                &= NEW c25DbAdapterClass()
        Adapter.AdaptersRecord                  = DataBaseHandler.Adapters
        Adapter.AdaptersRecord.Instance        &= Adapter
        Adapter.AdaptersRecord.InstancePtr      = Address(Adapter)

        DataBaseHandler.Adapters.InstancePtr    = Address(Adapter)
        DataBaseHandler.Adapters.Instance       &= (DataBaseHandler.Adapters.InstancePtr)

        c25_GetModuleHandleExA(2,0,Address(AppInstance))
        ClassName                               = 'ClaWin11Main' & Chr(0)

        Clear(ApiWndClassExA)
        ApiWndClassExA.Size                     = Size(ApiWndClassExA)
        ApiWndClassExA.Style                    = 0
        ApiWndClassExA.WndProcPtr                = Address(WndProc)
        ApiWndClassExA.ClsExtra                 = 8
        ApiWndClassExA.WndExtra                 = 4
        ApiWndClassExA.Instance                 = system{prop:appInstance}
        ApiWndClassExA.Icon                     = 0
        ApiWndClassExA.Cursor                   = 0
        ApiWndClassExA.Background             = 0
        ApiWndClassExA.szMenuName               = 0
        ApiWndClassExA.szClassName              = Address(ClassName)
        ApiWndClassExA.IconSm                   = 0

        Atom#                                   = c25_RegisterClassExA(Address(ApiWndClassExA))
        WindowStyle                             =  WS_POPUPWINDOW
        WindowName                              = 'Hello World' & Clock() & Chr(0)
        WinHandle                               = c25_CreateWindowExA(0, Address(ClassName),Address(WindowName), WindowStyle,-1000,Random(400,600),200,500,0,0,system{prop:appInstance},0)
        Adapter.AdaptersRecord.WinHandle        = WinHandle

        c25_SetwindowlongA(WinHandle,GWL_USERDATA,Address(Adapter))
        TimerIDEvent = c25_SetTimer(WinHandle, 0, 100, 0)
        Adapter.AdaptersRecord.TimerIDEvent     = TimerIDEvent
        AdaptersWinHandlesArray[Adapter.AdaptersRecord.Id] = WinHandle
        c25_ShowWindow(WinHandle, False)
        Put(DataBaseHandler.Adapters)
        Adapter.Init()
        
        
        DataBaseHandler.ProcessNextAdapter = True
        NanoSync        &= NEW NanoSyncClass()
        WinMesAddress   = Address(WinMes)
        c25_UpdateWindow(WinHandle)
        loop
            GetMessageReturn = c25_GetMessage(WinMesAddress, 0,0,0)
            If GetMessageReturn = 0
                Break
            End
            If GetMessageReturn = -1
                CYCLE
            End
            c25_TranslateMessage(WinMesAddress)
            c25_DispatchMessage(WinMesAddress)
        End
        Return WinMes.wparam

WndProc                 Procedure(Long _winHandle, ULong _winMes, ULong _wParam, Long _lParam)

WndProcAdapterPtr           Long,auto
WndProcAdapter              &c25DbAdapterClass,auto
I                           Long,auto
M                           Long,auto

    Code

        M = Maximum(AdaptersWinHandlesArray,1)
        I = 0
        Loop M TIMES
            I = I + 1
            If AdaptersWinHandlesArray[I] = _winHandle
                WndProcAdapterPtr = c25_GetWindowlongA(_winHandle,GWL_USERDATA)
                If WndProcAdapterPtr <> 0
                    WndProcAdapter &= (WndProcAdapterPtr)
                    Return WndProcAdapter.WndProc_Process(_winHandle, _winMes, _wParam, _lParam)
                End
                BREAK
            End
        End
        Return c25_DefWindowProcA(_winHandle, _winMes, _wParam, _lParam)

