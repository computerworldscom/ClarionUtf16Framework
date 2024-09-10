    Include('c25_AWEClass.inc'),Once
    Include('c25_BindingSourceClass.inc'),Once
    Include('C25_BitconverterClass.Inc'),Once
    Include('c25_ClassStarter.inc'),Once
    Include('c25_ControlButtonClass.inc'),Once
    Include('c25_ControlButtonRenderClass.inc'),Once
    Include('c25_ControlClass.inc'),Once
    Include('c25_ControlLabelClass.inc'),Once
    Include('c25_ControlLabelRenderClass.inc'),Once
    Include('c25_ControlRendererClass.inc'),Once
    Include('c25_ControlsFactoryClass.inc'),Once
    Include('c25_ControlTreeViewClass.inc'),Once
    Include('c25_ControlTreeViewRenderClass.inc'),Once
    Include('c25_DataCellClass.inc'),Once
    Include('c25_DataColumnClass.inc'),Once
    Include('c25_DataColumnsCollectionClass.inc'),Once
    Include('c25_DataControlStyleClass.inc'),Once
    Include('c25_DataManagerClass.inc'),Once
    Include('c25_DataReflectionClass.inc'),Once
    Include('c25_DataRowClass.inc'),Once
    Include('c25_DataSetClass.inc'),Once
    Include('c25_DataSourceClass.inc'),Once
    Include('c25_DataTableClass.inc'),Once
    Include('C25_Datatypes.Clw'),Once
    Include('c25_DictionaryClass.inc'),Once
    Include('C25_DllloaderClass.Inc'),Once
    Include('C25_Equates_Global.Clw'),Once
    Include('C25_Equates_Wm.Clw'),Once
    Include('c25_ExtendedDataTypes.inc'),Once
    Include('c25_ExtractResourcesThreadClass.inc'),once
    Include('C25_GdiplusClass.Inc'),Once
    Include('c25_GlobalDataClass.inc'),Once
    Include('c25_HardwareClass.inc'),ONCE
    Include('c25_ListItemClass.inc'),Once
    Include('c25_MessageOnlyWindowClass.inc'),Once
    Include('C25_NanoSyncClass.Inc'),Once
    Include('c25_ObjectClass.inc'),Once
    Include('c25_PageBufferClass.inc'),Once
    Include('c25_QueueCreateClass.inc'),Once
    Include('C25_RenderEngineClass.inc'),Once
    Include('c25_ResultClass.inc'),Once
    Include('c25_SetupClass.inc'),Once
    Include('C25_SingletonClass.Inc'),Once
    Include('c25_SqliteClass.inc'),Once
    Include('c25_TabClass.inc'),Once
    Include('C25_TabRenderEngineClass.inc'),Once
    Include('c25_ThemeManagerClass.inc'),Once
    Include('c25_TreeClass.inc'),Once
    Include('c25_TreeViewClass.inc'),ONCE
    Include('c25_ValueObjectClass.inc'),Once
    Include('C25_WinApiClass.inc'),Once
    Include('c25_WinMesObjectClass.inc'),Once
    Include('c25_WinNT_Errorcode_Equates.clw'),ONCE
    Include('Cwsynchc.Inc'),Once
    Include('Errors.Clw'),Once
    INCLUDE('fp_sqlite3.clw')
    Include('Jfiles.Inc'),Once
    Include('Stringtheory.Inc'),Once
    Include('Windows.inc'),Once

C25_ProgramHandlerClass                                                 Class(),type, Module('C25_ProgramHandlerClass.clw'), Link('C25_ProgramHandlerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

!Constructaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa     Procedure()
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

RootLog                                                                     &c25_NanoSyncClass
AutoCloseDownTimer                                                          &c25_NanoSyncClass


GlobalDataClass                                                             &c25_GlobalDataClass
ThemeManagerClass                                                           &c25_ThemeManagerClass

HardwareClass                                                               &c25_HardwareClass
ClientPaintCount                                                            LONG
MouseAppOriginePointX long
MouseAppOriginePointY long

ActivateAppDone                                                             Byte
RegisteredRawInputDevices                                                   BOOL
StatusBarHeight                                                             LONG

CloseDown                                                                   Procedure(),string,proc

!TreeViewNodes                                                               &TreeViewNode_TYPE
!TreeViewNav                                                                 &TreeViewNode_TYPE


!NavigationTreeControl                                                       &c25_TreeViewClass

WindowRect                                                                  &WindowRect_TYPE
TabObject                                                                   &Tab_TYPE

!DictTabs                                                                    &c25_DictionaryClass
WinAppState                                                                 Long ! active or not active
PaintTimeoutForced                                                          decimal(21,0)


DC                                                                          Long
DCClient                                                                    Long

ApplicationFileNameAnsi                     &STRING
ApplicationFileNameUtf8                     &STRING
ApplicationFileNameUtf16                    &STRING
ApplicationDriveAnsi                        &STRING
ApplicationDriveUtf16                       &STRING
ApplicationDriveUtf8                        &STRING
ApplicationFolderNameAnsi                   &STRING
ApplicationFolderNameUtf16                  &STRING
ApplicationFolderNameUtf8                   &STRING
ApplicationPathAnsi                         &STRING
ApplicationPathUtf16                        &STRING
ApplicationPathUtf8                         &STRING
ApplicationNameAnsi                         &STRING
ApplicationNameUtf16                        &STRING
ApplicationNameUtf8                         &STRING
ProgramDataAnsi                             &STRING
ProgramDataUtf16                            &STRING
ProgramDataUtf8                             &STRING
ApplicationFileNameAndPathUtf16             &STRING
ApplicationFileNameAndPathUtf8              &STRING
ApplicationFileNameAndPathAnsi              &STRING
ProgramDataFolderNameAnsi                   &STRING
ProgramDataFolderNameUtf16                  &STRING
ProgramDataFolderNameUtf8                   &STRING
DataStoreDriveAnsi                          &STRING
DataStoreDriveUtf16                         &STRING
DataStoreDriveUtf8                          &STRING
ProgramDataPathAnsi                         &STRING
ProgramDataPathUtf16                        &STRING
ProgramDataPathUtf8                         &STRING
AppDataAnsi                                 &STRING
AppDataUtf16                                &STRING
AppDataUtf8                                 &STRING
KnownPath_ApplicationShortcutsUtf16         &STRING
KnownPath_DesktopUtf16                      &STRING
KnownPath_DocumentsUtf16                    &STRING
KnownPath_LocalAppDataUtf16                 &STRING
KnownPath_ProgramDataAnsi                   &STRING
KnownPath_ProgramDataUtf16                  &STRING
KnownPath_ProgramDataUtf8                   &STRING
KnownPath_ProgramFilesAnsi                  &STRING
KnownPath_ProgramFilesUtf16                 &STRING
KnownPath_ProgramFilesUtf8                  &STRING
KnownPath_AppDataUtf16                      &STRING
ProgramDataFolderAnsi                       &STRING
ProgramDataFolderUtf16                      &STRING
AppSqliteFileNameUtf8                       &STRING
AppSqliteFileNameUtf16                      &STRING
AppSqliteFullPathUtf8                       &STRING
AppSqliteFullPathUtf16                      &STRING

RenderEngineClassDrawCount                                                  Long

DictKnownPaths                                                              &c25_DictionaryClass


Ready                                                                       BOOL


TabBackdropColorDimmed                                                      Long
TabBackdropColorActive                                                      Long
TabHeaderColorDimmed                                                        Long
TabHeaderColorActive                                                        Long


BorderColorActive                                                           Long
BorderColor                                                                 Long

RootInitSuccess                                                             BOOL
IsRootProgramHandler                                                        BOOL

SQLiteAsyncConnections                                                      &SQLiteAsyncConnection_TYPE

INCLUDE('CWMVars.clw')

EXE_DLL_MODE                                                                BOOL
EXE_COMPILED_DEBUG                                                          BOOL


WindowHandle                                                                long
ClientWindowHandle                                                          long
WNDProc                                                                     long
ClientWndProc                                                               long
OldWNDProc                                                                  long
OldClientWndProc                                                            long

ExtendedQueueFunctions                                                      Bool

Int16MaxValue                                                               decimal(20)
Int16MinValue                                                               decimal(20)
Int32                                                                       Long
Int32MaxValue                                                               decimal(20)
Int32MinValue                                                               decimal(20)
Int64MaxValue                                                               decimal(20)
Int64MinValue                                                               decimal(20)
ResultCode                                                                  Long
SelfAddress                                                                 Long
UInt16MaxValue                                                              decimal(20)
UInt16MinValue                                                              decimal(20)
UInt32MaxValue                                                              decimal(20)
UInt32MinValue                                                              decimal(20)
UInt64MaxValue                                                              decimal(20)
UInt64MinValue                                                              decimal(20)

Name                                                                        String(250)
ReturnVal                                                                   Long
SomeString64K                                                               String(65000)
UniqueProcessName                                                           String(128)
UniqueProcessNameRegMes                                                     Long
WindowClientHandle                                                          Long

CaptionActiveFillColorHint                                                  Long
DwmColorizationColor                                                        Long
DwmOpaqueBlend                                                              Long


GdiplusToken                                                                Long
CloseButtonRect                                                             &WindowRect_TYPE
CloseButtonState                                                            Long
WM_C25_CloseApp                                                             LONG
WM_C25_Special                                                              LONG

RibbonHeight                                                                Long
RibbonTabHeadersHeight                                                      Long
RibbonShortCutBarHeight                                                     Long

LastPhase                                                                   cstring(255)
Phase                                                                       cstring(255)
NextPhase                                                                   cstring(255)

CanUseSqliteForRendering                                                    Bool
RenderStarted                                                               BOOL

TabsClassPtrArray                                                           long,dim(1024)
TabsWindowHandleArray                                                       long,dim(1024)
TabsArrayMax                                                                Long
TabIdActive                                                                 Long

TabsOffsetY                                                                 Long

DisplayWidth                                                                Long
DisplayHeight                                                               Long

GdiplusStartupInput                                                         GROUP,PRE(GdiplusStartupInput)
Version                                                                         ULong
DebugEventCallback                                                              Long
SuppressBackgroundThread                                                        Byte
SuppressExternalCodecs                                                          Byte
                                                                            End

RenderEngineClass                                                           &c25_RenderEngineClass
BitConverterClass                                                           &C25_BitConverterClass
CreatedQueue                                                                &QUEUE
CurrentWindowHandler                                                        &C25_WindowHandlerClass
DLLDataReflectionClass                                                      &c25_DataReflectionClass
DataManagerClass                                                            &c25_DataManagerClass
DllLoaderClass                                                              &C25_DllLoaderClass
GdiPlusClass                                                                &C25_GdiPlusClass
MessageOnlyWindowClass                                                      &c25_MessageOnlyWindowClass
NanoClockClass                                                              &C25_NanoSyncClass
ObjectClass                                                                 &c25_ObjectClass
PostWindowHandler                                                           &C25_WindowHandlerClass
QueueCreateClass                                                            &C25_QueueCreateClass
QueueExtender                                                               &c25_QueueExtenderClass
Singleton                                                                   &C25_SingletonClass
WinApiClass                                                                 &c25_WinApiClass
WinMesObjectClass                                                           &c25_WinMesObjectClass
WindowHandlers                                                              &WindowHandlers_TYPE
DataReflectionClass                                                         &c25_DataReflectionClass
SetupClass                                                                  &c25_SetupClass
AWEClass                                                                    &c25_AWEClass

KnownFolders                                                                &KeyValue_TYPE                                                 
EnumSpecialPaths                                                            Procedure(),long,PROC
NavigationTree                                                              &TreeViewNode_TYPE !NavigationTree_TYPE ! move out

DictSpecialFolders                                                          &c25_DictionaryClass

LoadTabs                                                                    Procedure(),string,PROC

UpdateRenderEngineClassDraw                                                 Procedure(),long,PROC
UpdateWindowRect                                                            Procedure(),string,PROC
PopulateNavigationTree                                                      Procedure(),string,PROC
SetDefaultFolders                                                           Procedure(),long,PROC
!Start                                                                       Procedure(),long,PROC
PopulateSQLiteAsyncConnections                                              Procedure(),long,proc
CreateMainAppWindow                                                         Procedure(<bool _hideParentWindow>),LONG,PROC
CreateNewWindow                                                             Procedure(String _name, <bool _wait>, <bool _hideParentWindow>, <string _functionName>),Long,Proc
GetCWM_C25WinMesName                                                        Procedure(long _c25MessageId),STRING
GetWindow                                                                   Procedure(String _name),Long,Proc
OpenNewWindow                                                               Procedure(<bool _hideParentWindow>),Long,Proc
PostMessageA                                                                Procedure(string _windowName, ULong _message, ULong _wParam, Long _lParam),String,proc
PostMessageA                                                                Procedure(string _windowName, string _tabName, ULong _message, ULong _wParam, Long _lParam),String,proc
ProcessC25WinMes                                                            Procedure()
RegisterWM                                                                  Procedure(string _messageName),uLong,proc
RegisterWMs                                                                 Procedure(),long,proc
RootInit                                                                    Procedure(<BOOL EXE_DLL_MODE>, <BOOL EXE_COMPILED_DEBUG>),LONG,PROC
SendMessageTimeoutA                                                         Procedure(string _windowName, string _tabName, ULong _message, ULong _wParam, Long _lParam, <string _retWhenFailed>),String,proc
SetC25WinMes_ReturnBufferPtr                                                Procedure(long _bufferPtr, long _bufferSizeLo, <long _bufferSizeHi>)
SetC25WinMes_ReturnInt32                                                    Procedure(long _valueInt32)
SetC25WinMes_ReturnString16K                                                Procedure(string _message)
SetCurrentWindowByName                                                      Procedure(string _name),long
WndProc_Process                                                             Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, long ReturnVal, <*bool PostProcess>)
                                                                       End

