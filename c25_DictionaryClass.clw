                        Member

                        Include('c25_DictionaryClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_DictionaryClass.Construct                                  Procedure()

ClassTypeName cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_DictionaryClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    !Clear(Self.CRC32Buffer)
    
    Self.CreateCRC32Buffer(1024)
    
    Self.DictKeyValues          &= NEW DictKeyValues_TYPE
    Self.DictKeySorted          &= NEW DictKeySorted_TYPE
    Self.DictKeyUpperSorted     &= NEW DictKeySorted_TYPE
    Self.DictValueSorted        &= NEW DictValueSorted_TYPE


c25_DictionaryClass.Destruct                                  Procedure()

Code

    Self.DestructDicionary()


c25_DictionaryClass.DestructDicionary                       Procedure()

CODE
        
    Self.Index = 0
    Loop Self.Count Times
        Self.Index = Self.Index + 1
        Get(Self.DictKeyValues,Self.Index)
        If not Self.DictKeyValues.Key &= NULL
            Dispose(Self.DictKeyValues.Key)
        End
        If not Self.DictKeyValues.Value &= NULL
            Dispose(Self.DictKeyValues.Value)
        End    
        Put(Self.DictKeyValues)
    End
    Loop
        Self.Index = Self.Index + 1
        Get(Self.DictKeyValues,Self.Index)
        If Errorcode() <> 0
            Break
        End
        If not Self.DictKeyValues.Key &= NULL
            Dispose(Self.DictKeyValues.Key)
        End
        If not Self.DictKeyValues.Value &= NULL
            Dispose(Self.DictKeyValues.Value)
        End    
        Put(Self.DictKeyValues)
    End
    
    Free(Self.DictKeyValues)

    
c25_DictionaryClass.ParseKeyValue                           Procedure(*KeyValue_TYPE _keyValue)

CODE
    
    Self.CreateCRC32Buffer(512)
    If _keyValue &= null
        Return 0
    End
    
    I# = 0
    LOOP
        I# = I# + 1
        Get(_keyValue,I#)
        If Errorcode() <> 0
            Break
        End
        If _keyValue.Key &= null or _keyValue.Value &= NULL
            CYCLE
        End
        Self.AddByRef(_keyValue.Key, _keyValue.Value)
    End
    Self.CreateCRC32Buffer(512)
    Return 0
    
c25_DictionaryClass.Add                                     Procedure(string _key, string _value, <bool _caseInSensitive>)



CODE
    
    If Size(_key) < 1
        Return 0
    End
    If Size(_value) < 1
        Return 0
    End
    
    If Self.ContainsKey(_key, _caseInSensitive) = TRUE
        Return 0
    End

    Self.DictKeyValues.Key &= NEW STRING(Size(_key))
    Self.DictKeyValues.Key = _key

    Self.DictKeyValues.Value &= NEW STRING(Size(_value))
    Self.DictKeyValues.Value = _value
    Self.DictKeyValues.KeyHash          = Self.GetCrc32C_CaseSensitive(Self.DictKeyValues.Key)
    Self.DictKeyValues.KeyUpperHash     = Self.GetCrc32C_CaseInSensitive(Self.DictKeyValues.Key)
    Self.DictKeyValues.ValueHash        = Self.GetCrc32C_CaseSensitive(Self.DictKeyValues.Value)
    Self.DictKeyValues.Index            = Records(Self.DictKeyValues) + 1
    Add(Self.DictKeyValues)
    !Message('Self.DictKeyValues.Key : ' & Self.DictKeyValues.Key)

    
    Clear(Self.DictKeySorted)
    Self.DictKeySorted.Hash             = Self.DictKeyValues.KeyHash
    Self.DictKeySorted.SortOrdinal      = 0
    Self.DictKeySorted.SourceIndex      = Self.DictKeyValues.Index
    Self.DictKeySorted.Key              &= Self.DictKeyValues.Key 
    Self.DictKeySorted.Value            &= Self.DictKeyValues.Value
    
    Self.Add_DictKeySorted(Self.DictKeySorted)
    
    Return 0

c25_DictionaryClass.AddByRef                                     Procedure(*string _key, *string _value, <bool _caseInSensitive>)



CODE
    
    If Size(_key) < 1
        Return 0
    End
    If Size(_value) < 1
        Return 0
    End
    
    If Self.ContainsKey(_key, _caseInSensitive) = TRUE
        Return 0
    End

    
    Self.DictKeyValues.Key &= NEW STRING(Size(_key))
    Self.DictKeyValues.Key = _key
    
    
    Self.DictKeyValues.Value &= NEW STRING(Size(_value))
    Self.DictKeyValues.Value = _value
    Self.DictKeyValues.KeyHash          = Self.GetCrc32C_CaseSensitive(Self.DictKeyValues.Key)
    Self.DictKeyValues.KeyUpperHash     = Self.GetCrc32C_CaseInSensitive(Self.DictKeyValues.Key)
    Self.DictKeyValues.ValueHash        = Self.GetCrc32C_CaseSensitive(Self.DictKeyValues.Value)
    Self.DictKeyValues.Index            = Records(Self.DictKeyValues) + 1
    Add(Self.DictKeyValues)

    
    Clear(Self.DictKeySorted)
    Self.DictKeySorted.Hash             = Self.DictKeyValues.KeyHash
    Self.DictKeySorted.SortOrdinal      = 0
    Self.DictKeySorted.SourceIndex      = Self.DictKeyValues.Index
    Self.DictKeySorted.Key          &= Self.DictKeyValues.Key 
    Self.DictKeySorted.Value        &= Self.DictKeyValues.Value
    
    Self.Add_DictKeySorted(Self.DictKeySorted)
    
    Return 0
    
    
c25_DictionaryClass.Add_DictKeySorted             Procedure(*DictKeySorted_TYPE _dictKeySorted)

CODE

    Add(Self.DictKeySorted)
    Self.Count = Records(Self.DictKeySorted)
    Sort(Self.DictKeySorted, +Self.DictKeySorted.Hash)

    
c25_DictionaryClass.ContainsKey                             Procedure(string _key, <bool _caseSensitive>)

Code
        
    If Self.DictKeySorted &= NULL
        Message('Self.DictKeySorted is null, error')
    End

    Self.DictKeySorted.Hash = Self.GetCrc32C_CaseSensitive(_key)
        
    Get(Self.DictKeySorted, +Self.DictKeySorted.Hash)
    If Errorcode() <> 0
        Return FALSE
    END

    Self.IndexContainsKey = Pointer(Self.DictKeySorted) - 1
    Loop
        Self.IndexContainsKey = Self.IndexContainsKey + 1
        If Self.IndexContainsKey > Self.Count
            Return FALSE
        END
        
        Get(Self.DictKeySorted,Self.IndexContainsKey)
        If Self.DictKeySorted.Key = _key
            Return TRUE
        End
    End
    Return False
    
c25_DictionaryClass.ContainsKeyByRef                             Procedure(*string _key, <bool _caseSensitive>)

Code
        
    If Self.DictKeySorted &= NULL
        Message('Self.DictKeySorted is null, error')
    End

    Self.DictKeySorted.Hash = Self.GetCrc32C_CaseSensitive(_key)
        
    Get(Self.DictKeySorted, +Self.DictKeySorted.Hash)
    If Errorcode() <> 0
        Return FALSE
    END

    Self.IndexContainsKey = Pointer(Self.DictKeySorted) - 1
    Loop
        Self.IndexContainsKey = Self.IndexContainsKey + 1
        If Self.IndexContainsKey > Self.Count
            Return FALSE
        END
        
        Get(Self.DictKeySorted,Self.IndexContainsKey)
        If Self.DictKeySorted.Key = _key
            Return TRUE
        End
    End
    Return False
        
c25_DictionaryClass.ReplaceValueOnKey           Procedure(string _key, string _newValue, <bool _caseInSensitive>)

StrRefOld &STRING

Code

    Self.DictKeySorted.Hash = Self.GetCrc32C_CaseSensitive(_key)
        
    Get(Self.DictKeySorted, +Self.DictKeySorted.Hash)
    If Errorcode() <> 0
        Return 0
    END

    Self.IndexContainsKey = Pointer(Self.DictKeySorted) - 1
    Loop
        Self.IndexContainsKey = Self.IndexContainsKey + 1
        If Self.IndexContainsKey > Self.Count          
            Return 0
        END
        
        Get(Self.DictKeySorted,Self.IndexContainsKey)
        If omitted(_caseInSensitive) = False And _caseInSensitive = True
            If upper(Self.DictKeySorted.Key) = upper(_key)
                Self.RemoveOnKey(_key, _caseInSensitive)
                Self.Add(_key, _newValue, _caseInSensitive)
                Return True
            ElsIf Self.DictKeySorted.Key = _key
                Self.RemoveOnKey(_key, _caseInSensitive)
                Self.Add(_key, _newValue, _caseInSensitive)
                Return True
            End
        End
    End
    Return 0

    
    
c25_DictionaryClass.RemoveOnKey           Procedure(string _key, <bool _caseInSensitive>)
    
CODE
    
    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.DictKeyValues,I#)
        If Errorcode() <> 0
            BREAK
        END
        If omitted(_caseInSensitive) = False And _caseInSensitive = True
            If upper(Self.DictKeyValues.Key) = upper(_key)
                Dispose(Self.DictKeyValues.Key)
                Dispose(Self.DictKeyValues.Value)
                Delete(Self.DictKeyValues)
                I# = I# -1
                Cycle
            END
        ELSE
            If Self.DictKeyValues.Key = _key
                Dispose(Self.DictKeyValues.Key)
                Dispose(Self.DictKeyValues.Value)                
                Delete(Self.DictKeyValues)
                I# = I# -1
                Cycle
            END            
        End
    End
    
    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.DictKeySorted,I#)
        If Errorcode() <> 0
            BREAK
        END
        If omitted(_caseInSensitive) = False And _caseInSensitive = True
            If upper(Self.DictKeySorted.Key) = upper(_key)
                Dispose(Self.DictKeySorted.Key)
                Dispose(Self.DictKeySorted.Value)                
                Delete(Self.DictKeySorted)
                I# = I# - 1
                Cycle
            END
        ELSE
            If Self.DictKeySorted.Key = _key
                Dispose(Self.DictKeySorted.Key)
                Dispose(Self.DictKeySorted.Value)                
                Delete(Self.DictKeySorted)
                I# = I# - 1
                Cycle
            END            
        End
    End    
    Return 0
    
    

c25_DictionaryClass.TryGetValueRef  Procedure(string _key, <*string _value>, <bool _ansi>, <bool _caseInSensitive>)

StrRef &STRING

Code

    Self.DictKeySorted.Hash = Self.GetCrc32C_CaseSensitive(_key)
        
    Get(Self.DictKeySorted, +Self.DictKeySorted.Hash)
    If Errorcode() <> 0
        If omitted(_value) = False
            _value = ''
        End
        Return NULL
    END

    Self.IndexContainsKey = Pointer(Self.DictKeySorted) - 1
    Loop
        Self.IndexContainsKey = Self.IndexContainsKey + 1
        If Self.IndexContainsKey > Self.Count
            If omitted(_value) = False
                _value = ''
            End            
            Return NULL
        END
        
        Get(Self.DictKeySorted,Self.IndexContainsKey)
        If omitted(_caseInSensitive) = False And _caseInSensitive = True
            If upper(Self.DictKeySorted.Key) = upper(_key)
                If omitted(_value) = False
                    _value = Self.DictKeySorted.Value
                Else
                    If _ansi = True
                        !StrRef = Self.DictKeySorted.Value
                        Return Self.ProgramHandlerClass.BitConverterClass.Utf16ToAnsi(Self.DictKeySorted.Value)
                    Else
                        StrRef &= NEW String(Size(Self.DictKeySorted.Value))
                        StrRef = Self.DictKeySorted.Value
                        Return StrRef
                    End
                End
            ElsIf Self.DictKeySorted.Key = _key
                If omitted(_value) = False
                    _value = Self.DictKeySorted.Value
                Else
                    If _ansi = True
                        !StrRef = Self.DictKeySorted.Value
                        Return Self.ProgramHandlerClass.BitConverterClass.Utf16ToAnsi(Self.DictKeySorted.Value)
                    Else
                        StrRef &= NEW String(Size(Self.DictKeySorted.Value))
                        StrRef = Self.DictKeySorted.Value
                        Return StrRef
                    End
                End
            End
        End
    End
    If omitted(_value) = False
        _value = ''
    End    
    Return NULL
    
c25_DictionaryClass.TryGetValue                            Procedure(string _key, <bool _ansi>, <bool _caseInSensitive>)

Code

    Self.DictKeySorted.Hash = Self.GetCrc32C_CaseSensitive(_key)
        
    Get(Self.DictKeySorted, +Self.DictKeySorted.Hash)
    If Errorcode() <> 0
        Return ''
    END

    Self.IndexContainsKey = Pointer(Self.DictKeySorted) - 1
    Loop
        Self.IndexContainsKey = Self.IndexContainsKey + 1
        If Self.IndexContainsKey > Self.Count
            Return ''
        End
        
        Get(Self.DictKeySorted,Self.IndexContainsKey)
        If omitted(_caseInSensitive) = False And _caseInSensitive = True
            If upper(Self.DictKeySorted.Key) = upper(_key)
                If _ansi = True
                    Return Self.ProgramHandlerClass.BitConverterClass.Utf16ToAnsi(Self.DictKeySorted.Value)
                End
                Return Self.DictKeySorted.Value
            End
        ELSE
            If Self.DictKeySorted.Key = _key
                If _ansi = True
                    Return Self.ProgramHandlerClass.BitConverterClass.Utf16ToAnsi(Self.DictKeySorted.Value)
                End
                Return Self.DictKeySorted.Value
            End
        End
    End
    Return ''
        
    
c25_DictionaryClass.CreateCRC32Buffer        Procedure(long _len)

CODE

    If not Self.CRC32Buffer &= NULL
        Dispose(Self.CRC32Buffer)
    End
    Self.CRC32BufferSize        = _len
    Self.CRC32Buffer            &= NEW STRING(Self.CRC32BufferSize)
    Self.CRC32BufferAddress     = Address(Self.CRC32Buffer)
    
    Return 0
    
    
    
c25_DictionaryClass.GetCrc32C_Default                             Procedure(*string _value)

Code

    Self.CRC32BufferLen = Size(_value)
    If Self.CRC32BufferLen < 1
        Return 0
    End
    If Self.CRC32BufferLen > Size(Self.CRC32Buffer)
        Self.CreateCRC32Buffer(Self.CRC32BufferLen)
    End
    If Self.CaseSensitive
        Self.CRC32Buffer[1 : Self.CRC32BufferLen] = UPPER(_value)
    Else
        Self.CRC32Buffer[1 : Self.CRC32BufferLen] = _value
    End
    Return c25_crc32c_append(0, Self.CRC32BufferAddress, Self.CRC32BufferLen)
    
    
c25_DictionaryClass.GetCrc32C                             Procedure(string _value, <bool _caseSensitive>)

Code

    Self.CRC32BufferLen = Size(_value)
    If Self.CRC32BufferLen < 1
        Return 0
    End
    If Self.CRC32BufferLen > Size(Self.CRC32Buffer)
        Self.CreateCRC32Buffer(Self.CRC32BufferLen)
    End
    If (omitted(_caseSensitive) = False And _caseSensitive = True) Or Self.CaseSensitive
        Self.CRC32Buffer[1 : Self.CRC32BufferLen] = UPPER(_value)
    Else
        Self.CRC32Buffer[1 : Self.CRC32BufferLen] = _value
    End
    Return c25_crc32c_append(0, Self.CRC32BufferAddress, Self.CRC32BufferLen)
    
    
c25_DictionaryClass.GetCrc32C                             Procedure(*string _value, <bool _caseSensitive>)

Code

    Self.CRC32BufferLen = Size(_value)
    If Self.CRC32BufferLen < 1
        Return 0
    End
    If Self.CRC32BufferLen > Size(Self.CRC32Buffer)
        Self.CreateCRC32Buffer(Self.CRC32BufferLen)
    End
    If (omitted(_caseSensitive) = False And _caseSensitive = True) Or Self.CaseSensitive
        Self.CRC32Buffer[1 : Self.CRC32BufferLen] = UPPER(_value)
    Else
        Self.CRC32Buffer[1 : Self.CRC32BufferLen] = _value
    End
    Return c25_crc32c_append(0, Self.CRC32BufferAddress, Self.CRC32BufferLen)
    
    
c25_DictionaryClass.GetCrc32C_CaseSensitive                             Procedure(*string _value)


Code
    
    Self.CRC32BufferLen = Size(_value)
    If Self.CRC32BufferLen < 1
        Return 0
    End
    If Self.CRC32BufferLen > Size(Self.CRC32Buffer)
        Self.CreateCRC32Buffer(Self.CRC32BufferLen)
    End
    Self.CRC32Buffer[1 : Self.CRC32BufferLen] = _value
    Return c25_crc32c_append(0, Self.CRC32BufferAddress, Self.CRC32BufferLen)    
    
    
c25_DictionaryClass.GetCrc32C_CaseInSensitive                             Procedure(*string _value)


Code

    Self.CRC32BufferLen = Size(_value)
    If Self.CRC32BufferLen < 1
        Return 0
    End
    If Self.CRC32BufferLen > Size(Self.CRC32Buffer)
        Self.CreateCRC32Buffer(Self.CRC32BufferLen)
    End
    Self.CRC32Buffer[1 : Self.CRC32BufferLen] = UPPER(_value)
    Return c25_crc32c_append(0, Self.CRC32BufferAddress, Self.CRC32BufferLen)    