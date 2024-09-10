    Member

    Include('c25_MemLogClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.clw'),Once
    End

c25MemLogClass.Construct                                Procedure()

Code

    Self.ProgramHandler &= NEW c25ProgramHandlerClass()
    Self.ProgramHandler &= Self.ProgramHandler.Singleton.GetPointer()
    Self.ProgramHandler.Singleton.Start()

    Self.StMappedData           &= NEW StringTheory()
    Self.StMappedData.Start()
    Self.StMappedDataReturn     &= NEW StringTheory()
    Self.StMappedDataReturn.Start()
    Self.BytesQ                 &= NEW BytesQ_TYPE()
    Self.NanoSync               &= NEW c25NanoSyncClass()
    Self.BitConverter           &= NEW c25BitConverterClass()
    Self.SharedMemory           &= NEW c25SharedMemoryClass()
    Self.MappedFileHdr          &= NEW MappedFileHdr_TYPE()
    Self.MappedClientHdr        &= NEW MappedClientHdr_TYPE()
    Self.LocalMappedFileHdr     &= NEW MappedFileHdr_TYPE()
    Self.LocalMappedClientHdr   &= NEW MappedClientHdr_TYPE()
    Self.LogLines               &= NEW LogLines_TYPE
    Self.LogLinesDisplay        &= NEW LogLines_TYPE
    Self.LogLinesTemp           &= NEW LogLines_TYPE
    Self.LogLinesDefault        &= NEW LogLines_TYPE
    Self.RegisterWMs()

c25MemLogClass.Destruct                                 Procedure()

Code

    Dispose(Self.NanoSync)
    Dispose(Self.BitConverter)

c25MemLogClass.Init                                     Procedure(<bool _isServer>, <string _globalFilenameA>, <long _windowHandle>)


MyUInt64                                                Like(UINT64)
MyDecimal                                               Decimal(20)

Code

    C25_Sleepex(200,0)

    If omitted(_windowHandle) = False
        Self.MappedFileHdr.SrvWindowHandle = _windowHandle
    Else
        Self.MappedFileHdr.SrvWindowHandle = 0{Prop:Handle}
    End
    If Omitted(_globalFilenameA) = False
        Self.MappedFileHdr.FileNameA = 'Global\' & Clip(_globalFilenameA)
    Else
        Self.MappedFileHdr.FileNameA = 'Global\Clarion25MemLog'
    End  
    
    If Omitted(_isServer) = False And _isServer = True
        Self.IsServer = True
    End
    Self.LastNewLogReadPosition = -1

    Self.SetMappedFileHdr()
    Self.SetMappedClientHdr()

    Self.LocalMappedFileHdr     = Self.MappedFileHdr
    Self.LocalMappedClientHdr   = Self.MappedClientHdr

    If Self.IsServer
        Self.WriteMappedFileHdr()
    Else
        Self.WriteMappedClientHdr()
        Message('dat wel')
    End

    Return 0
    
c25MemLogClass.SetMappedFileHdr                         Procedure()

SystemInfo Like(SystemInfo_TYPE)

Code
        
    C25_GetSystemInfo(Address(SystemInfo))
    Self.MappedFileHdr.Size                             = Size(Self.MappedFileHdr)
    Self.MappedFileHdr.AllocGranularity                 = SystemInfo.AllocationGranularity
    Self.MappedFileHdr.PageSize                         = Self.MappedFileHdr.AllocGranularity
    Self.MappedFileHdr.FileSize                         = (10000000/Self.MappedFileHdr.PageSize) * Self.MappedFileHdr.PageSize
    Self.DecToHiAndLo(Format(Self.MappedFileHdr.FileSize,@N020), Self.MappedFileHdr.FileSizeHi, Self.MappedFileHdr.FileSizeLo)
    Self.MappedFileHdr.PageNo                           = 1
    Self.MappedFileHdr.FilePages                        = Self.MappedFileHdr.FileSize / Self.MappedFileHdr.PageSize
    Self.MappedFileHdr.FileHeadersPages                 = 2
    Self.MappedFileHdr.FileHandle = Self.SharedMemory.CreateMemoryMappedFile(Self.MappedFileHdr.FileNameA, Self.MappedFileHdr.FileSizeHi, Self.MappedFileHdr.FileSizeLo)
    If Self.MappedFileHdr.FileHandle = 0 Or Self.MappedFileHdr.FileHandle = -1
        Message('error creating memory mapped file ' & C25_GetLastError() )
        Return 0
    End
    Self.MappedFileHdr.StartingAddress = c25_MapViewOfFile(Self.MappedFileHdr.FileHandle, C25_SECTION_ALL_ACCESS, 0, 0, Self.MappedFileHdr.PageSize * Self.MappedFileHdr.FileHeadersPages)

    Return 0
    
c25MemLogClass.SetMappedClientHdr                       Procedure()

Code
        
    Self.MappedClientHdr.Size                           = Size(Self.MappedClientHdr)
    Self.MappedClientHdr.PageNo                         = 2
    Self.MappedClientHdr.HdrMappedOffset                = ((Self.MappedClientHdr.PageNo-1) * Self.MappedFileHdr.PageSize)
    i64FromDecimal(Self.MappedClientHdr.HdrMappedOffsetINT64,Self.MappedClientHdr.HdrMappedOffset)
    Self.DecToHiAndLo(Format(Self.MappedClientHdr.HdrMappedOffset,@N020), Self.MappedClientHdr.HdrMappedOffsetHi, Self.MappedClientHdr.HdrMappedOffsetLo)
                
    Self.MappedClientHdr.MappedDataStartPageNo          = 3
    Self.MappedClientHdr.MappedDataPages                = Self.MappedFileHdr.FilePages - Self.MappedClientHdr.MappedDataStartPageNo
    Self.MappedClientHdr.MappedDataSize                 = Self.MappedClientHdr.MappedDataPages * Self.MappedFileHdr.PageSize
    Self.DecToHiAndLo(Format(Self.MappedClientHdr.MappedDataSize,@N020), Self.MappedClientHdr.MappedDataSizeHi, Self.MappedClientHdr.MappedDataSizeLo)
        
    Self.MappedClientHdr.HdrStartingAddress             = c25_MapViewOfFile(Self.MappedFileHdr.FileHandle, C25_SECTION_ALL_ACCESS, Self.MappedClientHdr.HdrMappedOffsetHi, Self.MappedClientHdr.HdrMappedOffsetLo, Self.MappedFileHdr.PageSize)
    Self.MappedClientHdr.MappedDataOffset               = (Self.MappedClientHdr.MappedDataStartPageNo * Self.MappedFileHdr.PageSize)
    i64FromDecimal(Self.MappedClientHdr.MappedDataOffsetINT64,Self.MappedClientHdr.MappedDataOffset)
    Self.DecToHiAndLo(Format(Self.MappedClientHdr.MappedDataOffset,@N020), Self.MappedClientHdr.MappedDataOffsetHi, Self.MappedClientHdr.MappedDataOffsetLo)
    Self.MappedClientHdr.MappedDataStartingAddress      = c25_MapViewOfFile(Self.MappedFileHdr.FileHandle, C25_SECTION_ALL_ACCESS, Self.MappedClientHdr.MappedDataOffsetHi, Self.MappedClientHdr.MappedDataOffsetLo, Self.MappedClientHdr.MappedDataSizeLo)
        
    Self.MappedClientHdr.CurrentPointer                 = Self.MappedClientHdr.MappedDataStartingAddress
    Self.DecToHiAndLo(Format(Self.MappedClientHdr.CurrentPointer,@N020), Self.MappedClientHdr.CurrentPointerHi, Self.MappedClientHdr.CurrentPointerLo)
    Self.MappedClientHdr.CurrentPointerINT64.Hi         = Self.MappedClientHdr.CurrentPointerHi
    Self.MappedClientHdr.CurrentPointerINT64.Lo         = Self.MappedClientHdr.CurrentPointerLo
    
    Self.MappedClientHdr.LastNewLogWritePosition        = -1 !Self.MappedClientHdr.CurrentPointer - Self.MappedClientHdr.MappedDataStartingAddress
    

    Return 0
    
c25MemLogClass.DecToHiAndLo                             Procedure(string _dec, *long _hi, *long _lo)

    CODE

    Self.MyDecimal = _dec
    i64FromDecimal(Self.MyInt64, Self.MyDecimal)
    _hi = Self.MyInt64.Hi
    _lo = Self.MyInt64.Lo

c25MemLogClass.Add_LogLine                              Procedure(string _line)

Code

    Self.WriteMappedDataLogLines( , _line)
    
c25MemLogClass.SignalServer                             Procedure(<long _startPtr>)

Code

c25MemLogClass.Refresh_LogLinesDisplay                  Procedure()

NewlyAddedCount long

Code

    NewlyAddedCount = Records(Self.LogLines) - Records(Self.LogLinesDisplay)
    
    T# = Records(Self.LogLines)
    If Records(Self.LogLinesDisplay) > 0
        Loop
            If Records(Self.LogLinesDisplay) > T#
                Get(Self.LogLinesDisplay,1)
                Delete(Self.LogLinesDisplay)
                Cycle
            END
            BREAK
        END
    End
    Loop
        If Records(Self.LogLinesDisplay) < T#
            Clear(Self.LogLinesDisplay)
            If Records(Self.LogLinesDisplay) = 0
                Add(Self.LogLinesDisplay)
            Else
                Add(Self.LogLinesDisplay,1)
            End
            Cycle
        END
        Break
    End
    
    I# = 0
    Loop
        I# = I# + 1
        If I# > NewlyAddedCount
            BREAK
        End
        Get(Self.LogLines,I#)
        If Errorcode() <> 0
            BREAK
        End
        Get(Self.LogLinesDisplay,I#)
        If Self.LogLinesDisplay <> Self.LogLines
            Self.LogLinesDisplay = Self.LogLines
            Put(Self.LogLinesDisplay)
        End
    End
    Return 0

c25MemLogClass.Process_WM_NewLogEntry                   Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

    CODE

        Return ''

c25MemLogClass.RegisterWMs                              Procedure()

RegMesStringA   String(250)

Code

    RegMesStringA = 'WM_RequestLogServerWindowHandle' & Chr(0)
    Self.WM_RequestLogServerWindowHandle = c25_RegisterWindowMessageA(Address(RegMesStringA))

    RegMesStringA = 'WM_LogServerWindowHandle' & Chr(0)
    Self.WM_LogServerWindowHandle = c25_RegisterWindowMessageA(Address(RegMesStringA))

    RegMesStringA = 'WM_NewLogToServer' & Chr(0)
    Self.WM_NewLogToServer = c25_RegisterWindowMessageA(Address(RegMesStringA))

    RegMesStringA = 'WM_NewLogEntry' & Chr(0)
    Self.WM_NewLogEntry = c25_RegisterWindowMessageA(Address(RegMesStringA))

    Return 0

c25MemLogClass.EnumStMappedToQueue                      Procedure(<*StringTheory _stMappedData>, <*BytesQ_TYPE _bytesQ>, <long _extraOffset>, <string _addressStart>, <string _startPos>)

st &StringTheory(),Auto
AddressStart       Decimal(20,0)

Code

    If omitted(_addressStart) = FALSE
        AddressStart = _addressStart
    End

    If omitted(_stMappedData) = False
        st &= _stMappedData
    ELSE
        st &= Self.StMappedData
    End

    If omitted(_bytesQ) = False
        Self.BytesQ &= _bytesQ
    End
    Free(Self.BytesQ)
    Clear(Self.BytesQ)
    If omitted(_startPos) = FALSE
        Self.BytesQ.Pos = _startPos - 1
    End

    AddressStart = AddressStart - 1
    L# = St.Length()
    Loop L# Times
        AddressStart = AddressStart + 1
        Self.BytesQ.Address = AddressStart
        Self.BytesQ.Pos = Self.BytesQ.Pos + 1
        Self.BytesQ.Char = St.Slice(Self.BytesQ.Pos,Self.BytesQ.Pos)
        Self.BytesQ.ValByte = Val(Self.BytesQ.Char)
        Self.BytesQ.Hex = ByteToHex(Self.BytesQ.ValByte,False)
        Add(Self.BytesQ)
    End
    If omitted(_bytesQ) = False
        Self.BytesQ &= null
    End
    st &= null
    Return 0

c25MemLogClass.ReRead                                   Procedure()

Code

    Self.ReadMappedFileHdr()
    Self.ReadMappedClientHdr()
    Return 0
    
c25MemLogClass.ParseMappedFileHdr                       Procedure()

Code
    Return Clip(Self.MappedFileHdr)

c25MemLogClass.ParseMappedClientHdr                     Procedure()
Code
    Return Clip(Self.MappedClientHdr)

c25MemLogClass.Read_NewLogEntries                       Procedure(<string _startReadPtr>, <string _offsetDataAddress>)

MyInt           LONG
Str4OverInt     String(4),Over(MyInt)
MyLen           LONG

stLog           &StringTheory
CurrentPointer  LONG
LastNewLogReadPosition long
Code

    Free(Self.LogLinesTemp)
    If Omitted(_startReadPtr) = False
        CurrentPointer = _startReadPtr
    ElsIf Omitted(_offsetDataAddress) = False
        CurrentPointer = Self.LocalMappedClientHdr.MappedDataStartingAddress + _offsetDataAddress
    End
    Loop
        LastNewLogReadPosition = CurrentPointer - Self.LocalMappedClientHdr.MappedDataStartingAddress
        MyLen = Self.ReadMappedDataInt(,CurrentPointer)
        If MyLen = 0
            BREAK
        End
        
        CurrentPointer = CurrentPointer + 4
        Free(Self.LogLinesTemp)

        If MyLen < 3
            CurrentPointer = CurrentPointer + MyLen
            Message('error mylen < 3')
            CYCLE
        End
        Self.BitConverter.JsonStringToQueue(Clip(Self.ReadMappedData(CurrentPointer, MyLen)), Self.LogLinesTemp)
        I# = 0
        Loop
            I# = I# + 1
            Get(Self.LogLinesTemp,I#)
            If Errorcode() <> 0
                BREAK
            End
            Self.LogLines = Self.LogLinesTemp
            If Records(Self.LogLines) = 0
                Add(Self.LogLines)
            Else
                Add(Self.LogLines,1)
            End
            Self.LocalMappedClientHdr.RecordsRead = Self.LocalMappedClientHdr.RecordsRead + 1
        End
        CurrentPointer = CurrentPointer + MyLen
    End
    Free(Self.LogLinesTemp)
    Dispose(stLog)
    Return LastNewLogReadPosition
    
c25MemLogClass.ReadMappedFileHdr                        Procedure(<bool _isClient>, <byte _show>)

Code

    Clear(Self.MappedFileHdr.Crc)
    If Self.MappedFileHdr.StartingAddress <> 0
        A# = Self.MappedFileHdr.StartingAddress
        c25_MemCpy(Address(Self.MappedFileHdr), Self.MappedFileHdr.StartingAddress, Size(Self.MappedFileHdr))
        Self.MappedFileHdr.StartingAddress = A#
    Else
        Message('error Self.MappedFileHdr.StartingAddress = 0')
    End
    Return 0

c25MemLogClass.ReadMappedClientHdr                      Procedure(<bool _isClient>, <byte _show>)

Code

    Clear(Self.MappedClientHdr.Crc)
    If Self.MappedClientHdr.HdrStartingAddress <> 0
        A# = Self.MappedClientHdr.HdrStartingAddress
        c25_MemCpy(Address(Self.MappedClientHdr), Self.MappedClientHdr.HdrStartingAddress, Size(Self.MappedClientHdr))
        Self.MappedClientHdr.HdrStartingAddress = A#
!        If Self.IsServer
!            If Self.MappedClientHdr.LastNewLogWritePosition <> 0
!
!            End
!        End
    Else
        Message('error Self.MappedClientHdr.StartingAddress = 0')
    End
    Return 0

c25MemLogClass.ReadMappedDataInt                        Procedure(<INT64 _ptr64>, <long _ptr>, <*long _int>, <byte _show>)

Code

    If omitted(_ptr64) = False
        If _ptr64.Hi = 0
            If omitted(_int) = False
                Peek(_ptr64.Lo ,_int)
            ELSE
                Self.ValInt = 0
                Peek(_ptr64.Lo, Self.ValInt)
                Return Self.ValInt
            End
        ELSE
        End
    ELSE
        If _ptr <> 0
            If omitted(_int) = False
                Peek(_ptr ,_int)
            ELSE
                Self.ValInt = 0
                Peek(_ptr, Self.ValInt)
                Return Self.ValInt
            End
        End
    End
    Return 0

c25MemLogClass.ReadMappedData                           Procedure(long _address, long _len, <*StringTheory _stMappedData>, <string _saveFileNameA>)

st &StringTheory(),Auto
ReadLen long,auto

Code

    If omitted(_stMappedData) = False
        st &= _stMappedData
    ELSE
        st &= Self.StMappedDataReturn
    End
    st.Start()
    st.SetValueByAddress(_address, _len)
    If omitted(_saveFileNameA) = False
        st.SaveFile(_saveFileNameA)
    End
    If omitted(_stMappedData) = True
        st &= null
        Return Self.StMappedDataReturn.GetValue()
    End
    st &= null

    Return _stMappedData.GetValue()

c25MemLogClass.ReadMappedDataPage                       Procedure(long _fromPageNo, <long _untilPageNo>, <*StringTheory _stMappedData>, <string _saveFileNameA>)

st          &StringTheory(),Auto
ReadLen     long,auto
ReadAddress LONG

Code

    If omitted(_stMappedData) = False
        st &= _stMappedData
    ELSE
        st &= Self.StMappedData
    End
    If _fromPageNo > 0
        If _untilPageNo > 0
            ReadLen = (_untilPageNo - _fromPageNo + 1) * Self.LocalMappedFileHdr.PageSize
            ReadAddress = Self.LocalMappedClientHdr.MappedDataStartingAddress + ((_fromPageNo * Self.LocalMappedFileHdr.PageSize) - Self.LocalMappedFileHdr.PageSize)
        Else
            ReadLen = Self.LocalMappedClientHdr.MappedDataSize - (_fromPageNo * Self.LocalMappedFileHdr.PageSize)
            ReadAddress = Self.LocalMappedClientHdr.MappedDataStartingAddress
        End
    Else
        ReadLen = Self.LocalMappedFileHdr.PageSize
        ReadAddress = Self.LocalMappedClientHdr.MappedDataStartingAddress
    End

    
    st.Start()
    st.SetValueByAddress(ReadAddress, ReadLen)
    If omitted(_saveFileNameA) = False
        st.SaveFile(_saveFileNameA)
    End

    st &= null
    Return 0
    
c25MemLogClass.WriteMappedFileHdr                       Procedure()

Code

    Self.LocalMappedFileHdr.Crc = 123
    If Self.LocalMappedFileHdr.StartingAddress <> 0
        c25_MemCpy(Self.LocalMappedFileHdr.StartingAddress, Address(Self.LocalMappedFileHdr), Size(Self.LocalMappedFileHdr))
    End
    Return 0

c25MemLogClass.WriteMappedClientHdr                     Procedure()

Code

    Self.LocalMappedClientHdr.Crc = 789
    If Self.LocalMappedClientHdr.HdrStartingAddress <> 0
        c25_MemCpy(Self.LocalMappedClientHdr.HdrStartingAddress, Address(Self.LocalMappedClientHdr), Size(Self.LocalMappedClientHdr))
    End
    Return 0

c25MemLogClass.WriteMappedDataInt                       Procedure(INT64 _ptr, Long _int)

Code

    If _ptr.Hi = 0
        c25_MemCpy(_ptr.Lo, Address(_int), 4)
    Else
    End
    Return 0
    
c25MemLogClass.WriteMappedDataLogLines                  Procedure(<*StringTheory _stMappedData>, <string _logLine>, <*LogLines_TYPE _logLines>)

MyInt           LONG
Str4OverInt     String(4),Over(MyInt)

Code

    If omitted(_logLines) = False
        Free(Self.LogLinesTemp)
        Self.LogLinesTemp = _logLines
        Add(Self.LogLinesTemp)
        Self.StMappedData.Start()
        Self.BitConverter.QueueToJsonStringTheory(Self.StMappedData,Self.LogLinesTemp,False,True)
        MyInt = Self.StMappedData.Length()
        Self.StMappedData.Insert(1, Str4OverInt)
        Self.LocalMappedClientHdr.LastNewLogWritePosition = Self.LocalMappedClientHdr.CurrentPointer - Self.LocalMappedClientHdr.MappedDataStartingAddress        
        Self.WriteMappedData(Self.LocalMappedClientHdr.CurrentPointer)
        Self.LocalMappedClientHdr.CurrentPointer = Self.LocalMappedClientHdr.CurrentPointer + MyInt + 4
        Self.LocalMappedClientHdr.RecordsWritten = Self.LocalMappedClientHdr.RecordsWritten + 1

    ElsIf omitted(_logLine) = False
        Free(Self.LogLinesTemp)
        Self.LogLinesTemp.Line = Self.LogLinesDefault
        Self.LogLinesTemp.Line = Clip(_logLine)
        Self.LogLinesTemp.TimeStamp = Self.NanoSync.GetSysTime()
        Self.LogLinesTemp.TimeStampFormatted = Self.NanoSync.Get_DateTime()
        Add(Self.LogLinesTemp)
        Self.StMappedData.Start()
        Self.BitConverter.QueueToJsonStringTheory(Self.StMappedData,Self.LogLinesTemp,False,True)
    
        MyInt = Self.StMappedData.Length()
        Self.StMappedData.Insert(1, Str4OverInt)
        Self.LocalMappedClientHdr.LastNewLogWritePosition = Self.LocalMappedClientHdr.CurrentPointer - Self.LocalMappedClientHdr.MappedDataStartingAddress        
        Self.WriteMappedData(Self.LocalMappedClientHdr.CurrentPointer)
        Self.LocalMappedClientHdr.CurrentPointer = Self.LocalMappedClientHdr.CurrentPointer + MyInt + 4
        Self.LocalMappedClientHdr.RecordsWritten = Self.LocalMappedClientHdr.RecordsWritten + 1
    End

    
    Self.WriteMappedClientHdr()
    Return 0

c25MemLogClass.WriteMappedData                          Procedure(<long _targetAddress>, <*StringTheory _stMappedData>, <string _data>, <long _sourceOffset>, <long _targetOffset>, <long _len>)

st              &StringTheory(),Auto
WriteLen        Long,AUTO
Offset          LONG

Code

    If omitted(_stMappedData) = False
        st &= _stMappedData
    ELSE
        If omitted(_data) = False
            Self.StMappedData.Start()
            st &= Self.StMappedData
            st.Append(_data)
        Else
            st &= Self.StMappedData
        End
    End
    If omitted(_len) = False
        WriteLen = _len
    Else
        WriteLen = st.Length()
    End
    Offset = _sourceOffset
    If omitted(_targetAddress) = False
        C25_Memcpy(_targetAddress,  st.GetAddress() + _sourceOffset, WriteLen)
        !Message('wrote _targetOffset ' & _targetOffset)
    Else
        C25_Memcpy(Self.LocalMappedClientHdr.MappedDataStartingAddress + _targetOffset,  st.GetAddress() + _sourceOffset, WriteLen)
        !Message('wrote on Self.LocalMappedClientHdr.MappedDataStartingAddress + _targetOffset ' & Self.LocalMappedClientHdr.MappedDataStartingAddress + _targetOffset)
    End
    Return 0

c25MemLogClass.WriteMappedDataPage                      Procedure(long _fromPageNo, <long _untilPageNo>, <*StringTheory _stMappedData>, <string _saveFileNameA>)

st &StringTheory(),auto
ReadLen long,auto
Code

    If omitted(_stMappedData) = False
        st &= _stMappedData
    ELSE
        st &= Self.StMappedData
    End
    If Omitted(_untilPageNo) = False
        ReadLen = (_untilPageNo - _fromPageNo + 1) * Self.LocalMappedFileHdr.PageSize
    Else
        ReadLen = Self.LocalMappedFileHdr.PageSize
    End
    If st.Length() < ReadLen
        st.SetLength(ReadLen)
    End
    C25_Memcpy(Self.LocalMappedClientHdr.MappedDataStartingAddress,  st.GetAddress(), ReadLen)
    st &= null
    Return 0
