!    INCLUDE('c25_BYTESHANDLERCLASS.INC'),ONCE
!    INCLUDE('c25_DATATYPES.CLW'),ONCE
!    INCLUDE('C25_DUMMY.CLW'), ONCE
!    INCLUDE('c25_EQUATES_ITEMIZED.CLW'),ONCE
!    INCLUDE('c25_EQUATES_SQLITE3.CLW'),ONCE
!    INCLUDE('C25_DUMMY.CLW'),ONCE
!    INCLUDE('C25_DUMMY.CLW'),ONCE
!    INCLUDE('c25_QUEUEOBJECTCLASS.INC'),ONCE
!    INCLUDE('c25_TRUEREFLECTIONCLASS.INC'),ONCE
!    INCLUDE('c25_TYPES.CLW'),ONCE
!    INCLUDE('c25_USERCLASS.INC'),ONCE
!    INCLUDE('c25_WINAPI32CLASS.INC'), ONCE
!    INCLUDE('ERRORS.CLW'),ONCE
!    INCLUDE('JFILES.INC'),ONCE
!    INCLUDE('STRINGTHEORY.INC'),ONCE
!!    INCLUDE('c25_LOGGERCLASS.INC'),ONCE
!    INCLUDE('c25_NANOSYNCCLASS.INC'), ONCE
!    INCLUDE('CWSYNCHC.INC'),ONCE
!    INCLUDE('REFLECTION.INC'),ONCE
!    INCLUDE('WINEVENT.INC'),ONCE
Include('c25_ProgramHandlerClass.inc'),Once

TrueReflectionClass             Class(),type,Module('c25_TrueReflectionClass.clw'), Link('c25_TrueReflectionClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                           Procedure(),private
Destruct                            Procedure(),private

c25QueueObject                      &c25QueueObjectClass
AddRowBytesToQueue                  Procedure(*queue _q, *StringTheory _st, Long _startPos , Long _endPos)
Analyze                             Procedure(<*QUEUE _queue>,<*ClarionFields_TYPE _outputQ>, <Byte _autoStyleColumns>,<*GROUP _group>,<String _tableName>, <bool _debug>, <String _name>, <String _jsonFileOut>),String,proc
BitConverter                        &c25BitConverterClass
ClarionFields                       &ClarionFields_TYPE
ClarionFields1                      &ClarionFields_TYPE
ClarionFields2                      &ClarionFields_TYPE
ClarionFieldsClaEnd_Array           Long,dim(256)
ClarionFieldsClaStart_Array         Long,dim(256)
ClarionFieldsIsRefStr_Array         bool,dim(256)
CreateQueueObject                   Procedure(String _queueName, String _queueTypeName, <bool _free>),*QUEUE
CreateSqliteScriptFromQueue         Procedure(*QUEUE _queue, String _tableName),String
CRLF                                String(2)
Dec20Cla                            Decimal(20,0)
Decimal20                           Decimal(20,0)
Decimal31                           Decimal(31,0)
DeSerializeQueues                   Procedure(*StringTheory _st),String, PROC
DisposeQFields                      Procedure(*QUEUE _q),bool,proc
DisposeStringRef                    Procedure(String _stringRef),bool,proc
EF_Address                          Long
EF_CurrentFieldAny                  ANY
EF_ptrString                        &String
F                                   Long
FieldsCount                         Long
GetNewId_QueueObjectsQ              Procedure(<bool _isGlobal>),Long
GetPutStringFromRef                 Procedure(String _stringRef, *StringTheory _st, <*Long _totalLength>),String,PROC
I                                   Long
I2                                  Long
IndicatorLong                       Long
IndicatorShort                      Short
IsRefArray                          bool,Dim(256)
!Logger                              &LoggerClass
MetaQueueObjectsQ                   &QueueObjectsQ_TYPE
Name                                cSTRING(128)
P                                   Long
P2                                  Long
PtrString                           &String
QBlockLength                        Long
QBlockLengthIndicatorPos            Long
QHdrLength                          Long
QHdrLengthIndicatorPos              Long
QHdrStartPos                        Long
QRefStr4                            String(4)
QueueObjectsQ                       &QueueObjectsQ_TYPE
QVarsLength                         Long
QVarsLengthIndicatorPos             Long
R                                   Long
R2                                  Long
Reflection                          &ReflectClass
SerializeQueue                      Procedure(*queue _q, <*StringTheory _st>, <String _filenameUtf>),String,proc
SomeQ                               &QUEUE
SomeQueueRef                        &QUEUE
StartPosTotalLength                 Long
Str8Zeroed                          String(8)
StrSize                             Long
T                                   Long
T2                                  Long
ThisLength                          Long
ThisNewQueue                        &Queue
TotalLength                         Long
TrueReflection1                     &TrueReflectionClass
TrueReflection2                     &TrueReflectionClass



LoadQueueTypes                      Procedure(),proc,String
EF_AdrGroup                         Group,pre(EF_AdrGroup)
EF_PtrAddress                           Long
EF_PtrSize                              Long
                                    End
QueueGroup                          Group,Pre(QueueGroup)
Q                                       &QUEUE
                                    End

Dec20ClaStr11                       String(11),Over(Dec20Cla)
Decimal20_Over                      String(11),Over(Decimal20)
Decimal31_Over                      String(16),Over(Decimal31)
EF_AddressAndSizeFromAny            String(8),over(EF_AdrGroup)
EF_AddressFromAny                   String(4),over(EF_Address)
IndicatorLongStrOver                String(4),Over(IndicatorLong)
IndicatorShortStrOver               String(2),Over(IndicatorShort)
LengthStr                           String(4),Over(ThisLength)
QBlockLengthStr                     String(4),Over(QBlockLength)
QHdrLengthStr                       String(4),Over(QHdrLength)
QVarsLengthStr                      String(4),Over(QVarsLength)
TotalLengthStr                      String(4),Over(TotalLength)
QRefLongOverStr4                    Long,over(QRefStr4)
                                End

