Include('c25_ProgramHandlerClass.inc'),Once

c25ResourceHandlerClass                                     Class(),type, Module('c25_ResourceHandlerClass.clw'), Link('c25_ResourceHandlerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)


GetResource                                                     Procedure(String _resourceName, <StringTheory _stOut>),Proc,String
AppInstance                                                     Long
BitConverter                                                    &c25BitConverterClass
BufferString                                                    &String
CompileApp                                                      Byte
Construct                                                       Procedure()
CRLF                                                            String(2)
CurrentModuleFileNameA                                          String(2048)
CurrentModuleFileNameW                                          String(2048)
dataString                                                      String(2000000)
Destruct                                                        Procedure()
DevicePropDefQ                                                  &DevicePropDef_TYPE
DevicePropertyCodeQ                                             &DevicePropertyCode_TYPE
DumHeight                                                       Long
DummyBuffer16K                                                  String(16000)
DummyString1K                                                   String(1024)
DumWidth                                                        Long
DumzPad                                                         Long
ExeFileName                                                     String(256)
ExtractFontsAndInstall                                          Procedure(),String,PROC
ExtractResource                                                 Procedure(<String _resourceName>, <Resources_TYPE _resourcesQ>),String,PROC
ExtractResources                                                Procedure(<string _category>),String,PROC
FileHandleFirst                                                 Long
GenerateJsonFile                                                Procedure(),String,PROC
HandleResource                                                  Long
HandleResourceData                                              Long
HandleResourceDataPtr                                           Long
HeapMemAddress                                                  Long
Idx                                                             Long
ImportBlob                                                      &BLOB
ImportResourcesQJson                                            Procedure(String _resourceName, <Byte _fromDisk>),Long,PROC
Installed                                                       Byte
IsAlreadyInstalled                                              Byte
IsInstalledParam                                                Byte
Js1                                                             &JSONClass
JsonImport                                                      &JSONClass
JSONSTRING                                                      String(2000000)
KnownFolders                                                    &KnownFolders_TYPE
LBindSqlite3Library                                             Byte
LFontResources                                                  Long
LinePart                                                        String(512)
LocalDummyInt                                                   Long
LSqlite3DllExists                                               Byte
LUnRarThreadOwnId                                               Long
NanoClock                                                       &NanoSyncClass
OutputNameA                                                     String(2048)
OutputNameW                                                     String(2048)
ProcessHeapHandle                                               Long
QueueNameCurrent                                                String(255)
recs                                                            Long
Reflection                                                      &TrueReflectionClass
ResourceDataHandle                                              Long
ResourceDataHandlePtr                                           Long
ResourceHandle                                                  Long
ResourceName                                                    CSTRING(256)
ResourcesQ                                                      &Resources_TYPE
ResourceType                                                    CSTRING(16)
SizeResource                                                    Long
SomeLine                                                        String(255)
Sqlite3                                                         &Sqlite3Class
St1                                                             &StringTheory
St2                                                             &StringTheory
st2GetLine                                                      String(256)
St3                                                             &StringTheory
st3GetLine                                                      String(250)
St4                                                             &StringTheory
St5                                                             &StringTheory
Start                                                           Procedure(<Byte _isInstalledParam>),String,PROC
StEncoder                                                       &StringTheory
StErrorLog                                                      &StringTheory
SystemClassesQ                                                  &SystemClasses_TYPE
SystemClassOldQ                                                 &SystemClassOld_TYPE
SystemX86FolderOutputFile                                       String(2048)
TargetFolderNameA                                               String(2048)
TargetFolderNameW                                               String(2048)
ThisDLLFilename                                                 String(256)
ThisDLLHandle                                                   Long
unicodeChars                                                    Long
unicodeText                                                     &String
UnRarThreadHandle                                               Long
UnRarThreadId                                                   Long
WinApi                                                          &c25WinApiClass
WriteHandle                                                     Long
Zero                                                            String(1)
Zero2                                                           String(2)
ZeroUtf                                                         String(2)

ThreadInfo                                                      Group(ThreadInfo_TYPE),Pre(ThreadInfo)
                                                                End
                                End

