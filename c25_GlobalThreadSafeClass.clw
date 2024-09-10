    Member

        Include('c25_GlobalThreadSafeClass.inc'), once
        Include('c25_HardwareClass.inc'),once
        include('C25_DUMMY.CLW'),ONCE
                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
                        End

c25GlobalThreadSafeClass.Construct              Procedure()

    Code

        Self.SelfAddress                     = Address(Self)

c25GlobalThreadSafeClass.Init              Procedure(Long _paramA)

    Code

        Self.NanoSync                       &= NEW NanoSyncClass()
        Self.c25MessagesQ                   &= NEW c25Messages_TYPE()
        Self.c25MessagesQBuffer             &= NEW c25Messages_TYPE()
!        Self.c25DatabaseHandler_Instance    &= NEW c25DatabaseHandlerClass()

        Self.st1                            &= NEW StringTheory()
        Self.st1.Start()
        Self.WinApi                         &= NEW WinApi32Class()
!        Self.Sqlite34                        &= NEW Sqlite34Class()
!        Self.Sqlite34.AppMemConnHandle         = Self.AppMemConnHandle
!        Self.Sqlite34.ConnHandle             = Self.AppMemConnHandle
!        Self.Hardware_Instance                 &= NEW HardwareClass()
!        Self.Hardware_Instance.Init(_appRootPtr)

        Self.InitReady = True
        Return Self.InitReady

c25GlobalThreadSafeClass.GetRealThreadHandle Procedure()

    Code

    Return Self.WinApi.GetThreadHandle()

c25GlobalThreadSafeClass.PostMessageOld Procedure(<c25Messages_TYPE _c25MessagesQ>,<ULong _mes>,<ULong _wParam>,<Long _lParam>,<String _messageStr>)

something                                   &String

    Code

    Self.c25MessagesQBufferProcessedCount = Self.c25MessagesQBufferProcessedCount + 1
        If Omitted(_c25MessagesQ) = True ! not passed
            Clear(Self.c25MessagesQBuffer)
            Add(Self.c25MessagesQBuffer)

            Self.c25MessagesQBuffer.MessageStrAnsi  &= null
            Self.c25MessagesQBuffer.Mes         = _mes
            Self.c25MessagesQBuffer.WParam      = _wParam
            Self.c25MessagesQBuffer.LParam      = _lParam
            If Self.WinApi &= NULL
                Message('error Self.WinApi is null')
            End
!            Case Self.c25MessagesQBuffer.Mes
!            Of WMC_Test                                     !EQUATE(WM_USER + 1)
!                Self.c25MessagesQBuffer.MessageStrAnsi &= Self.WinApi.AnsiToAnsi('WMC_Test')
!            Of WMC_InjectDatabaseInstance                   !EQUATE(WM_USER + 2)
!                Self.c25MessagesQBuffer.MessageStrAnsi &= Self.WinApi.AnsiToAnsi('WMC_InjectDatabaseInstance')
!            Of WMC_Sqlite3_ConnHandle                        !EQUATE(WM_USER + 3)
!                Self.c25MessagesQBuffer.MessageStrAnsi &= Self.WinApi.AnsiToAnsi('WMC_Sqlite3_ConnHandle')
!            Of WMC_GetBiosData                              !EQUATE(WM_USER + 4)
!                Self.c25MessagesQBuffer.MessageStrAnsi &= Self.WinApi.AnsiToAnsi('WMC_GetBiosData')
!            Of WMC_HardwareFillDefaults                        !EQUATE(WM_USER + 5)
!                Self.c25MessagesQBuffer.MessageStrAnsi &= Self.WinApi.AnsiToAnsi('WMC_HardwareFillDefaults')
!            Of WMC_EnumerateWinObj                             !EQUATE(WM_USER + 6)
!                Self.c25MessagesQBuffer.MessageStrAnsi &= Self.WinApi.AnsiToAnsi('WMC_EnumerateWinObj')
!            Of WMC_EnumerateDevices                            !EQUATE(WM_USER + 7)
!                Self.c25MessagesQBuffer.MessageStrAnsi &= Self.WinApi.AnsiToAnsi('WMC_EnumerateDevices')
!            End
        Else
            Self.c25MessagesQBuffer = _c25MessagesQ
            Add(Self.c25MessagesQBuffer)
        End

        Put(Self.c25MessagesQBuffer)

        Self.st1.Start()
        If not Self.c25MessagesQBuffer.MessageStrAnsi &= null
            Self.st1.Append('received message in PostMessage ' & Self.c25MessagesQBuffer.Mes & ', ' & Self.c25MessagesQBuffer.MessageStrAnsi & Chr(13) & Chr(10))
        Else
            Self.st1.Append('received message in PostMessage ' & Self.c25MessagesQBuffer.Mes & ', null' & Chr(13) & Chr(10))
        End
        Self.st1.SaveFile('logGlobalThreadSafeClass.txt', true)
    Self.MessagePump()

    Return 0

c25GlobalThreadSafeClass.Destruct       Procedure()

    Code

c25GlobalThreadSafeClass.GetSelfAddress       Procedure()

    Code

        Self.SelfAddress = Address(Self)
        Return Self.SelfAddress

c25GlobalThreadSafeClass.MessagePump     Procedure()

MessageRecords Long

    Code

!    If Self.Sqlite34.ConnHandle <> 0
!        MessageRecords = Self.Sqlite34.ExecuteScalar('select count(*) from c25Messages')
!        If MessageRecords > 0
!            Message('ja zeg found messages ' & MessageRecords)
!        End
!    End
    Return 0

!c25GlobalThreadSafeClass.MessagePumpOld       Procedure()
!
!Idx                 Long
!Recs                 Long
!Idx2                Long
!Recs2                 Long
!QKeyValue             &QKeyValue_TYPE
!OutputLine                                      cstring(256)
!
!    Code
!
!        If Self.AppRoot_Instance.AppMemoryReady = 0 Or Self.AppRoot_Instance.AppMemoryConnHandle = 0
!            Return 0
!        End
!
!        LOOP 1 Times
!            If Self.c25MessagesQBuffer &= NULL
!                Cycle
!            End
!            If Records(Self.c25MessagesQBuffer) < 1
!                Cycle
!            End
!            Idx = 0
!            Loop !Recs TIMES
!                Idx = Idx + 1
!                If Idx > Records(Self.c25MessagesQBuffer)
!                    BREAK
!                End
!                Get(Self.c25MessagesQBuffer,Idx)
!                If Errorcode() <> 0
!                    BREAK
!                End
!                If not Self.c25MessagesQ.MessageStrAnsi &= null
!                    Dispose(Self.c25MessagesQ.MessageStrAnsi)
!                End
!                Clear(Self.c25MessagesQ)
!
!                Self.c25MessagesQ.Mes           = Self.c25MessagesQBuffer.Mes
!                Self.c25MessagesQ.Id            = Self.c25MessagesQBuffer.Id
!                Self.c25MessagesQ.SourceHnd     = Self.c25MessagesQBuffer.SourceHnd
!                Self.c25MessagesQ.TargetHnd     = Self.c25MessagesQBuffer.TargetHnd
!                Self.c25MessagesQ.Timeout       = Self.c25MessagesQBuffer.Timeout
!                Self.c25MessagesQ.TimeStamp     = Self.c25MessagesQBuffer.TimeStamp
!                Self.c25MessagesQ.WParam        = Self.c25MessagesQBuffer.WParam
!                Self.c25MessagesQ.LParam        = Self.c25MessagesQBuffer.LParam
!                Add(Self.c25MessagesQ)
!
!            End
!
!            Loop 1 Times
!                break
!                Get(Self.c25MessagesQ,1)
!                If Errorcode() <> 0
!                    BREAK
!                End
!                Self.c25MessagesQProcessedCount = Self.c25MessagesQProcessedCount + 1
!
!                Case Self.c25MessagesQ.Mes
!                Of WMC_Test
!                Of WMC_HardwareFillDefaults
!                    If not Self.Hardware_Instance &= null
!
!                        Self.Hardware_Instance.FillDefaults()
!                    End
!                Of WMC_GetBiosData
!                    If not Self.Hardware_Instance &= null
!
!                        Self.Hardware_Instance.Sqlite3ConnHandle = Self.AppRoot_Instance.AppMemoryConnHandle
!                        Self.Hardware_Instance.Sqlite34.ConnHandle = Self.AppRoot_Instance.AppMemoryConnHandle
!
!                        Self.Hardware_Instance.EnumerateBiosReady = 0
!                        Self.Hardware_Instance.EnumerateBios()
!                    End
!                Of WMC_EnumerateWinObj
!                    If not Self.Hardware_Instance &= null
!
!                        Self.Hardware_Instance.Sqlite3ConnHandle = Self.AppRoot_Instance.AppMemoryConnHandle
!                        Self.Hardware_Instance.Sqlite34.ConnHandle = Self.AppRoot_Instance.AppMemoryConnHandle
!
!                        Self.Hardware_Instance.EnumerateWinObjReady = 0
!                        Self.Hardware_Instance.EnumerateWinObj()
!                    End
!                Of WMC_EnumerateDevices
!                    If not Self.Hardware_Instance &= null
!
!                        Self.Hardware_Instance.Sqlite3ConnHandle = Self.AppRoot_Instance.AppMemoryConnHandle
!                        Self.Hardware_Instance.Sqlite34.ConnHandle = Self.AppRoot_Instance.AppMemoryConnHandle
!
!                        Self.Hardware_Instance.EnumerateDevicesReady = 0
!                        Self.Hardware_Instance.EnumerateDevices()
!                    End
!                End
!
!            End
!        End
!        c25_sleepex(50,0)

    Return 0

