        Member

            Include('c25_LogThreadClass.inc'),once

                        MAP
                            Include('c25_Prototypes_WinApi32.clw')
                            Include('i64.inc')

                        End

LogClass.Construct                     Procedure()

    Code

        Self.CRLF           = Chr(13) & Chr(10)
        Self.LogInfoDimQ   &= NEW LogInfoDim_TYPE()
        Self.NanoSync      &= NEW NanoSyncClass()
        Self.WinApi        &= NEW WinApi32Class()

LogClass.Destruct                      Procedure()

    Code

LogClass.AddLine    Procedure(String _uniqueLogName, String _line)

LogInfo                 Group(LogInfo_TYPE),Pre(LogInfo)
                        End
LogLinesQ               &LogLines_TYPE

    Code

        If Self.LogInfoDimQ &= NULL
            Return ''
        End

        F# = 0
        I# = 0
        Loop
            I# = I# + 1
            Get(Self.LogInfoDimQ,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Lower(Clip(Left(Self.LogInfoDimQ.UniqueName))) <> Lower(Clip(Left(_uniqueLogName)))
                CYCLE
            End
            F# = I#
            Break
        End
        If F# = 0
            Return ''
        End
        If Self.LogInfoDimQ.Index < 1 Or Self.LogInfoDimQ.Index > Maximum(Self.LogInfoArray,1)
            Return ''
        End
        If Self.LogInfoArray[Self.LogInfoDimQ.Index].WaitTimeOut > 0
            Self.NanoSync.Timeout = Self.NanoSync.CalcSysTimeout(0,0,1,0)
            Loop
                If Self.LogInfoArray[Self.LogInfoDimQ.Index].WaitTimeOut = 0
                    BREAK
                End
                If Self.NanoSync.Timeout < Self.NanoSync.GetSysTime()
                    Break
                End
                c25_sleepex(50,0)
            End
        End

        LogInfo = Self.LogInfoArray[Self.LogInfoDimQ.Index]

        Case LogInfo.LogLinesQCurrentId
        Of 2
            LogLinesQ &= LogInfo.LogLinesQ2
        Else
            LogLinesQ &= LogInfo.LogLinesQ1
        End
        LogInfo.LineCounter             = LogInfo.LineCounter + 1

        LogLinesQ.TimeStamp             = Self.NanoSync.GetSysTime()
        LogLinesQ.PrintTimeStamp        = True
        LogLinesQ.LineCounter           = LogInfo.LineCounter
        If not LogLinesQ.Line &= NULL
            Dispose(LogLinesQ.Line)
        End
        L# = Len(_line)
        If L# < 0
            LogLinesQ.Line &= NEW String(LEN('<EMPTY LINE>') + 2)
            LogLinesQ.Line = '<EMPTY LINE>' & Self.CRLF
        ELSE
            LogLinesQ.Line &= NEW String(L# + 2)
            LogLinesQ.Line = _line & Self.CRLF
        End
        Add(LogLinesQ)
        Self.LogInfoArray[Self.LogInfoDimQ.Index] = LogInfo

        LogLinesQ &= null
        Return ''

LogClass.CreateNewLog       Procedure(<String _uniqueName>, <String _filenameUtf8>, <String _pathUtf8>, <Byte _append>, <Byte _deleteOldLog>, <String _flushInterval>, <String _flushIntervalUnits>, <String _extraJson>)

FlushIntervalUnits              cstring('seconds')
FlushInterval                   decimal(20)
FlushIntervalInNanoSeconds      decimal(20)
PathUtf16                       &String
LogInfo                         Group(LogInfo_TYPE),Pre(LogInfo)
                                End
ThreadId                        Long

    Code

        I# = 0
        M# = Maximum(Self.LogInfoArray,1)
        F# = 0
        Loop M# TIMES
            I# = I# + 1
            If Self.LogInfoArray[I#].ThreadHandle <> 0
                CYCLE
            End
            F# = True
            BREAK
        End
        If F# = 0
            Return 0
        End

        Clear(LogInfo)
        LogInfo.Index = I#
        If omitted(_append) = False
            LogInfo.AppendLog       = _append
        Else
            LogInfo.AppendLog       = TRUE
        End
        If Omitted(_deleteOldLog) = False
            LogInfo.DeleteOldLog    = _deleteOldLog
        Else
            LogInfo.DeleteOldLog    = True
        End

        If omitted(_flushIntervalUnits) = False
            FlushIntervalUnits = _flushIntervalUnits
        End
        If omitted(_flushInterval) = False
            FlushInterval = _flushInterval
        Else
            FlushInterval = 3 ! defaults to 3 seconds
        End
        Case Lower(clip(FlushIntervalUnits))
        Of 'seconds'
        OrOf 'sec'
        OrOf 's'
            FlushIntervalInNanoSeconds = Self.NanoSync.CalcSysTimeout(0,0,FlushInterval,0)
        ELSE
            FlushIntervalInNanoSeconds = Self.NanoSync.CalcSysTimeout(0,0,FlushInterval,0)
        End
        LogInfo.FlushIntervalNano = FlushIntervalInNanoSeconds

        If omitted(_uniqueName)
            LogInfo.UniqueName &= Self.WinApi.AnsiToAnsi(Self.NanoSync.GetSysTime())
        ELSE
            LogInfo.UniqueName = Clip(Left(_uniqueName))
        End

        If omitted(_filenameUtf8)
            LogInfo.FileNameUtf16 &= Self.WinApi.AnsiToUtf16(LogInfo.UniqueName  & '_log.txt')
        ELSE
            LogInfo.FileNameUtf16 &= Self.WinApi.Utf8ToUtf16(_filenameUtf8)
        End

        If omitted(_pathUtf8)
            PathUtf16 &= Self.WinApi.AnsiToUtf16('./')
        ELSE
            PathUtf16 &= Self.WinApi.Utf8ToUtf16(_pathUtf8)
        End

        LogInfo.FullPathUtf16       &= Self.WinApi.ConcatUtf16(False, , PathUtf16, '/' & Chr(0) , LogInfo.FileNameUtf16, Chr(0) & Chr(0))
        LogInfo.FullPathAnsi        &= Self.WinApi.Utf16ToAnsi(LogInfo.FullPathUtf16)

        LogInfo.ThisAddress          = Address(Self.LogInfoArray[I#])
        LogInfo.LogLinesQ1          &= NEW LogLines_TYPE
        LogInfo.LogLinesQ2          &= NEW LogLines_TYPE
        LogInfo.LogLinesQCurrentId   = 1
        LogInfo.LogLinesQ1.Line     &= NEW String(LEN('TEST LINE') + 2)
        LogInfo.LogLinesQ1.Line      = 'Test LINE' & Self.CRLF
        Add(LogInfo.LogLinesQ)

        Self.LogInfoArray[I#]       = LogInfo

        Self.LogInfoDimQ.Index      = I#
        Self.LogInfoDimQ.UniqueName = LogInfo.UniqueName
        Add(Self.LogInfoDimQ)
        Sort(Self.LogInfoDimQ,+Self.LogInfoDimQ.UniqueName)

        Message('start thread')
        Self.LogInfoArray[I#].ThreadHandle = c25_CreateThread(0, 010000h, Address(ThreadLogHandler), LogInfo.ThisAddress, 0,Address(ThreadId))
        Self.LogInfoArray[I#].ThreadId = ThreadId
        Message('started thread ' & ThreadId)
        Return I#

LogClass.GetByUniqueName      Procedure(String _uniqueName)

    Code

        Self.LogInfoDimQ.UniqueName = _uniqueName
        Get(Self.LogInfoDimQ,+Self.LogInfoDimQ.UniqueName)
        If Errorcode() = 0
            Return Self.LogInfoDimQ.Index
        End
        Return 0

LogClass.GetByIndex      Procedure(Long _index)

    Code

        Self.LogInfoDimQ.Index = _index
        Get(Self.LogInfoDimQ,+Self.LogInfoDimQ.Index)
        If Errorcode() = 0
            Return Self.LogInfoDimQ.UniqueName
        End
        Return ''

ThreadLogHandler                   Procedure(Long _paramA, Long _logInfoAddress)

FlushIntervalUnits                      cstring('seconds')
FlushInterval                           decimal(20)
FlushIntervalInNanoSeconds              decimal(20)
PathUtf16                               &String
LogInfo                                 Group(LogInfo_TYPE),Pre(LogInfo)
                                        End
ThreadId                                Long
st1                                     &StringTheory()
LogLinesQ                               &LogLines_TYPE
NanoSync                                &NanoSyncClass
LogLinesQCopy                           &LogLines_TYPE
CRLF                                    String(2)

    Code

        c25_Attachthreadtoclarion(True)

        CRLF = Chr(13) & Chr(10)
        LogLinesQCopy &= NEW LogLines_TYPE()
        NanoSync &= NanoSyncClass()
        st1 &= NEW StringTheory()
        st1.Start()
        c25_memcpy(Address(LogInfo),_logInfoAddress,Size(LogInfo))
        Message(LogInfo.UniqueName)
        st1.Append('start log ' & LogInfo.Index & ', ' & LogInfo.UniqueName & CRLF)
        st1.SaveFile(LogInfo.PathUtf16,true)
        Loop
            Message('LogInfo.LogLinesQCurrentId ' & LogInfo.LogLinesQCurrentId)
            Case LogInfo.LogLinesQCurrentId
            Of 2
                LogLinesQ &= LogInfo.LogLinesQ2
            Else
                LogLinesQ &= LogInfo.LogLinesQ1
            End
            If Records(LogLinesQ) > 0
                LogInfo.WaitTimeOut = True
                c25_memcpy(_logInfoAddress,Address(LogInfo),Size(LogInfo))
                Case LogInfo.LogLinesQCurrentId
                Of 2
                    LogInfo.LogLinesQCurrentId = 1
                Else
                    LogInfo.LogLinesQCurrentId = 2
                End
                c25_memcpy(_logInfoAddress,Address(LogInfo),Size(LogInfo))

                I# = 0
                Loop
                    I# = I# + 1
                    Get(LogLinesQ,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    LogLinesQCopy = LogLinesQ
                    Add(LogLinesQCopy)
                End
                Free(LogLinesQ)

                LogInfo.WaitTimeOut = False
                c25_memcpy(_logInfoAddress,Address(LogInfo),Size(LogInfo))
                I# = 0
                Loop
                    I# = I# + 1
                    Get(LogLinesQCopy,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If not LogLinesQCopy.Line &= null
                        st1.Append(LogLinesQCopy.Line)
                    End
                End
                Free(LogLinesQCopy)
                st1.SaveFile(LogInfo.PathUtf16,true)
            End
            c25_sleepex(3000,0)
        End

        Return 0

