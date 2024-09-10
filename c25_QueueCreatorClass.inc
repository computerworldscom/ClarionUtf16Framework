!    INCLUDE('c25_HARDWARECLASS.INC'),ONCE
!    INCLUDE('c25_LOGGERCLASS.INC'),ONCE
!    INCLUDE('c25_MACHINECLASS.INC'),ONCE
!    INCLUDE('c25_USERCLASS.INC'),ONCE
    INCLUDE('c25_BYTESHANDLERCLASS.INC'),ONCE
    INCLUDE('c25_DATATYPES.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'), ONCE
    INCLUDE('c25_EQUATES_ITEMIZED.CLW'),ONCE
    INCLUDE('c25_EQUATES_SQLITE3.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('C25_DUMMY.CLW'),ONCE
    INCLUDE('c25_NANOSYNCCLASS.INC'), ONCE
    !INCLUDE('c25_QueueCreatorClass.INC'),ONCE
    INCLUDE('c25_TYPES.CLW'),ONCE
    INCLUDE('c25_WINAPI32CLASS.INC'), ONCE
    INCLUDE('CWSYNCHC.INC'),ONCE
    INCLUDE('ERRORS.CLW'),ONCE
    INCLUDE('REFLECTION.INC'),ONCE
    INCLUDE('STRINGTHEORY.INC'),ONCE
    INCLUDE('WINEVENT.INC'),ONCE




c25QueueCreatorClass                Class(),type,Module('c25_QueueCreatorClass.clw'), Link('c25_QueueCreatorClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                               Procedure(),private
Destruct                                Procedure(),private

!fn_CreateNewQueue                       Long,Name('c25CreateNewQueue')
hModule                                 Long
FreeResources                           Procedure(),proc,Long
ProductsQ                            &Products_TYPE
ProductFunctionsQ                    &ProductFunctions_TYPE
DllTemplate                             &StringTheory
LoadDlls                                Procedure(),Long
!CreateNewQueue                          Procedure(String _description),*QUEUE,PROC
GetProcAddress                          Procedure(String _description),Long,PROC
Loadc25Dlls                             Procedure(<Long _dllLibraryHandle>, String _ProductName,String _functionName,<String _nameDllUtf8>,<String _nameDllUtf16>,<String _serialKey>,<String _version>),String
                                    End

