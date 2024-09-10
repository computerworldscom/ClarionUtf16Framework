    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_RenderEngineClass                                                   Class(),type, Module('c25_RenderEngineClass.clw'), Link('c25_RenderEngineClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                   Procedure()
Destruct                                                                    Procedure()

BufferGraphics                                                              Long
BufferImagePtr                                                              Long
ClassTypeName                                                               cstring(128)
DWMWA_VALUE                                                                 Long
GetRawInputDataReturn                                                       Long
InitDone                                                                    Byte
LinearGradientBrush                                                         long
PaintGraphics                                                               Long
RawDataBuffer                                                               String(2048)
RawDataBufferAddress                                                        Long
RawDataBufferAddressOffset                                                  Long
RawDataSize                                                                 Long
RawInputDevicesRegistered                                                   Byte
SomePathHandle                                                              Long
SomePenHandle                                                               Long
SomeSReal                                                                   SREAL
TabsCount                                                                   long
BufferImageWidth                                                            Long
BufferImageHeight                                                           Long
stLogFileName                                                               cstring(1024)
BufferScan0                                                                 Long
BufferAllocSize                                                             Long
MouseXY                                                                     Long
GlobalAlpha                                                                 byte
DcTemp                                                                      Long
CanRender                                                                   BOOL

BitConverterClass                                                           &c25_BitConverterClass
GdiPlusClass                                                                &c25_GdiPlusClass
NanoSync                                                                    &c25_NanoSyncClass
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
WinApiClass                                                                 &c25_WinApiClass()
RawMouse                                                                    &RawMouse_TYPE
!Tabs                                                                        &Tab_TYPE
WMInputQ                                                                    &WMInput_TYPE
stLog                                                                       &StringTheory()

!CreateTab                                                                   Procedure(*Tab_TYPE _tab),long,proc
CreateTabs                                                                  Procedure(),long,proc
Draw                                                                        Procedure(long _whandle, long _state),Long,proc
DrawSystemButtons                                                           Procedure(long _activeState),long,PROC
Init                                                                        Procedure(),proc,Long
Process_WM_INPUT                                                            Procedure(ULong WParam,Long LParam),String,proc
Process_MouseEvent                                                          Procedure(),long,PROC
RegisterRawInputDevices                                                     Procedure(<Long _handle>),Long,proc

BufferBitmapInfo                                                            Group,Pre(BufferBitmapInfo)
Size                                                                            Long
Width                                                                           Long
Height                                                                          Long
Planes                                                                          Short
BitCount                                                                        Short
Compression                                                                     Long
SizeImage                                                                       Long
XpelsPerMeter                                                                   Long
YPelsPerMeter                                                                   Long
ClrUsed                                                                         Long
ClrImportant                                                                    Long
                                                                            End
RawInputDevice                                                              Group(RawInputDevice_TYPE),Pre(RawInputDevice)
                                                                            End
RawInputHeader                                                              Group,Pre(RawInputHeader)
Type                                                                            Long
Size                                                                            Long
HandleDevice                                                                    Long
WParam                                                                          Long
                                                                            End
BeginPaintDC                                                                Long
PaintStruct                                                                 Group,Pre(PaintStruct)
DC                                                                              Long
Erase                                                                           Long
X                                                                               Long
Y                                                                               Long
W                                                                               Long
H                                                                               Long
Restore                                                                         Long
IncUpdate                                                                       Long
Reserved                                                                        String(512)
                                                                            End
MousePoint                                                                  Group,Pre(MousePoint)
X                                                                               Long
Y                                                                               Long
                                                                            End
MouseAppOriginePoint                                                        Group,Pre(MouseAppOriginePoint)
X                                                                               Long
Y                                                                               Long
                                                                            End
SomeColorARGB                                                               Group,Pre(SomeColorARGB)
B                                                                               Byte
G                                                                               Byte
R                                                                               Byte
A                                                                               Byte
                                                                            End
CanvasRect                                                                  Group,Pre(CanvasRect)
Left                                                                            Long
Top                                                                             Long
Right                                                                           Long
Bottom                                                                          Long
Width                                                                           Long
Height                                                                          Long
Size                                                                            Long
                                                                            End
TempRect                                                                    Group,Pre(TempRect)
Left                                                                            Long
Top                                                                             Long
Right                                                                           Long
Bottom                                                                          Long
Width                                                                           Long
Height                                                                          Long
                                                                            End

SomeColor                                                                   Long,OVER(SomeColorARGB)

MousePos                                                                    Group,Pre(MousePos),Over(MouseXY)
MouseX                                                                          short
MouseY                                                                          short
                                                                            End

                                                                        End

