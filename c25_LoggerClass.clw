        Member

            Include('c25_LoggerClass.inc'),once

                        MAP
                            Include('c25_Prototypes_WinApi32.clw')
                            Include('i64.inc')

                            Module('c25_LoggerClass.clw')
!ThreadLogHandler                Procedure(Long _paramA, Long _paramB),Long
                            End
                        End

LoggerClass.Construct                     Procedure()

    Code

!        Self.CRLF               = Chr(13) & Chr(10)
!        Self.LogRecord          &= NEW LogLines_TYPE()
!        Self.LogLinesBuffer     &= NEW LogLines_TYPE()
!        Self.NanoSync           &= NEW NanoSyncClass()
!        Self.BytesHandler       &= NEW BytesHandlerClass()
!        Self.WinApi             &= NEW WinApi32Class()
!        !Self.TrueReflection     &= NEW TrueReflectionClass()
!        Self.SetLogClientWinHandle()
        
LoggerClass.Destruct                      Procedure()

    Code


LoggerClass.SetLogClientWinHandle   Procedure()

    Code
        
        If Self.LogClientWinHandle = 0
!            If Self.WinApi.GlobalMem &= NULL
!                Message('Self.WinApi.GlobalMem still null')
!            End
            Self.LogClientWinHandle = Self.WinApi.GetGlobalDictionaryValue('LogClientWinHandle')
            If Self.LogClientWinHandle = 0
                Return 0
            End
        End        
        Return Self.LogClientWinHandle
        
LoggerClass.PostLogLine   Procedure(String _line, <String _module>,<String _threadName>, <String _functionName>)


    Code
        
!        If Self.LogClientWinHandle = 0
!            Self.SetLogClientWinHandle()
!            If Self.LogClientWinHandle = 0
!                Return 0
!            End
!        End
!        If Self.LogRecord &= NULL
!            Message('error Self.LogRecord is null')
!            Return 0
!        End
!        !Self.Clear_LogLineQ(Self.LogRecord)
!        !Clear( Self.LogRecord)
!        !Self.TrueReflection.DisposeQFields(Self.LogRecord)
!        Free(Self.LogRecord)
!        
!        Clear(Self.LogRecord)
!        
!        Self.LogRecord.Line         &= Self.BytesHandler.BinaryCopy(_line)
!        Self.LogRecord.TimeStamp    = Self.NanoSync.GetSysTime()
!        Self.LogRecord.TimeStampFormatted    = Self.NanoSync.DecToSQL_TIMESTAMP_STRUCT_TIMEONLY(Format(Self.LogRecord.TimeStamp,@N020),True)
!        
!        If OMITTED(_module) = False
!            Self.LogRecord.Module = _module
!        End
!        If OMITTED(_threadName) = False
!            !Self.LogRecord.ThreadName = _threadName
!        End
!        If OMITTED(_functionName) = False
!            Self.LogRecord.MethodName = _functionName
!        End
!        
!        Self.PostLogRecord()

        Return 0        
        
        
LoggerClass.AddLogLine   Procedure(String _logLine, <String _value>, <String _module>,<String _className>, <String _methodName>,<String _lastPhase>, <String _phase>, <String _nextPhase>)


    Code
        
!        If Self.LogClientWinHandle = 0
!            Self.SetLogClientWinHandle()
!            If Self.LogClientWinHandle = 0
!                Return 0
!            End
!        End
!        If Self.LogRecord &= NULL
!            Message('error Self.LogRecord is null')
!            Return 0
!        End
!        !Self.Clear_LogLineQ(Self.LogRecord)
!        !Clear( Self.LogRecord)
!        !Self.TrueReflection.DisposeQFields(Self.LogRecord)
!        Free(Self.LogRecord)
!        Clear(Self.LogRecord)
!        
!        Self.LogRecord.Line                     &= Self.BytesHandler.BinaryCopy(_logLine)
!        Self.LogRecord.TimeStamp                = Self.NanoSync.GetSysTime()
!        Self.LogRecord.TimeStampFormatted       = Self.NanoSync.DecToSQL_TIMESTAMP_STRUCT_TIMEONLY(Format(Self.LogRecord.TimeStamp,@N020),True)
!        
!        If OMITTED(_value) = False
!            Self.LogRecord.Value = _value
!        End
!        
!        If OMITTED(_module) = False
!            Self.LogRecord.Module = _module
!        Else
!            Self.LogRecord.Module = Self.Module
!        End
!        
!        If OMITTED(_className) = False
!            Self.LogRecord.ClassName = _className
!        End
!        
!        If OMITTED(_methodName) = False
!            Self.LogRecord.MethodName = _methodName
!        End
!        
!        If OMITTED(_className) = False
!            Self.LogRecord.ClassName = _className
!        End
!        
!        If OMITTED(_lastPhase) = False
!            Self.LogRecord.LastPhase = _lastPhase
!        End
!        
!        If OMITTED(_phase) = False
!            Self.LogRecord.Phase = _phase
!        End
!        
!        If OMITTED(_nextPhase) = False
!            Self.LogRecord.NextPhase = _nextPhase
!        End
!
!        Self.LogRecord.PacketTypeEnum   = Self.PacketTypeEnum
!        Self.LogRecord.PacketType       = Self.PacketType
!        Self.LogRecord.FromIp           = Self.FromIp
!        Self.LogRecord.ToIp             = Self.ToIp
!        Self.LogRecord.RemoteIp         = Self.RemoteIp
!        Self.LogRecord.RemotePort       = Self.RemotePort
!        Self.LogRecord.OnSocket         = Self.OnSocket
!        Self.LogRecord.SocketId         = Self.SocketId
!        Self.LogRecord.DataLen          = Self.DataLen
!
!        Self.PostLogRecord()

        Return 0
        
        
LoggerClass.ClearVariables  Procedure()

    Code
        
        Clear(Self.PacketTypeEnum)
        Clear(Self.PacketType)
        Clear(Self.FromIp)
        Clear(Self.ToIp)
        Clear(Self.RemoteIp)
        Clear(Self.OnSocket)
        Clear(Self.SocketId)
        Clear(Self.DataLen)
        Clear(Self.LogLine)
        Clear(Self.Value)
        Clear(Self.ClassName)
        Clear(Self.MethodName)
        Clear(Self.LastPhase)
        Clear(Self.Phase)
        Clear(Self.NextPhase)
        
        

LoggerClass.PostLogRecord    Procedure()

    Code
        
        
        If Self.LogClientWinHandle = 0
            Self.SetLogClientWinHandle()
            If Self.LogClientWinHandle = 0
                Return 0
            End
        End
!            Self.LogClientWinHandle = Self.WinApi.GetGlobalDictionaryValue('LogClientWinHandle')
!            If Self.LogClientWinHandle = 0
!                If Self.StackBuffer
!                    Self.Copy(Self.LogLinesBuffer, Self.LogRecord)
!                    !Add(Self.LogLinesBuffer)
!                    !Self.Clear_LogLineQ(Self.LogRecord)                    
!                End
!                Return 0
!            End
!        End

        Self.Copy(Self.LogLinesBuffer, Self.LogRecord)
        !Add(Self.LogLinesBuffer)
        !Self.Clear_LogLineQ(Self.LogRecord)

        Self.FlushBuffer()
        
        Return 0
        
        
LoggerClass.FlushBuffer         Procedure()

LogLinesRecord                  &LogLines_TYPE

    Code
        
        If Records(Self.LogLinesBuffer) = 0
            Return 0
        End
        
        I# = 0
        R# = Records(Self.LogLinesBuffer)
        Loop R# Times
            I# = I# + 1
            Get(Self.LogLinesBuffer,I#)
            If Errorcode() <> 0
                BREAK
            End
            LogLinesRecord &= NEW LogLines_TYPE
            Self.Copy(LogLinesRecord,Self.LogLinesBuffer,I#)
            LogLinesRecord.PID = c25_GetProcessId(c25_GetCurrentProcess())
            Ret# = c25_PostMessageA(Self.LogClientWinHandle, c25:LogLineQRec, 0, Self.BytesHandler.QueueRecordToStringRefPtr(LogLinesRecord))
            Dispose(LogLinesRecord)
        End
        Self.Clear_LogLineQ(Self.LogLinesBuffer)
        
        Return 0


LoggerClass.Copy  Procedure(*LogLines_TYPE _logLinesRecordTarget, *LogLines_TYPE _logLinesRecordSource, <Long _pointer>)

    Code
        
        If _logLinesRecordTarget &= NULL
            Message('error copy _logLinesRecordTarget is null')
            Return ''
        End
        If _logLinesRecordSource &= NULL
            Message('error copy _logLinesRecordSource is null')
            Return ''
        End        
        If omitted(_pointer) = False And _pointer > 0 And _pointer <= Records(_logLinesRecordSource)
            Get(_logLinesRecordSource,_pointer)
        End
        _logLinesRecordTarget = _logLinesRecordSource
        If not _logLinesRecordSource.Line &= null
            _logLinesRecordTarget.Line &= Self.BytesHandler.BinaryCopy(Clip(_logLinesRecordSource.Line))
        Else
            _logLinesRecordTarget.Line &= null
        End
        Add(_logLinesRecordTarget)
        
        Return ''        
        

LoggerClass.Clear_LogLineQ    Procedure(LogLines_TYPE _logLinesRecord)


    Code
        
        
        
        
        If _logLinesRecord &= NULL
            Return ''
        End
!        I# = 0
!        R# = Records(_logLinesRecord)
!        Loop R# Times
!            I# = I# + 1
!            Get(_logLinesRecord,I#)
!            If Errorcode() <> 0
!                BREAK
!            End            
!            If not _logLinesRecord.Line &= null
!                Dispose(_logLinesRecord.Line)
!            End
!            Clear(_logLinesRecord)
!            Put(_logLinesRecord)
!        End
        Free(_logLinesRecord)
        Return ''        
