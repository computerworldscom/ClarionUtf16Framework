Include('c25_ProgramHandlerClass.inc'),Once

Int8                                            EQUATE(byte)
Int16                                           EQUATE(short)
Int32                                           EQUATE(long)
PtrInt32                                        EQUATE(long)
ByteArray                                       EQUATE(STRING)

c25_QueueCreateClass           	                Class(),type,Module('c25_QueueCreateClass.clw'), Link('c25_QueueCreateClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                           Procedure()
Destruct                                            Procedure()
ClassTypeName                                                               cstring(128)

CallbackClassPtr                                    long
DLLAddress                                          LONG
DllFileNameUtf8                                     string(1024)
DLLHandle                                           long
DLLSize                                             LONG
FieldMagic7Pos                                      long
fp_CreateQueue                                      LONG,NAME('CreateQueue')
Id                                                  Long
MagicFieldPos                                       Int32
MessageQueueOnly                                    BOOL
ModuleHandle                                        Long
NewLine                                             String(2)
ParentClassPtr                                        long
ProcessHeapHandle                                   LONG
ProductName                                         string(1024)

BitConverterClass                                   &c25_BitConverterClass
DLLDataReflectionClass                              &c25_DataReflectionClass
DataReflectionClass                                 &c25_DataReflectionClass
DataTable                                           &c25_DataTableClass
DllLoader                                           &C25_DllLoaderClass
DllLoaderClass                                      &c25_DllLoaderClass
MessageOnlyWindowClass                              &c25_MessageOnlyWindowClass
ObjectClass                                         &c25_ObjectClass
ProgramHandlerClass                                 &c25_ProgramHandlerClass
DataTableColumns                                    &DataTableColumns_TYPE
DllBytes                                            &DllBytes_TYPE
DllWriteSection                                     &QDLLSections_TYPE
QInfo                                               &Q_TYPE
QReturn                                             &QUEUE
QueueCreateColumns                                  &QueueCreateColumns_TYPE
StDllBytes                                          &StringTheory
StDllBytesDefault                                   &StringTheory
StDllBytesNew                                       &StringTheory
stLog                                               &StringTheory
stStructure                                         &StringTheory

!ApplyQueueStructure                                 Procedure(<*DataTableColumns_TYPE _dataTableColumns>),long,proc
!GetCreatedQueueJson                                 Procedure(<long _dataTableId>, <string _dataTableName>),STRING
!GetDataTableId                                      Procedure(<string _dataTableName>),LONG
CopyDllBytesToBuffer                                Procedure(<LONG _offset>, <LONG _length>),String,proc
CreateQueue                                         Procedure(long _dataTableId),long,proc
GetCreateQueue                                      Procedure(long _dataTableId),*QUEUE,PROC
GetCreatedQueue                                     Procedure(long _dataTableId),*QUEUE
GetDllSectionInfo                                   Procedure(<Int32 _sectionId>, <string _sectionName>),string,proc
GetFieldLenToString                                 Procedure(long _dataTypeLen),String
GetInt32ToString                                    Procedure(long _Characters),String
GetQInfo                                            Procedure(long _dataTableId),ByteArray
LoadQDllIntoMemory                                  Procedure(*long _address, *long _size),string,proc
LoadedDllToDllBytesQ                                Procedure(),LONG,PROC
WndProc_Process                                     Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)
Init                                                Procedure(),LONG,PROC


ModuleInfo                                          Group,Pre(ModuleInfo)
BaseOfDll                                               long
SizeOfImage                                             long
EntryPoint                                              long
                                                    End
WndProcDispatchArray                                Group,Pre(WndProcDispatchArray),Dim(256)
DllLibraryHandle                                        Long
ProcAddress                                             Long
ReturnVal                                               Long
Processed                                               Long
                                                    End

                                                End


