                    Member
                        Include('c25_ClientServerClass.inc'), once
                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
                        End

c25ClientServerClass.Construct                     Procedure()

Code

    Self.Logger                     &= NEW LoggerClass()
    Self.CRLF                       = Chr(13) & Chr(10)
    Self.BytesHandler               &= NEW BytesHandlerClass()
    Self.NanoSync                   &= NEW NanoSyncClass()
    Self.WinApi                     &= NEW WinApi32Class()
    Self.St1                        &= NEW StringTheory()
    Self.St2                        &= NEW StringTheory()
    If not Self.WinApi.GlobalMem &= null
        Self.GlobalNanoSync &= Self.WinApi.GlobalMem.NanoSync
    End
    Self.NanoSync                   &= NEW NanoSyncClass()
    Self.NanoSync.SetTimeOut(0,1,0,0,'LocalAlive')
    Self.WindowHandle               = 0{Prop:Handle}
    Self.ThreadHandle               = Self.WinApi.GetThreadHandle()
    Self.TrueReflection             &= NEW TrueReflectionClass()
    
    Self.c25NetObject001               &= NEW c25NetObjectClass()
    Self.c25NetObject002               &= NEW c25NetObjectClass()
    Self.c25NetObject003               &= NEW c25NetObjectClass()
    Self.c25NetObject004               &= NEW c25NetObjectClass()
    Self.c25NetObject005               &= NEW c25NetObjectClass()
    Self.c25NetObject006               &= NEW c25NetObjectClass()
    Self.c25NetObject007               &= NEW c25NetObjectClass()
    Self.c25NetObject008               &= NEW c25NetObjectClass() 

c25ClientServerClass.Destruct                      Procedure()

Code

c25ClientServerClass.CloseWindow         Function(<Long _level>)

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

c25ClientServerClass.CloseWindowThis Procedure(Long _wparam)

Code

    If Self.ActivateCloseWindow = 0
        Self.CloseWindow(_wparam)
        Self.NanoSync.SetTimeOut(0,0,0,0,'ThisAlive')
    End
    Return 0

c25ClientServerClass.c25_OpenConnection     Function(Long _wParam, Long _lParam)


Code


    Execute _wParam
        Self.c25NetObject001.c25_OpenConnection(_lParam, True)
        Self.c25NetObject002.c25_OpenConnection(_lParam, True)
        Self.c25NetObject003.c25_OpenConnection(_lParam, True)
        Self.c25NetObject004.c25_OpenConnection(_lParam, True)
        Self.c25NetObject005.c25_OpenConnection(_lParam, True)
        Self.c25NetObject006.c25_OpenConnection(_lParam, True)
        Self.c25NetObject007.c25_OpenConnection(_lParam, True)
        Self.c25NetObject008.c25_OpenConnection(_lParam, True)
    End
    Return True

c25ClientServerClass.c25_SendData           Function(Long _wParam, Long _lParam)

Code

    Execute _wParam
        Self.c25NetObject001.c25_SendData(,_lParam)
        Self.c25NetObject002.c25_SendData(,_lParam)
        Self.c25NetObject003.c25_SendData(,_lParam)
        Self.c25NetObject004.c25_SendData(,_lParam)
        Self.c25NetObject005.c25_SendData(,_lParam)
        Self.c25NetObject006.c25_SendData(,_lParam)
        Self.c25NetObject007.c25_SendData(,_lParam)
        Self.c25NetObject008.c25_SendData(,_lParam)
    End    
    Return True

c25ClientServerClass.c25_QueryStatus           Function(Long _wParam, Long _lParam)

Code

    Execute _wParam
        Return Self.c25NetObject001.QueryStatus(_lParam, True)
        Return Self.c25NetObject002.QueryStatus(_lParam, True)
        Return Self.c25NetObject003.QueryStatus(_lParam, True)
        Return Self.c25NetObject004.QueryStatus(_lParam, True)
        Return Self.c25NetObject005.QueryStatus(_lParam, True)
        Return Self.c25NetObject006.QueryStatus(_lParam, True)
        Return Self.c25NetObject007.QueryStatus(_lParam, True)
        Return Self.c25NetObject008.QueryStatus(_lParam, True)
    End       
    Return 0

c25ClientServerClass.Process                Procedure(Long _simpleObjectId)

Code


    Execute _simpleObjectId
        Self.c25NetObject001.Process(true)
        Self.c25NetObject002.Process(true)
        Self.c25NetObject003.Process(true)
        Self.c25NetObject004.Process(true)
        Self.c25NetObject005.Process(true)
        Self.c25NetObject006.Process(true)
        Self.c25NetObject007.Process(true)
        Self.c25NetObject008.Process(true)
    End      
    Return True

c25ClientServerClass.PacketReceived         Procedure(Long _simpleObjectId)

    Code

    Execute _simpleObjectId
        Self.c25NetObject001.PacketReceived(true)
        Self.c25NetObject002.PacketReceived(true)
        Self.c25NetObject003.PacketReceived(true)
        Self.c25NetObject004.PacketReceived(true)
        Self.c25NetObject005.PacketReceived(true)
        Self.c25NetObject006.PacketReceived(true)
        Self.c25NetObject007.PacketReceived(true)
        Self.c25NetObject008.PacketReceived(true)
    End      
    Return True

c25ClientServerClass.c25_GetFreeNetObject   Function(Long _wParam, Long _lParam)

Code

    I# = 0
    LOOP 8 Times
        I# = I# + 1
        B# = 0
        Execute I#
            B# = Self.c25NetObject001.IsFree
            B# = Self.c25NetObject002.IsFree
            B# = Self.c25NetObject003.IsFree
            B# = Self.c25NetObject004.IsFree
            B# = Self.c25NetObject005.IsFree
            B# = Self.c25NetObject006.IsFree
            B# = Self.c25NetObject007.IsFree
            B# = Self.c25NetObject008.IsFree
        End         
        If B# = True
            Return I#
        End
    End
    Return 0

