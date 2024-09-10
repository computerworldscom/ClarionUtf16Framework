!    Include('c25_DataTypes.clw'),Once
!    Include('c25_NanoSyncClass.inc'),once
!    Include('c25_WinApi32Class.inc'),once
!    Include('errors.clw'),Once
!    Include('jFiles.inc'),once
!    Include('StringTheory.inc'),once
!    Include('C25_DUMMY.CLW'),once
!    Include('C25_DUMMY.CLW'),once
    Include('c25_ProgramHandlerClass.inc'),Once

c25_ExtractResourcesThreadClass                                         Class(),type, Module('c25_ExtractResourcesThreadClass.clw'), Link('c25_ExtractResourcesThreadClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                   Procedure()
Destruct                                                                    Procedure()


ExtractPath                                                                 &STRING

ClassTypeName                                                               cstring(128)
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
StLog                                                                       &StringTheory
StLogFileName                                                               CSTRING(1024)
WinApiClass                                                                 &c25_WinApiClass()
BitConverterClass                                                           &c25_BitConverterClass()
Installed                                                                   Byte
IsInstalledParam                                                            Byte
Zero                                                                        string(1)
Zero2                                                                       string(2)
AppInstance                                                                 LONG
CRLF                                                                        string(2)
ProcessHeapHandle                                                           LONG
IsAlreadyInstalled                                                          Byte
SizeResource                                                                Long
ResourceHandle                                                              Long
ResourceDataHandle                                                          Long
ResourceDataHandlePtr                                                       Long
HeapMemAddress                                                              Long
CompileApp                                                                  BYTE
CurrentModuleFileNameA                                                      string(2048)
CurrentModuleFileNameW                                                      string(2048)
dataString                                                                  STRING(2000000)
DumHeight                                                                   LONG
DummyBuffer16K                                                              STRING(16000)
DummyString1K                                                               STRING(1024)
DumWidth                                                                    LONG
DumzPad                                                                     LONG
ExeFileName                                                                 String(256)
FileHandleFirst                                                             LONG
HandleResource                                                              LONG
HandleResourceData                                                          LONG
HandleResourceDataPtr                                                       LONG
Idx                                                                         long
JSONSTRING                                                                  STRING(2000000)
LBindSqlite3Library                                                         BYTE
LFontResources                                                              LONG
LinePart                                                                    STRING(512)
LocalDummyInt                                                               LONG
LSqlite3DllExists                                                           BYTE
LUnRarThreadOwnId                                                           LONG
OutputNameA                                                                 string(2048)
OutputNameW                                                                 string(2048)
QueueNameCurrent                                                            STRING(255)
recs                                                                        long
ResourceName                                                                CSTRING(256)
ResourceType                                                                CSTRING(16)
SomeLine                                                                    STRING(255)
st2GetLine                                                                  STRING(256)
st3GetLine                                                                  STRING(250)
SystemX86FolderOutputFile                                                   STRING(2048)
TargetFolderNameA                                                           string(2048)
TargetFolderNameW                                                           string(2048)
ThisDLLFilename                                                             STRING(256)
ThisDLLHandle                                                               LONG
unicodeChars                                                                long
UnRarThreadHandle                                                           LONG
UnRarThreadId                                                               LONG
WriteHandle                                                                 LONG
BufferString                                                                &string


DevicePropDefQ                                                              &DevicePropDef_TYPE
DevicePropertyCodeQ                                                         &DevicePropertyCode_TYPE
ImportBlob                                                                  &BLOB
Js1                                                                         &JSONClass
JsonImport                                                                  &JSONClass
!KnownFolders                                                                &KnownFolders_TYPE
NanoClock                                                                   &NanoSyncClass
Reflection                                                                  &TrueReflectionClass
ResourcesQ                                                                  &Resources_TYPE
Sqlite3                                                                     &Sqlite3Class
St1                                                                         &StringTheory
St2                                                                         &StringTheory
St3                                                                         &StringTheory
St4                                                                         &StringTheory
StEncoder                                                                   &StringTheory
StErrorLog                                                                  &StringTheory
!SystemClassOldQ                                                             &SystemClassOld_TYPE
SystemClasses                                                               &SystemClasses_TYPE
SystemClassesFlat                                                           &SystemClassesFlat_TYPE
WinApi                                                                      &WinApi32Class
unicodeText                                                                 &string


ExtractFontsAndInstall                                                      Procedure(),string,PROC
ExtractResource                                                             Procedure(<string _resourceName>, <Resources_TYPE _resourcesQ>, <string _ouputPath>),string,PROC
ExtractResources                                                            Procedure(),string,PROC
GenerateJsonFile                                                            Procedure(),string,PROC
ImportResourcesQJson                                                        Procedure(string _resourceName, <byte _fromDisk>),long,PROC
Start                                                                       Procedure(<byte _isInstalledParam>),string,PROC

ThreadInfo                                                                  Group(ThreadInfo_TYPE),Pre(ThreadInfo)
                                                                            End
                                                                        End


