
    Include('c25_ProgramHandlerClass.inc'),Once

c25_DictionaryClass                                                     Class(),type, Module('c25_DictionaryClass.clw'), Link('c25_DictionaryClass.clw',1),DLL(0)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ProgramHandlerClass                                                         &c25_ProgramHandlerClass

SomeHash                                                                    Long

DictKeyValues                                                               &DictKeyValues_TYPE
DictKeySorted                                                               &DictKeySorted_TYPE
DictKeySortedTEMP                                                           &DictKeySorted_TYPE
DictKeyUpperSorted                                                          &DictKeySorted_TYPE
DictValueSorted                                                             &DictValueSorted_TYPE

CaseSensitive                                                               BOOL

Index                                                                       Long
IndexContainsKey                                                            Long
IndexDictKeySortedTEMP                                                      Long

Count                                                                       Long
CRC32Buffer                                                                 &string !string(128000)
CRC32BufferLen                                                              Long
CRC32BufferSize                                                             Long
CRC32BufferAddress                                                          Long
CreateCRC32Buffer                                                           Procedure(long _len),Long,proc

!Add                                                                         Procedure(string _key, string _value),bool,proc
ParseKeyValue                                                               Procedure(*KeyValue_TYPE _keyValue),bool,proc
AddByRef                                                                    Procedure(*string _key, *string _value, <bool _caseInSensitive>),bool,PROC
Add                                                                         Procedure(string _key, string _value, <bool _caseInSensitive>),bool,PROC

ContainsKey                                                                 Procedure(string _key, <bool _caseSensitive>),bool
ContainsKeyByRef                                                            Procedure(*string _key, <bool _caseSensitive>),bool
DestructDicionary                                                           Procedure()
GetCrc32C_Default                                                           Procedure(*string _value),Long
GetCrc32C                                                                   Procedure(string _value, <bool _caseSensitive>),Long
GetCrc32C                                                                   Procedure(*string _value, <bool _caseSensitive>),long
GetCrc32C_CaseSensitive                                                     Procedure(*string _value),Long
GetCrc32C_CaseInSensitive                                                   Procedure(*string _value),Long
Add_DictKeySorted                                                           Procedure(*DictKeySorted_TYPE _dictKeySorted)

ReplaceValueOnKey                                                           Procedure(string _key, string _newValue, <bool _caseInSensitive>),bool,proc
TryGetValueRef                                                              Procedure(string _key, <*string _value>, <bool _ansi>, <bool _caseInSensitive>),*STRING
TryGetValue                                                                 Procedure(string _key, <bool _ansi>, <bool _caseInSensitive>),STRING
RemoveOnKey                                                                 Procedure(string _key, <bool _caseInSensitive>),bool,PROC
                                                                        End


