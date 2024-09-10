    Member

    Include('c25_BitConverterClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.inc'),Once
    End

c25_BitConverterClass.Construct                             Procedure()

Code
    
    Self.ClassTypeName = 'c25_BitConverterClass'
    
    Self.Int16MaxValue                  = 32767
    Self.Int16MinValue                  = -32768
    Self.UInt16MaxValue                 = 65535
    Self.UInt16MinValue                 = 0

    Self.Int32MaxValue                  = 2147483647
    Self.Int32MinValue                  = -2147483648
    Self.UInt32MaxValue                 = 4294967295
    Self.UInt32MinValue                 = 0

    Self.Int64MaxValue                  = 9223372036854775807
    Self.Int64MinValue                  = -9223372036854775808
    Self.UInt64MaxValue                 = 18446744073709551615
    Self.UInt64MinValue                 = 0    
    
    Self.CRLF = Chr(13) & Chr(10)
    
    Self.st1 &= NEW StringTheory()
    Self.st1.Start()
    Self.st2 &= NEW StringTheory()
    Self.st2.Start()
    Self.st3 &= NEW StringTheory()
    Self.st3.Start()
    Self.StAnsi &= New StringTheory()
    Self.StAnsi.Start()
    Self.StAnsiToAnsi &= NEW StringTheory()
    Self.StAnsiToAnsi.Start()
    Self.StAnsiToUtf16 &= New StringTheory()
    Self.StAnsiToUtf16.Start()
    Self.StAnsiToUtf8 &= New StringTheory()
    Self.StAnsiToUtf8.Start()
    Self.StUtf16 &= New StringTheory()
    Self.StUtf16.Start()
    Self.StUtf16ToAnsi &= New StringTheory()
    Self.StUtf16ToAnsi.Start()
    Self.StUtf16ToUtf8 &= NEW StringTheory()
    Self.StUtf16ToUtf8.Start()
    Self.StUtf32 &= New StringTheory()
    Self.StUtf32.Start()
    Self.StUtf8 &= New StringTheory()
    Self.StUtf8.Start()
    Self.StUtf8ToAnsi &= New StringTheory()
    Self.StUtf8ToAnsi.Start()
    Self.StUtf8ToUtf8 &= NEW StringTheory()
    Self.StUtf8ToUtf8.Start()
    Self.Js1 &= NEW JSONClass()
    Self.Js1.Start()
    
    Self.BytesArray16KAddress = Address(Self.BytesArray16K)

c25_BitConverterClass.Destruct                              Procedure()

Code

!    Dispose(Self.AnsiStringSearchUpper)
!    Dispose(Self.AnsiStringUpper)
!    Dispose(Self.BufferStr)
!    Dispose(Self.CurrentPathW)
!    Dispose(Self.DummyStringRef)
!    Dispose(Self.FormatMessageAnsi)
!    !Dispose(Self.Js1)
!    Dispose(Self.ReturnString)
!    Dispose(Self.st1)
!    Dispose(Self.st2)
!    Dispose(Self.st3)
!    Dispose(Self.StAnsi)
!    Dispose(Self.StAnsiToAnsi)
!    Dispose(Self.StAnsiToUtf16)
!    Dispose(Self.StAnsiToUtf8)
!    Dispose(Self.StLog)
!    Dispose(Self.StUtf16)
!    Dispose(Self.StUtf16ToAnsi)
!    Dispose(Self.StUtf16ToUtf16)
!    Dispose(Self.StUtf16ToUtf8)
!    Dispose(Self.StUtf32)
!    Dispose(Self.StUtf8)
!    Dispose(Self.StUtf8ToAnsi)
!    Dispose(Self.StUtf8ToUtf16)
!    Dispose(Self.StUtf8ToUtf8)
!    Dispose(Self.Utf16Buffer)

    
c25_BitConverterClass.Get_UNICODE_STRING                                            Procedure(*UnicodeString_TYPE _unicodeString, <bool _isNull>, <*string _stringOut>)    
    
CODE
        
    If _unicodeString &= NULL
        Return 'NULL'
    End
    
    If _unicodeString.BufferPtr = 0 Or _unicodeString.Length = 0
        Return 'NULL'
    End
    
    If not Self.BufferStr &= null
        Dispose(Self.BufferStr)
    End
    Self.BufferStr &= NEW String(_unicodeString.Length)
    C25_Memcpy(Address(Self.BufferStr), _unicodeString.BufferPtr, _unicodeString.Length)

    Return Self.BufferStr & Chr(0) & Chr(0)



c25_BitConverterClass.GetBits                                           Procedure(string _input, long _lengthBytes)

BitsReturn string(1024)
I                                                                           LONG


CODE
        
    I = 0
    LOOP _lengthBytes Times
        I = I + 1
        If I > Size(_input)
            !error
            return 'error, lengthBytes not matching getBits'
        End
        BitsReturn = Clip(BitsReturn) & Self.GetBits8FromString1(_input[I])
        
    End
    Return Clip(BitsReturn)


c25_BitConverterClass.StringIsInt                                       Procedure(string _input)    
 
Code

    I# = 0
    T# = Len(Clip(_input))
    Loop T# TIMES
        I# = I# + 1
        Case _input[I#] 
        Of '0'
        OrOf '1'
        OrOf '2'
        OrOf '3'
        OrOf '4'
        OrOf '5'
        OrOf '6'
        OrOf '7'
        OrOf '8'
        OrOf '9'
        ELSE
            Return FALSE
        END
    End
    Return True

c25_BitConverterClass.RefToPtrAndSizePtr                    Procedure(*String _strRef)

PtrAndSizeRef   &ByteArray
PtrAndSize      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
                End
    Code

    PtrAndSizeRef   &= New ByteArray(8)
    PtrAndSize.Ptr  = Address(_strRef)
    PtrAndSize.Size = Size(_strRef)

    PtrAndSizeRef = PtrAndSize
    Return Address(PtrAndSizeRef)

c25_BitConverterClass.PtrToPtrAndSizePtrToStr               Procedure(Long _ptrToPtrAndSize)

PtrAndSizeRef   &ByteArray
PtrAndSize      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
                End
String100       String(100)

    Code

        Message('error obselate PtrToPtrAndSizePtrToStr')
        If c25_IsBadreadPtr(_ptrToPtrAndSize,8) <> 0
            Return ''
        End
        Peek(_ptrToPtrAndSize,PtrAndSize)
        PtrAndSizeRef &= (PtrAndSize)

        Message('PtrAndSizeRef: ' & PtrAndSizeRef)
        Message('PtrAndSize.Ptr ' & PtrAndSize.Ptr)
        Peek(PtrAndSize.Ptr,String100)
        Message('String100 ' & String100)
        Message('PtrAndSize.Size ' & PtrAndSize.Size)

        PtrAndSizeRef &= (PtrAndSize.Ptr)
        Message('PtrAndSizeRef: ' & PtrAndSizeRef)

        Return ''

c25_BitConverterClass.QueueRecordToStringRefPtr             Procedure(*Queue _q)

StringRef                       &ByteArray

GrpDummyString                  Group,Pre(GrpDummyString)
DummyString                         &ByteArray
                                End
AnyField                        ANY
AdrGroup                        Group,pre()
PtrAddress                          Long
PtrSize                             Long
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
PtrAndSizeRef                   &ByteArray
PtrAndSize                      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
                                End

    Code

        PtrAndSizeRef &= New ByteArray(8)
        Clear(PtrAndSizeRef,-1)
        If _q &= NULL
            Return 0
        End
        StringRef &= New ByteArray(Size(_q))
        StringRef = _q
        GrpDummyString.DummyString &= StringRef
        AnyField &= What(GrpDummyString,1)
        AddressAndSizeFromAny = AnyField
        PtrAndSize = AddressAndSizeFromAny
        PtrAndSizeRef = AddressAndSizeFromAny
        Return Address(PtrAndSizeRef)

c25_BitConverterClass.JsonStringTheoryToQueue                     Procedure(*StringTheory _jsonStringTheory, *queue _q, <Byte _debug>)

    Code

        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End

        Self.Js1.Start()
        Free(_q)
        Self.Js1.SetTagCase(jf:CaseAsIs)
        Self.Js1.Load(_q, _jsonStringTheory)
        Return 0

c25_BitConverterClass.JsonStringToQueue                     Procedure(String _jsonString, *queue _q, <Byte _debug>)

    Code

        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End

        Self.st1.Start()
        Self.st1.SetValue(Clip(_jsonString))

        Self.Js1.Start()
        Free(_q)
        Self.Js1.SetTagCase(jf:CaseAsIs)
        Self.Js1.Load(_q, Self.st1)
        Return 0


c25_BitConverterClass.FileToJsonStringRef                   Procedure(*File _t, <Byte _allRecords>)

StringRef                               &ByteArray

    Code

        If _t &= NULL
            Return null
        End
        If omitted(_allRecords) = True Or _allRecords = 0
            Get(_t,Pointer(_t))
        End

        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End

        Self.st1.Start()
        Self.Js1.Start()

        Self.Js1.SetRemovePrefix(True)
        Self.Js1.SetReplaceColons(True)
        Self.Js1.SetTagCase(jf:CaseAsIs)

        If omitted(_allRecords) = True Or _allRecords = 0
            Self.Js1.Save(_t, Self.st1,,1,0,False)
        Else
            Self.Js1.Save(_t, Self.st1)
        End
        If Self.st1.Length() > 0
            StringRef &= New ByteArray(Self.st1.Length())
            StringRef = Self.st1.GetValue()
            Return StringRef
        End
        Return null

c25_BitConverterClass.QueueToJsonStringTheory               Procedure(*StringTheory _st, *queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>,<String _filenameSave>)

    Code


        If _q &= NULL
            Return '[]'
        End
        If Records(_q) < 1
            Return '[]'
        End
        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End

        _st.Start()
        Self.Js1.Start()

        Self.Js1.SetTagCase(jf:CaseAsIs)

        Self.Js1.Save(_q, _st)
        If _disposeQ
            Free(_q)
            Dispose(_q)
        End

        If omitted(_filenameSave) = False
            If _st.Length() > 1
                _st.SaveFile(_filenameSave)
            End
        End
        !Dispose(Self.Js1)

        Return ''
        
c25_BitConverterClass.ConvertToI64                            Procedure(string _value)

!Dec                                                                     decimal(20,0)
!Int64                                                                   like(INT64)

Code        
    
    Self.Dec20 = _value
    i64FromDecimal(Self.Int64, Self.Dec20)
    Return Self.Int64 
    
c25_BitConverterClass.ConvertFromI64                         Procedure(string _I64)

!Dec20                                                                     decimal(20,0)
!Int64                                                                   like(INT64)
!DecStr                                                                  string(21)

Code        
    
    Self.Int64 = _I64
    i64ToDecimal(Self.Dec20, Self.Int64)
    Self.DecStr = Self.Dec20
    Return Self.DecStr    
    
c25_BitConverterClass.QToJson                     Procedure(*queue _q, <String _filenameSave>, <bool _format>, <bool _compress>)

DataReflection &c25_DataReflectionClass

    Code

        
        
        !DataReflection &= NEW c25_DataReflectionClass

        Self.st1.Start()
        !Message('hier QToJson')
        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End
        Self.Js1.Start()

        !Message('hier QToJson')
        
        
        If _q &= NULL
            Return '[]'
        End
        Self.Js1.SetTagCase(jf:CaseAsIs)

!        DataReflection.Analyze(_q)
!        I# = 0
!        LOOP
!            I# = I# + 1
!            Get(DataReflection.ClarionFields,I#)
!            If errorcode() <> 0
!                BREAK
!            End
!            If DataReflection.ClarionFields.IsRef And DataReflection.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_STRING !) = 'CLA_STRING'
!                Self.Js1.SetColumnType(_q, Clip(DataReflection.ClarionFields.Name), json:StringPtr)
!            End
!        End
        
        Self.Js1.Save(_q, Self.st1,, _format)
        !Message('hier QToJson')
        
        If omitted(_filenameSave) = False
            If Self.st1.Length() > 1
                Self.st1.SaveFile(_filenameSave)
            End
        End
        !!Dispose(Self.Js1)
        Dispose(DataReflection)
        Return '' !Self.st1.GetValue()

c25_BitConverterClass.GetBytesFromInt16      Procedure(Int16 _int16, <bool _trim>)


    CODE

    C25_Memcpy(Self.BytesArray16KAddress, Address(_int16),2)
    Return Self.BytesArray16K[1 : 2]

c25_BitConverterClass.GetBytesFromInt32      Procedure(Int32 GetBytesFromInt32, <bool _trim>)


ReturnVal string(4)
IntVal    LONG
IntVal4    string(4),Over(IntVal)

    CODE

        IntVal = GetBytesFromInt32
        If omitted(_trim) = False And _trim = True
            If IntVal4[2 : 4] = Chr(0) & Chr(0) & Chr(0)
                ReturnVal = IntVal4[1]
            ElsIf IntVal4[3 : 4] = Chr(0) & Chr(0)
                ReturnVal = IntVal4[1 : 2]
            ElsIf IntVal4[1] = Chr(0)
                ReturnVal = IntVal4[2 : 4]
            Else
                ReturnVal = IntVal4[1 : 4]
            End
            ReturnVal = Left(ReturnVal)
            Return Clip(ReturnVal)
        End
        Return IntVal4

c25_BitConverterClass.StAppendLine                  Procedure(*StringTheory _st, string _line)

    CODE

        _st.Append(Clip(_line) & Chr(13) & Chr(10))


c25_BitConverterClass.GetValueRefByPtr                  Procedure(PtrInt32 _valuePtr, Int32 _valueLen, <bool _freeValuePtr>)

StringRef &ByteArray

CODE

    If _valueLen < 1
        Return NULL
    End
    If _valuePtr = 0
        Return NULL
    End
    StringRef &= New ByteArray(_valueLen)
    C25_Memcpy(Address(StringRef), _valuePtr, _valueLen)
    Return StringRef


c25_BitConverterClass.GetValueByPtr                  Procedure(PtrInt32 _valuePtr, Int32 _valueLen, <bool _freeValuePtr>)


CODE

    If _valueLen > 0 And _valuePtr <> 0
        If NOT Self.BufferStr &= NULL
            Dispose(Self.BufferStr)
        End
        Self.BufferStr &= New ByteArray(_valueLen)
        C25_Memcpy(Address(Self.BufferStr), _valuePtr, _valueLen)
        Return Self.BufferStr
    END
    Return ''


c25_BitConverterClass.GetValueByPtr Procedure(PtrInt32 _valuePtr, Int32 _valueLen, *StringTheory stOut, <bool _freeValuePtr>)

CODE

    If stOut &= NULL
        stOut &= NEW StringTheory()
    End
    stOut.Start()
    If _valueLen > 0 And _valuePtr <> 0
        If NOT Self.BufferStr &= NULL
            Dispose(Self.BufferStr)
        End
        Self.BufferStr &= New ByteArray(_valueLen)
        C25_Memcpy(Address(Self.BufferStr), _valuePtr, _valueLen)

        stOut.Append(Self.BufferStr)
        Dispose(Self.BufferStr)
    End



c25_BitConverterClass.QToJsonToStringTheoryValuePtr Procedure(*Queue _q, *long _valuePtr, *long _valueSize)

format         BOOL
StrRef        &ByteArray

    Code

        Dispose(Self.DataReflectionTemp) ! todo implement a Start for reset
        Self.DataReflectionTemp &= NEW c25_DataReflectionClass

        Self.st1.Start()
        Self.Js1.Start()

        If _q &= NULL
            Return '[]'
        End

        Self.Js1.SetTagCase(jf:CaseAsIs)
        Self.DataReflectionTemp.Analyze(_q)



        format = true
        Self.Js1.Save(_q, Self.st1, , format)


        Self.st1.SaveFile('m:\QToJsonToStringTheoryValuePtr.json')

        Self.Js1.Start()


        StrRef &= New ByteArray(Self.st1.Length())
        StrRef = Self.st1.GetValue()

        _valuePtr = Address(StrRef) !Self.st1.GetAddress()
        _valueSize = Size(StrRef) !Self.st1.Length()

        Return True



c25_BitConverterClass.QueueToJsonString                     Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>,<String _filenameSave>)

DataReflection &c25_DataReflectionClass

    Code

        DataReflection &= NEW c25_DataReflectionClass

        Self.st1.Start()
        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End
        Self.Js1.Start()

        If _q &= NULL
            Return '[]'
        End
        Self.Js1.SetTagCase(jf:CaseAsIs)

        DataReflection.Analyze(_q)
        I# = 0
        LOOP
            I# = I# + 1
            Get(DataReflection.ClarionFields,I#)
            If errorcode() <> 0
                BREAK
            End
            If DataReflection.ClarionFields.IsRef And lower(DataReflection.ClarionFields.DataType) = 'string'
                Self.Js1.SetColumnType(_q,Clip(DataReflection.ClarionFields.Name), json:StringPtr)
            End
        End


        If omitted(_skipFormatted) = False And _skipFormatted = True
            Self.Js1.Save(_q, Self.st1,'',json:Object, False)
        Else
            Self.Js1.Save(_q, Self.st1,'',json:Object, True)
        End
        If _disposeQ
            Message('do not use disposeQ parameter on c25_BitConverterClass.QueueToJsonString')
        End

        If omitted(_filenameSave) = False
            If Self.st1.Length() > 1
                Self.st1.SaveFile(_filenameSave)
            End
        End

        !Dispose(Self.Js1)
        Dispose(DataReflection)

        Return Self.st1.GetValue()

c25_BitConverterClass.QueueToJsonStringRef                  Procedure(*queue _q, <Byte _disposeQ>, <Byte _skipFormatted>, <Byte _compress>)

StringRef  &ByteArray

    Code

        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End
        Self.st1.Start()
        Self.Js1.Start()
        If _q &= NULL
            Return null
        End
        If omitted(_skipFormatted) = False And _skipFormatted = True
            Self.Js1.Save(_q, Self.st1,'',json:Object, False)
        Else
            Self.Js1.Save(_q, Self.st1,'',json:Object, True)
        End

        If _disposeQ
            Free(_q)
            Dispose(_q)
        End
        If Self.st1.Length() > 0
            If _compress = TRUE
                Self.st1.gzip(1)
            End

            StringRef &= New ByteArray(Self.st1.Length())
            StringRef = Self.st1.GetValue()
            Return StringRef
        End
        Return null

c25_BitConverterClass.StringRefToQueue                      Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>)

StringRef  &ByteArray,AUTO

    Code

        If _q &= NULL
            Return ''
        End
        If _initFree
            Free(_q)
        End
        Clear(_q)

        StringRef &= _strRef
        If not StringRef &= NULL
            _q = _strRef
        End
        Add(_q)
        If _skipDisposeStringRef = 0 Or Omitted(_skipDisposeStringRef) = TRUE
            Dispose(StringRef)
        End

        Return _q

c25_BitConverterClass.StringRefJSonToQueue                  Procedure(*String _strRef, *queue _q, <Byte _initFree>, <Byte _skipDisposeStringRef>)

StringRef  &ByteArray,AUTO

    Code

        If _q &= NULL
            Return ''
        End
        If _initFree
            Free(_q)
        End
        Clear(_q)
        If Self.Js1 &= null
            Self.Js1 &= NEW JSONClass()
        End

        Self.Js1.Start()

        StringRef &= _strRef
        If not StringRef &= NULL
            Self.st1.Start()
            Self.st1.SetValue(StringRef)
            Self.Js1.Load(_q,Self.st1)
            Self.Js1.Start()
        End

        If _skipDisposeStringRef = 0 Or Omitted(_skipDisposeStringRef) = TRUE
            Dispose(StringRef)
        End

        Return _q

c25_BitConverterClass.StringToStringRefPtr                  Procedure(String _s)

StringRef                       &ByteArray

GrpDummyString                  Group,Pre(GrpDummyString)
DummyString                         &ByteArray
                                End
AnyField                        ANY
AdrGroup                        Group,pre()
PtrAddress                          Long
PtrSize                             Long
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
PtrAndSizeRef                   &ByteArray
PtrAndSize                      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
                                End

    Code

        PtrAndSizeRef &= New ByteArray(8)
        Clear(PtrAndSizeRef,-1)
        If Size(_s) < 1
            Return 0
        End

        StringRef &= New ByteArray(Size(_s))
        StringRef = _s

        GrpDummyString.DummyString &= StringRef
        AnyField &= What(GrpDummyString,1)
        AddressAndSizeFromAny = AnyField
        PtrAndSize = AddressAndSizeFromAny
        PtrAndSizeRef = AddressAndSizeFromAny

        Return Address(PtrAndSizeRef)

c25_BitConverterClass.StringToStringRefPtr                  Procedure(long _wmSpecial, String _s)

StringRef                       &ByteArray

GrpDummyString                  Group,Pre(GrpDummyString)
DummyString                         &ByteArray
                                End
AnyField                        ANY
AdrGroup                        Group,pre()
PtrAddress                          Long
PtrSize                             Long
                                End
AddressAndSizeFromAny           String(8),over(AdrGroup)
PtrAndSizeRef                   &ByteArray
PtrAndSize                      Group(PtrAndSize_TYPE),Pre(PtrAndSize)
                                End
WmSpecial                       Long
WmSpecialStr4Over               string(4),OVER(WmSpecial)

    Code


        PtrAndSizeRef &= New ByteArray(8)
        Clear(PtrAndSizeRef,-1)

        WmSpecial = _wmSpecial

        StringRef &= New ByteArray(Size(_s) + 4)
        StringRef = WmSpecialStr4Over[1 : 4] & Clip(_s)


        GrpDummyString.DummyString &= StringRef
        AnyField &= What(GrpDummyString,1)
        AddressAndSizeFromAny = AnyField
        PtrAndSize = AddressAndSizeFromAny
        PtrAndSizeRef = AddressAndSizeFromAny

        Return Address(PtrAndSizeRef)




c25_BitConverterClass.StringRefPtrToWmSpecial                  Procedure(Long _ptrAndSizePtr)

WmSpecialStr4                           string(4)
WmSpecialOver                           Long,over(WmSpecialStr4)

    Code

        WmSpecialStr4 = Self.StringRefPtrToString(_ptrAndSizePtr,True)
        Return WmSpecialOver

c25_BitConverterClass.StringRefPtrToStringWmSpecialStr                  Procedure(Long _ptrAndSizePtr)

StringRef                               &ByteArray
PtrAndSize                              Group(PtrAndSize_TYPE),Pre(PtrAndSize)
                                        End

    Code

        If c25_IsBadreadPtr(_ptrAndSizePtr,8) <> 0
            Return ''
        End
        Peek(_ptrAndSizePtr,PtrAndSize)
        StringRef &= (_ptrAndSizePtr)

        StringRef &= NULL

        If PtrAndSize.Size < 1 Or PtrAndSize.Ptr = 0
            Return ''
        End

        If not Self.BufferStr &= NULL
            Dispose(Self.BufferStr)
        End

        Self.BufferStr &= New ByteArray(PtrAndSize.Size)

        If c25_IsBadreadPtr(PtrAndSize.Ptr,PtrAndSize.Size) <> 0
            Return ''
        End

        Peek(PtrAndSize.Ptr,Self.BufferStr)

        If Size(Self.BufferStr) < 5
            Return ''
        End

        Return Self.BufferStr[5 : Size(Self.BufferStr)]

c25_BitConverterClass.StringToJsonObject                    Procedure(string _s)

JsonObject &JSONClass
st  StringTheory()
Code

    JsonObject &= NEW JSONClass()
    JsonObject.Start()
    st.Start()
    st.SetValue(_s)
    JsonObject.LoadString(st)


    Return JsonObject

c25_BitConverterClass.StringRefPtrToString                  Procedure(Long _ptrAndSizePtr, <bool _reuse>)

StringRef                               &ByteArray
PtrAndSize                              Group(PtrAndSize_TYPE),Pre(PtrAndSize)
                                        End

    Code

        If c25_IsBadreadPtr(_ptrAndSizePtr,8) <> 0
            Return ''
        End
        Peek(_ptrAndSizePtr,PtrAndSize)


        If PtrAndSize.Size < 1 Or PtrAndSize.Ptr = 0
            Return ''
        End

        If not Self.BufferStr &= NULL and _reuse = 0
            Dispose(Self.BufferStr)
        End

        Self.BufferStr &= New ByteArray(PtrAndSize.Size)

        If c25_IsBadreadPtr(PtrAndSize.Ptr,PtrAndSize.Size) <> 0
            Return ''
        End

        Peek(PtrAndSize.Ptr,Self.BufferStr)

        Return Self.BufferStr

c25_BitConverterClass.StringRefPtrToQueue                   Procedure(Long _ptrAndSizePtr, *Queue _q, <Byte _add>)

    Code

        If _q &= NULL
            Return 0
        End
        Clear(_q)
        _q = Self.StringRefPtrToString(_ptrAndSizePtr)
        If _add
            Add(_q)
        End
        Return 0

c25_BitConverterClass.CreateGuid36                          Procedure()

Guid16                                  String(16)
Guid36                                  String(36)

    Code

        Clear(Guid16,-1)
        c25_UuidCreate(Address(Guid16))
        Guid36 = Self.Guid16To36(Guid16)

        Return Guid36

c25_BitConverterClass.Guid16To36                            Procedure(String _guid16)

Guid16                                  String(16)
Guid36Ptr                               Long
Guid36                                  String(36)

    Code

        Guid16 = _guid16
        c25_uuidtostringA(Address(Guid16),Address(Guid36Ptr))
        If Guid36Ptr <> 0
            c25_memcpy(Address(Guid36),Guid36Ptr,36)
        End
        Return UPPER(Guid36)

c25_BitConverterClass.CreateString                          Procedure(<String _value>,<Long _len>)

NewString                       &ByteArray

    Code

        If OMITTED(_value) = False
            If Len(clip(_value)) < 1
                Return NULL
            End
            If Omitted(_len) = False And _len > 0
                NewString &= New ByteArray(_len)
            Else
                NewString &= New ByteArray(Len(clip(_value)))
            End
            NewString = _value
            Return NewString
        ElsIf OMITTED(_len) = False And _len > 0
            NewString &= New ByteArray(_len)
            Return NewString
        End
        Return null


c25_BitConverterClass.ShortToHex                                Procedure(short _short, <byte _lowercase>)

Shrt ulong
Code

    Shrt = _short
    Self.Hex8 = LongToHex(Shrt, 0)
    Return Self.Hex8[4 : 8]

c25_BitConverterClass.GetBits8FromString1                   Procedure(String _str)

Code

    Self.STRING1 = _str

    Self.BITS8 = '00000000'
    Self.OneLong = Val(Self.STRING1)

    If BAND(Self.OneLong,00000001B)
        Self.BITS8[8] = '1'
    End
    If BAND(Self.OneLong,00000010B)
        Self.BITS8[7] = '1'
    End
    If BAND(Self.OneLong,00000100B)
        Self.BITS8[6] = '1'
    End
    If BAND(Self.OneLong,00001000B)
        Self.BITS8[5] = '1'
    End
    If BAND(Self.OneLong,00010000B)
        Self.BITS8[4] = '1'
    End
    If BAND(Self.OneLong,00100000B)
        Self.BITS8[3] = '1'
    End
    If BAND(Self.OneLong,01000000B)
        Self.BITS8[2] = '1'
    End
    If BAND(Self.OneLong,10000000B)
        Self.BITS8[1] = '1'
    End
    Return Self.BITS8

c25_BitConverterClass.GetBits16FromShort                     Procedure(LONG _int16)

SomeInt long
STR4                                                                STRING(4),over(SomeInt)

    Code

        SomeInt = _int16
        Self.Str2 = STR4[1 : 2]

        Return Self.GetBits8FromString1(Self.Str2[2]) & Self.GetBits8FromString1(Self.Str2[1])

c25_BitConverterClass.GetBits16FromStr2                     Procedure(String _str2)

    Code

        Self.Str2 = _str2
        Return Self.GetBits8FromString1(Self.Str2[2]) & Self.GetBits8FromString1(Self.Str2[1])

c25_BitConverterClass.GetBits32FromLong                     Procedure(Long _int32)


    Code

        Self.Str4 = _int32
        Return Self.GetBits8FromString1(Self.Str4[4]) & Self.GetBits8FromString1(Self.Str4[3]) & Self.GetBits8FromString1(Self.Str4[2]) & Self.GetBits8FromString1(Self.Str4[1])

c25_BitConverterClass.GetBits32FromStr4                     Procedure(String _str)

    Code

        Self.Str4 = _str
        Return Self.GetBits8FromString1(Self.Str4[4]) & Self.GetBits8FromString1(Self.Str4[3]) & Self.GetBits8FromString1(Self.Str4[2]) & Self.GetBits8FromString1(Self.Str4[1])

c25_BitConverterClass.Guid74To16                            Procedure(String _guid74)

Guid74 String(74)
Guid16 String(16)
Guid36 String(36)

    Code

        Guid74        = _guid74

        Self.st1.Start()
        Self.st1.SetValue(Guid74)
        Self.st2.Start()
        Self.st2.SetValue(Self.st1.Sub(3,8) & '-' & Self.st1.Sub(15,4)  & '-' &  Self.st1.Sub(23,4)  & '-' &  Self.st1.Sub(31,2) & Self.st1.Sub(37,2)  & '-' &  Self.st1.Sub(43,2) & Self.st1.Sub(49,2) & Self.st1.Sub(55,2) & Self.st1.Sub(61,2) & Self.st1.Sub(67,2) & Self.st1.Sub(73,2) )

        Guid36      = Upper(Self.st2.GetValue())
        Guid16      = Self.Guid16FromGuid36(Guid36)

        Return Guid16

c25_BitConverterClass.Guid74To36                            Procedure(String _guid74)

Guid74 String(74)
Guid36 String(36)

    Code

        Guid74        = _guid74

        Self.st1.Start()
        Self.st1.SetValue(Guid74)
        Self.st2.Start()
        Self.st2.SetValue(Self.st1.Sub(3,8) & '-' & Self.st1.Sub(15,4)  & '-' &  Self.st1.Sub(23,4)  & '-' &  Self.st1.Sub(31,2) & Self.st1.Sub(37,2)  & '-' &  Self.st1.Sub(43,2) & Self.st1.Sub(49,2) & Self.st1.Sub(55,2) & Self.st1.Sub(61,2) & Self.st1.Sub(67,2) & Self.st1.Sub(73,2) )

        Guid36 = Upper(Self.st2.GetValue())
        Return Guid36

c25_BitConverterClass.INT64ToBits                           Procedure(String _int64)

    Code

    Self.Bits64 = All('0',64)
    Self.Int64Str8 = _int64

    Self.BytePos = 0
    Loop 8 TIMES
        Self.BytePos = Self.BytePos + 1
        Self.ByteVal = Val(Self.Int64Str8[9-Self.BytePos])

        If Self.ByteVal = 0
            CYCLE
        End
        Self.BitPos = (Self.BytePos*8) - 7
        If BAND(Self.ByteVal,10000000b)
            Self.Bits64[Self.BitPos] = '1'
        End
        If BAND(Self.ByteVal,01000000b)
            Self.Bits64[Self.BitPos+1] = '1'
        End
        If BAND(Self.ByteVal,00100000b)
            Self.Bits64[Self.BitPos+2] = '1'
        End
        If BAND(Self.ByteVal,00010000b)
            Self.Bits64[Self.BitPos+3] = '1'
        End
        If BAND(Self.ByteVal,00001000b)
            Self.Bits64[Self.BitPos+4] = '1'
        End
        If BAND(Self.ByteVal,00000100b)
            Self.Bits64[Self.BitPos+5] = '1'
        End
        If BAND(Self.ByteVal,00000010b)
            Self.Bits64[Self.BitPos+6] = '1'
        End
        If BAND(Self.ByteVal,01000001b)
            Self.Bits64[Self.BitPos+7] = '1'
        End
    End
    Return Self.Bits64

c25_BitConverterClass.GetShortFromStr2                      Procedure(String _str2)

    Code

    Self.Str2 = _str2
    Return Self.ShortOverStr2

c25_BitConverterClass.GetUShortFromStr2                     Procedure(String _str2)

    Code

    Self.Str2 = _str2
    Return Self.UShortOverStr2

c25_BitConverterClass.GetLongFromStr4                       Procedure(String _str4)

    Code

    Self.Str4 = _str4
    Return Self.LongOverStr4

c25_BitConverterClass.GetULongFromStr4                      Procedure(String _str4)

    Code

    Self.Str4 = _str4
    Return Self.ULongOverStr4

c25_BitConverterClass.ReplaceCharsAnsi                      Procedure(String _str, String _old, String _new, <Long _codePage>)

    Code

        Self.st1.Start()
        Self.st1.encoding = st:EncodeAnsi
        If omitted(_codePage) = False
            Self.st1.CodePage = _codePage
        ELSE
            Self.st1.CodePage = st:CP_OEMCP
        End
        Self.st1.SetValue(_str)
        Self.st1.Replace(_old,_new)
        _str = Self.st1.GetValue()
        Return _str

c25_BitConverterClass.ReplaceCharsUtf8                      Procedure(String _str, String _old, String _new)

    Code

        Self.st1.Start()
        Self.st1.encoding = st:EncodeUtf8
        Self.st1.CodePage = st:CP_UTF8
        Self.st1.SetValue(_str)
        Self.st1.Replace(_old,_new)
        _str = Self.st1.GetValue()
        Return _str

c25_BitConverterClass.ReplaceCharsUtf16                     Procedure(String _str, String _old, String _new)

    Code

        Self.st1.Start()
        Self.st1.encoding = st:EncodeUtf16
        Self.st1.SetValue(_str)
        Self.st1.Replace(_old,_new)
        Return _str

        
c25_BitConverterClass.IntegerStringToUInt64 Procedure(string _integer)     

Dec1            Decimal(20)
UInt64Val       like(UINT64)

    CODE
        
    Dec1 = _integer
    i64FromDecimal(UInt64Val,Dec1)
    Return UInt64Val
        
        
        
        
        
c25_BitConverterClass.Int32ToHex                            Procedure(Int32 _int32, <bool _trim>, <bool _prefixOddWithZero>)

Hex       string(32)
HexReturn string(32)

CODE
        
    F# = 0
    Hex = LongToHex(_int32)
    T# = 0
    Loop Size(Hex) TIMES
        T# = T# + 1
        If Hex[T#] = '0' And F# = False
            Cycle
        End
        F# = True
        HexReturn = Clip(HexReturn) & Hex[T#]
    End
    If _prefixOddWithZero
        If (Len(Clip(HexReturn)) %2)
            HexReturn = '0' & HexReturn
        End    
    End
    Return Clip(HexReturn)
        
c25_BitConverterClass.RemoveTrailingZeros                   Procedure(String _str, <Long _encoding>)

StringRefOut                            &ByteArray

    Code

        L# = Len(_str)
        NL# = L#

        Case _encoding
        Of st:EncodeUtf16
            P# = L# + 1
            Loop
                P# = P# - 1
                If P# < 1
                    Break
                End

                If _str[P#] = Chr(0)
                    NL# = P# - 1
                End
            End
            If (NL#%2)
                NL# = NL# + 1
            End
            If NL# < 1
                Return NULL
            Else
                StringRefOut &= New ByteArray(NL#)
                StringRefOut = _str
                Return StringRefOut
            End
        ELSE
            P# = L# + 1
            Loop
                P# = P# - 1
                If P# < 1
                    Break
                End

                If _str[P#] = Chr(0)
                    NL# = P# - 1
                End
            End

            If NL# < 1
                Return NULL
            Else
                StringRefOut &= New ByteArray(NL#)
                StringRefOut = _str
                Return StringRefOut
            End

        End
        Return NULL

c25_BitConverterClass.ConcatAnsiStr                         Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)

StringRefOut                    &ByteArray

Code
        
    If Self.StAnsi &= null
        Self.StAnsi &= New StringTheory()
    End
    If Self.StAnsiToAnsi &= null
        Self.StAnsiToAnsi &= New StringTheory()
    End    
    Self.StAnsi.Start()
    Self.StAnsiToAnsi.Start()
        
        Self.StAnsi.encoding = st:EncodeAnsi
        Self.StAnsi.CodePage = st:CP_THREAD_ACP
        Self.StAnsi.Append(_s1)

        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False
            Self.StAnsi.Append(_divider)
        End
        Self.StAnsi.Append(_s2)
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s3) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s3)
        ElsIf omitted(_s3) = False
            Self.StAnsi.Append(_s3)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s4) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s4)
        ElsIf omitted(_s4) = False
            Self.StAnsi.Append(_s4)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s5) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s5)
        ElsIf omitted(_s5) = False
            Self.StAnsi.Append(_s5)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s6) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s6)
        ElsIf omitted(_s6) = False
            Self.StAnsi.Append(_s6)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s7) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s7)
        ElsIf omitted(_s7) = False
            Self.StAnsi.Append(_s7)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s8) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s8)
        ElsIf omitted(_s8) = False
            Self.StAnsi.Append(_s8)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If Self.StAnsi.Length() > 0
            StringRefOut &= New ByteArray(Self.StAnsi.Length())
            StringRefOut = Self.StAnsi.GetValue()

            If not Self.BufferStr &= NULL
                Dispose(Self.BufferStr)
            End
            Self.BufferStr &= New ByteArray(Len(StringRefOut))
            Self.BufferStr = StringRefOut
            Dispose(StringRefOut)
            Return Self.BufferStr
        End

        Return ''

c25_BitConverterClass.ConcatUtf8Str                         Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)

StringRefOut                    &ByteArray

    Code

        Self.StUtf8.Start()
        Self.StUtf8.encoding = st:EncodeUtf8
        Self.StUtf8.CodePage = st:CP_UTF8
        Self.StUtf8.Append(_s1)

        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False
            Self.StUtf8.Append(_divider)
        End
        Self.StUtf8.Append(_s2)
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s3) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s3)
        ElsIf omitted(_s3) = False
            Self.StUtf8.Append(_s3)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s4) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s4)
        ElsIf omitted(_s4) = False
            Self.StUtf8.Append(_s4)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s5) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s5)
        ElsIf omitted(_s5) = False
            Self.StUtf8.Append(_s5)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s6) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s6)
        ElsIf omitted(_s6) = False
            Self.StUtf8.Append(_s6)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s7) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s7)
        ElsIf omitted(_s7) = False
            Self.StUtf8.Append(_s7)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s8) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s8)
        ElsIf omitted(_s8) = False
            Self.StUtf8.Append(_s8)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If Self.StUtf8.Length() > 0
            StringRefOut &= New ByteArray(Self.StUtf8.Length())
            StringRefOut = Self.StUtf8.GetValue()

            If not Self.BufferStr &= NULL
                Dispose(Self.BufferStr)
            End
            Self.BufferStr &= New ByteArray(Len(StringRefOut))
            Self.BufferStr = StringRefOut
            Dispose(StringRefOut)
            Return Self.BufferStr
        End

        Return ''

c25_BitConverterClass.ConcatUtf16Str                        Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)

StringRefOut                    &ByteArray
PreRemoveTrailingZeros          Byte

Code

        
    If Self.StUtf16 &= null
        Self.StUtf16 &= New StringTheory()
    End
 
    Self.StUtf16.Start()
    
        
        PreRemoveTrailingZeros = _preRemoveTrailingZeros
        PreRemoveTrailingZeros = False
        Self.StUtf16.Start()
        Self.StUtf16.encoding = st:EncodeUtf16
        Self.StUtf16.Append(_s1)

        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False
            Self.StUtf16.Append(_divider)
        End
        Self.StUtf16.Append(_s2)
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s3) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s3)
        ElsIf omitted(_s3) = False
            Self.StUtf16.Append(_s3)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s4) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s4)
        ElsIf omitted(_s4) = False
            Self.StUtf16.Append(_s4)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s5) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s5)
        ElsIf omitted(_s5) = False
            Self.StUtf16.Append(_s5)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s6) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s6)
        ElsIf omitted(_s6) = False
            Self.StUtf16.Append(_s6)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s7) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s7)
        ElsIf omitted(_s7) = False
            Self.StUtf16.Append(_s7)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s8) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s8)
        ElsIf omitted(_s8) = False
            Self.StUtf16.Append(_s8)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If Self.StUtf16.Length() > 0
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            Else
            End

            StringRefOut &= New ByteArray(Self.StUtf16.Length())
            StringRefOut = Self.StUtf16.GetValue()

            If not Self.BufferStr &= NULL
                Dispose(Self.BufferStr)
            End
            Self.BufferStr &= New ByteArray(Len(StringRefOut))
            Self.BufferStr = StringRefOut
            Dispose(StringRefOut)
            Return Self.BufferStr
        End

        Return ''

c25_BitConverterClass.ConcatAnsi                            Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)

StringRefOut                    &ByteArray

Code

    If Self.StAnsi &= null
        Self.StAnsi &= New StringTheory()
    End
    If Self.StAnsiToAnsi &= null
        Self.StAnsiToAnsi &= New StringTheory()
    End    
    Self.StAnsi.Start()
    Self.StAnsiToAnsi.Start()
                
        
        !Self.StAnsi.Start()
        Self.StAnsi.encoding = st:EncodeAnsi
        Self.StAnsi.CodePage = st:CP_THREAD_ACP
        Self.StAnsi.Append(_s1)

        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False
            Self.StAnsi.Append(_divider)
        End
        Self.StAnsi.Append(_s2)
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s3) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s3)
        ElsIf omitted(_s3) = False
            Self.StAnsi.Append(_s3)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s4) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s4)
        ElsIf omitted(_s4) = False
            Self.StAnsi.Append(_s4)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s5) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s5)
        ElsIf omitted(_s5) = False
            Self.StAnsi.Append(_s5)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s6) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s6)
        ElsIf omitted(_s6) = False
            Self.StAnsi.Append(_s6)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s7) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s7)
        ElsIf omitted(_s7) = False
            Self.StAnsi.Append(_s7)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s8) = False
            Self.StAnsi.Append(_divider)
            Self.StAnsi.Append(_s8)
        ElsIf omitted(_s8) = False
            Self.StAnsi.Append(_s8)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StAnsi.Length() < 1
                    Break
                End
                If Self.StAnsi.EndsWith(Chr(0))
                    Self.StAnsi.RemoveFromPosition(Self.StAnsi.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If Self.StAnsi.Length() > 0
            StringRefOut &= New ByteArray(Self.StAnsi.Length())
            StringRefOut = Self.StAnsi.GetValue()
            Return StringRefOut
        End

        Return NULL

c25_BitConverterClass.ConcatUtf8                            Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)

StringRefOut                    &ByteArray

Code

        
    If Self.StUtf8 &= null
        Self.StUtf8 &= New StringTheory()
    End
 
    Self.StUtf8.Start()
    
        
        Self.StUtf8.Start()
        Self.StUtf8.encoding = st:EncodeUtf8
        Self.StUtf8.CodePage = st:CP_UTF8
        Self.StUtf8.Append(_s1)

        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False
            Self.StUtf8.Append(_divider)
        End
        Self.StUtf8.Append(_s2)
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s3) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s3)
        ElsIf omitted(_s3) = False
            Self.StUtf8.Append(_s3)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s4) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s4)
        ElsIf omitted(_s4) = False
            Self.StUtf8.Append(_s4)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s5) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s5)
        ElsIf omitted(_s5) = False
            Self.StUtf8.Append(_s5)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s6) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s6)
        ElsIf omitted(_s6) = False
            Self.StUtf8.Append(_s6)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s7) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s7)
        ElsIf omitted(_s7) = False
            Self.StUtf8.Append(_s7)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If omitted(_divider) = False And omitted(_s8) = False
            Self.StUtf8.Append(_divider)
            Self.StUtf8.Append(_s8)
        ElsIf omitted(_s8) = False
            Self.StUtf8.Append(_s8)
        End
        If _preRemoveTrailingZeros = True
            Loop
                If Self.StUtf8.Length() < 1
                    Break
                End
                If Self.StUtf8.EndsWith(Chr(0))
                    Self.StUtf8.RemoveFromPosition(Self.StUtf8.Length()-0,1)
                Else
                    BREAK
                End
            End
        End

        If Self.StUtf8.Length() > 0
            StringRefOut &= New ByteArray(Self.StUtf8.Length())
            StringRefOut = Self.StUtf8.GetValue()
            Return StringRefOut
        Else
            StringRefOut &= New ByteArray(6)
            StringRefOut = '<NULL>'
            Return StringRefOut
        End

        Return NULL

c25_BitConverterClass.ConcatUtf16                           Procedure(<Byte _preRemoveTrailingZeros>,<String _divider>,String _s1, String _s2, <String _s3>,  <String _s4>, <String _s5>, <String _s6>, <String _s7>, <String _s8>)

StringRefOut                    &ByteArray
PreRemoveTrailingZeros          Byte

Code

    
    If Self.StUtf16 &= null
        Self.StUtf16 &= New StringTheory()
    End
 
    Self.StUtf16.Start()
    
        PreRemoveTrailingZeros = _preRemoveTrailingZeros
        PreRemoveTrailingZeros = False

        Self.StUtf16.encoding = st:EncodeUtf16
        Self.StUtf16.Append(_s1)

        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False
            Self.StUtf16.Append(_divider)
        End
        Self.StUtf16.Append(_s2)
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s3) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s3)
        ElsIf omitted(_s3) = False
            Self.StUtf16.Append(_s3)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s4) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s4)
        ElsIf omitted(_s4) = False
            Self.StUtf16.Append(_s4)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s5) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s5)
        ElsIf omitted(_s5) = False
            Self.StUtf16.Append(_s5)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s6) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s6)
        ElsIf omitted(_s6) = False
            Self.StUtf16.Append(_s6)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s7) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s7)
        ElsIf omitted(_s7) = False
            Self.StUtf16.Append(_s7)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If omitted(_divider) = False And omitted(_s8) = False
            Self.StUtf16.Append(_divider)
            Self.StUtf16.Append(_s8)
        ElsIf omitted(_s8) = False
            Self.StUtf16.Append(_s8)
        End
        If PreRemoveTrailingZeros = True
            Loop
                If Self.StUtf16.Length() < 1
                    Break
                End
                If Self.StUtf16.EndsWith(Chr(0) & Chr(0))
                    Self.StUtf16.RemoveFromPosition(Self.StUtf16.Length()-1,2)
                Else
                    BREAK
                End
            End
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            End
        End

        If Self.StUtf16.Length() > 0
            If (Self.StUtf16.Length()%2)
                Self.StUtf16.Append(Chr(0))
            Else
            End
            StringRefOut &= New ByteArray(Self.StUtf16.Length())
            StringRefOut = Self.StUtf16.GetValue()

            Return StringRefOut
        End

        Return NULL
!
!c25_BitConverterClasss.Guid16FromGuid36                      Procedure(String _guid36)
!
!Code
!
!    Self.Guid36 = _guid36
!
!    Return Self.FastCharFromHex2(Self.Guid36[7:8]) & |
!        Self.FastCharFromHex2(Self.Guid36[5:6]) & |
!        Self.FastCharFromHex2(Self.Guid36[3:4]) & |
!        Self.FastCharFromHex2(Self.Guid36[1:2]) & |
!        Self.FastCharFromHex2(Self.Guid36[12:13]) & |
!        Self.FastCharFromHex2(Self.Guid36[10:11]) & |
!        Self.FastCharFromHex2(Self.Guid36[17:18]) & |
!        Self.FastCharFromHex2(Self.Guid36[15:16]) & |
!        Self.FastCharFromHex2(Self.Guid36[20:21]) & |
!        Self.FastCharFromHex2(Self.Guid36[22:23]) & |
!        Self.FastCharFromHex2(Self.Guid36[25:26]) & |
!        Self.FastCharFromHex2(Self.Guid36[27:28]) & |
!        Self.FastCharFromHex2(Self.Guid36[29:30]) & |
!        Self.FastCharFromHex2(Self.Guid36[31:32]) & |
!        Self.FastCharFromHex2(Self.Guid36[33:34]) & |
!        Self.FastCharFromHex2(Self.Guid36[35:36])
!
!        



c25_BitConverterClass.AnsiToUtf8    Procedure(String _ansi, <long _extraZeroCount>)

StringRefOut                                                    &ByteArray
ExtraZeroCount long

    Code

        If omitted(_extraZeroCount) = FALSE
            ExtraZeroCount = _extraZeroCount
        End
        Self.StAnsiToUtf8.Start()
        Self.StAnsiToUtf8.encoding = st:EncodeAnsi
        Self.StAnsiToUtf8.codepage = st:CP_ACP

        Self.StAnsiToUtf8.SetValue(clip(_ansi))
        Self.StAnsiToUtf8.ToUnicode(st:EncodeUtf8)

        If Self.StAnsiToUtf8.Length() > 0
            StringRefOut &= New ByteArray(Self.StAnsiToUtf8.Length() + ExtraZeroCount)
            
            If ExtraZeroCount > 0
                StringRefOut = Self.StAnsiToUtf8.GetValue() + All(Chr(0),ExtraZeroCount)
            ELSE
                StringRefOut = Self.StAnsiToUtf8.GetValue()
            End
            Return StringRefOut
        ELSE
            Return NULL
        End

c25_BitConverterClass.AnsiToUtf8GetLength                   Procedure(String _ansi)

StringRefOut                                    &ByteArray

    Code

        StringRefOut &= Self.AnsiToUtf8(_ansi)
        If StringRefOut &= NULL
            Return 0
        End
        L# = Len(StringRefOut)
        Dispose(StringRefOut)
        Return L#

c25_BitConverterClass.AnsiToUtf16                           Procedure(String _ansi, <Byte _debug>,<Byte _addUtf16Zero>)

StringRefOut &ByteArray

    Code

        If (Size(_ansi) < 1 or Size(_ansi) > 2000000 Or Len(Clip(_ansi)) < 1) And _addUtf16Zero <> True
            Return NULL
        End

        Self.StAnsiToUtf16.Start()

        Self.StAnsiToUtf16.encoding = st:EncodeAnsi
        Self.StAnsiToUtf16.codepage = st:CP_ACP

        Self.StAnsiToUtf16.Append(_ansi)
        If _debug
            Message('done Self.StAnsiToUtf16.Append(_ansi)')
        End
        Self.StAnsiToUtf16.ToUnicode(st:EncodeUtf16)
        If _debug
            Message('done Self.StAnsiToUtf16.Append(_ansi)')
        End
        If _debug
            Message('Self.StAnsiToUtf16.Length() ' & Self.StAnsiToUtf16.Length())
        End
        If Self.StAnsiToUtf16.Length() > 0 Or _addUtf16Zero = True
            If _addUtf16Zero = True
                StringRefOut &= New ByteArray(Self.StAnsiToUtf16.Length() + 2)
                StringRefOut = Self.StAnsiToUtf16.GetValue() & Chr(0) & Chr(0)
            ELSE
                StringRefOut &= New ByteArray(Self.StAnsiToUtf16.Length())
                StringRefOut = Self.StAnsiToUtf16.GetValue()
            End
            If _debug
                Message('Return stringrefout')
            End
            Return StringRefOut
        ELSE
            If _debug
                Message('Return null')
            End
            Return NULL
        End
        Return NULL

c25_BitConverterClass.AnsiToUtf16Str                           Procedure(String _ansi, <Byte _debug>,<Byte _addUtf16Zero>)

    Code

        If (Size(_ansi) < 1 or Size(_ansi) > 2000000 Or Len(Clip(_ansi)) < 1) And _addUtf16Zero <> True
            Return ''
        End

        If not Self.BufferStr &= NULL
            Dispose(Self.BufferStr)
        End

        Self.StAnsiToUtf16.Start()

        Self.StAnsiToUtf16.encoding = st:EncodeAnsi
        Self.StAnsiToUtf16.codepage = st:CP_ACP

        Self.StAnsiToUtf16.Append(_ansi)
        If _debug
            Message('done Self.StAnsiToUtf16.Append(_ansi)')
        End
        Self.StAnsiToUtf16.ToUnicode(st:EncodeUtf16)
        If _debug
            Message('done Self.StAnsiToUtf16.Append(_ansi)')
        End
        If _debug
            Message('Self.StAnsiToUtf16.Length() ' & Self.StAnsiToUtf16.Length())
        End
        If Self.StAnsiToUtf16.Length() > 0 Or _addUtf16Zero = True
            If _addUtf16Zero = True
                Self.BufferStr &= New ByteArray(Self.StAnsiToUtf16.Length() + 2)
                Self.BufferStr = Self.StAnsiToUtf16.GetValue() & Chr(0) & Chr(0)
            ELSE
                Self.BufferStr &= New ByteArray(Self.StAnsiToUtf16.Length())
                Self.BufferStr = Self.StAnsiToUtf16.GetValue()
            End
            If _debug
                Message('Return stringrefout')
            End

            Return Self.BufferStr
        ELSE
            If _debug
                Message('Return null')
            End
            Return ''
        End
        Return ''

c25_BitConverterClass.AnsiToUtf16Fast                           Procedure(*String _ansi, Long _lenAnsi, <*String _utf16>)

    Code

        If _lenAnsi < 1
            Return ''
        End
        If omitted(_utf16) = False
            If Size(_utf16) >= _lenAnsi * 2
                Clear(_utf16,-1)
                Self.P = 1
                Self.T = 1
                Loop _lenAnsi Times
                    _utf16[Self.T] = _ansi[Self.P]
                    Self.P = Self.P + 1
                    Self.T = Self.T + 2
                End
            End
            Return ''
        ELSE
            If not Self.Utf16Buffer &= null
                If Size(Self.Utf16Buffer) < _lenAnsi * 2
                    Dispose(Self.Utf16Buffer)
                    Self.Utf16Buffer &= New ByteArray(_lenAnsi * 2)
                End
            Else
                Self.Utf16Buffer &= New ByteArray(_lenAnsi * 2)
            End
            Clear(Self.Utf16Buffer,-1)
            Self.P = 1
            Self.T = 1
            Loop _lenAnsi Times
                Self.Utf16Buffer[Self.T] = _ansi[Self.P]
                Self.P = Self.P + 1
                Self.T = Self.T + 2
            End
            Return Self.Utf16Buffer[1 : Self.T]
        End
        Return ''

c25_BitConverterClass.AnsiToUtf16GetLength                  Procedure(String _ansi)

StringRefOut                                    &ByteArray

    Code

        StringRefOut &= Self.AnsiToUtf16(_ansi)
        If StringRefOut &= NULL
            Return 0
        End
        L# = Len(StringRefOut)
        Dispose(StringRefOut)
        Return L#

c25_BitConverterClass.MultiSzZeroToCRLFUtf16Str             Procedure(String _utf16)

    Code

        If not Self.ReturnString &= NULL
            Dispose(Self.ReturnString)
        End
        Self.ReturnString &= Self.MultiSzZeroToCRLFUtf16(_utf16)
        If Self.ReturnString &= NULL
            Return ''
        End
        Return Clip(Self.ReturnString)

c25_BitConverterClass.MultiSzZeroToCRLFUtf16                Procedure(String _utf16)

CroppedUtf16        &ByteArray
StringRefOut        &ByteArray

    Code

        CroppedUtf16 &= Self.CropZerosUtf16(_utf16)

        L# = Len(CroppedUtf16)
        If L# < 2
            Return null
        End

        Self.StUtf16.Start()
        Self.StUtf16.encoding = st:EncodeUtf16

        P# = -1
        Loop
            P# = P# + 2
            If P# >= L#
                BREAK
            End
            If P# + 3 =< L#
                If CroppedUtf16[P# : P# + 3] = Chr(0) & Chr(0) & Chr(0) & Chr(0)
                    BREAK
                End
            End
            If CroppedUtf16[P# : P# + 1] = Chr(0) & Chr(0)
                Self.StUtf16.Append(Chr(13) & Chr(0) & Chr(10) & Chr(0))
            Else
                Self.StUtf16.Append(CroppedUtf16[P# : P# + 1])
            End
        End
        Self.StUtf16.Append(Chr(13) & Chr(0) & Chr(10) & Chr(0))
        Dispose(CroppedUtf16)

        If Self.StUtf16.Length() < 1
            Return NULL
        End
        StringRefOut &= New ByteArray(Self.StUtf16.Length())
        StringRefOut = Self.StUtf16.GetValue()

        Return StringRefOut


c25_BitConverterClass.CropZerosAnsi                         Procedure(String _ansi)

StringRefOut        &ByteArray

    Code

        If Len(_ansi) < 1
            Return NULL
        End

        L# = Len(Self.CropZerosAnsiStr(_ansi))
        If L# < 1
            Return NULL
        End
        StringRefOut &= New ByteArray(L#)
        StringRefOut = Self.CropZerosAnsiStr(_ansi)

        Return StringRefOut

c25_BitConverterClass.CropZerosAnsiStr                      Procedure(String _ansi)

    Code

        P# = Len(Clip(_ansi)) + 1
        Loop
            P# = P# - 1
            If P# < 1
                Return ''
            ELSE
                If _ansi[P#] = Chr(0)
                    Cycle
                ELSE
                    If P# = 1
                        Return _ansi[P#]
                    ELSE
                        Return _ansi[1 : P#]
                    End
                End
            End
        End
        Return ''

c25_BitConverterClass.CropZerosUtf8                         Procedure(String _utf8)

StringRefOut        &ByteArray

    Code

        If LEN(CLIP(_utf8)) < 1
            Return NULL
        End
        StringRefOut        &= New ByteArray(LEN(CLIP(_utf8)))
        StringRefOut        = Self.CropZerosAnsiStr(_utf8)
        Return StringRefOut

c25_BitConverterClass.CropZerosUtf8Str                      Procedure(String _utf8)

    Code

        Return Self.CropZerosAnsiStr(_utf8)

c25_BitConverterClass.CropZerosUtf16                        Procedure(String _utf16)

StringRefOut        &ByteArray

    Code

        If Len(_utf16) < 1
            Return NULL
        End

        L# = Len(Self.CropZerosUtf16Str(_utf16))
        If L# < 2
            Return NULL
        End
        StringRefOut &= New ByteArray(L#)
        StringRefOut = Self.CropZerosUtf16Str(_utf16)

        Return StringRefOut

c25_BitConverterClass.CropZerosUtf16Str                     Procedure(String _utf16)

    Code

        P# = Len(Clip(_utf16)) + 1
        LOOP
            P# = P# - 1
            If P# < 1
                Return ''
            ELSE
                If _utf16[P#] = Chr(0)
                    Cycle
                ELSE
                    If P# = 1
                        Return _utf16[1] & Chr(0)
                    Else
                        If (P#%2)
                            Return _utf16[1 : P#] & Chr(0)
                        Else
                            Return _utf16[1 : P#]
                        End
                    End
                End
            End
        End
        Return ''


c25_BitConverterClass.ColorFromARGB                         Procedure(long _a, long _b, long _g, long _r)

Code

    Return (_a * 16777216) + (_r * 65536) + (_g * 256) + _b

c25_BitConverterClass.Utf8ToAnsi                            Procedure(String _utf8)

StringRefOut &ByteArray

    Code

        If Len(Clip(_utf8)) < 1
            Return NULL
        End
        Self.StUtf8ToAnsi.Start()
        Self.StUtf8ToAnsi.encoding = st:EncodeUtf8
        Self.StUtf8ToAnsi.codepage = st:CP_UTF8

        Self.StUtf8ToAnsi.SetValue(clip(_utf8))
        Self.StUtf8ToAnsi.ToAnsi()

        If Self.StUtf8ToAnsi.Length() > 0
            StringRefOut &= New ByteArray(Self.StUtf8ToAnsi.Length())
            StringRefOut = Self.StUtf8ToAnsi.GetValue()
            Return StringRefOut
        ELSE
            Return NULL
        End

c25_BitConverterClass.Utf8ToUtf8                            Procedure(String _utf8)

StringRefOut                        &ByteArray

    Code

        If Len(_utf8) < 1
            Return NULL
        End

        StringRefOut &= New ByteArray(Len(_utf8))
        StringRefOut = _utf8
        Return StringRefOut

c25_BitConverterClass.Utf8ToUtf16                           Procedure(String _utf8, <bool _debug>, <BOOL _addUtf16Zero>)

StringRefOut &ByteArray

Code

        If (Size(_utf8) < 1 or Size(_utf8) > 2000000 Or Len(Clip(_utf8)) < 1) And _addUtf16Zero <> True
            Return NULL
        End

        Self.StAnsiToUtf16.Start()

        Self.StAnsiToUtf16.encoding = st:EncodeUtf8
        Self.StAnsiToUtf16.codepage = st:CP_UTF8 !st:CP_ACP

        Self.StAnsiToUtf16.Append(_utf8)
        If _debug
            Message('done Self.StAnsiToUtf16.Append(_ansi)')
        End
        Self.StAnsiToUtf16.ToUnicode(st:EncodeUtf16)
        If _debug
            Message('done Self.StAnsiToUtf16.Append(_ansi)')
        End
        If _debug
            Message('Self.StAnsiToUtf16.Length() ' & Self.StAnsiToUtf16.Length())
        End
        If Self.StAnsiToUtf16.Length() > 0 Or _addUtf16Zero = True
            If _addUtf16Zero = True
                StringRefOut &= New ByteArray(Self.StAnsiToUtf16.Length() + 2)
                StringRefOut = Self.StAnsiToUtf16.GetValue() & Chr(0) & Chr(0)
            ELSE
                StringRefOut &= New ByteArray(Self.StAnsiToUtf16.Length())
                StringRefOut = Self.StAnsiToUtf16.GetValue()
            End
            If _debug
                Message('Return stringrefout')
            End
            Return StringRefOut
        ELSE
            If _debug
                Message('Return null')
            End
            Return NULL
        End
        Return NULL

c25_BitConverterClass.Utf16ToUtf8                           Procedure(String _utf16)

StringRefOut &ByteArray

Code

    If Len(_utf16) < 2
        Return NULL
    End

    If Self.StUtf16ToUtf8 &= NULL
        Self.StUtf16ToUtf8 &= NEW StringTheory()
    END
    
    Self.StUtf16ToUtf8.Start()
    Self.StUtf16ToUtf8.encoding = st:EncodeUtf16

    Self.StUtf16ToUtf8.SetValue(_utf16)
    Self.StUtf16ToUtf8.ToUnicode(st:EncodeUtf8)

    If Self.StUtf16ToUtf8.Length() > 0
        StringRefOut &= New ByteArray(Self.StUtf16ToUtf8.Length())
        StringRefOut = Self.StUtf16ToUtf8.GetValue()
        Return StringRefOut
    ELSE
        Return NULL
    End

c25_BitConverterClass.Utf16ToUtf8Str                        Procedure(String _utf16, <bool _addTrailingZero>)


Code

    If Len(_utf16) < 2
        If _addTrailingZero
            Return Chr(0) & Chr(0)
        End
        Return ''
    End

    If Self.StUtf16ToUtf8 &= NULL
        Self.StUtf16ToUtf8 &= NEW StringTheory()
    END
        
    Self.StUtf16ToUtf8.Start()
    Self.StUtf16ToUtf8.encoding = st:EncodeUtf16

    Self.StUtf16ToUtf8.SetValue(_utf16)
    If _addTrailingZero = True
        If Self.StUtf16ToUtf8.EndsWith(Chr(0) & Chr(0)) = 0
            Self.StUtf16ToUtf8.Append(Chr(0) & Chr(0))
        End
    End
    Self.StUtf16ToUtf8.ToUnicode(st:EncodeUtf8)

    Return Self.StUtf16ToUtf8.GetValue()

c25_BitConverterClass.BinaryCopy                          Procedure(ByteArray _byteArray, <bool _forceNullTerminated>)

StringRefOut    &ByteArray

Code

    If Size(_byteArray) < 1
        Return NULL
    End
    If _forceNullTerminated = True
        If Size(_byteArray) > 1
            If _byteArray[Size(_byteArray)-1 : Size(_byteArray)] = Chr(0) & Chr(0)
                StringRefOut &= NEW ByteArray(Size(_byteArray))
                StringRefOut = _byteArray
            Else
                StringRefOut &= NEW ByteArray(Size(_byteArray) + 2)
                StringRefOut = _byteArray & Chr(0) & Chr(0)
            End
        Else
            StringRefOut &= NEW ByteArray(Size(_byteArray) + 2)
            StringRefOut = _byteArray & Chr(0) & Chr(0)
        End
    ELSE
        StringRefOut &= NEW ByteArray(Size(_byteArray))
        StringRefOut = _byteArray
    End
    Return StringRefOut

c25_BitConverterClass.BinaryCopyByLen                          Procedure(long _len, <string _clearChar>)

StringRefOut    &ByteArray

    Code

        If _len < 1
            Return NULL
        End

        StringRefOut &= New ByteArray(_len)
        If omitted(_clearChar) = FALSE
            StringRefOut = All(_clearChar,_len)
        Else
            Clear(StringRefOut,-1)
        End
        Return StringRefOut

c25_BitConverterClass.BlobToBlob                            Procedure(String _blob)

StringRefOut                    &ByteArray

    Code

        If Len(_blob) < 1
            Return null
        End

        StringRefOut &= New ByteArray(Len(_blob))
        StringRefOut = _blob
        Return StringRefOut

c25_BitConverterClass.BlobToBlob                            Procedure(*String _blob)

StringRefOut                    &ByteArray

    Code

        If Len(_blob) < 1
            Return NULL
        End

        StringRefOut &= New ByteArray(Len(_blob))
        StringRefOut = _blob
        Return StringRefOut

c25_BitConverterClass.AnsiToAnsi                            Procedure(String _ansi)

StringRefOut                    &ByteArray

    Code

        If Size(_ansi) < 1 or Size(_ansi) > 2000000 Or Len(Clip(_ansi)) < 1
            Return NULL
        End
        StringRefOut &= New ByteArray(Len(Clip(_ansi)))
        StringRefOut = _ansi

        Return StringRefOut

c25_BitConverterClass.Utf16ToUtf8GetLength                  Procedure(String _utf16)

StringRefOut                                    &ByteArray

    Code

        If len(clip(_utf16)) < 1
            Return 0
        End
        StringRefOut &= Self.Utf16ToUtf8(clip(_utf16))
        L# = Len(StringRefOut)
        Dispose(StringRefOut)
        Return L#

c25_BitConverterClass.Utf16ToAnsi                           Procedure(String _utf16)

StringRefOut &ByteArray
StUtf16ToAnsi &StringTheory()

    Code

        StUtf16ToAnsi &= NEW StringTheory()

        StUtf16ToAnsi.Start()
        StUtf16ToAnsi.encoding = st:EncodeUtf16

        If Len(Clip(_utf16)) > 1
            StUtf16ToAnsi.SetValue(Clip(_utf16) & Chr(0) & Chr(0) )
            StUtf16ToAnsi.ToAnsi(st:EncodeUtf16)
            I# = StUtf16ToAnsi.FindChars(Chr(0))
            If I# < 2
                Return NULL
            End
            StringRefOut &= New ByteArray(I#-1)
            StringRefOut = StUtf16ToAnsi.GetValue()
            Dispose(StUtf16ToAnsi)
            Return StringRefOut
        End
        Dispose(StUtf16ToAnsi)
        Return NULL

c25_BitConverterClass.Utf16ToAnsiStr                        Procedure(String _utf16)

    Code

        If Len(clip(_utf16)) < 1
            Return ''
        End

        Self.StUtf16ToAnsi.Start()
        Self.StUtf16ToAnsi.encoding = st:EncodeUtf16

        Self.StUtf16ToAnsi.SetValue(clip(_utf16))
        Self.StUtf16ToAnsi.ToAnsi(st:EncodeUtf16)

        Return Self.StUtf16ToAnsi.GetValue()

c25_BitConverterClass.Utf16ToAnsiGetLength                  Procedure(String _utf16)

StringRefOut                                    &ByteArray

    Code

        StringRefOut &= Self.Utf16ToAnsi(_utf16)
        L# = Len(StringRefOut)
        Dispose(StringRefOut)
        Return L#

c25_BitConverterClass.UuidCreateA                           Procedure(<Byte _lowerCase>)

AliasGuidString                 String(36)
AliasGuidCStringPtr             Long
GuidBlob16                      String(16)
PtrUuid                         Long

    Code

        CLEAR(GuidBlob16,-1)
        CLEAR(AliasGuidString)
        c25_UuidCreate(Address(GuidBlob16))
        c25_uuidtostringa(Address(GuidBlob16), Address(AliasGuidCStringPtr))
        Peek(AliasGuidCStringPtr,AliasGuidString)
        If _lowerCase
            Return Lower(AliasGuidString)
        End
        Return Upper(AliasGuidString)

c25_BitConverterClass.UuidCreateSequential                  Procedure(<Byte _lowerCase>)

AliasGuidString                 String(36)
AliasGuidCStringPtr             Long
GuidBlob16                      String(16)
PtrUuid                         Long

    Code

        CLEAR(GuidBlob16,-1)
        CLEAR(AliasGuidString)
        c25_UuidCreateSequential(Address(GuidBlob16))
        c25_uuidtostringa(Address(GuidBlob16), Address(AliasGuidCStringPtr))
        Peek(AliasGuidCStringPtr,AliasGuidString)
        If _lowerCase
            Return Lower(AliasGuidString)
        End
        Return Upper(AliasGuidString)

c25_BitConverterClass.UuidToString                          Procedure(String _bytes16)

AliasGuidString                     String(36)
OutBuffer                           String(128)
AliasGuidCStringPtr                 Long
GuidBlob16                          String(16)

    Code

        GuidBlob16 = _bytes16
        X# = c25_uuidtostringa(Address(GuidBlob16), Address(AliasGuidCStringPtr))
        If X# <> 0
            Message('error UuidToString ' & C25_GetLastError() )
        End
        If AliasGuidCStringPtr <> 0
            c25_MemCpy(Address(OutBuffer),AliasGuidCStringPtr,36)
            c25_RpcStringFreeA(Address(AliasGuidCStringPtr))
            AliasGuidString = OutBuffer
            Return AliasGuidString
        End
        Return '00000000-0000-0000-0000-000000000000'

c25_BitConverterClass.UuidFromStringA                           Procedure(String _guid36)

Guid36                              String(36)
Guid16                              String(16)


    Code

        Guid36 = _guid36
        X# = c25_UuidFromStringA(Address(Guid36), Address(Guid16))
        If X# = 0
            Return Guid16
        End
        Return All(Chr(0),16)

c25_BitConverterClass.BufferToByteQ                         Procedure(<String _buffer>, <Long _startAddress>,<Long _expectedLength>,<String _fileName>)

BytesQ                          QUEUE,Pre(BytesQ)
Ordinal                             Long
Pos                                 Long
Address                             Long
ValChar                             String(1)
ValHex                              String(2)
ValNum                              Byte
BadPtr                              Byte
                                End
Line512                         String(512)

    Code

        If omitted(_startAddress) = False
            If _startAddress = 0
                Return ''
            End
            A# = _startAddress
        End
        If omitted(_buffer) = False
            If Size(_buffer) = 0
                Return ''
            End
            A# = Address(_buffer)
        End

        O# = -1
        P# = 0
        LOOP
            O# = O# + 1
            P# = P# + 1
            If omitted(_expectedLength) = False
                If P# > _expectedLength
                    BREAK
                End
            End
            BytesQ.Ordinal   = O#
            BytesQ.Pos       = P#
            BytesQ.Address   = A# + O#
            If c25_IsBadreadPtr(BytesQ.Address,1) = True
                BytesQ.BadPtr = TRUE
                Add(BytesQ)
                BREAK
            End
            Peek(BytesQ.Address,BytesQ.ValChar)
            Peek(BytesQ.Address,BytesQ.ValNum)
            BytesQ.ValHex    = BYTETOHEX(BytesQ.ValNum,0)
            Add(BytesQ)
        End

        Self.st1.Start()
        I# = 0
        Loop Records(BytesQ) Times
            I# = I# + 1
            Get(BytesQ,I#)
            Clear(Line512)
            Line512[1 : 10] = BytesQ.Ordinal
            Line512[12] = '|'
            Line512[14 : 24] = BytesQ.Pos
            Line512[26] = '|'
            Line512[28 : 38] = BytesQ.Address
            Line512[40] = '|'
            Line512[42 : 52] = BytesQ.ValChar
            Line512[54] = '|'
            Line512[56 : 66] = BytesQ.ValNum
            Line512[68] = '|'
            Line512[70 : 80] = BytesQ.ValHex
            Line512[82] = '|'
            If BytesQ.BadPtr = TRUE
                Line512[84 : 100] = 'BAD PTR'
            End
            Self.st1.Append(Clip(Line512) & Chr(13) & Chr(10))
        End
        If omitted(_fileName) = False
            Self.st1.SaveFile(_fileName)
        Else
            SETCLIPBOARD(Self.st1.GetValue())
        End

        Return ''

c25_BitConverterClass.ParseZeroTerminatedStringA            Procedure(Long _ptr, <Byte _excludeTermZero>, <Byte _debug>)

FakeRef                                                 &ByteArray

    Code

        If _debug
            Message('start ParseZeroTerminatedStringA')
        End

        If _ptr = 0
            Return ''
        End

        Self.AddressPtr = _ptr - 1
        Loop 64000000 Times
            Self.AddressPtr = Self.AddressPtr + 1
            If _debug
            End
            If c25_IsBadReadPtr(Self.AddressPtr,1)
                Return ''
            End
            Peek(Self.AddressPtr,Self.ByteOut)
            If _debug
            End
            If Self.ByteOut = 0
                Break
            End
        End
        If _excludeTermZero = True
            Self.BufferLength = Self.AddressPtr - _ptr
        Else
            Self.BufferLength = Self.AddressPtr - _ptr + 1
        End
        If Self.BufferLength < 1
            Return ''
        End

        If not Self.ReturnString &= NULL
            If _debug
                Message('try Dispose(Self.ReturnString)')
            End
            If _debug
                Message('Self.ReturnString : ' & Self.ReturnString)
            End
            FakeRef &= Self.ReturnString
            Self.ReturnString &= null
            Dispose(FakeRef)
            If _debug
                Message('try Dispose(Self.ReturnString) OK')
            End
        End

        Self.ReturnString &= New ByteArray(Self.BufferLength)
        If _debug
            Message('Self.BufferLength ' & Self.BufferLength)
        End

        c25_MemCpy(Address(Self.ReturnString),_ptr,Self.BufferLength)

        If _debug
            Message('will Return : ' & Self.ReturnString)
        End

        Return Self.ReturnString
        
        
c25_BitConverterClass.ParseZeroTerminatedStringAToRef            Procedure(Long _ptr, <Byte _excludeTermZero>)

NewString  &ByteArray

    Code

        If _ptr = 0
            Return NULL
        End

        Self.AddressPtr = _ptr - 1
        Loop 2000000 Times
            Self.AddressPtr = Self.AddressPtr + 1
            If c25_IsBadReadPtr(Self.AddressPtr,1)
                Return NULL
            End
            Peek(Self.AddressPtr,Self.ByteOut)
            If Self.ByteOut = 0
                Break
            End
        End
        If _excludeTermZero = True
            Self.BufferLength = Self.AddressPtr - _ptr
        Else
            Self.BufferLength = Self.AddressPtr - _ptr + 1
        End
        If Self.BufferLength < 1
            Return NULL
        End
        NewString &= NEW STRING(Self.BufferLength)

        c25_MemCpy(Address(NewString), _ptr , Self.BufferLength)

        Return NewString       

c25_BitConverterClass.ParseZeroTerminatedUtf16String        Procedure(Long _address, Long _getLengthOrBufferLen, <Byte _excludeTermZero>,<Byte _skipReturnString>)

    Code

        If _getLengthOrBufferLen = -1 Or _getLengthOrBufferLen = 0
            Self.AddressPtr = _address - 2
            Loop 64000000 Times
                Self.AddressPtr = Self.AddressPtr + 2
                Peek(Self.AddressPtr,Self.ShortOut)
                If Self.ShortOut = 0
                    Break
                End
            End
            If _excludeTermZero = 1
                Self.BufferLength = Self.AddressPtr - _address
            Else
                Self.BufferLength = Self.AddressPtr - _address + 2
            End
            If _getLengthOrBufferLen = -1
                Return Self.BufferLength
            End
        End
        If _getLengthOrBufferLen > 0
            Self.BufferLength = _getLengthOrBufferLen
        End
        If Self.BufferLength < 2000001
            If not Self.ReturnString &= NULL
                Dispose(Self.ReturnString)
            End
            Self.ReturnString &= New ByteArray(Self.BufferLength)
            c25_MemCpy(Address(Self.ReturnString),_address,Self.BufferLength)
            If _skipReturnString = 1
                Return ''
            End
            Return Self.ReturnString
        End

        Return ''

c25_BitConverterClass.FastHexFromLong                       Procedure(Long _long)

lng Long
str4                String(4),over(lng)

    Code

    lng = _long
    Return '0x' & Self.FastHexFromByte(Val(str4[4])) & Self.FastHexFromByte(Val(str4[3])) & Self.FastHexFromByte(Val(str4[2])) & Self.FastHexFromByte(Val(str4[1])) & 'H'

c25_BitConverterClass.FastHexFromByte                       Procedure(Byte _Byte)

    Code

    EXECUTE _Byte
        Return'01';Return'02';Return'03';Return'04';Return'05';Return'06';Return'07';Return'08';
        Return'09';Return'0A';Return'0B';Return'0C';Return'0D';Return'0E';Return'0F';Return'10';
        Return'11';Return'12';Return'13';Return'14';Return'15';Return'16';Return'17';Return'18';
        Return'19';Return'1A';Return'1B';Return'1C';Return'1D';Return'1E';Return'1F';Return'20';
        Return'21';Return'22';Return'23';Return'24';Return'25';Return'26';Return'27';Return'28';
        Return'29';Return'2A';Return'2B';Return'2C';Return'2D';Return'2E';Return'2F';Return'30';
        Return'31';Return'32';Return'33';Return'34';Return'35';Return'36';Return'37';Return'38';
        Return'39';Return'3A';Return'3B';Return'3C';Return'3D';Return'3E';Return'3F';Return'40';
        Return'41';Return'42';Return'43';Return'44';Return'45';Return'46';Return'47';Return'48';
        Return'49';Return'4A';Return'4B';Return'4C';Return'4D';Return'4E';Return'4F';Return'50';
        Return'51';Return'52';Return'53';Return'54';Return'55';Return'56';Return'57';Return'58';
        Return'59';Return'5A';Return'5B';Return'5C';Return'5D';Return'5E';Return'5F';Return'60';
        Return'61';Return'62';Return'63';Return'64';Return'65';Return'66';Return'67';Return'68';
        Return'69';Return'6A';Return'6B';Return'6C';Return'6D';Return'6E';Return'6F';Return'70';
        Return'71';Return'72';Return'73';Return'74';Return'75';Return'76';Return'77';Return'78';
        Return'79';Return'7A';Return'7B';Return'7C';Return'7D';Return'7E';Return'7F';Return'80';
        Return'81';Return'82';Return'83';Return'84';Return'85';Return'86';Return'87';Return'88';
        Return'89';Return'8A';Return'8B';Return'8C';Return'8D';Return'8E';Return'8F';Return'90';
        Return'91';Return'92';Return'93';Return'94';Return'95';Return'96';Return'97';Return'98';
        Return'99';Return'9A';Return'9B';Return'9C';Return'9D';Return'9E';Return'9F';Return'A0';
        Return'A1';Return'A2';Return'A3';Return'A4';Return'A5';Return'A6';Return'A7';Return'A8';
        Return'A9';Return'AA';Return'AB';Return'AC';Return'AD';Return'AE';Return'AF';Return'B0';
        Return'B1';Return'B2';Return'B3';Return'B4';Return'B5';Return'B6';Return'B7';Return'B8';
        Return'B9';Return'BA';Return'BB';Return'BC';Return'BD';Return'BE';Return'BF';Return'C0';
        Return'C1';Return'C2';Return'C3';Return'C4';Return'C5';Return'C6';Return'C7';Return'C8';
        Return'C9';Return'CA';Return'CB';Return'CC';Return'CD';Return'CE';Return'CF';Return'D0';
        Return'D1';Return'D2';Return'D3';Return'D4';Return'D5';Return'D6';Return'D7';Return'D8';
        Return'D9';Return'DA';Return'DB';Return'DC';Return'DD';Return'DE';Return'DF';Return'E0';
        Return'E1';Return'E2';Return'E3';Return'E4';Return'E5';Return'E6';Return'E7';Return'E8';
        Return'E9';Return'EA';Return'EB';Return'EC';Return'ED';Return'EE';Return'EF';Return'F0';
        Return'F1';Return'F2';Return'F3';Return'F4';Return'F5';Return'F6';Return'F7';Return'F8';
        Return'F9';Return'FA';Return'FB';Return'FC';Return'FD';Return'FE';Return'FF'
    ELSE
        Return '00'
    End

c25_BitConverterClass.FastCharFromHex2                      Procedure(String _Hex)

    Code

    If Val(_Hex[1]) > 039h
        If Val(_Hex[2]) > 039h
            Return Chr(((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-55))
        Else
            Return Chr(((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-48))
        End
    Else
        If Val(_Hex[2]) > 039h
            Return Chr(((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-55))
        Else
            Return Chr(((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-48))
        End
    End

c25_BitConverterClass.FastByteFromHex2                      Procedure(String _Hex)

    Code

    If Val(_Hex[1]) > 039h
        If Val(_Hex[2]) > 039h
            Return ((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-55)
        Else
            Return ((Val(_Hex[1])-55) * 16) + (Val(_Hex[2])-48)
        End
    Else
        If Val(_Hex[2]) > 039h
            Return ((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-55)
        Else
            Return ((Val(_Hex[1])-48) * 16) + (Val(_Hex[2])-48)
        End
    End

c25_BitConverterClass.Guid16FromGuid36                      Procedure(String _guid36)

    Code
        Self.Guid36 = _guid36

    Return Self.FastCharFromHex2(Self.Guid36[7:8]) & |
        Self.FastCharFromHex2(Self.Guid36[5:6]) & |
        Self.FastCharFromHex2(Self.Guid36[3:4]) & |
        Self.FastCharFromHex2(Self.Guid36[1:2]) & |
        Self.FastCharFromHex2(Self.Guid36[12:13]) & |
        Self.FastCharFromHex2(Self.Guid36[10:11]) & |
        Self.FastCharFromHex2(Self.Guid36[17:18]) & |
        Self.FastCharFromHex2(Self.Guid36[15:16]) & |
        Self.FastCharFromHex2(Self.Guid36[20:21]) & |
        Self.FastCharFromHex2(Self.Guid36[22:23]) & |
        Self.FastCharFromHex2(Self.Guid36[25:26]) & |
        Self.FastCharFromHex2(Self.Guid36[27:28]) & |
        Self.FastCharFromHex2(Self.Guid36[29:30]) & |
        Self.FastCharFromHex2(Self.Guid36[31:32]) & |
        Self.FastCharFromHex2(Self.Guid36[33:34]) & |
        Self.FastCharFromHex2(Self.Guid36[35:36])

c25_BitConverterClass.Guid36FromGuid16                      Procedure(String _guid16)

    Code
        Self.Guid16 = _guid16
        Return Self.UuidToString(_guid16)

c25_BitConverterClass.FormatErrorMessageAnsiStr             Procedure(<ULong _errorcode>, <Long _ntstatus>, <Byte _showMessage>, <String _extraPrefixText>)

    Code

        If not Self.FormatMessageAnsi &= NULL
            Dispose(Self.FormatMessageAnsi)
        End
        Clear(Self.HResult)
        Clear(Self.NTSTatusCode)
        Clear(Self.NTSTatusFacility)
        Clear(Self.NTSTatusSeverity)
        Clear(Self.NTSTatusSeveritySuccess)
        Clear(Self.NTSTatusSeverityInformational)
        Clear(Self.NTSTatusSeverityWarning)
        Clear(Self.NTSTatusSeverityError)
        Clear(Self.NTSTatusCustomer)
        Clear(Self.NTSTatusIsNTSTATUS)
        Self.ErrorCodeInt = 0
        If omitted(_ntstatus) = False
            Self.NTSTatusCode = BAND(65535,_ntstatus)
            Self.ErrorCodeInt = Self.NTSTatusCode

            Self.NTSTatusFacility = BAND(134152192,_ntstatus)
            Self.NTSTatusSeverity = BAND(3221225472,_ntstatus)
            If Self.NTSTatusSeverity = 0
                Self.NTSTatusSeveritySuccess = TRUE
            ELSE
                Case Self.NTSTatusSeverity
                Of 1
                    Self.NTSTatusSeverityInformational = True
                Of 2
                    Self.NTSTatusSeverityWarning = True
                Of 3
                    Self.NTSTatusSeverityError = True
                End
            End
        Else
            Self.ErrorCodeInt = _errorcode
        End

        If Self.ErrorCodeInt <> 0
            L# = Len(Clip(Self.FormatErrorMessage(Self.ErrorCodeInt)))
            If omitted(_extraPrefixText) = False
                L# = L# + Len(Clip(_extraPrefixText))
            End
            L# = L# + 1024
            If L# > 0
                Self.FormatMessageAnsi &= New ByteArray(L#)
                If omitted(_extraPrefixText) = False
                    Self.FormatMessageAnsi = Clip(_extraPrefixText) & ' ' & Self.FormatErrorMessage(Self.ErrorCodeInt)
                Else
                    Self.FormatMessageAnsi = Self.FormatErrorMessage(Self.ErrorCodeInt)
                End
                If _showMessage = True
                    Message(Self.FormatMessageAnsi)
                End
            End
        End

        Return Self.FormatMessageAnsi

c25_BitConverterClass.FormatErrorMessageAnsi                Procedure(<ULong _errorcode>, <Long _ntstatus>, <String _extraPrefixText>)

MessageStringRef                                &ByteArray

    Code

        If not Self.FormatMessageAnsi &= NULL
            Dispose(Self.FormatMessageAnsi)
        End
        Clear(Self.HResult)
        Clear(Self.NTSTatusCode)
        Clear(Self.NTSTatusFacility)
        Clear(Self.NTSTatusSeverity)
        Clear(Self.NTSTatusSeveritySuccess)
        Clear(Self.NTSTatusSeverityInformational)
        Clear(Self.NTSTatusSeverityWarning)
        Clear(Self.NTSTatusSeverityError)
        Clear(Self.NTSTatusCustomer)
        Clear(Self.NTSTatusIsNTSTATUS)
        Self.ErrorCodeInt = 0
        If omitted(_ntstatus) = False
            Self.NTSTatusCode = BAND(65535,_ntstatus)
            Self.ErrorCodeInt = Self.NTSTatusCode

            Self.NTSTatusFacility = BAND(134152192,_ntstatus)
            Self.NTSTatusSeverity = BAND(3221225472,_ntstatus)
            If Self.NTSTatusSeverity = 0
                Self.NTSTatusSeveritySuccess = TRUE
            ELSE
                Case Self.NTSTatusSeverity
                Of 1
                    Self.NTSTatusSeverityInformational = True
                Of 2
                    Self.NTSTatusSeverityWarning = True
                Of 3
                    Self.NTSTatusSeverityError = True
                End
            End
        Else
            Self.ErrorCodeInt = _errorcode
        End

        If Self.ErrorCodeInt <> 0
            L# = Len(Clip(Self.FormatErrorMessage(Self.ErrorCodeInt)))
            If L# = 0
                Return NULL
            End
            If omitted(_extraPrefixText) = False
                L# = L# + Len(Clip(_extraPrefixText) + 1)
            End
            If L# > 0
                L# = L# + 1024
                Self.FormatMessageAnsi &= New ByteArray(L#)
                If omitted(_extraPrefixText) = False
                    Self.FormatMessageAnsi = Clip(_extraPrefixText) & ' ' & Self.FormatErrorMessage(Self.ErrorCodeInt)
                Else
                    Self.FormatMessageAnsi = Self.FormatErrorMessage(Self.ErrorCodeInt)
                End

                MessageStringRef &= New ByteArray(L#)
                MessageStringRef = Self.FormatMessageAnsi
                Return Self.FormatMessageAnsi
            End

        End

        Return NULL

c25_BitConverterClass.FormatErrorMessage        Procedure(Long _errorCode)

jo:FORMAT_MESSAGE_ALLOCATE_BUFFER                                       equate(000100h)
jo:FORMAT_MESSAGE_ARGUMENT_ARRAY                                        equate(002000h)
jo:FORMAT_MESSAGE_FROM_HMODULE                                          equate(000800h)
jo:FORMAT_MESSAGE_FROM_STRING                                           equate(000400h)
jo:FORMAT_MESSAGE_FROM_SYSTEM                                           equate(001000h)
jo:FORMAT_MESSAGE_IGNORE_INSERTS                                        equate(000200h)
jo:FORMAT_MESSAGE_MAX_WIDTH_MASK                                        equate(0000FFh)

winErrMessage       cstring(255)
errMessage          String(255)
numChars            ULong

    Code

    numChars = c25_FormatMessage(jo:FORMAT_MESSAGE_FROM_SYSTEM + jo:FORMAT_MESSAGE_IGNORE_INSERTS, 0, _errorCode, 0, winErrMessage, 255, 0)

    errMessage = winErrMessage
    Return errMessage


