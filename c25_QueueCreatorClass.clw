        Member

    Include('c25_QueueCreatorClass.inc'),Once

                    MAP
!                        Module('QueueMeta001.dll')
!                            !c25QMInit(Long _paramA),String,pascal,PROC,dll(1)
!                            c25CreateNewQueue(String _typeName, String _name),*queue,pascal,PROC,dll(1)
!                        End
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
                        Include('c25_Prototypes_WinApi32.clw')
                    End

c25QueueCreatorClass.Destruct                        Procedure()

    Code

c25QueueCreatorClass.Construct                       Procedure()

    Code

        Self.DllTemplate &= NEW StringTheory()
        Self.ProductsQ               &= NEW Products_TYPE()
        Self.ProductFunctionsQ       &= NEW ProductFunctions_TYPE()        
!        Self.CRLF = Chr(13) & Chr(10)
!        Self.ClarionFields &= NEW ClarionFields_TYPE()
        !Self.st1 &= NEW StringTheory()
!        Self.st2 &= NEW StringTheory()
!        Self.st3 &= NEW StringTheory()
!        Self.st1.Start()
!        Self.st2.Start()
!        Self.st3.Start()
!        Self.Str8Zeroed = All(Chr(0),8)
!        Self.Logger &= null

c25QueueCreatorClass.FreeResources                      Function()

Code

    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.ProductsQ,I#)
        If Errorcode() <> 0
            BREAK
        End
        If Self.ProductsQ.DllLibraryHandle <> 0
            c25_FreeLibrary(Self.ProductsQ.DllLibraryHandle)
            Self.ProductsQ.DllLibraryHandle = 0
            Put(Self.ProductsQ)
        End
    End
    Return 0        
        
    
    
c25QueueCreatorClass.GetProcAddress Procedure(String _description)
!
!                    map
!                        Module('QueueMeta001.dll')
!                            !c25QMInit(Long _paramA),String,pascal,PROC,dll(1)
!                            c25CreateNewQueue(String _typeName, String _name),*queue,pascal,PROC,dll(1)
!                        End
!                    End

ProcAddress                 Long
SomeQ                       &QUEUE
!fn_CreateNewQueue           Long,Name('c25CreateNewQueue')

    Code
        
        
       
        Self.DllTemplate.Start()
        Self.DllTemplate.LoadFile('QueueMeta001.dll')
        F# = Self.DllTemplate.FindChar('FIELD001')
        !F# = F# - 2
        !Self.DllTemplate.SetSlice(F#-2, F#-1, Chr(01) & Chr(02) )
        !Message(F#)
        !F# = 1621
        !Self.DllTemplate.Replace('FIELD001','FI' & Chr(Random(041h,05Ah)) & 'LD001')
        !Self.DllTemplate.SetSlice(F#, F#, Chr(Random(041h,05Ah)))
        !Self.DllTemplate.SetSlice(F#+1, F#+1, Chr(Random(041h,05Ah)))
        
        Self.DllTemplate.SaveFile('QueueMeta001.dll')
        
        ProcAddress = Self.LoadDlls()
!        If ProcAddress = 0
!            Return NULL
!        End
        !fn_CreateNewQueue = ProcAddress
        !Message('fn_CreateNewQueue ' & fn_CreateNewQueue)
        
!        SomeQ &= c25CreateNewQueue('test','test')
!        Loop 110 TIMES
!            Add(SomeQ)
!        End
!        Message(Records(SomeQ))
        
        Return ProcAddress
!        SomeQ &= c25CreateNewQueue('test','test')
!        !Message(F#)
!        If SomeQ &= NULL
!            Message('some is null')
!            Return null
!        End
!        
!        !Self.DllTemplate
!        Return SomeQ
        
c25QueueCreatorClass.LoadDlls                           Procedure()

c25St1                  &StringTheory()
c25Js1                  &JSonClass()
TulipGrpLoadDll         GROUP
DllLibraryHandle            Long
ProcAddress                 Long
LastErrorcode               Long
                        End

    Code

    c25St1 &= NEW StringTheory()
    c25Js1 &= NEW JSonClass()

    If LoadJSon#

    End
    GenJson# = True
    If GenJson# = True
        Free(Self.ProductsQ)
        Free(Self.ProductFunctionsQ)

       
        Self.ProductsQ.FullName               = 'QueueMeta001'
        Self.ProductsQ.Name                   = 'QueueMeta001'
        Self.ProductsQ.DllName                = 'QueueMeta001.dll'
        Self.ProductsQ.PathDll                = ''
        Self.ProductsQ.PathDllUtf8            = ''
        Self.ProductsQ.Version                = ''
        Self.ProductsQ.SerialKey              = ''
        Self.ProductsQ.ForceDebugVersion      = 0
        Self.ProductsQ.ForceReleaseVersion    = 0
        Self.ProductsQ.DllLibraryHandle       = 0
        Self.ProductsQ.ErrorLoading           = 0
        Self.ProductsQ.ERRORCODE              = 0
        Self.ProductsQ.ErrorMessage           = ''
        Self.ProductsQ.SkipShowError          = 0
        Add(Self.ProductsQ)

        Self.ProductFunctionsQ.ProductName    = Self.ProductsQ.Name
        Self.ProductFunctionsQ.FriendlyName   = ''
        Self.ProductFunctionsQ.FunctionName   = 'CreateQueue'
        Self.ProductFunctionsQ.ExpName        = 'CreateQueue'
        Self.ProductFunctionsQ.Version        = ''
        Self.ProductFunctionsQ.SerialKey      = ''
        Self.ProductFunctionsQ.ProcHandle     = 0
        Self.ProductFunctionsQ.ERRORCODE      = 0
        Self.ProductFunctionsQ.ErrorMessage   = ''
        Self.ProductFunctionsQ.SkipShowError  = 0
        Self.ProductFunctionsQ.Ordinal        = 1
        Add(Self.ProductFunctionsQ)        

  
    End

    I# = 0
    Loop
        I# = I# + 1
        Get(Self.ProductsQ,I#)
        If Errorcode() <> 0
            BREAK
        End

        I2# = 0
        Loop
            I2# = I2# + 1
            Get(Self.ProductFunctionsQ,I2#)
            If Errorcode() <> 0
                BREAK
            End
            If Upper(clip(Self.ProductFunctionsQ.ProductName)) <> Upper(clip(Self.ProductsQ.Name))
                CYCLE
            End
            Clear(TulipGrpLoadDll)
            If Self.ProductFunctionsQ.Ordinal > 0
                TulipGrpLoadDll = Self.Loadc25Dlls(Self.ProductsQ.DllLibraryHandle , Self.ProductsQ.DllName , Self.ProductFunctionsQ.Ordinal) !, <String _nameDllUtf8>, <String _nameDllUtf16>,<String _serialKey>,<String _version>)
            Else
                TulipGrpLoadDll = Self.Loadc25Dlls(Self.ProductsQ.DllLibraryHandle , Self.ProductsQ.DllName , Self.ProductFunctionsQ.ExpName) !, <String _nameDllUtf8>, <String _nameDllUtf16>,<String _serialKey>,<String _version>)
            End
            Self.ProductsQ.DllLibraryHandle   = TulipGrpLoadDll.DllLibraryHandle
            Put(Self.ProductsQ)
            Self.ProductFunctionsQ.ProcHandle = TulipGrpLoadDll.ProcAddress
            Put(Self.ProductFunctionsQ)
            Allocated# = 0
            If TulipGrpLoadDll.ProcAddress = 0
                Message('error ' & clip(Self.ProductFunctionsQ.ProductName) & ',' & clip(Self.ProductsQ.Name))
            Else
!                Case Self.ProductFunctionsQ.FunctionName
!                Of 'c25REInit'
!                    Self.fn_c25REInit = TulipGrpLoadDll.ProcAddress
!                    Allocated# = 1
!                Of 'c25DBHInit'
!                    Self.fn_c25DBHInit = TulipGrpLoadDll.ProcAddress
!                    Allocated# = 1
!                Of 'c25WTInit'
!                    Self.fn_c25WTInit = TulipGrpLoadDll.ProcAddress
!                    Allocated# = 1
!                Of 'c25QMInit'
!                    Self.fn_c25QMInit = TulipGrpLoadDll.ProcAddress
!                    Allocated# = 1     
!                Of 'CreateQueue'
!                    Self.fn_CreateQueue = TulipGrpLoadDll.ProcAddress
!                    Allocated# = 1                      
!                End
                !Message('TulipGrpLoadDll.ProcAddress ' & TulipGrpLoadDll.ProcAddress)
                Return TulipGrpLoadDll.ProcAddress
            End
            If Allocated# = 0
                Message('error fn_ allocation')
            End
        End
    End
    Return 0
        
c25QueueCreatorClass.Loadc25Dlls                        Function(<Long _dllLibraryHandle>, String _ProductName, String _functionName, <String _nameDllUtf8>, <String _nameDllUtf16>,<String _serialKey>,<String _version>)

ProductName              cstring(128)
c25DllFilePathUtf8          String(1024)
c25DllFilePathUtf16         String(1024)
c25ProcNameA                cstring(255)
TulipGrp                    GROUP
DllLibraryHandle                Long
ProcAddress                     Long
LastErrorcode                   Long
                            End
DebugLevel                  Byte

    Code

        If _DEBUG_
            DebugLevel = 0
        End

        c25ProcNameA = Clip(Left(_functionName))

        TulipGrp.ProcAddress = 0
        If omitted(_dllLibraryHandle) = False
            TulipGrp.DllLibraryHandle = _dllLibraryHandle
        ELSE
            TulipGrp.DllLibraryHandle = 0
        End
        ProductName = Upper(Clip(_ProductName))
        If Omitted(_nameDllUtf8) = True
            If instring('.dll',Lower(ProductName),1,1) < 1
                c25DllFilePathUtf8 = Clip(ProductName) & '.dll' & Chr(0)
            Else
                c25DllFilePathUtf8 = Clip(ProductName) & Chr(0)
            End
            If c25DllFilePathUtf8[1] <> '.'
                c25DllFilePathUtf8 = '.\' & Clip(c25DllFilePathUtf8)
            End
            If DebugLevel
                Message('c25DllFilePathUtf8 ' & c25DllFilePathUtf8)
            End
        Else
            c25DllFilePathUtf8 = Clip(_nameDllUtf8) & Chr(0)
        End
        If DebugLevel
            Message('ProductName ' & ProductName)
        End
        If TulipGrp.DllLibraryHandle = 0
            TulipGrp.DllLibraryHandle   = c25_LoadLibraryA(Address(c25DllFilePathUtf8))
        Else
            TulipGrp.DllLibraryHandle = _dllLibraryHandle
        End
        If DebugLevel
            Message('TulipGrp.DllLibraryHandle ' & TulipGrp.DllLibraryHandle)
        End
        If TulipGrp.DllLibraryHandle <> 0 And TulipGrp.DllLibraryHandle <> -1
            If DebugLevel
                Message('c25ProcNameA ' & c25ProcNameA)
            End
            If numeric(c25ProcNameA) = False
                TulipGrp.ProcAddress = c25_GetProcAddress(TulipGrp.DllLibraryHandle, Address(c25ProcNameA))
            ELSE
                TulipGrp.ProcAddress = c25_GetProcAddress(TulipGrp.DllLibraryHandle, c25ProcNameA)
            End
            If TulipGrp.ProcAddress = 0
                TulipGrp.LastErrorcode = c25_GetLastError()
            ELSE
                TulipGrp.LastErrorcode = 0
            End
            If DebugLevel
                Message('TulipGrp.ProcAddress ' & TulipGrp.ProcAddress)
            End
        Else

        End
        Return TulipGrp        