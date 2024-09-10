    Include('c25_ProgramHandlerClass.inc'),Once

c25_NanoSyncClass                                                       Class(),Type, Module('c25_NanoSyncClass.clw'), Link('c25_NanoSyncClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                   Procedure()
Destruct                                                                    Procedure()

Log                                                                         &StringTheory
LogFileName                                                                 &string
LogInMSec                                                                   BOOL
LogSinceLast                                                                BOOL

InitLog                                                                     Procedure(<string _logfileNameA>, <bool _logInMSecSinceLast>, <bool _create>),string,PROC
WriteLog                                                                    Procedure(string _line, <bool _write>),string,PROC

CRLF                                                                        string(2)
ClassTypeName                                                               cstring(128)
UseLocalDateTime                                                            Byte
AddressLDummyUINT64                                                         Long
BCP_TIMESTAMP_ANSI                                                          String(27)
BCP_TIMESTAMP_UTF16                                                         String(54)
DecInput                                                                    Decimal(20)
DecNanosInOneHour                                                           Decimal(20)
DecNanosInOneMinute                                                         Decimal(20)
DecNanosInOneMMSec                                                          Decimal(20)
DecNanosInOneSecond                                                         Decimal(20)
DecOutput                                                                   Decimal(20)
DurationStopWatchTime                                                       Decimal(20)
DurationStopWatchTimeMins                                                   Decimal(20)
DurationStopWatchTimeMMSec                                                  Decimal(20)
DurationStopWatchTimeSecs                                                   Decimal(20)
i64NanosInOneHour                                                           Like(UINT64)
i64NanosInOneMinute                                                         Like(UINT64)
i64NanosInOneMMSec                                                          Like(UINT64)
i64NanosInOneSecond                                                         Like(UINT64)
Int64Input                                                                  Like(INT64)
Int64Inter                                                                  Like(INT64)
Int64Output                                                                 Like(INT64)
Int64SystemTime                                                             Like(INT64)
IsTimeOut                                                                   Byte
LAddHours                                                                   Decimal(20)
LAddMinutes                                                                 Decimal(20)
LAddMM                                                                      Decimal(20)
LAddSeconds                                                                 Decimal(20)
LCalcDec                                                                    Decimal(20)
LDec                                                                        decimal(20)
LDec1                                                                       Decimal(20)
LDecDiff                                                                    Decimal(20)
LDecEnd                                                                     Decimal(20)
LDecNanoToAdd                                                               Decimal(20)
LDecStart                                                                   Decimal(20)
LDecVal10                                                                   Decimal(20)
LDecVal100                                                                  Decimal(20)
LDecZero                                                                    Decimal(20)
LDUMMY2UINT64                                                               Like(UINT64)
LDUMMYUINT64                                                                Like(UINT64)
LFileTimeDec                                                                Decimal(20)
LFileTimeUINT64                                                             Like(UINT64)
Li64Hours                                                                   Like(UINT64)
Li64HoursInNanoUnits                                                        Like(UINT64)
Li64Minutes                                                                 Like(UINT64)
Li64MinutesInNanoUnits                                                      Like(UINT64)
Li64MM                                                                      Like(UINT64)
Li64MMInNanoUnits                                                           Like(UINT64)
Li64NanoLeft                                                                Like(UINT64)
Li64NanoToAdd                                                               Like(UINT64)
Li64Seconds                                                                 Like(UINT64)
Li64SecondsInNanoUnits                                                      Like(UINT64)
Li64Val10                                                                   Like(UINT64)
Li64Val100                                                                  Like(UINT64)
LResult                                                                     Long
LReturnString1K                                                             String(1024)
LSystemTimeAsFileTimeUINT64                                                 Like(UINT64)
LSystemTimeUINT64                                                           Like(UINT64)
MMSecondsInLDAPTime                                                         Like(UINT64)
MMSecondsInLDAPTimeDec                                                      Decimal(20,)
StartStopWatchTime                                                          Decimal(20)
StopStopWatchTime                                                           Decimal(20)
StopWatchDuration                                                           Decimal(20)
StopWatchDurationHours                                                      Decimal(20)
StopWatchDurationMilliSec                                                   Decimal(20)
StopWatchDurationMinutes                                                    Decimal(20)
StopWatchDurationSeconds                                                    Decimal(20)
StopWatchEndTime                                                            Decimal(20)
StopWatchEndTimeTemp                                                        Decimal(20)
StopWatchStartTime                                                          Decimal(20)
Str8                                                                        String(8)
Str8Address                                                                 Long
Str8UTC                                                                     String(8)
Str8UTCAddress                                                              Long
SysTime                                                                     Decimal(20)
SysTimeTimeOut                                                              Decimal(20)
Timeout                                                                     Decimal(20)
Timeout_Days                                                                Long
Timeout_Hours                                                               Long
Timeout_MilliSeconds                                                        Long
Timeout_Minutes                                                             Long
Timeout_NanoSeconds                                                         Long
Timeout_Seconds                                                             Long
LastSysTime                                                                 Decimal(20)
Str20                                                                       String(20)



BitConverter                                                                &c25_BitConverterClass
St1                                                                         &StringTheory
TimeOutQ                                                                    &TimeOut_TYPE

CalcSysTimeout                                                              Procedure(Long _hr,Long _min,Long _sec,Long _mm),String
ConvertUTCToLocal                                                           Procedure(String _fileTimeStr8),String
DecToSQL_TIMESTAMP_STRUCT                                                   Procedure(String _dec, <bool _convertToLocal>),String
DecToSQL_TIMESTAMP_STRUCT_IsValid                                           Procedure(String _dec, <bool _convertToLocal>),Byte
DecToSQL_TIMESTAMP_STRUCT_TIMEONLY                                          Procedure(String _dec, <bool _convertToLocal>),String
FormatFromNanoseconds                                                       Procedure(String _nanoSeconds),String,Proc
GetLDAPTime                                                                 Procedure(<bool _convertToLocal>),String
GetNanoSecondsFromFILETIME                                                  Procedure(String _fileTimeStr8),String,Proc
GetSysTime                                                                  Procedure(<bool _convertToLocal>, <INT64 _int64>),String,proc
GetSysTimeInMSec                                                            Procedure(<bool _convertToLocal>),String,proc
!GetSysTime                                                                  Procedure(<bool _convertToLocal>, <string _cstringVal>),String,proc
GetSysTimeAsUINT64                                                          Procedure(<bool _convertToLocal>),String
GetSystemTimeFromStr8                                                       Procedure(String _fileTimeStr8),String,Proc
Get_DateTime                                                                Procedure(<*String _output>),String,Proc
Get_DateTime                                                                Procedure(<*String _output>, String _dec20),String,Proc
Get_DateTimeW                                                               Procedure(<*String _output>),String,Proc
Get_DateTimeW                                                               Procedure(<*String _output>, String _dec20),String,Proc
IsTimeOut                                                                   Procedure(<String _name>,<Byte _removeWhenTimeout>,<Byte _createWhenNotExist>, <Long _returnValIfNotExist>),Byte
LDAPTimeToMMSeconds                                                         Procedure(String _LDAPTime),String
SetTimeOut                                                                  Procedure(<Long _hr>,<Long _min>,<Long _sec>,<Long _mm>,<String _name>),String,Proc
StartStopwatch                                                              Procedure(),String,Proc
StopStopWatch                                                               Procedure(<bool _showSecs>),String,Proc
TimerExists                                                                 Procedure(String _name),Byte
FormatNanoSeconds                                                           Procedure(String _dec, <bool _convertToLocal>),string




LSystemTime                                 Group,Pre(LSystemTime)
Year                                            Short
Month                                           Short
DayOfWeek                                       Short
Day                                             Short
Hour                                            Short
Minute                                          Short
Second                                          Short
Milliseconds                                    Short
                                            End
SYSTEMTIME                                  Group(SYSTEMTIME_TYPE)
NanoSeconds                                     short
                                            End

SetSystemTimeFromFileTime                   Procedure(String _fileTimeStr8),string,Proc

                                        End

