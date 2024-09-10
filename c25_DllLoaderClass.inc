    Include('c25_ProgramHandlerClass.inc'),Once

c25_DllLoaderClass                                                      Class(),Type, Module('c25_DllLoaderClass.clw'), Link('c25_DllLoaderClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ClassTypeName                                                               cstring(128)

ProgramHandlerClass                                                         &c25_ProgramHandlerClass
BitConverter                                                                &c25_BitConverterClass
NanoSync                                                                    &c25_NanoSyncClass
WinApi                                                                      &c25_WinApiClass
ProductFunctionsQ                                                           &ProductFunctions_TYPE
ProductsQ                                                                   &Products_TYPE

CallDllFunction                                                             Procedure(String _functionName, <String _dllNameA>, <String _params>, <*Long _returnVal>),Long,Proc
CallDllFunction                                                             Procedure(String _functionName, <String _dllNameA>, <String _params>, <*queue returnVal>),*Queue,Proc
CallDllFunction                                                             Procedure(String _functionName, <String _dllNameA>, <String _params>, <*String returnVal>),String,Proc
FreeResources                                                               Procedure(),Long,Proc
GetMessageNameById                                                          Procedure(Long _id),String
GetModuleHandle                                                             Procedure(<string _productName>),long,PROC
GetProcAddress                                                              Procedure(Long _dllHandle, <String _procedureName>, <Long _ordinal>),Long
LoadDllFunctionCall                                                         Procedure(String _dllNameA, <String _functionName>, <Long _ordinal>, <String _dllNameW>,<string _productName>),Long
LoadDllIntoMemory                                                           Procedure(<String _dllNameA>, <String _dllNameW>, <string _productName>),long,PROC
LoadDllLibrary                                                              Procedure(<String _dllNameA>, <String _dllNameW>),Long
NotYetImplemented                                                           Procedure(),Long,Proc

                                                                        End



