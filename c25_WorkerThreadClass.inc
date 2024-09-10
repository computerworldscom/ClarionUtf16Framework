    INCLUDE('c25_BYTESHANDLERCLASS.INC'),ONCE
    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_EQUATES_ITEMIZED.CLW'),ONCE
    INCLUDE('c25_EQUATES_SQLITE3.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_HARDWARECLASS.INC'),ONCE
    INCLUDE('c25_LOGGERCLASS.INC'),ONCE
    INCLUDE('c25_MACHINECLASS.INC'),ONCE
    INCLUDE('c25_NANOSYNCCLASS.INC'),ONCE
    INCLUDE('c25_RENDERENGINECLASS.INC'),ONCE
    INCLUDE('c25_TRUEREFLECTIONCLASS.INC'),ONCE
    INCLUDE('c25_TYPES.CLW'),ONCE
    INCLUDE('c25_USERCLASS.INC'),ONCE
    INCLUDE('c25_WINAPI32CLASS.INC'),ONCE
    INCLUDE('CWSYNCHC.INC'),ONCE
    INCLUDE('ERRORS.CLW'),ONCE
    INCLUDE('JFILES.INC'),ONCE
    INCLUDE('REFLECTION.INC'),ONCE
    INCLUDE('STRINGTHEORY.INC'),ONCE

c25WorkerThreadClass           Class(),type, Module('c25_WorkerThreadClass.clw'), Link('c25_WorkerThreadClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                           Procedure()
Destruct                            Procedure()

Adapter                             &c25DbAdapterClass
BytesHandler                        &BytesHandlerClass
c25_BuildUserTree                   Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_CreateHardwareObject            Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_CreateRendererObject            Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_EnumPrinters                    Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_GetHardwarePtr                  Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_GetLargeTreeById                Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_GetMaxIdLargeTree               Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_HardwareInit                    Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_SendMachineData                 Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_SetSqlite34ConnUriUtf8          Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25_TakeSnapShot                    Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
c25DatabaseHandler                  &c25DatabaseHandlerClass
c25DatabaseHandlerPtr               Long
CRLF                                String(2)
CurrentLevel                        Long
DatabasesTemp                       &c25DbDatabases_TYPE
DummyProc                           Procedure(),Long,proc
FullMachineQ                        &MachineQ_TYPE
GetAppObjects                       Procedure(),Long,proc
GetSelfAddress                      Procedure(),Long
GetWinHandleByAdapterName           Procedure(String _name),Long
GlobalNanoSync                      &NanoSyncClass()
Hardware                            &HardwareClass
Init                                Procedure(),Long,proc
Js1                                 &JSONClass()
LargeTreeTEMP                       &LargeTree_TYPE
Logger                              &LoggerClass
MachineObject                       &MachineClass
MachineTest                         &MachineClass
Name                                &String
NanoSync                            &NanoSyncClass()
PrepareFunctionality                Procedure(<Long _functionality>),Long,proc
ReflectionCapesoft                  &ReflectClass()
RenderEngine                        &c25RenderEngineClass
ReturnVal                           Long
SelfAddress                         Long
Sqlite34                            &Sqlite34Class
Sqlite34HardwareConnHandle          Long
St1                                 &StringTheory
St2                                 &StringTheory
StartApp                            Byte
StartupApp                          Procedure(),Long,proc
ThisMachineId                       Long
TrueReflection                      &TrueReflectionClass()
UserObject                          &UserClass
WinApi                              &WinApi32Class()
WinHandle                           Long
WM_000016_WM_CLOSE                  Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WM_000275_WM_TIMER                  Procedure(Long _winHandle, Long _winMes, ULong _wParam, Long _lParam),Long,proc
WM_TimerCount                       Long
WndMessageProcessed                 Byte
WndProc_Process                     Procedure(Long winHandle, Long WM, ULong wparam, Long lParam),Long,proc

InterPacket                         Group(InterPacket_TYPE)
                                    End
InterPacketStrOver                  String(256),OVER(InterPacket)
                                End

