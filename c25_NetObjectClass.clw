                    Member
                        Include('c25_NetObjectClass.inc'), once
                        Map
                            Include('i64.inc')
                            Include('c25_Prototypes_WinApi32.clw')
                        End

c25NetObjectClass.Construct                     Procedure()

    Code

        Self.IsFree = 1
        Self.Logger                     &= NEW LoggerClass()
        Self.CRLF                       = Chr(13) & Chr(10)
        Self.BytesHandler               &= NEW BytesHandlerClass()
        Self.WinApi                     &= NEW WinApi32Class()
        Self.St1                        &= NEW StringTheory()
        Self.St2                        &= NEW StringTheory()
        Self.StSend                     &= NEW StringTheory()
        If not Self.WinApi.GlobalMem &= null
            Self.GlobalNanoSync &= Self.WinApi.GlobalMem.NanoSync
        End
        Self.NanoSync                   &= NEW NanoSyncClass()
        Self.NetObjectSettings          &= NULL
        Self.TrueReflection             &= NEW TrueReflectionClass()

        Self.Logger.ClassName           = 'c25NetObjectClass'
        
        Self.Machine                    &= NEW MachineClass()
        !Self.Machine.CreateHardwareObjects()
        Self.MachineQ                   &= NEW MachineQ_TYPE
        
        
c25NetObjectClass.Destruct                      Procedure()

    Code

c25NetObjectClass.GetPhaseEnumName  Procedure(Long _enumPhaseId)

    Code

        Case _enumPhaseId
        Of NetPhase:TryOpenConnection
            Return 'TryOpenConnection'
        Of NetPhase:SendHello
            Return 'SendHello'
        Of NetPhase:SendingHello
            Return 'SendingHello'
        Of NetPhase:WaitForHelloResponse
            Return 'WaitForHelloResponse'
        Of NetPhase:TryOpenListener
            Return 'TryOpenListener'
        Of NetPhase:Listen
            Return 'Listen'
        Of NetPhase:Idle
            Return 'Idle'
        End
        Return ''

c25NetObjectClass.c25_OpenConnection            Function(Long _lParam, <Byte _debug>)

Code

    If _debug
        Self.Logger.LogLine         = 'START'
        Self.Logger.Value           = ''
        Self.Logger.MethodName      = 'c25_OpenConnection'
        Self.Logger.LastPhase       = ''
        Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
        Self.Logger.NextPhase      = ''
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End
    If _lParam <> 0
    End
    If Self.NetObjectSettings &= null
        Self.NetObjectSettings                                           &= NEW NetSimpleObject_TYPE()
        Self.NetObjectSettings.Protocol                                   = 2
        Self.NetObjectSettings.BindToDomainName                          &= Self.BytesHandler.BinaryCopy('filesrv.allmydrives.com')
        Self.NetObjectSettings.BindToIps                                 &= Self.BytesHandler.BinaryCopy('212.8.240.8')
        Self.NetObjectSettings.SuppressErrorMsg                           = True
        Self.NetObjectSettings.AsyncOpenUse                               = True
        Self.NetObjectSettings.Log                                        = True
        Self.NetObjectSettings.AsyncOpenTimeOut                           = 10000
        Self.NetObjectSettings.InActiveTimeout                            = 0
        Self.NetObjectSettings.Open                                       = True
        Self.NetObjectSettings.Port                                       = 433
        Self.NetObjectSettings.SSL                                        = 0
        Self.NetObjectSettings.CertificateFile                           &= Self.BytesHandler.BinaryCopy('.\cert\filesrv.allmydrives.com.crt')
        Self.NetObjectSettings.PrivateKeyFile                            &= Self.BytesHandler.BinaryCopy('.\cert\filesrv.allmydrives.com.key')
        Self.NetObjectSettings.DontVerifyRemoteCertificateWithCARoot      = True
        Self.NetObjectSettings.DontVerifyRemoteCertificateCommonName      = 0
        Self.NetObjectSettings.CARootFile                                &= Self.BytesHandler.BinaryCopy('.\cert\caroot.pem')
        Self.NetObjectSettings.SSLDontConnectOnOpen                       = 0
        !Self.NetObjectSettings.RemoteIp                                  &= Self.BytesHandler.BinaryCopy('212.8.240.80')
        Self.NetObjectSettings.RemoteIp                                  &= Self.BytesHandler.BinaryCopy('127.0.0.1')
        Self.NetObjectSettings.RemotePort                                 = 433
    End
    Self.NetObject.SuppressErrorMsg                                             = Self.NetObjectSettings.SuppressErrorMsg
    Self.NetObject.AsyncOpenUse                                                 = Self.NetObjectSettings.AsyncOpenUse
    Self.NetObject.AsyncOpenTimeOut                                             = Self.NetObjectSettings.AsyncOpenTimeOut
    Self.NetObject.InActiveTimeout                                              = Self.NetObjectSettings.InActiveTimeout
    Self.NetObject.SSL                                                          = Self.NetObjectSettings.SSL
    Self.NetObject.SSLCertificateOptions.CertificateFile                        = Self.NetObjectSettings.CertificateFile
    Self.NetObject.SSLCertificateOptions.PrivateKeyFile                         = Self.NetObjectSettings.PrivateKeyFile
    Self.NetObject.SSLCertificateOptions.DontVerifyRemoteCertificateWithCARoot  = Self.NetObjectSettings.DontVerifyRemoteCertificateWithCARoot
    Self.NetObject.SSLCertificateOptions.DontVerifyRemoteCertificateCommonName  = Self.NetObjectSettings.DontVerifyRemoteCertificateCommonName
    Self.NetObject.SSLCertificateOptions.CARootFile                             = Self.NetObjectSettings.CARootFile
    Self.NetObject._SSLDontConnectOnOpen                                        = Self.NetObjectSettings.SSLDontConnectOnOpen

    Self.SimpleAsyncOpenSuccessful = 0
    Self.Phase = NetPhase:TryOpenConnection
    If _debug
        Self.Logger.LogLine         = 'End'
        Self.Logger.Value           = ''
        Self.Logger.MethodName      = 'c25_OpenConnection'
        Self.Logger.LastPhase       = ''
        Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
        Self.Logger.NextPhase      = ''
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End
    Self.NetObject.Open(Self.NetObjectSettings.RemoteIp, Self.NetObjectSettings.RemotePort)

    Self.Logger.ClearVariables()
    Self.Logger.LogLine = 'OK Self.NetObject.Open'
    Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)

    Self.StSend.Start()
    Self.StSend.Append('hello')
    Self.NetObject.Send(Self.StSend)

    Return True

c25NetObjectClass.c25_SendData                  Function(<*StringTheory _st>, <Long _lParam>, <String _fromIp>, <String _toIp>, <Long _onSocket>, <Long _toPort>, <Byte _debug>)

Code

    If omitted(_toIp) = False
        Self.NetObject.Packet.ToIP = _toIp
    End
    If omitted(_onSocket) = False
        Self.NetObject.Packet.OnSocket = _onSocket
    End    
    
    If _debug
        Self.Logger.ClearVariables()
        Self.Logger.PacketTypeEnum = Self.NetObject.Packet.PacketType
        Self.Logger.PacketType     = Self.GetEnumNamePacketType(Self.Logger.PacketTypeEnum)
        Self.Logger.FromIp         = _fromIp
        Self.Logger.ToIp           = _toIp
        Self.Logger.RemoteIp       = Self.NetObject._qServerConnections.RemoteIp
        Self.Logger.RemotePort     = Self.NetObject._qServerConnections.RemotePort
        Self.Logger.OnSocket       = _onSocket
        Self.Logger.SocketId       = Self.NetObject.Packet.SockID
        Self.Logger.DataLen        = Self.NetObject.Packet.BinDataLen
        Self.Logger.LogLine         = 'START'
        Self.Logger.Value           = Self.NetObject.Packet.ToIP & ', ' & Self.NetObject.Packet.OnSocket
        Self.Logger.MethodName      = 'c25_SendData'
        Self.Logger.LastPhase       = ''
        Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
        Self.Logger.NextPhase      = ''
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End


    If _lParam <> 0
        Self.StSend.Start()
        Self.StSend.Append(Self.BytesHandler.StringRefPtrToString(_lParam))
        Self.Logger.LogLine = '_lParam <> 0 StSend :'
        Self.Logger.Value = Self.StSend.GetValue()
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End

    Self.NetObject.DontErrorTrapInSendIfConnectionClosed = True
    If omitted(_st) = False
        Self.NetObject.Send(_st)
    Else
        Self.NetObject.Send(Self.StSend)
    End
    
    If Self.NetObject.Error = ERROR:ClientNotConnected
        If _debug
            Self.Logger.LogLine         = 'ERROR Self.NetObject.Error = ERROR:ClientNotConnected'
            Self.Logger.Value           = ''
            Self.Logger.MethodName      = 'c25_SendData'
            Self.Logger.LastPhase       = ''
            Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
            Self.Logger.NextPhase      = ''
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
        End
    Else
        If _debug
            Self.Logger.LogLine         = 'OK Self.NetObject.Error NOT ERROR:ClientNotConnected'
            Self.Logger.Value           = ''
            Self.Logger.MethodName      = 'c25_SendData'
            Self.Logger.LastPhase       = ''
            Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
            Self.Logger.NextPhase      = ''
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
        End
    End
    Return True

c25NetObjectClass.GetEnumNamePacketType     Procedure(Long _packetType)

Code

    Case Self.NetObject.Packet.PacketType
    Of NET:SimpleClient
        Return 'NET:SimpleClient'
    Of NET:SimpleServer
        Return 'NET:SimpleServer'
    Of NET:SimpleNewConnection
        Return 'NET:SimpleNewConnection'
    Of NET:SimpleDataPacket
        Return 'NET:SimpleDataPacket'
    Of NET:SimpleNoConnection
        Return 'NET:SimpleNoConnection'
    Of NET:SimpleSocketClosedPacket1
        Return 'NET:SimpleSocketClosedPacket1'
    Of NET:SimpleSocketClosedPacket2
        Return 'NET:SimpleSocketClosedPacket2'
    Of NET:SimpleAsyncOpenSuccessful
        Return 'NET:SimpleAsyncOpenSuccessful'
    Of NET:SimpleAsyncOpenFailed
        Return 'NET:SimpleAsyncOpenFailed'
    Of NET:SimpleIdleConnection
        Return 'NET:SimpleIdleConnection'
    Of NET:SimplePartialDataPacket
        Return 'NET:SimplePartialDataPacket'
    Of NET:SimpleBannedConnection
        Return 'NET:SimpleBannedConnection'
    ELSE
    End
    Return ''

c25NetObjectClass.QueryStatus                   Procedure(Long _lParam, <Byte _debug>)

    Code

        Self.StatusCode = 0
        Case _lParam
        Of NetQueryStatus:IsOpen
            Self.StatusCode = Self.SimpleAsyncOpenSuccessful
        End
        Return Self.StatusCode

c25NetObjectClass.Process                       Procedure(<Byte _debug>)

Code

    If _debug
        Case Self.NetObject.Packet.PacketType
        Of NET:SimpleDataPacket
        Else        
            Self.Logger.ClearVariables()
            Self.Logger.PacketTypeEnum = Self.NetObject.Packet.PacketType
            Self.Logger.PacketType     = Self.GetEnumNamePacketType(Self.Logger.PacketTypeEnum)
            Self.Logger.FromIp         = Self.NetObject.Packet.FromIP
            Self.Logger.ToIp           = Self.NetObject.Packet.ToIP
            Self.Logger.RemoteIp       = Self.NetObject._qServerConnections.RemoteIp
            Self.Logger.RemotePort     = Self.NetObject._qServerConnections.RemotePort
            Self.Logger.OnSocket       = Self.NetObject.Packet.OnSocket
            Self.Logger.SocketId       = Self.NetObject.Packet.SockID
            Self.Logger.DataLen        = Self.NetObject.Packet.BinDataLen
            Self.Logger.LogLine         = 'START'
            Self.Logger.Value           = ''
            Self.Logger.MethodName      = 'Process'
            Self.Logger.LastPhase       = ''
            Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
            Self.Logger.NextPhase      = ''
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
        End
    End

    Case Self.NetObject.Packet.PacketType
    Of NET:SimpleClient
    OrOf NET:SimpleDataPacket
    OrOf NET:SimpleAsyncOpenSuccessful
    OrOf NET:SimplePartialDataPacket
        Case Self.Phase
        Of NetPhase:TryOpenConnection
            Self.SimpleAsyncOpenSuccessful = True
            Self.Phase = NetPhase:Idle
            If _debug
                Self.Logger.LogLine         = 'SET PHASE, SimpleAsyncOpenSuccessful'
                Self.Logger.Value           = Self.SimpleAsyncOpenSuccessful
                Self.Logger.LastPhase       = Self.GetPhaseEnumName(NetPhase:TryOpenConnection)
                Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
                Self.Logger.NextPhase       = ''
                Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
            End
        End
    End

    Case Self.NetObject.Packet.PacketType
    Of NET:SimpleClient
    Of NET:SimpleServer
    Of NET:SimpleNewConnection
        Case Self.Phase
        Of NetPhase:Listen
!            Self.LParam = Self.BytesHandler.StringToStringRefPtr(NetHdr_OK)
!            Self.c25_SendData( ,Self.LParam, ,Self.NetObject.Packet.FromIP,Self.NetObject.Packet.OnSocket , ,True)
        End
    Of NET:SimpleDataPacket
    Of NET:SimpleNoConnection
    Of NET:SimpleSocketClosedPacket1
    Of NET:SimpleSocketClosedPacket2
    Of NET:SimpleAsyncOpenSuccessful
    Of NET:SimpleAsyncOpenFailed
    Of NET:SimpleIdleConnection
        Self.NetObject.Abort()
    Of NET:SimplePartialDataPacket
    Of NET:SimpleBannedConnection
    End
    If _debug
        Case Self.NetObject.Packet.PacketType
        Of NET:SimpleDataPacket
        Else
            Self.Logger.LogLine         = 'End'
            Self.Logger.Value           = ''
            Self.Logger.MethodName      = 'Process'
            Self.Logger.LastPhase       = ''
            Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
            Self.Logger.NextPhase      = ''
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
        End
    End
    Return 0

c25NetObjectClass.PacketReceived                Procedure(<Byte _debug>)

Code

    If _debug
        Self.Logger.ClearVariables()
        Self.Logger.PacketTypeEnum = Self.NetObject.Packet.PacketType
        Self.Logger.PacketType     = Self.GetEnumNamePacketType(Self.Logger.PacketTypeEnum)
        Self.Logger.FromIp         = Self.NetObject.Packet.FromIP
        Self.Logger.ToIp           = Self.NetObject.Packet.ToIP
        Self.Logger.RemoteIp       = Self.NetObject._qServerConnections.RemoteIp
        Self.Logger.RemotePort     = Self.NetObject._qServerConnections.RemotePort
        Self.Logger.OnSocket       = Self.NetObject.Packet.OnSocket
        Self.Logger.SocketId       = Self.NetObject.Packet.SockID
        Self.Logger.DataLen        = Self.NetObject.Packet.BinDataLen

        Self.Logger.LogLine         = 'START'
        Self.Logger.Value           = ''
        Self.Logger.MethodName      = 'PacketReceived'
        Self.Logger.LastPhase       = ''
        Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
        Self.Logger.NextPhase      = ''
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End
    If Self.NetObject.WholePacket.Length() > 0
        Self.NetObject.Packet.ToIP = Self.NetObject.Packet.FromIP
        If _debug
            Self.Logger.LogLine         = 'Self.NetObject.WholePacket.Length()'
            Self.Logger.Value           = Self.NetObject.WholePacket.Length()
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
            Self.Logger.AddLogLine('Self.NetTcpWholePacket.Packet.FromIP'   ,  Self.NetObject.Packet.FromIP     ,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
            Self.Logger.AddLogLine('Self.NetTcpWholePacket.Packet.OnSocket' ,  Self.NetObject.Packet.OnSocket   ,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
            Self.Logger.AddLogLine('Self.NetTcpWholePacket.Packet.SockID'   ,  Self.NetObject.Packet.SockID     ,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
            Self.Logger.AddLogLine('Self.NetTcpWholePacket.Packet.ToIP'     ,  Self.NetObject.Packet.ToIP       ,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
            Self.Logger.AddLogLine('Self.NetObject.WholePacket.GetValue()', Self.NetObject.WholePacket.GetValue() , Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
        End
        Case Self.BytesHandler.GetHeaderGuid36(Self.NetObject.WholePacket)
        Of NetHdr_Machine
            Self.Logger.LogLine         = 'GetHeaderGuid36'
            Self.Logger.Value           = 'NetHdr_Machine'
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
            
            
            Self.St1.Start()
            
            Self.St1.Append(Self.NetObject.WholePacket.Slice(37, Self.NetObject.WholePacket.Length() ))
            
!            !CreateHardwareObjects
!            If not Self.MachineQ &= NULL
!                Self.TrueReflection.DisposeQFields(Self.MachineQ)
!                If not Self.MachineQ &= NULL
!                    Dispose(Self.MachineQ)
!                End
!            End
!            
!            Self.MachineQ &= NEW MachineQ_TYPE
!            Add(Self.MachineQ)
!            Self.TrueReflection.CreateSubQueues(Self.MachineQ)
!            Put(Self.MachineQ)
!            Self.TrueReflection.DeSerializeQueue(Self.MachineQ, Self.St1)
!            Put(Self.MachineQ)
            
            Self.Logger.LogLine         = 'START'
            Self.Logger.Value           = 'Self.TrueReflection.DeSerializeQueues(Self.St1)'
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
          
            !Self.TrueReflection.DeSerializeQueues(Self.St1)
            
            Self.Logger.LogLine         = 'End'
            Self.Logger.Value           = 'Self.TrueReflection.DeSerializeQueues(Self.St1)'
            Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
          
            
            
            
            !Self.Machine.DeSerialize(Self.St1)
            
!            Get(Self.MachineQ.BiosBoardCpu,1)
!            
!            !Self.Machine.CreateHardwareObjects()
!            
!            Message(Self.MachineQ.BiosBoardCpu.BiosVendor & ', ' & Self.MachineQ.BiosBoardCpu.BiosSerial)
        End
        
!        Case Self.Phase
!        Of NetPhase:WaitForHelloResponse
!            Case Self.BytesHandler.GetHeaderGuid36(Self.NetObject.WholePacket)
!            Of NetHdr_OK
!                Self.Phase = NetPhase:IDLE
!                Self.Logger.AddLogLine('Self.BytesHandler.GetHeaderGuid36(Self.NetObject.WholePacket)', Self.GetPhaseEnumName(Self.Phase) ,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
!            End
!        End
!        If _debug = TRUE
!            Self.St1.Start()
!            Self.St1.Append('hello weer terug from clientfileserver')
!            Self.Logger.AddLogLine('try Self.NetClient.Send()', Self.St1.GetValue() ,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
!        End
    Else
        If _debug = TRUE
            Self.Logger.PostLogLine('Self.NetObject.Error : ' & Self.NetObject.Error , Self.Logger.Module, , 'PacketReceived')
        End
    End
    If _debug
        Self.Logger.LogLine         = 'End'
        Self.Logger.Value           = ''
        Self.Logger.MethodName      = 'PacketReceived'
        Self.Logger.LastPhase       = ''
        Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
        Self.Logger.NextPhase      = ''
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End
    Return 0

c25NetObjectClass.c25_StartListener Function(Long _lParam, <Byte _debug>)

Code

    If _debug
        Self.Logger.LogLine         = 'START'
        Self.Logger.Value           = ''
        Self.Logger.MethodName      = 'c25_StartListener'
        Self.Logger.LastPhase       = ''
        Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
        Self.Logger.NextPhase      = ''
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End
    If _lParam <> 0
    End
    If Self.NetObjectSettings &= null
        Self.NetObjectSettings                                           &= NEW NetSimpleObject_TYPE()
        Self.NetObjectSettings.Protocol                                   = 2
        Self.NetObjectSettings.BindToDomainName                          &= Self.BytesHandler.BinaryCopy('filesrv.allmydrives.com')
        !Self.NetObjectSettings.BindToIps                                 &= Self.BytesHandler.BinaryCopy('212.8.240.80')
        Self.NetObjectSettings.BindToIps                                 &= Self.BytesHandler.BinaryCopy('127.0.0.1')
        Self.NetObjectSettings.SuppressErrorMsg                           = False
        Self.NetObjectSettings.AsyncOpenUse                               = False
        Self.NetObjectSettings.Log                                        = True
        Self.NetObjectSettings.AsyncOpenTimeOut                           = 1200
        Self.NetObjectSettings.InActiveTimeout                            = 0
        Self.NetObjectSettings.Open                                       = True
        Self.NetObjectSettings.Port                                       = 433
        Self.NetObjectSettings.SSL                                        = 0
        Self.NetObjectSettings.CertificateFile                           &= Self.BytesHandler.BinaryCopy('.\cert\filesrv.allmydrives.com.crt')
        Self.NetObjectSettings.PrivateKeyFile                            &= Self.BytesHandler.BinaryCopy('.\cert\filesrv.allmydrives.com.key')
        Self.NetObjectSettings.DontVerifyRemoteCertificateWithCARoot      = True
        Self.NetObjectSettings.DontVerifyRemoteCertificateCommonName      = 0
        Self.NetObjectSettings.CARootFile                                &= Self.BytesHandler.BinaryCopy('.\cert\caroot.pem')
        Self.NetObjectSettings.SSLDontConnectOnOpen                       = 0
    End
    If Self.NetObject &= NULL
        Message('error NetObject is null')
        Return 0
    ELSE
    End
    Self.NetObject.SuppressErrorMsg                                             = Self.NetObjectSettings.SuppressErrorMsg
    Self.NetObject.AsyncOpenUse                                                 = Self.NetObjectSettings.AsyncOpenUse
    Self.NetObject.AsyncOpenTimeOut                                             = Self.NetObjectSettings.AsyncOpenTimeOut
    Self.NetObject.InActiveTimeout                                              = Self.NetObjectSettings.InActiveTimeout
    Self.NetObject.SSL                                                          = Self.NetObjectSettings.SSL
    Self.NetObject.SSLCertificateOptions.CertificateFile                        = Self.NetObjectSettings.CertificateFile
    Self.NetObject.SSLCertificateOptions.PrivateKeyFile                         = Self.NetObjectSettings.PrivateKeyFile
    Self.NetObject.SSLCertificateOptions.DontVerifyRemoteCertificateWithCARoot  = Self.NetObjectSettings.DontVerifyRemoteCertificateWithCARoot
    Self.NetObject.SSLCertificateOptions.DontVerifyRemoteCertificateCommonName  = Self.NetObjectSettings.DontVerifyRemoteCertificateCommonName
    Self.NetObject.SSLCertificateOptions.CARootFile                             = Self.NetObjectSettings.CARootFile
    Self.NetObject._SSLDontConnectOnOpen                                        = Self.NetObjectSettings.SSLDontConnectOnOpen
    Self.NetObject._Connection.MaxServerConnections = 0
    Self.Phase = NetPhase:Listen
    !Self.NetObject.Open('212.8.240.80',Self.NetObjectSettings.Port)
    Self.NetObject.Open('127.0.0.1',Self.NetObjectSettings.Port)
    If _debug
        Self.Logger.LogLine         = 'End'
        Self.Logger.Value           = ''
        Self.Logger.MethodName      = 'c25_StartListener'
        Self.Logger.LastPhase       = ''
        Self.Logger.Phase           = Self.GetPhaseEnumName(Self.Phase)
        Self.Logger.NextPhase      = ''
        Self.Logger.AddLogLine(Self.Logger.LogLine, Self.Logger.Value,Self.Logger.Module, Self.Logger.ClassName, Self.Logger.MethodName, Self.Logger.LastPhase, Self.Logger.Phase, Self.Logger.NextPhase)
    End
    Return True

