                    Member
                        Include('c25_FileServerClass.inc'), once
                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
                        End

c25FileServerClass.Construct                     Procedure()

Code

    Self.Logger                     &= NEW LoggerClass()
    Self.Logger.PostLogLine(ClearLogQueue, ClearLogQueue,ClearLogQueue ,ClearLogQueue)

    Self.CRLF                       = Chr(13) & Chr(10)
    Self.BytesHandler               &= NEW BytesHandlerClass()
    Self.WinApi                     &= NEW WinApi32Class()
    Self.St1                        &= NEW StringTheory()
    Self.St2                        &= NEW StringTheory()
    If not Self.WinApi.GlobalMem &= null
        Self.GlobalNanoSync &= Self.WinApi.GlobalMem.NanoSync
        If Self.GlobalNanoSync &= NULL
            Message('error in fileserverclass Self.GlobalNanoSync is null')
        End
    End
    Self.NanoSync                   &= NEW NanoSyncClass()
    Self.NanoSync.SetTimeOut(0,1,0,0,'LocalAlive')
    Self.WindowHandle               = 0{Prop:Handle}
    Self.ThreadHandle               = Self.WinApi.GetThreadHandle()
    Self.TrueReflection             &= NEW TrueReflectionClass()
    Self.c25NetObject001            &= NEW c25NetObjectClass
    Self.c25NetObject002            &= NEW c25NetObjectClass
    Self.c25NetObject003            &= NEW c25NetObjectClass
    Self.c25NetObject004            &= NEW c25NetObjectClass
    Self.c25NetObject005            &= NEW c25NetObjectClass
    Self.c25NetObject006            &= NEW c25NetObjectClass
    Self.c25NetObject007            &= NEW c25NetObjectClass
    Self.c25NetObject008            &= NEW c25NetObjectClass    
    Self.WinApi.SetGlobalDictionaryValue('NetServer.WinHandle', Self.WindowHandle)


c25FileServerClass.Destruct                      Procedure()

    Code

c25FileServerClass.CloseWindow         Function(<Long _level>)

Code

    Self.CloseWindowCount = Self.CloseWindowCount + 1
    If Self.ActivateCloseWindow = 0
        Self.ActivateCloseWindow = True

        Self.WinApi.ArmCloseWindow(_level)

    Else
        Self.CheckArmCloseWindowCount = Self.CheckArmCloseWindowCount + 1
        Self.WinApi.CheckArmCloseWindow()
    End
    Return 0

c25FileServerClass.CloseWindowThis Procedure(Long _wparam)

Code

    If Self.ActivateCloseWindow = 0
        Self.CloseWindow(_wparam)
        Self.NanoSync.SetTimeOut(0,0,0,0,'ThisAlive')
    End
    Return 0

c25FileServerClass.c25_StartListener     Function(Long _wParam, Long _lParam)

Code


    Execute _wParam
        Self.c25NetObject001.c25_StartListener(_lParam, True)
    End

    Return True

c25FileServerClass.Process                Procedure(Long _simpleObjectId)

Code

    Execute _simpleObjectId
        Self.c25NetObject001.Process(True)
    End
    Return True

c25FileServerClass.PacketReceived         Procedure(Long _simpleObjectId)

Code

    Execute _simpleObjectId
        Self.c25NetObject001.PacketReceived(True)
    End
    Return True


