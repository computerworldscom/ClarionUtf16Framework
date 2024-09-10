                Member
    Include('c25_NanoSyncClass.inc'), once
    Include('C25_Datatypes.Clw'),Once

                    Map
                        Include('i64.inc')
                        Include('c25_WinApiPrototypes.inc')
                    End

c25_NanoSyncClass.Construct              Procedure()

Code

    
    Self.ClassTypeName                      = 'c25_NanoSyncClass'
    Self.TimeOutQ                          &= New TimeOut_TYPE()
    Self.Str8Address                        = Address(Self.Str8)
    Self.Str8UTCAddress                     = Address(Self.Str8UTC)
    Self.DecNanosInOneHour                  = 3600000000000
    Self.DecNanosInOneMinute                = 60000000000
    Self.DecNanosInOneSecond                = 1000000000
    Self.DecNanosInOneMMSec                 = 1000000

    i64FromDecimal(Self.i64NanosInOneHour,Self.DecNanosInOneHour)
    i64FromDecimal(Self.i64NanosInOneMinute,Self.DecNanosInOneMinute)
    i64FromDecimal(Self.i64NanosInOneSecond,Self.DecNanosInOneSecond)
    i64FromDecimal(Self.i64NanosInOneMMSec,Self.DecNanosInOneMMSec)

    Self.CRLF = Chr(13) & Chr(10)
    
    Self.st1 &= NEW StringTheory()

    Self.LDecVal100 = 100
    i64FromDecimal(Self.Li64Val100,Self.LDecVal100)

    Self.MMSecondsInLDAPTimeDec = 10000
    i64FromDecimal(Self.MMSecondsInLDAPTime,Self.MMSecondsInLDAPTimeDec)

    Self.BitConverter &= NEW c25_BitConverterClass()
    

c25_NanoSyncClass.Destruct       Procedure()

    Code

c25_NanoSyncClass.InitLog                      Procedure(<string _logfileNameA>, <bool _logInMSecSinceLast>, <bool _create>)

Code

    If _create = 0
        return 0
    End
    
    If omitted(_logInMSecSinceLast) = FALSE
        Self.LogSinceLast = _logInMSecSinceLast
    ELSE
        Self.LogSinceLast = False
    End
    
    Self.Log &= NEW StringTheory()
    Self.Log.Start()
    
    Self.LogFileName &= Self.BitConverter.BinaryCopy(_logfileNameA)
    Remove(Self.LogFileName)
    
    Self.Log.SetValue(Format(Self.GetSysTime(),@N021) & ' : ' & 'InitLog' & Self.CRLF)
    
    Self.Log.SaveFile(Self.LogFileName, False)
    Self.LastSysTime = Self.GetSysTime()
    Return 0
        
c25_NanoSyncClass.WriteLog                      Procedure(string _line, <bool _write>)

Code

    If _write = 0
        return 0
    End
    
    If Self.LogSinceLast
        Self.Str20 = Self.GetSysTime() - Self.LastSysTime
        Self.Str20 = Right(Self.Str20)
        !Self.Log.SetValue(Self.Str20 & ' : ' & _line & Self.CRLF)
        
        
        Self.Log.SetValue(Self.Str20 & ' : ' & Self.FormatNanoSeconds(Self.GetSysTime(true)) & ' : ' & _line & Self.CRLF)
        
    Else
        Self.Log.SetValue(Self.GetSysTime() & ' : ' & _line & Self.CRLF)
    End
    Self.LastSysTime = Self.GetSysTime()
    Self.Log.SaveFile(Self.LogFileName, True)
    Return 0     
    
        
        
c25_NanoSyncClass.StartStopwatch                      Procedure()

    Code

        Self.StartStopWatchTime = Self.GetSysTime()
        Return Self.StartStopWatchTime

        
c25_NanoSyncClass.StopStopWatch                        Procedure(<bool _showSecs>)

    Code

        Self.StopStopWatchTime = Self.GetSysTime()
        Self.DurationStopWatchTime = Self.StopStopWatchTime - Self.StartStopWatchTime
        Self.DurationStopWatchTime = Self.DurationStopWatchTime !/ 10
        If _showSecs
            Return Self.FormatNanoSeconds(Self.DurationStopWatchTime)
        End
        Return Self.DurationStopWatchTime

        
c25_NanoSyncClass.FormatNanoSeconds     Procedure(String _dec, <bool _convertToLocal>)


DecInput            Decimal(21,0)
DecOutput           Decimal(21,0)
Int64Input          Like(INT64)
Int64SystemTime     Like(INT64)
Int64Output         Like(INT64)

Code

    DecInput = _dec

    If omitted(_convertToLocal) = False And _convertToLocal = True
        i64FromDecimal(Int64Input, DecInput)
        Self.Str8UTC = Int64Input
        c25_FileTimeToLocalFileTime(Self.Str8UTCAddress, Self.Str8Address)
        Int64Input = Self.Str8
        i64ToDecimal(DecInput, Int64Input)
    ELSE
        i64FromDecimal(Int64Input, DecInput)
        Self.Str8 = Int64Input
    End
    c25_FileTimeToSystemTime(Self.Str8Address,Address(Self.SYSTEMTIME))

    Self.st1.Start()
!    Self.st1.Append(Format(Self.SYSTEMTIME.wHour,@N02))
!    Self.st1.Append(':')
!    Self.st1.Append(Format(Self.SYSTEMTIME.wMinute,@N02))
!    Self.st1.Append(':')
!    Self.st1.Append(Format(Self.SYSTEMTIME.wSecond,@N02))
!
!    Self.st1.Append(' ')

    Self.st1.Append(Format(Self.SYSTEMTIME.wHour,@N02))
    Self.st1.Append(':')
    Self.st1.Append(Format(Self.SYSTEMTIME.wMinute,@N02))
    Self.st1.Append(':')
    Self.st1.Append(Format(Self.SYSTEMTIME.wSecond,@N02))

    Self.st1.Append('.')
    Self.SYSTEMTIME.wMilliseconds = 0

    c25_SystemTimeToFileTime(Address(Self.SYSTEMTIME), Self.Str8Address)
    Int64SystemTime = Self.Str8

    i64Sub(Int64Input, Int64SystemTime, Int64Output)
    i64ToDecimal(DecOutput, Int64Output)

    Self.st1.Append(Format(DecOutput,@N07))

    Return Self.st1.GetValue()
        
c25_NanoSyncClass.CalcSysTimeout              FUNCTION(Long _hr,Long _min,Long _sec,Long _mm)

Code

        Self.LAddHours = _hr
        Self.LAddMinutes = _min
        Self.LAddSeconds = _sec
        Self.LAddMM = _mm
        Self.LDecZero = 0
        i64FromDecimal(Self.Li64NanoToAdd,Self.LDecZero)
        c25_GetSystemTimePreciseAsFileTime(Address(Self.LSystemTimeAsFileTimeUINT64))
        i64FromDecimal(Self.Li64Hours,Self.LAddHours)
        i64FromDecimal(Self.Li64Minutes,Self.LAddMinutes)
        i64FromDecimal(Self.Li64Seconds,Self.LAddSeconds)
        i64FromDecimal(Self.Li64MM,Self.LAddMM)
        i64Mult(Self.Li64Hours,Self.i64NanosInOneHour,Self.Li64HoursInNanoUnits)
        i64Mult(Self.Li64Minutes,Self.i64NanosInOneMinute,Self.Li64MinutesInNanoUnits)
        i64Mult(Self.Li64Seconds,Self.i64NanosInOneSecond,Self.Li64SecondsInNanoUnits)
        i64Mult(Self.Li64MM,Self.i64NanosInOneMMSec,Self.Li64MMInNanoUnits)
        i64Add(Self.Li64NanoToAdd,Self.Li64HoursInNanoUnits)
        i64Add(Self.Li64NanoToAdd,Self.Li64MinutesInNanoUnits)
        i64Add(Self.Li64NanoToAdd,Self.Li64SecondsInNanoUnits)
        i64Add(Self.Li64NanoToAdd,Self.Li64MMInNanoUnits)
        i64Div(Self.Li64NanoToAdd,Self.Li64Val100,Self.Li64NanoToAdd)
        i64Add(Self.LSystemTimeAsFileTimeUINT64,Self.Li64NanoToAdd)
        i64ToDecimal(Self.LCalcDec,Self.LSystemTimeAsFileTimeUINT64)
        Return Self.LCalcDec


c25_NanoSyncClass.SetSystemTimeFromFileTime  Procedure(String _fileTimeStr8)

UniversalTime   Group(SYSTEMTIME_TYPE),Pre(UniversalTime)
                End
LocalTime       Group(SYSTEMTIME_TYPE),Pre(LocalTime)
                End
FileTimeStr8Out String(8)

Code

    Self.Str8 = _fileTimeStr8
    c25_FileTimeToSystemTime(Self.Str8Address,Address(Self.SYSTEMTIME))



    Return ''

c25_NanoSyncClass.ConvertUTCToLocal  Procedure(String _fileTimeStr8)

UniversalTime   Group(SYSTEMTIME_TYPE),Pre(UniversalTime)
                End
LocalTime       Group(SYSTEMTIME_TYPE),Pre(LocalTime)
                End
FileTimeStr8Out String(8)

NanoUniversalTime       Decimal(20)
NanoLocalTime           Decimal(20)
NanoDiffTime            Decimal(20)


Code

    Self.Str8 = _fileTimeStr8
    NanoUniversalTime = Self.GetNanoSecondsFromFILETIME(Self.Str8Address)
    c25_FileTimeToSystemTime(Self.Str8Address,Address(UniversalTime))
    c25_SystemTimeToTzSpecificLocalTime(0, Address(UniversalTime),  Address(LocalTime))
    C25_SystemTimeToFileTime(Address(LocalTime) ,Address(FileTimeStr8Out))
    Return FileTimeStr8Out

c25_NanoSyncClass.GetSysTime                      Procedure(<bool _convertToLocal>, <INT64 _int64>)


  Code

       c25_GetSystemTimePreciseAsFileTime(Address(Self.LDummyUINT64))
        i64ToDecimal(Self.LDec, Self.LDummyUINT64)
        If omitted(_int64) = FALSE
            i64FromDecimal(_int64, Self.LDec)
            !i64ToDecimal(Self.LDec, Self.LDummyUINT64)
        End
        Return Self.LDec

c25_NanoSyncClass.GetSysTimeInMSec                    Procedure(<bool _convertToLocal>)


Code

    c25_GetSystemTimePreciseAsFileTime(Address(Self.LDummyUINT64))
    i64ToDecimal(Self.LDec, Self.LDummyUINT64)
    
    Self.LDec = Self.LDec / 1000000
    
    Return Self.LDec

        
c25_NanoSyncClass.GetSysTimeAsUINT64              Procedure(<bool _convertToLocal>)

  Code

       c25_GetSystemTimePreciseAsFileTime(Address(Self.LDummyUINT64))
       Return Self.LDummyUINT64

c25_NanoSyncClass.GetLDAPTime                      Procedure(<bool _convertToLocal>)

  Code

        c25_GetSystemTimePreciseAsFileTime(Address(Self.LDummyUINT64))
        i64ToDecimal(Self.LDec, Self.LDummyUINT64)
        Return Clip(Left(Format(Self.LDec,@N_21)))

c25_NanoSyncClass.LDAPTimeToMMSeconds   Procedure(String _LDAPTime)

    Code

        Self.LDec = _LDAPTime
        i64FromDecimal(Self.LDummyUINT64, Self.LDec)

        i64Div(Self.LDummyUINT64,Self.MMSecondsInLDAPTime,Self.LDUMMY2UINT64)

        i64ToDecimal(Self.LCalcDec,Self.LDUMMY2UINT64)

        Return Self.LCalcDec

c25_NanoSyncClass.SetTimeOut    Procedure(<Long _hr>,<Long _min>,<Long _sec>,<Long _mm>,<String _name>)

    Code

        If Self.TimeOutQ &= NULL
            Return 0
        End
        If omitted(_name) = False
            F# = 0
            I# = 0
            R# = Records(Self.TimeOutQ)
            Loop R# Times
                I# = I# + 1
                Get(Self.TimeOutQ,I#)
                If Errorcode() <> 0
                    BREAK
                End
                If Clip(Self.TimeOutQ.Name) = Clip(_name)
                    F# = TRUE
                    Self.TimeOutQ.IsTimeout  = 0
                    Self.TimeOutQ.Timeout    = Self.CalcSysTimeout(_hr, _min, _sec, _mm)
                    Put(Self.TimeOutQ)
                    Break
                End
            End
            If F# = 0
                Self.TimeOutQ.Name       = Clip(_name)
                Self.TimeOutQ.IsTimeout  = 0
                Self.TimeOutQ.Timeout    = Self.CalcSysTimeout(_hr, _min, _sec, _mm)
                Add(Self.TimeOutQ)
            End
        Else
            Self.IsTimeOut = 0
            Self.SysTimeTimeOut = Self.CalcSysTimeout(_hr, _min, _sec, _mm)
        End
        Return 0

c25_NanoSyncClass.IsTimeOut     Procedure(<String _name>,<Byte _removeWhenTimeout>, <Byte _createWhenNotExist>, <Long _returnValIfNotExist>)

    Code

        If Self.TimeOutQ &= NULL
            Return 0
        End
        If omitted(_name) = False
            I# = 0
            R# = Records(Self.TimeOutQ)
            Loop R# Times
                I# = I# + 1
                Get(Self.TimeOutQ,I#)
                If Errorcode() <> 0
                    BREAK
                End
                If Clip(Self.TimeOutQ.Name) = Clip(_name)
                    If Self.TimeOutQ.Timeout < Self.GetSysTime()
                        If _removeWhenTimeout = TRUE
                            Delete(Self.TimeOutQ)
                        Else
                            Self.TimeOutQ.IsTimeout  = TRUE
                            Put(Self.TimeOutQ)
                        End
                        Return TRUE
                    Else
                        Return False
                    End
                End
            End
            If omitted(_returnValIfNotExist) = False
                Return _returnValIfNotExist
            End
            If _createWhenNotExist = TRUE
                Self.SetTimeOut(0,0,0,0, Clip(_name))
            End
            Return True
        Else
            If Self.SysTimeTimeOut > 0 And Self.SysTimeTimeOut < Self.GetSysTime()
                Self.IsTimeOut = True
                Return TRUE
            End
        End

        Return 0


c25_NanoSyncClass.TimerExists   Procedure(String _name)

    Code

        I# = 0
        R# = Records(Self.TimeOutQ)
        Loop R# Times
            I# = I# + 1
            Get(Self.TimeOutQ,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Clip(Self.TimeOutQ.Name) = Clip(_name)
                Return True
            End
        End
        Return False

c25_NanoSyncClass.GetNanoSecondsFromFILETIME      Procedure(String _fileTimeStr8)

FileTimeStr8      String(8)

    Code

        FileTimeStr8 = _fileTimeStr8

        Self.LDummyUINT64 = FileTimeStr8
        i64ToDecimal(Self.LDec, Self.LDummyUINT64)

         Return Self.LDec

c25_NanoSyncClass.FormatFromNanoseconds          Procedure(String _nanoSeconds)

DecDummy                                            decimal(22,0)
Int64Dummy                                          like(INT64)

    Code

        DecDummy = _nanoSeconds
        i64FromDecimal(Int64Dummy, DecDummy)

        Self.Str8 = Int64Dummy

        c25_FileTimeToSystemTime(Self.Str8Address,Address(Self.SYSTEMTIME))

        Self.st1.Start()
        Self.st1.Append(Format(Self.SYSTEMTIME.wYear,@N04))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wMonth,@N02))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wDay,@N02))
        Self.st1.Append('T')
        Self.st1.Append(Format(Self.SYSTEMTIME.wHour,@N02))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wMinute,@N02))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wSecond,@N02))
        Self.st1.Append('Z')

        Return Self.st1.GetValue() !Self.LDec

c25_NanoSyncClass.GetSystemTimeFromStr8          Procedure(String _fileTimeStr8)

    Code

        Self.Str8 = _fileTimeStr8

        c25_FileTimeToSystemTime(Self.Str8Address,Address(Self.SYSTEMTIME))

        Self.st1.Start()
        Self.st1.Append(Format(Self.SYSTEMTIME.wYear,@N04))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wMonth,@N02))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wDay,@N02))
        Self.st1.Append('T')
        Self.st1.Append(Format(Self.SYSTEMTIME.wHour,@N02))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wMinute,@N02))
        Self.st1.Append('-')
        Self.st1.Append(Format(Self.SYSTEMTIME.wSecond,@N02))
        Self.st1.Append('Z')

        Return Self.st1.GetValue()




c25_NanoSyncClass.DecToSQL_TIMESTAMP_STRUCT     Procedure(String _dec, <bool _convertToLocal>)


DecInput            Decimal(21,0)
DecOutput           Decimal(21,0)
Int64Input          Like(INT64)
Int64SystemTime     Like(INT64)
Int64Output         Like(INT64)

Code

    DecInput = _dec

    If omitted(_convertToLocal) = False And _convertToLocal = True
        i64FromDecimal(Int64Input, DecInput)
        Self.Str8UTC = Int64Input
        c25_FileTimeToLocalFileTime(Self.Str8UTCAddress, Self.Str8Address)
        Int64Input = Self.Str8
        i64ToDecimal(DecInput, Int64Input)
    ELSE
        i64FromDecimal(Int64Input, DecInput)
        Self.Str8 = Int64Input
    End
    c25_FileTimeToSystemTime(Self.Str8Address,Address(Self.SYSTEMTIME))

    Self.st1.Start()
    Self.st1.Append(Format(Self.SYSTEMTIME.wHour,@N02))
    Self.st1.Append(':')
    Self.st1.Append(Format(Self.SYSTEMTIME.wMinute,@N02))
    Self.st1.Append(':')
    Self.st1.Append(Format(Self.SYSTEMTIME.wSecond,@N02))

    Self.st1.Append(' ')

    Self.st1.Append(Format(Self.SYSTEMTIME.wHour,@N02))
    Self.st1.Append(':')
    Self.st1.Append(Format(Self.SYSTEMTIME.wMinute,@N02))
    Self.st1.Append(':')
    Self.st1.Append(Format(Self.SYSTEMTIME.wSecond,@N02))

    Self.st1.Append('.')
    Self.SYSTEMTIME.wMilliseconds = 0

    c25_SystemTimeToFileTime(Address(Self.SYSTEMTIME), Self.Str8Address)
    Int64SystemTime = Self.Str8

    i64Sub(Int64Input, Int64SystemTime, Int64Output)
    i64ToDecimal(DecOutput, Int64Output)

    Self.st1.Append(Format(DecOutput,@N07))

    Return Self.st1.GetValue()

c25_NanoSyncClass.DecToSQL_TIMESTAMP_STRUCT_TIMEONLY     Procedure(String _dec, <bool _convertToLocal>)

DecInput            Decimal(21,0)
DecOutput           Decimal(21,0)
Int64Input          Like(INT64)
Int64SystemTime     Like(INT64)
Int64Output         Like(INT64)
MMSECS              Decimal(21,0)

    Code

        DecInput = _dec

        If omitted(_convertToLocal) = False And _convertToLocal = True
            i64FromDecimal(Int64Input, DecInput)
            Self.Str8UTC = Int64Input
            c25_FileTimeToLocalFileTime(Self.Str8UTCAddress, Self.Str8Address)
            Int64Input = Self.Str8
            i64ToDecimal(DecInput, Int64Input)
        ELSE
            i64FromDecimal(Int64Input, DecInput)
            Self.Str8 = Int64Input
        End
        c25_FileTimeToSystemTime(Self.Str8Address,Address(Self.SYSTEMTIME))

        Self.st1.Start()
        Self.st1.Append(Format(Self.SYSTEMTIME.wHour,@N02))
        Self.st1.Append(':')
        Self.st1.Append(Format(Self.SYSTEMTIME.wMinute,@N02))
        Self.st1.Append(':')
        Self.st1.Append(Format(Self.SYSTEMTIME.wSecond,@N02))
        Self.st1.Append('.')
        Self.SYSTEMTIME.wMilliseconds = 0

        c25_SystemTimeToFileTime(Address(Self.SYSTEMTIME), Self.Str8Address)
        Int64SystemTime = Self.Str8

        i64Sub(Int64Input, Int64SystemTime, Int64Output)
        i64ToDecimal(DecOutput, Int64Output)

        Self.st1.Append(Format(DecOutput,@N07))

    Return Self.st1.GetValue()



c25_NanoSyncClass.DecToSQL_TIMESTAMP_STRUCT_IsValid     Procedure(String _dec, <bool _convertToLocal>)


DecInput            Decimal(21,0)
Int64Input          Like(INT64)
DecString           String(21)

    Code


        DecInput = _dec
        DecString = DecInput

        If DecString <> _dec
            Return 0
        End

        i64FromDecimal(Int64Input, DecInput)

        Self.Str8 = Int64Input

        If c25_FileTimeToSystemTime(Self.Str8Address,Address(Self.SYSTEMTIME)) = 0
            Return 0
        End

        Return True


c25_NanoSyncClass.Get_DateTimeW      Procedure(<*String _output>)

    Code

        Self.DecInput = Self.GetSysTime()
        i64FromDecimal(Self.Int64Input, Self.DecInput)
        c25_FileTimeToSystemTime(Address(Self.Int64Input) ,Address(Self.SYSTEMTIME))
        Self.SYSTEMTIME.wMilliseconds = 0
        c25_SystemTimeToFileTime(Address(Self.SYSTEMTIME),Address(Self.Int64Inter))
        i64Sub(Self.Int64Input, Self.Int64Inter, Self.Int64Output)
        i64ToDecimal(Self.DecOutput, Self.Int64Output)
        Self.BCP_TIMESTAMP_ANSI = Format(Self.SYSTEMTIME.wYear,@N04) & '-' & Format(Self.SYSTEMTIME.wMonth,@N02) & '-' & Format(Self.SYSTEMTIME.wDay,@N02) & ' ' & Format(Self.SYSTEMTIME.wHour,@N02) & ':' & Format(Self.SYSTEMTIME.wMinute,@N02) & ':' &  Format(Self.SYSTEMTIME.wSecond,@N02) & '.' &  Format(Self.DecOutput,@N07)
        If Omitted(_output) = False
            Self.BitConverter.AnsiToUtf16Fast(Self.BCP_TIMESTAMP_ANSI, 27, _output)
            Return ''
        End
        Return Self.BitConverter.AnsiToUtf16Fast(Self.BCP_TIMESTAMP_ANSI, 27)


c25_NanoSyncClass.Get_DateTimeW      Procedure(<*String _output> , String _dec20)

    Code

        Self.DecInput = _dec20
        i64FromDecimal(Self.Int64Input, Self.DecInput)
        c25_FileTimeToSystemTime(Address(Self.Int64Input) ,Address(Self.SYSTEMTIME))
        Self.SYSTEMTIME.wMilliseconds = 0
        c25_SystemTimeToFileTime(Address(Self.SYSTEMTIME),Address(Self.Int64Inter))
        i64Sub(Self.Int64Input, Self.Int64Inter, Self.Int64Output)
        i64ToDecimal(Self.DecOutput, Self.Int64Output)
        Self.BCP_TIMESTAMP_ANSI = Format(Self.SYSTEMTIME.wYear,@N04) & '-' & Format(Self.SYSTEMTIME.wMonth,@N02) & '-' & Format(Self.SYSTEMTIME.wDay,@N02) & ' ' & Format(Self.SYSTEMTIME.wHour,@N02) & ':' & Format(Self.SYSTEMTIME.wMinute,@N02) & ':' &  Format(Self.SYSTEMTIME.wSecond,@N02) & '.' &  Format(Self.DecOutput,@N07)
        If Omitted(_output) = False
            Self.BitConverter.AnsiToUtf16Fast(Self.BCP_TIMESTAMP_ANSI, 27, _output)
            Return ''
        End
        Return Self.BitConverter.AnsiToUtf16Fast(Self.BCP_TIMESTAMP_ANSI, 27)


c25_NanoSyncClass.Get_DateTime      Procedure(<*String _output>)

    Code

        Self.DecInput = Self.GetSysTime()
        i64FromDecimal(Self.Int64Input, Self.DecInput)
        c25_FileTimeToSystemTime(Address(Self.Int64Input) ,Address(Self.SYSTEMTIME))
        Self.SYSTEMTIME.wMilliseconds = 0
        c25_SystemTimeToFileTime(Address(Self.SYSTEMTIME),Address(Self.Int64Inter))
        i64Sub(Self.Int64Input, Self.Int64Inter, Self.Int64Output)
        i64ToDecimal(Self.DecOutput, Self.Int64Output)
        If Omitted(_output) = False
            _output = Format(Self.SYSTEMTIME.wYear,@N04) & '-' & Format(Self.SYSTEMTIME.wMonth,@N02) & '-' & Format(Self.SYSTEMTIME.wDay,@N02) & ' ' & Format(Self.SYSTEMTIME.wHour,@N02) & ':' & Format(Self.SYSTEMTIME.wMinute,@N02) & ':' &  Format(Self.SYSTEMTIME.wSecond,@N02) & '.' &  Format(Self.DecOutput,@N07)
            Return ''
        End
        Return Format(Self.SYSTEMTIME.wYear,@N04) & '-' & Format(Self.SYSTEMTIME.wMonth,@N02) & '-' & Format(Self.SYSTEMTIME.wDay,@N02) & ' ' & Format(Self.SYSTEMTIME.wHour,@N02) & ':' & Format(Self.SYSTEMTIME.wMinute,@N02) & ':' &  Format(Self.SYSTEMTIME.wSecond,@N02) & '.' &  Format(Self.DecOutput,@N07)


c25_NanoSyncClass.Get_DateTime      Procedure(<*String _output> , String _dec20)

    Code

        Self.DecInput = _dec20
        i64FromDecimal(Self.Int64Input, Self.DecInput)
        c25_FileTimeToSystemTime(Address(Self.Int64Input) ,Address(Self.SYSTEMTIME))
        Self.SYSTEMTIME.wMilliseconds = 0
        c25_SystemTimeToFileTime(Address(Self.SYSTEMTIME),Address(Self.Int64Inter))
        i64Sub(Self.Int64Input, Self.Int64Inter, Self.Int64Output)
        i64ToDecimal(Self.DecOutput, Self.Int64Output)
        If Omitted(_output) = False
            _output = Format(Self.SYSTEMTIME.wYear,@N04) & '-' & Format(Self.SYSTEMTIME.wMonth,@N02) & '-' & Format(Self.SYSTEMTIME.wDay,@N02) & ' ' & Format(Self.SYSTEMTIME.wHour,@N02) & ':' & Format(Self.SYSTEMTIME.wMinute,@N02) & ':' &  Format(Self.SYSTEMTIME.wSecond,@N02) & '.' &  Format(Self.DecOutput,@N07)
            Return ''
        End
        Return Format(Self.SYSTEMTIME.wYear,@N04) & '-' & Format(Self.SYSTEMTIME.wMonth,@N02) & '-' & Format(Self.SYSTEMTIME.wDay,@N02) & ' ' & Format(Self.SYSTEMTIME.wHour,@N02) & ':' & Format(Self.SYSTEMTIME.wMinute,@N02) & ':' &  Format(Self.SYSTEMTIME.wSecond,@N02) & '.' &  Format(Self.DecOutput,@N07)




