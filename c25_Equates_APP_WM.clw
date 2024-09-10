WMAPP                               EQUATE(32768)
WMCAPP_Field                        ITEMIZE,PRE(WMCAPP_Field)
InitDone                                EQUATE(1)
                                    End

c25_WMSpecial                       ITEMIZE,PRE(c25_WMSpecial)
Test                                    EQUATE(1)
CreateBaseLayer                         EQUATE
CreateCanvas                            EQUATE
                                    End
c25User                             ITEMIZE,PRE(c25User)
Test                                    EQUATE(1025)
WM_ConvertMedia                         EQUATE
                                    End
c25                                 ITEMIZE,PRE(c25)
Test                                EQUATE(WMAPP + 1)
AdapterReady                        EQUATE
AddNetClientsPool                   EQUATE
AddNetListenersPool                 EQUATE
AppAlive                            EQUATE
AttachSqlite3ToPrimary              EQUATE
BuildUserTree                       EQUATE
BulkImport                          EQUATE
BulkSave                            EQUATE
CloseWindow                         EQUATE
ConnectMsSql                        EQUATE
ConnectSqlite3                      EQUATE
ConnFileSrv                         EQUATE
CreateDatabase                      EQUATE
CreateHardwareObject                EQUATE
CreateIndexes                       EQUATE
CreateNetClientServerPrimary        EQUATE
CreateNetClientsPool                EQUATE
CreateNetListenersPool              EQUATE
CreateRendererObject                EQUATE
CreateTables                        EQUATE
DetachSqlite3                       EQUATE
DisconnectMsSql                     EQUATE
DisconnectSqlite3                   EQUATE
EnumerateDevices                    EQUATE
EnumerateWinObj                     EQUATE
EnumPrinters                        EQUATE
EventsQueue                         EQUATE
Exec                                EQUATE
ExecuteScalar                       EQUATE
FetchRows                           EQUATE
GetBiosData                         EQUATE
GetCreateBCPFormatFile              EQUATE
GetHardwarePtr                      EQUATE
GetLargeTreeById                    EQUATE
GetMachineById                      EQUATE
GetMaxIdLargeTree                   EQUATE
GetSqlite3ConnHandle                EQUATE
HardwareFillDefaults                EQUATE
HardwareInit                        EQUATE
ImporBulkFile                       EQUATE
Login                               EQUATE
LogLine                             EQUATE
LogLineQRec                         EQUATE
LogLineQRecs                        EQUATE
NetCloseConn                        EQUATE
OpenFileServer                      EQUATE
PrepareServerDBs                    EQUATE
SaveQueueToSqlite3                  EQUATE
SaveQueueToSqlite3Sync              EQUATE
SaveToFileServer                    EQUATE
SetField                            EQUATE
SetSqlite34ConnUriUtf8              EQUATE
SpoolDataIn                         EQUATE
SpoolDataOut                        EQUATE
StartApp                            EQUATE
StartListener                       EQUATE
StartLogin                          EQUATE
TakeSnapShot                        EQUATE
InitSendData                        EQUATE
SendMachineData                     EQUATE
OpenConnection                      EQUATE
SendData                                EQUATE
GetFreeNetObject                        EQUATE
QueryStatus                             EQUATE
WM_NewLogEntries                        EQUATE
!WM_ConvertMedia                         EQUATE
                                    End

NetHdr_Hello                        EQUATE('7435DAA1-21DB-4872-8223-BF3266E9F721')
NetHdr_OK                           EQUATE('AB05FE21-64ED-4EFC-95E7-D6A550FF8B88')
NetHdr_IDLE                         EQUATE('ECEA94E8-94D4-4A4B-B7A5-64E8574E04D5')
NetHdr_Machine                      EQUATE('C5287591-0EEC-4672-AE0D-77CBA98B6866')

ClearLogQueue                       Equate('AB05FE21-64ED-4EFC-95E7-D6A550FF8B88')

NetQueryStatus                      ITEMIZE,PRE(NetQueryStatus)
IsOpen                                  EQUATE(1)
!SendHello                               EQUATE
                                    End


NetPhase                            ITEMIZE,PRE(NetPhase)
TryOpenConnection                       EQUATE(1)
SendHello                              EQUATE
SendingHello                           EQUATE
WaitForHelloResponse                    EQUATE
TryOpenListener                         EQUATE
Listen                                  EQUATE
Idle                                  EQUATE
                                    End

TreeIndicatorId                     ITEMIZE,PRE(TreeIndicatorId)
BiosTitle                           EQUATE(300)
BiosPageType00                      EQUATE
BiosPageType01                      EQUATE
BiosPageType02                      EQUATE
BiosPageType03                      EQUATE
BiosPageType04                      EQUATE
BiosPageType05                      EQUATE
BiosPageType06                      EQUATE
BiosPageType07                      EQUATE
BiosPageType08                      EQUATE
BiosPageType09                      EQUATE
BiosPageType10                      EQUATE
BiosPageType11                      EQUATE
BiosPageType12                      EQUATE
BiosPageType13                      EQUATE
BiosPageType14                      EQUATE
BiosPageType15                      EQUATE
BiosPageType16                      EQUATE
BiosPageType17                      EQUATE
BiosPageType18                      EQUATE
BiosPageType19                      EQUATE
BiosPageType20                      EQUATE
BiosPageType21                      EQUATE
BiosPageType22                      EQUATE
BiosPageType23                      EQUATE
BiosPageType24                      EQUATE
BiosPageType25                      EQUATE
BiosPageType26                      EQUATE
BiosPageType27                      EQUATE
BiosPageType28                      EQUATE
BiosPageType29                      EQUATE
BiosPageType30                      EQUATE
BiosPageType31                      EQUATE
BiosPageType32                      EQUATE
BiosPageType33                      EQUATE
BiosPageType34                      EQUATE
BiosPageType35                      EQUATE
BiosPageType36                      EQUATE
BiosPageType37                      EQUATE
BiosPageType38                      EQUATE
BiosPageType39                      EQUATE
BiosPageType40                      EQUATE
BiosPageType41                      EQUATE
BiosPageType42                      EQUATE
BiosPageType43                      EQUATE
BiosPageType44                      EQUATE
BiosPageType45                      EQUATE
BiosPageType46                      EQUATE
                                    End
TreeFieldIndicatorId                ITEMIZE,PRE(TreeFieldIndicatorId)
FullBiosTitle                       EQUATE(1)
                                    End
