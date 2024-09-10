                    Member
                        Include('c25_WorkerThreadClass.inc'), once
                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
                        End

c25WorkerThreadClass.Construct                      Procedure()

    Code

        !Self.Logger                     &= NEW LoggerClass()
        Self.CRLF                       = Chr(13) & Chr(10)
        Self.BytesHandler               &= NEW BytesHandlerClass()
        Self.SelfAddress                = Address(Self)
        Self.NanoSync                   &= NEW NanoSyncClass()
        Self.WinApi                     &= NEW WinApi32Class()
        Self.LargeTreeTEMP              &= NEW LargeTree_TYPE()
        Self.ReflectionCapesoft         &= NEW ReflectClass()
        Self.js1                        &= NEW JSONClass()
        Self.st1                        &= NEW StringTheory()
        Self.st2                        &= NEW StringTheory()
        If not Self.WinApi.GlobalMem &= null
            Self.GlobalNanoSync &= Self.WinApi.GlobalMem.NanoSync
        End

c25WorkerThreadClass.Destruct                       Procedure()

    Code

c25WorkerThreadClass.GetSelfAddress                 Procedure()

    Code

        Self.SelfAddress = Address(Self)
        Return Self.SelfAddress

c25WorkerThreadClass.Init                           Procedure()

    Code

        Return True

c25WorkerThreadClass.DummyProc                      Procedure()

    Code

        Return 0

c25WorkerThreadClass.c25_CreateHardwareObject       Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.Hardware &= NEW HardwareClass()
        Self.WndMessageProcessed = True
        Return Address(Self.Hardware)

c25WorkerThreadClass.c25_TakeSnapShot               Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.Hardware &= NULL
            Return 0
        End
        Self.Hardware.TakeSnapShot(_wParam)
        Return 0

c25WorkerThreadClass.c25_CreateRendererObject       Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.RenderEngine &= NEW c25RenderEngineClass()
        Self.WndMessageProcessed = True
        Return Address(Self.RenderEngine)

c25WorkerThreadClass.c25_EnumPrinters               Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.RenderEngine &= NULL
            Return 0
        End
        Self.RenderEngine.EnumPrinters()
        Return 0

c25WorkerThreadClass.GetAppObjects                  Procedure()

    Code

        If not Self.c25DatabaseHandler &= NULL
            Self.c25DatabaseHandler &= null
        End

        Self.c25DatabaseHandlerPtr          = Self.WinApi.GetGlobalDictionaryValue('DatabaseHandler_InstancePtr')
        Self.ThisMachineId                  = Self.WinApi.GetGlobalDictionaryValue('ThisMachineId')

        If Self.c25DatabaseHandlerPtr <> 0 And Self.c25DatabaseHandler &= null
            Self.c25DatabaseHandler &= (Self.c25DatabaseHandlerPtr)
        ELSE
        End

        If Self.ThisMachineId = 0
            Message('error Self.ThisMachineId = Self.WinApi.GetReg')
        End

        Return 0

c25WorkerThreadClass.PrepareFunctionality           Procedure(<Long _functionality>)

    Code

        Self.GetAppObjects()
        Self.Adapter &= (Self.c25DatabaseHandler.GetAdapterByAdapterName('AllMyDrives',DbEngineType:Sqlite3))
        If Self.Adapter &= NULL
            Message('error Self.Adapter is null')
        End
        If Self.UserObject &= null

            Self.UserObject                         &= NEW UserClass()
            Self.UserObject.Init(1)

            Self.DatabasesTemp                      &= NEW c25DbDatabases_TYPE()
            Self.DatabasesTemp                      = Self.c25DatabaseHandler.GetDbDatabaseBySourceName('AllMyDrives','Hardware',DbEngineType:Sqlite3)
            Self.Sqlite34HardwareConnHandle         = Self.Adapter.ConnectSqlite3(Self.DatabasesTemp)
            If Self.Sqlite34HardwareConnHandle      = 0
                Message('error If Self.Sqlite34Hardware.ConnHandle = 0')
            End

            Clear(Self.DatabasesTemp)
            Self.DatabasesTemp                      = Self.c25DatabaseHandler.GetDbDatabaseBySourceName('AllMyDrives','User',DbEngineType:Sqlite3)
            Self.UserObject.Sqlite34.ConnHandle     = Self.Adapter.ConnectSqlite3(Self.DatabasesTemp)
            If Self.UserObject.Sqlite34.ConnHandle  = 0
                Message('error Self.UserObject.Sqlite34.ConnHandle = 0')
            End
        End
        Return 0

c25WorkerThreadClass.c25_BuildUserTree              Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.PrepareFunctionality()

        If Self.MachineObject &= null
            Self.MachineObject &= NEW MachineClass()
            Self.WinApi.GlobalMem.SetGlobalDictionaryValue('Address(Self.MachineObject)',Address(Self.MachineObject))

            Self.MachineObject.Init(Self.ThisMachineId, Self.Sqlite34HardwareConnHandle)

            Self.LargeTreeTEMP = Self.UserObject.CreateUserTreeSection(UserTreeSection:Header, 1, 0)
            Self.CurrentLevel = Self.LargeTreeTEMP.LineLevel
            Self.LargeTreeTEMP = Self.UserObject.AddMachineToUserTree(Address(Self.MachineObject), Self.CurrentLevel + 1, Self.LargeTreeTEMP.NodeId)

            Self.UserObject.Sqlite34.QueueDataToSqliteTableEntity(Self.UserObject.LargeTree,'LargeTree',Self.UserObject.ClarionFieldsLargeTree)
        End

        Self.WndMessageProcessed = True
        Return 0

c25WorkerThreadClass.c25_GetLargeTreeById           Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

LargeTreeStr &String

    Code

        Self.WndMessageProcessed = True
        If Self.UserObject &= NULL
            Return 0
        End
        If Self.UserObject.Sqlite34 &= NULL
            Return 0
        End
        If Self.LargeTreeTEMP &= null
            Self.LargeTreeTEMP &= NEW LargeTree_TYPE()
        ELSE
            Self.ReflectionCapesoft.DisposeQueue(Self.LargeTreeTEMP)
        End
        If 1 > 0

            Self.UserObject.Sqlite34.ExecuteQueryToQueueEntity('select * from LargeTree where ID = ' & _wParam & ' LIMIT 1', Self.LargeTreeTEMP, Self.UserObject.ClarionFieldsLargeTree)
            Get(Self.LargeTreeTEMP,1)
            LargeTreeStr &= NEW String(Size(Self.LargeTreeTEMP))
            LargeTreeStr = Self.LargeTreeTEMP
            Return Address(LargeTreeStr)
        End
        Return 0

c25WorkerThreadClass.c25_GetMaxIdLargeTree          Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If not Self.UserObject &= null
            If not Self.UserObject.Sqlite34 &= null
                If Self.UserObject.Sqlite34.ConnHandle <> 0
                    MX# = Self.UserObject.Sqlite34.ExecuteScalar('select max(id) from LargeTree;')
                    Return MX#
                End
            End
        End
        Return 0

c25WorkerThreadClass.c25_HardwareInit               Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.Hardware &= NULL
            Return 0
        End
        Self.Hardware.Init()
        Return 0

c25WorkerThreadClass.c25_GetHardwarePtr             Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.Hardware &= NULL
            Return 0
        End
        Return Address(Self.Hardware)

c25WorkerThreadClass.c25_SetSqlite34ConnUriUtf8     Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        If Self.Hardware &= NULL
            Return 0
        End
        Self.WndMessageProcessed = True
        Return 0

c25WorkerThreadClass.WM_000016_WM_CLOSE             Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        c25_PostQuitMessage(_winHandle)
        Return 0

c25WorkerThreadClass.WM_000275_WM_TIMER             Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = True
        If Self.StartApp
            Self.StartApp = 0
        End

        c25_DefWindowProcA(_winHandle, _winMes, _wParam, _lParam)
        Return 0

c25WorkerThreadClass.c25_SendMachineData            Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

ConnHandle          Long,auto
InterPacket                                         Group
PacketType                                              String(128),Name('PacketType | String')
PacketSizeUnpacked                                      Long,Name('PacketSizeUnpacked | Long')
PacketSizePacked                                        Long,Name('PacketSizePacked | Long')
Reserved                                                String(120),Name('Reserved | String')
                                                    End

ClarionFields                                       &ClarionFields_TYPE

SessionId                                           cstring(21)
ThisReturnVal                                               Long

TargetWinHandle                                         Long
TargetNetObject                                         Long

MachineObjectAddress                                    Long

    Code

        !Message('START c25WorkerThreadClass.c25_SendMachineData')
        
        TargetWinHandle = _wParam
        TargetNetObject = _lParam

        !Self.Logger.PostLogLine('TargetWinHandle: ' & _wParam, 'c25WorkerThreadClass', '','c25_SendMachineData')
        !Self.Logger.PostLogLine('TargetNetObject: ' & _lParam, 'c25WorkerThreadClass', '','c25_SendMachineData')

        !Self.Logger.PostLogLine('in c25WorkerThreadClass.c25_SendMachineData Procedure()', 'c25WorkerThreadClass', '','c25_SendMachineData')

        Self.PrepareFunctionality()
        !Message('done Self.PrepareFunctionality()')
!        If not Self.MachineObject &= NULL
!            Dispose(Self.MachineObject)
!        End

        If NOT Self.TrueReflection &= null
            Dispose(Self.TrueReflection)
        End
        Self.TrueReflection &= NEW TrueReflectionClass()

        If Self.MachineObject &= null
            MachineObjectAddress = Self.WinApi.GlobalMem.GetGlobalDictionaryValue('Address(Self.MachineObject)',0)
            !Message('MachineObjectAddress ' & MachineObjectAddress)
            
            If MachineObjectAddress = 0
                Return 0
            End
            Self.MachineObject &= (MachineObjectAddress)
        End
        !Message('Self.MachineObject.Id : ' & Self.MachineObject.Id)
        !Get(Self.MachineObject.BiosPage000,1)
        !Message(Self.MachineObject.BiosPage000.Vendor)
        
        
        Self.FullMachineQ &= Self.MachineObject.FullMachineQ
        Get(Self.FullMachineQ,1)
        If Errorcode() <> 0
            Message('error get(Self.Self.FullMachineQ')
        End
        !Message('Self.FullMachineQ.Id ' & Self.FullMachineQ.Id)

        Self.St1.Start()
        Self.TrueReflection.LoadQueueTypes()
        !Message('try SerializeQueue')

        !Self.TrueReflection.SerializeQueue(Self.FullMachineQ, Self.St1)

        !Message('done SerializeQueue')
        !Message(Self.St1.GetValue())

!            ThisReturnVal = 0
!            R# = c25_SendMessageTimeoutA(TargetWinHandle, c25:OpenConnection, TargetNetObject, 0, SMTO_ABORTIFHUNG, 300000 , Address(ThisReturnVal))
!            If ThisReturnVal <> 0
!                !Self.Logger.PostLogLine('OK, c25:OpenConnection RETURNVAL: ' & ThisReturnVal, 'c25WorkerThreadClass', '','c25:OpenConnection')
!            ELSE
!                !Self.Logger.PostLogLine('NOT OK, c25:OpenConnection RETURNVAL: ' & ThisReturnVal, 'c25WorkerThreadClass', '','c25:OpenConnection')
!                Return -1
!            End
!
!            c25_sleepex(100,0)
!            LOOP
!                ThisReturnVal = 0
!                R# = c25_SendMessageTimeoutA(TargetWinHandle, c25:QueryStatus, TargetNetObject, NetQueryStatus:IsOpen, SMTO_ABORTIFHUNG, 300000 , Address(ThisReturnVal))
!                If ThisReturnVal <> 0
!                    !Self.Logger.PostLogLine('OK, c25:QueryStatus RETURNVAL: ' & ThisReturnVal, 'c25WorkerThreadClass', '','c25_SendMachineData')
!                    BREAK
!                ELSE
!                End
!                c25_sleepex(100,0)
!            End
!
!            ThisReturnVal = 0
!            R# = c25_SendMessageTimeoutA(TargetWinHandle, c25:SendData, TargetNetObject, Self.BytesHandler.StringToStringRefPtr(NetHdr_Machine & Self.St1.GetValue()), SMTO_ABORTIFHUNG, 300000 , Address(ThisReturnVal))
!            If ThisReturnVal <> 0
!                !Self.Logger.PostLogLine('OK, c25:SendData RETURNVAL: ' & ThisReturnVal, 'c25WorkerThreadClass', '','c25_SendMachineData')
!            ELSE
!                !Self.Logger.PostLogLine('NOT OK, c25:SendData RETURNVAL: ' & ThisReturnVal, 'c25WorkerThreadClass', '','c25_SendMachineData')
!                Return -1
!            End

        !End

        Self.WndMessageProcessed = True
        Message('DONE c25WorkerThreadClass.c25_SendMachineData')
        Return 0


c25WorkerThreadClass.GetWinHandleByAdapterName      Procedure(String _adapterName)

    Code

        H# = Self.WinApi.GetGlobalDictionaryValue('Adapter.' & Clip(_adapterName) & '.WinHandle')
        If H# <> 0
            Return H#
        End

        If Self.c25DatabaseHandlerPtr = 0
            Self.c25DatabaseHandlerPtr = Self.WinApi.GetGlobalDictionaryValue('DatabaseHandler_InstancePtr')
            If Self.c25DatabaseHandlerPtr <> 0
                Self.c25DatabaseHandler &= (Self.c25DatabaseHandlerPtr)
            End
        End
        If Self.c25DatabaseHandler &= NULL
            Return 0
        End
        H# = Self.c25DatabaseHandler.GetWinHandleByAdapterName(Clip(_adapterName))
        If H# = 0
            Return 0
        End
        Self.WinApi.SetGlobalDictionaryValue('Adapter.' & Clip(_adapterName) & '.WinHandle',H#)

        Return H#

c25WorkerThreadClass.StartupApp                     Procedure()

    Code

        Return 0

c25WorkerThreadClass.WndProc_Process                Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam)

    Code

        Self.WndMessageProcessed = 0
        Self.ReturnVal = 0

        Case _winMes

        Of c25:SendMachineData
            Self.ReturnVal = Self.c25_SendMachineData(_winHandle,_winMes,_wParam,_lParam)
        Of c25:TakeSnapShot
            Self.ReturnVal = Self.c25_TakeSnapShot(_winHandle,_winMes,_wParam,_lParam)
        Of c25:GetHardwarePtr
            Self.ReturnVal = Self.c25_GetHardwarePtr(_winHandle,_winMes,_wParam,_lParam)
        Of c25:EnumPrinters
            Self.ReturnVal = Self.c25_EnumPrinters(_winHandle,_winMes,_wParam,_lParam)
        Of c25:GetMaxIdLargeTree
            Self.ReturnVal = Self.c25_GetMaxIdLargeTree(_winHandle,_winMes,_wParam,_lParam)
        Of c25:GetLargeTreeById
            Self.ReturnVal = Self.c25_GetLargeTreeById(_winHandle,_winMes,_wParam,_lParam)
        Of c25:BuildUserTree
            Self.ReturnVal = Self.c25_BuildUserTree(_winHandle,_winMes,_wParam,_lParam)
        Of c25:CreateHardwareObject
            Self.ReturnVal = Self.c25_CreateHardwareObject(_winHandle,_winMes,_wParam,_lParam)
        Of c25:CreateRendererObject
            Self.ReturnVal = Self.c25_CreateRendererObject(_winHandle,_winMes,_wParam,_lParam)
        Of c25:HardwareInit
            Self.ReturnVal = Self.c25_HardwareInit(_winHandle,_winMes,_wParam,_lParam)
        Of c25:SetSqlite34ConnUriUtf8
            Self.ReturnVal = Self.c25_SetSqlite34ConnUriUtf8(_winHandle,_winMes,_wParam,_lParam)
        End
        If Self.WndMessageProcessed = 0
            Case _winMes
            Of WM_CLOSE
                Self.ReturnVal = Self.WM_000016_WM_CLOSE(_winHandle,_winMes,_wParam,_lParam)
            Of WM_TIMER
                Self.ReturnVal = Self.WM_000275_WM_TIMER(_winHandle,_winMes,_wParam,_lParam)
            ELSE
                Self.ReturnVal = Self.DummyProc()
            End
        End
        If Self.WndMessageProcessed = TRUE
            Return Self.ReturnVal
        End
        Return c25_DefWindowProcA(_winHandle, _winMes, _wParam, _lParam)

