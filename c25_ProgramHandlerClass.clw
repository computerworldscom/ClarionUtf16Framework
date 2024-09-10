    Member

    Include('c25_ProgramHandlerClass.inc'),Once

    Map
        Include('i64.inc'),Once
        Include('cwutil.inc'),Once
        Include('c25_WinApiPrototypes.inc'),Once
        LoadSqlite3Dll()
    End

C25_ProgramHandlerClass.Construct                               Procedure()

Code

    Self.Name                           = 'C25_ProgramHandlerClass'
    Self.RegisterWMs()
    Self.RibbonHeight                   = 79
    Self.RibbonShortCutBarHeight        = 55
    Self.RibbonTabHeadersHeight         = 42
    Self.TabsOffsetY                    = 1
    
    Self.StatusBarHeight                = 40
    
    Self.TabObject                      &= New Tab_TYPE()
    
    Self.DisplayWidth                   = 3840
    Self.DisplayHeight                  = 2160
    Self.Int16MaxValue                  = 32767
    Self.Int16MinValue                  = -32768
    Self.UInt16MaxValue                 = 65535
    Self.UInt16MinValue                 = 0

    Self.Int32MaxValue                  = 2147483647
    Self.Int32MinValue                  = -2147483648
    Self.UInt32MaxValue                 = 4294967295
    Self.UInt32MinValue                 = 0

    Self.Int64MaxValue                  = 9223372036854775807
    Self.Int64MinValue                  = -9223372036854775808
    Self.UInt64MaxValue                 = 18446744073709551615
    Self.UInt64MinValue                 = 0    
    Self.WindowRect                     &= NEW WindowRect_TYPE()
    Self.TabsArrayMax                   = Maximum(Self.TabsWindowHandleArray,1)
    Self.NavigationTree                 &= NEW TreeViewNode_TYPE() !NavigationTree_TYPE()
    Self.GdiplusStartupInput.Version    = 2
    !Self.TreeViewNodes                  &= NEW TreeViewNode_TYPE()
    
    Self.AutoCloseDownTimer             &= NEW c25_NanoSyncClass()
!    Self.AutoCloseDownTimer.SetTimeOut(0,0,5)
    
    c25_GdiplusStartup(Address(Self.GdiplusToken),Address(Self.GdiplusStartupInput),0)    
    Self.CloseButtonState = C25_CLOSEBUTTONSTATES:CBS_NORMAL
    Self.CloseButtonRect &= NEW WindowRect_TYPE()
    
    

    
C25_ProgramHandlerClass.Destruct                                 Procedure()

Code

!    Self.GdiPlusClass.GdiplusShutDown()
!    MEssage('dat wel')
    
!    If Self.IsRootProgramHandler
!        !UnLoadSqlite3Dll()
!        Self.GdiPlusClass.GdiplusShutDown()
!        Dispose(Self.BitConverterClass)
!        Dispose(Self.DataManagerClass)
!        Dispose(Self.DllDataReflectionClass)
!        Dispose(Self.DllLoaderClass)
!        Dispose(Self.GdiPlusClass)
!        Dispose(Self.MessageOnlyWindowClass)
!        Dispose(Self.NanoClockClass)
!        Dispose(Self.ObjectClass)
!        Dispose(Self.QueueCreateClass)
!        Dispose(Self.WinApiClass)
!        Dispose(Self.WindowHandlers)
!        Dispose(Self.WinMesObjectClass)
!    End
    
    
C25_ProgramHandlerClass.CloseDown  Procedure()

CODE
        
    !If Self.IsRootProgramHandler
        !UnLoadSqlite3Dll()
        Self.GdiPlusClass.GdiplusShutDown()
!        Dispose(Self.BitConverterClass)
!        Dispose(Self.DataManagerClass)
!        Dispose(Self.DllDataReflectionClass)
!        Dispose(Self.DllLoaderClass)
!        Dispose(Self.GdiPlusClass)
!        Dispose(Self.MessageOnlyWindowClass)
!        Dispose(Self.NanoClockClass)
!        Dispose(Self.ObjectClass)
!        Dispose(Self.QueueCreateClass)
!        Dispose(Self.WinApiClass)
!        Dispose(Self.WindowHandlers)
!        Dispose(Self.WinMesObjectClass)
!    !End
    
    Return 0


c25_ProgramHandlerClass.UpdateRenderEngineClassDraw       Procedure()

CODE
        
    Self.RenderEngineClassDrawCount = Self.RenderEngineClassDrawCount + 1
    Return 0
        
c25_ProgramHandlerClass.LoadTabs       Procedure()


CODE 
    
    Clear(Self.TabObject)
    Self.TabObject.Id                    = 1
    Self.TabObject.TitleMeasuredWidth    = 100
    Self.TabObject.TitleCropped          = False
    Self.TabObject.Ordinal               = 0
    Self.TabObject.ZOrder                = 0
    Self.TabObject.IsActive              = True
    Self.TabObject.Title                 &= Self.BitConverterClass.BinaryCopy('Home')
    Add(Self.TabObject)
    
    Clear(Self.TabObject)
    Self.TabObject.Id                    = 2
    Self.TabObject.TitleMeasuredWidth    = 100
    Self.TabObject.TitleCropped          = False
    Self.TabObject.Ordinal               = 0
    Self.TabObject.ZOrder                = 0
    Self.TabObject.IsActive              = 0
    Self.TabObject.Title                 &= Self.BitConverterClass.BinaryCopy('Home')
    Add(Self.TabObject)

    Return 0

    
    
c25_ProgramHandlerClass.UpdateWindowRect    Procedure()

    CODE

    Self.WindowRect = Self.WinApiClass.GetWindowRect(Self.WindowHandle)
        Return Self.WindowRect
        
        
        
        
c25_ProgramHandlerClass.RootInit    Procedure(<BOOL EXE_DLL_MODE>, <BOOL EXE_COMPILED_DEBUG>)

I                                       Long

CODE

    
    Self.RootLog &= NEW c25_NanoSyncClass()
    Self.RootLog.InitLog('m:\rootlog.txt', true)
    Self.RootLog.WriteLog('FIRSTWRITELINE')
    
    !Message('start')
    
    !Self.!
    
    Self.EXE_DLL_MODE = EXE_DLL_MODE
    Self.EXE_COMPILED_DEBUG = EXE_COMPILED_DEBUG
    
    !Message('Self.EXE_DLL_MODE ' & Self.EXE_DLL_MODE)
    !Message('Self.EXE_COMPILED_DEBUG ' & Self.EXE_COMPILED_DEBUG)
    
    !------------- GLOBAL SETTINGS
    Self.ExtendedQueueFunctions             = True
    !-----------------------------

    Self.Singleton &= NEW c25_SingletonClass()
    !Message(0)
    Self.Singleton.Init('ProgramHandler',Address(Self))
    
    Self.RootLog.WriteLog('Self.Singleton.Init')
    
    Self.GlobalDataClass                    &= NEW c25_GlobalDataClass()
    Self.RootLog.WriteLog('&= NEW c25_GlobalDataClass()')
    
    Self.IsRootProgramHandler               = True
    Self.RootInitSuccess                    = True

    !Message(3)
    
    Self.GdiPlusClass                       &= NEW c25_GdiPlusClass()
    Self.RootLog.WriteLog('&= NEW GdiPlusClass()')
    Self.GdiPlusClass.GdiplusStartUp()
    Self.RootLog.WriteLog('Self.GdiPlusClass.GdiplusStartUp()')
    Self.DictSpecialFolders                 &= NEW c25_DictionaryClass()
    Self.RootLog.WriteLog('&= NEW c25_DictionaryClass()')
    
    
    Self.BitConverterClass                  &= NEW c25_BitConverterClass()
    Self.RootLog.WriteLog('&= NEW c25_BitConverterClass()')
    
    Self.NanoClockClass                     &= NEW C25_NanoSyncClass()
    Self.RootLog.WriteLog('&= NEW C25_NanoSyncClass()')
    
    Self.ObjectClass                        &= NEW c25_ObjectClass()
    Self.RootLog.WriteLog('&= NEW c25_ObjectClass()')
    
    Self.WinApiClass                        &= NEW c25_WinApiClass()
    Self.RootLog.WriteLog('&= NEW c25_WinApiClass()')
    
    Self.WinMesObjectClass                  &= NEW c25_WinMesObjectClass()
    Self.RootLog.WriteLog('&= NEW WinMesObjectClass()')
    
    
!    Self.GdiPlusClass                       &= NEW c25_GdiPlusClass()
!    Self.GdiPlusClass.GdiplusStartUp()

    Self.DllLoaderClass                     &= NEW C25_DllLoaderClass()
    Self.RootLog.WriteLog('&= NEW C25_DllLoaderClass()')
    
    
    
    Self.DllDataReflectionClass             &= NEW c25_DataReflectionClass()
    Self.RootLog.WriteLog('&= NEW c25_DataReflectionClass()')
    
    Self.DataReflectionClass                &= NEW c25_DataReflectionClass()
    Self.RootLog.WriteLog('&= NEW c25_DataReflectionClass()')

    Self.WindowHandlers                     &= NEW WindowHandlers_TYPE()

    Self.QueueCreateClass                   &= NEW C25_QueueCreateClass()
    Self.RootLog.WriteLog('&= NEW C25_QueueCreateClass()')
    

    Self.DataManagerClass                   &= NEW c25_DataManagerClass()
    Self.RootLog.WriteLog('&= NEW c25_DataManagerClass()')
    

    Self.KnownFolders &= NEW KeyValue_TYPE()

    Self.EnumSpecialPaths()    
    Self.RootLog.WriteLog('Self.EnumSpecialPaths()')
    

    Self.HardwareClass                      &= NEW c25_HardwareClass()
    Self.RootLog.WriteLog('&= NEW c25_HardwareClass()')

!    Self.AWEClass                           &= NEW c25_AWEClass()
!    Self.QueueCreateClass.Init()
!    Self.DllDataReflectionClass.AnalyzeDll(Self.QueueCreateClass.DLLAddress, Self.QueueCreateClass.DLLSize,,False)

    
    Self.BitConverterClass.St1.Start()
    Self.BitConverterClass.St1.LoadFile('m:\harddisktools\Goodmorning.txt')
    
    Self.BitConverterClass.St1.Split( Chr(13) & Chr(10) )
    R# = Records(Self.BitConverterClass.St1.lines)
    I# = 0
    Loop R# Times
        I# = I# + 1
        Get(Self.BitConverterClass.St1.Lines, I#)
        If Errorcode() <> 0
            BREAK
        End
        Clear(Self.NavigationTree)
    
        Self.NavigationTree.Id = I#
        Self.NavigationTree.NodeLevel = Random(0,5)
        Self.NavigationTree.Name &= Self.BitConverterClass.AnsiToUtf16('NODE' & I#)
        Self.NavigationTree.LineText &= Self.BitConverterClass.Utf8ToUtf16(Self.BitConverterClass.St1.Lines.Line,,true)
        Add(Self.NavigationTree)
    End
    Self.RootLog.WriteLog('Add(Self.NavigationTree)')

    Self.TabBackdropColorDimmed             = Self.GdiPlusClass.GetColorMacro(255,232,232,232)
    Self.TabBackdropColorActive             = Self.GdiPlusClass.GetColorMacro(255,207,221,233)
    
    Self.TabHeaderColorDimmed               = Self.GdiPlusClass.GetColorMacro(255,248,248,248)
    Self.TabHeaderColorActive               = Self.GdiPlusClass.GetColorMacro(255,241,245,248)    
    
    Self.ThemeManagerClass                  &= NEW c25_ThemeManagerClass()
    Self.RootLog.WriteLog('&= NEW c25_ThemeManagerClass()')
    Self.LoadTabs()    
    Self.RootLog.WriteLog('Self.LoadTabs()')
    

    Self.SetupClass                         &= NEW c25_SetupClass()
    Self.RootLog.WriteLog('&= NEW c25_SetupClass()')
    
    Self.SetupClass.Start()
    Self.RootLog.WriteLog('Self.SetupClass.Start()')

    LoadSqlite3Dll()

    Self.RootLog.WriteLog('LoadSqlite3Dll()')
    
    
!    Self.HardwareClass.Init()
!    Self.RootLog.WriteLog('Self.HardwareClass.Init()')
!    Self.HardwareClass.EnumerateWinObj()
!    Self.RootLog.WriteLog('Self.HardwareClass.EnumerateWinObj()')
!    Self.HardwareClass.EnumerateBios()
!    Self.RootLog.WriteLog('Self.HardwareClass.EnumerateBios()')
!    Self.HardwareClass.EnumerateDevices()
!    Self.RootLog.WriteLog('Self.HardwareClass.EnumerateDevices()')
    
    
    Self.SQLiteAsyncConnections &= NEW SQLiteAsyncConnection_TYPE()
    Self.PopulateSQLiteAsyncConnections()
    Self.RootLog.WriteLog('Self.PopulateSQLiteAsyncConnections()')
    
    Self.PopulateNavigationTree()
    
    Self.RootLog.WriteLog('Self.PopulateNavigationTree()')
    
    
    
   
    
    Self.RenderEngineClass                  &= NEW c25_RenderEngineClass()   
    Self.RootLog.WriteLog('&= NEW c25_RenderEngineClass()')
    
    
    !Self.RenderEngineClass.CreateTabs()
    !Message('end renderclass')
!    If Self.Ready = TRUE
!        Message('dat kan niet')
!    END
    
    
    
    Self.MessageOnlyWindowClass             &= NEW c25_MessageOnlyWindowClass()
    Self.RootLog.WriteLog('&= NEW c25_MessageOnlyWindowClass()')
    Self.MessageOnlyWindowClass.InitWindow(c25ClassTypes:ProgramHandlerClassType , Address(Self))
    Self.RootLog.WriteLog('Self.MessageOnlyWindowClass.InitWindow')
    Self.MessageOnlyWindowClass.OpenWindow()    
    Self.RootLog.WriteLog('Self.MessageOnlyWindowClass.OpenWindow()')
    
    Self.RenderEngineClass.Init()
    Self.RootLog.WriteLog('Self.RenderEngineClass.Init()')
    Self.RenderEngineClass.CreateTabs() 
    Self.RootLog.WriteLog('Self.RenderEngineClass.CreateTabs()')
    
    
    
    !Self.RootLog.WriteLog('Self.MessageOnlyWindowClass.OpenWindow()')
    
    Self.RootLog.WriteLog('END - RootInit()')
    Return 0    
    
    
C25_ProgramHandlerClass.PopulateNavigationTree                                          Procedure()

SqliteClass &c25_SqliteClass

CODE

!!    Self.stLog.SetValue('c25_TabRenderEngineClass.CreateSqliteDatabases' & '<13><10>')
!!    Self.stLog.SaveFile(Self.stLogFileName, true)
!!    
!    
    If Self.SQLiteAsyncConnections &= NULL
        Message('ERROR Self.SQLiteAsyncConnections is null error')
    End
    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.SQLiteAsyncConnections,I#)
        If Errorcode() <> 0
            BREAK
        End

        !Message('daar gaan we op ' & I#)
        If Self.SQLiteAsyncConnections.SqliteClass &= NULL
            Self.SQLiteAsyncConnections.SqliteClass &= NEW C25_SqliteClass()
            Self.SQLiteAsyncConnections.SqliteClassPtr = Address(Self.SQLiteAsyncConnections.SqliteClass)
            If Self.SQLiteAsyncConnections.ToCreate And Self.SQLiteAsyncConnections.Creating = 0 And Self.SQLiteAsyncConnections.Created = 0
                Self.SQLiteAsyncConnections.Creating = True
                If Self.SQLiteAsyncConnections.RemoveWhenExisting
                    
                    !mESSAGE(Self.SQLiteAsyncConnections.FullPathAndFilenameUtf8)
                    
                    Self.WinApiClass.RemoveFileUtf16(Self.SQLiteAsyncConnections.FullPathAndFilenameUtf16)
                End
                
                !Message('Self.SQLiteAsyncConnections.ConnectionString ' & Self.SQLiteAsyncConnections.ConnectionString)

                Self.SQLiteAsyncConnections.ConnHandle = Self.SQLiteAsyncConnections.SqliteClass.Connect(Self.SQLiteAsyncConnections.ConnectionString,,false)
                If Self.SQLiteAsyncConnections.ConnHandle <> 0
                    Self.SQLiteAsyncConnections.Creating = 0
                    Self.SQLiteAsyncConnections.Created = True

                    I# = 0
                    Loop
                        I# = I# + 1
                        Get(Self.SQLiteAsyncConnections.SqliteTables,I#)
                        If Errorcode() <> 0
                            BREAK
                        End
                        
                        !Message(Self.SQLiteAsyncConnections.SqliteTables.CreateStatement)
                        
                        Self.SQLiteAsyncConnections.SqliteClass.Exec(, Self.SQLiteAsyncConnections.SqliteTables.CreateStatement)
                    End
                End
            End
        End

        Put(Self.SQLiteAsyncConnections)
        Self.CanUseSqliteForRendering = True
    End
    !Message('breakie')
    

    Return 0
    
    
    
    
!                        If NOT Self.SQLiteAsyncConnections.SqliteTables.SqliteClass_NavigationTree &= NULL
!
!                            SqliteClass &= Self.SQLiteAsyncConnections.SqliteTables.SqliteClass_NavigationTree.SqliteClass
!                            SqliteClass.ConnHandle = Self.SQLiteAsyncConnections.SqliteClass.ConnHandle
!                            SqliteClass.Turbo = True
!                            SqliteClass.AutoIncrementId = True
!
!                            Self.NavigationTree &= Self.SQLiteAsyncConnections.SqliteTables.SqliteClass_NavigationTree.NavigationTree
!                            Include('AddDefaultNavigationTree.clw')
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:Home
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Home')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:TopPanel
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Home')
!                            Self.NavigationTree.Flags           = NavigationTreeFlags:QuickAccess
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:Gallery
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Gallery')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:TopPanel
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Gallery')
!                            Self.NavigationTree.Flags           = NavigationTreeFlags:QuickAccess
!                            Add(Self.NavigationTree)
!                            
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:Cloud
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Cloud')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:TopPanel
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Cloud')
!                            Self.NavigationTree.Flags           = NavigationTreeFlags:QuickAccess
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderDesktop
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Desktop')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Desktop')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderDownloads
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Downloads')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Downloads')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderDocuments
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Documents')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Documents')
!                            Add(Self.NavigationTree)
!                            
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderPictures
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Pictures')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Pictures')
!                            Add(Self.NavigationTree)                            
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderMusic
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Music')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Music')
!                            Add(Self.NavigationTree)         
!                            
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderVideos
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('Videos')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('Videos')
!                            Add(Self.NavigationTree)         
!
!                            
!                            
!                            
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:ThisPC
!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('This PC')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('This PC')
!                            Add(Self.NavigationTree)
!
!
!                            If not Self.HardwareClass &= null
!                                If not Self.HardwareClass.Devices &= null
!                                    !Message('recs ' & Records(Self.HardwareClass.Devices))
!                                    H# = 0
!                                    LOOP
!                                        H# = H# + 1
!                                        Get(Self.HardwareClass.Devices,H#)
!                                        If Errorcode() <> 0
!                                            BREAK
!                                        End
!                                        If Self.HardwareClass.Devices.FriendlyNameUtf16 &= NULL
!                                            CYCLE
!                                        End
!                                        Self.NavigationTree.ParentId        = 0
!                                        Self.NavigationTree.Level           = 2
!                                        Self.NavigationTree.IconNumber      = IconLibrary:ThisPC
!                                        Self.NavigationTree.Line           &= Self.BitConverterClass.BinaryCopy(Self.HardwareClass.Devices.FriendlyNameUtf16)
!                                        Self.NavigationTree.TagId           = Self.HardwareClass.Devices.Id
!                                        Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                                        Self.NavigationTree.Name           &= Self.BitConverterClass.AnsiToUtf16('This PC')
!                                        Add(Self.NavigationTree)
!                                    End
!                                End
!                            End
!                            
!                           ! Self.NavigationTree.Fixed = True
!                            
!                            
!                            
!                            
!!                            Self.NavigationTree.ParentId        = 0
!!                            Self.NavigationTree.Level           = 1
!!                            Self.NavigationTree.IconNumber      = IconLibrary:ThisPC
!!                            Self.NavigationTree.Line           &= Self.BitConverterClass.AnsiToUtf16('This PC')
!!                            Self.NavigationTree.TagId           = 0
!!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!!                            Self.NavigationTree.Name           &= Self.BitConverterClass.BinaryCopy('This PC')
!!                            Add(Self.NavigationTree)  
!                            
!                            
!                            
!                            
!                            
!                            Self.NanoClockClass.StartStopwatch()
!
!                            Loop 1 Times
!
!                                SqliteClass.In_InitTurbo(Self.NavigationTree, 'NavigationTree')
!
!                                SqliteClass.SetClarionFieldProperty(SqliteClass.In_ClarionFields, 'Line', 'encoding', 'utf16')
!                                SqliteClass.InsertAllAsync(true,true)
!
!                            End
!                            
!                            
!                       
!                            
!
!                            SqliteClass &= null
!                        End
!                    End

    
    
    
    
    
    
    
    
    
    
    
C25_ProgramHandlerClass.EnumSpecialPaths        Procedure()


CODE
        
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AccountPictures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AddNewPrograms); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AdminTools); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppMods); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppCaptures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppDataDesktop); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppDataDocuments); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppDataFavorites); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppDataProgramData); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ApplicationShortcuts); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppsFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_AppUpdates); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CameraRollLibrary); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CdBurning); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ChangeRemovePrograms); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CommonAdminTools); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CommonOemLinks); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CommonPrograms); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CommonStartMenu); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CommonStartMenuPlaces); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CommonStartup); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CommonTemplates); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ComputerFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ConflictFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ConnectionsFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Contacts); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ControlPanelFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Cookies); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_CurrentAppMods); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Desktop); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_DevelopmentFiles); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Device); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_DeviceMetaDatastore); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Documents); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_DocumentsLibrary); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Downloads); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Favorites); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Fonts); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Games); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_GameTasks); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_History); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_HomeGroup); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_HomeGroupCurrentUser); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ImplicitAppShortcuts); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_InternetCache); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_InternetFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Libraries); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Links); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalAppData); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalAppDataLow); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalDocuments); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalDownloads); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalizedResourcesDir); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalMusic); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalPictures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_LocalVideos); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Music); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_MusicLibrary); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Nethood); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_NetworkFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Objects3D); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_OneDrive); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_OriginalImages); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PhotoAlbums); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Pictures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PicturesLibrary); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PlayLists); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PrintersFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Printhood); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Profile); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ProgramData); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ProgramFiles); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ProgramFilesCommon); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ProgramFilesCommonX64); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ProgramFilesCommonX86); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ProgramFilesX64); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ProgramFilesX86); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Programs); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Public); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicDesktop); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicDocuments); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicDownloads); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicGametasks); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicLibraries); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicMusic); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicPictures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicRingtones); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicUserTiles); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_PublicVideos); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_QuickLaunch); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Recent); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_RecordedCalls); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_RecordedTvLibrary); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_RecycleBinFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ResourceDir); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_RetailDemo); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Ringtones); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_RoamedTileImages); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_RoamingAppData); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_RoamingTiles); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SampleMusic); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SamplePictures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SamplePlaylists); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SampleVideos); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SavedGames); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SavedPictures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SavedPicturesLibrary); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SavedSearches); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_ScreenShots); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Search_Csc); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Search_Mapi); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SearchHistory); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SearchHome); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SearchTemplates); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SendTo); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SidebarDefaultParts); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SidebarParts); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SkyDrive); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SkyDriveCameraRoll); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SkyDriveDocuments); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SkyDriveMusic); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SkyDrivePictures); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_StartMenu); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_StartMenuAllPrograms); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Startup); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SyncManagerFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SyncResultsFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SyncSetupFolder); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_System); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_SystemX86); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Templates); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_UserPinned); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_UserProfiles); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_UserProgramFiles); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_UserProgramFilesCommon); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_UsersFiles); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_UsersLibraries); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Videos); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_VideosLibrary); Add(Self.KnownFolders)
    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Windows); Add(Self.KnownFolders)

    Self.KnownFolders.Key &= Self.BitConverterClass.BinaryCopy(KnownFolderId_Windows); Add(Self.KnownFolders)
    
    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.KnownFolders,I#)
        If Errorcode() <> 0
            BREAK
        END
        Self.KnownFolders.Value &= Self.WinApiClass.GetKnownPathById(Self.KnownFolders.Key,,false)
        Put(Self.KnownFolders)
    End
    Self.SetDefaultFolders()
    Return ''


C25_ProgramHandlerClass.SetDefaultFolders      Procedure()

DriveLetter string(1)

Code
    
    !Message(1000)
    Self.ApplicationNameUtf8 &= Self.BitConverterClass.BinaryCopy('HarddiskTools')
    !Message(1001)
    If Self.KnownFolders &= NULL
        Message('error Self.KnownFolders is null')
    End
    Self.DictSpecialFolders.ParseKeyValue(Self.KnownFolders)
    !Message(1002)
    DriveLetter = Self.DictSpecialFolders.TryGetValue(KnownFolderId_Desktop)
    !Message(1003)
    
    Self.ApplicationDriveAnsi                       &= Self.BitConverterClass.BinaryCopy(DriveLetter)
    Self.ApplicationDriveUtf16                      &= Self.BitConverterClass.AnsiToUtf16(Self.ApplicationDriveAnsi)
    Self.ApplicationDriveUtf8                       &= Self.BitConverterClass.AnsiToUtf8(Self.ApplicationDriveAnsi)
    
    Self.ApplicationFolderNameAnsi                  &= Self.BitConverterClass.BinaryCopy(Self.ApplicationNameUtf8)
    Self.ApplicationFolderNameUtf16                 &= Self.BitConverterClass.AnsiToUtf16(Self.ApplicationFolderNameAnsi)
    Self.ApplicationFolderNameUtf8                  &= Self.BitConverterClass.AnsiToUtf8(Self.ApplicationFolderNameAnsi)
    
    Self.ApplicationPathAnsi                        &= Self.BitConverterClass.ConcatAnsi(True, '\',Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramFilesX86,true),Self.ApplicationFolderNameAnsi)
    Self.ApplicationPathUtf16                       &= Self.BitConverterClass.ConcatUtf16(True, '\' & Chr(0), Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramFilesX86) ,Self.ApplicationFolderNameUtf16)
    Self.ApplicationPathUtf8                        &= Self.BitConverterClass.AnsiToUtf8(Self.ApplicationPathAnsi)
    
    Self.ApplicationFileNameAnsi                    &= Self.BitConverterClass.BinaryCopy(Self.ApplicationNameUtf8 & '.exe')
    Self.ApplicationFileNameUtf16                   &= Self.BitConverterClass.AnsiToUtf16(Self.ApplicationFileNameAnsi)
    Self.ApplicationFileNameUtf8                    &= Self.BitConverterClass.AnsiToUtf8(Self.ApplicationFileNameAnsi)
    
    
    Self.ApplicationFileNameAndPathAnsi             &= Self.BitConverterClass.ConcatAnsi(True, '\',Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramFilesX86,true),Self.ApplicationFolderNameAnsi,  Self.ApplicationFileNameAnsi)
    Self.ApplicationFileNameAndPathUtf16            &= Self.BitConverterClass.ConcatUtf16(True, '\' & Chr(0), Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramFilesX86) ,Self.ApplicationFolderNameUtf16, Self.ApplicationFileNameUtf16)
    Self.ApplicationFileNameAndPathUtf8             &= Self.BitConverterClass.AnsiToUtf8(Self.ApplicationPathAnsi)    
    
    
    !Message(1001)
    DriveLetter = Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramData)
    
    Self.DataStoreDriveAnsi                         &= Self.BitConverterClass.BinaryCopy(DriveLetter)
    Self.DataStoreDriveUtf16                        &= Self.BitConverterClass.AnsiToUtf16(Self.DataStoreDriveAnsi)
    Self.DataStoreDriveUtf8                         &= Self.BitConverterClass.AnsiToUtf8(Self.DataStoreDriveAnsi)

    Self.ProgramDataAnsi                            &= Self.BitConverterClass.BinaryCopy(Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramData, true))
    Self.ProgramDataUtf16                           &= Self.BitConverterClass.BinaryCopy(Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramData))
    Self.ProgramDataUtf8                            &= Self.BitConverterClass.Utf16ToUtf8(Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramData, true))
    
    Self.ProgramDataFolderNameAnsi                  &= Self.BitConverterClass.BinaryCopy(Self.ApplicationNameUtf8)
    Self.ProgramDataFolderNameUtf16                 &= Self.BitConverterClass.AnsiToUtf16(Self.ProgramDataFolderNameAnsi)
    Self.ProgramDataFolderNameUtf8                  &= Self.BitConverterClass.AnsiToUtf8(Self.ProgramDataFolderNameAnsi)
        
    Self.ProgramDataPathAnsi                        &= Self.BitConverterClass.ConcatAnsi(True, '\',Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramData,true),Self.ProgramDataFolderNameAnsi)
    Self.ProgramDataPathUtf16                       &= Self.BitConverterClass.ConcatUtf16(True, '\' & Chr(0),Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramData),Self.ProgramDataFolderNameUtf16)
    Self.ProgramDataPathUtf8                        &= Self.BitConverterClass.ConcatAnsi(True, '\',Self.DictSpecialFolders.TryGetValue(KnownFolderId_ProgramData,true),Self.ProgramDataFolderNameUtf8)
    
    Self.AppDataAnsi                                &= Self.BitConverterClass.ConcatAnsi(True, '\',Self.DictSpecialFolders.TryGetValue(KnownFolderId_RoamingAppData,true),Self.ApplicationFolderNameAnsi)
    Self.AppDataUtf16                               &= Self.BitConverterClass.ConcatUtf16(True, '\' & Chr(0),Self.DictSpecialFolders.TryGetValue(KnownFolderId_RoamingAppData),Self.ApplicationFolderNameUtf16)
    Self.AppDataUtf8                                &= Self.BitConverterClass.ConcatAnsi(True, '\',Self.DictSpecialFolders.TryGetValue(KnownFolderId_RoamingAppData,true),Self.ApplicationFolderNameAnsi)
    
    Self.WinApiClass.FindOrCreateFolderUtf16(Self.ApplicationPathUtf16)
    Self.WinApiClass.FindOrCreateFolderUtf16(Self.AppDataUtf16)
    Self.WinApiClass.FindOrCreateFolderUtf16(Self.ProgramDataPathUtf16)

    Return ''
    
C25_ProgramHandlerClass.PopulateSQLiteAsyncConnections      Procedure()

CODE

    Clear(Self.SQLiteAsyncConnections)
    Self.SQLiteAsyncConnections.Id                 = 1                               
    Self.SQLiteAsyncConnections.Pragmas            &= NEW KeyValue_TYPE()
    Self.SQLiteAsyncConnections.InMemory            = False
    Self.SQLiteAsyncConnections.OnDisk              = True
    
    Self.SQLiteAsyncConnections.RootPathUtf8       &= Self.BitConverterClass.BinaryCopy(Self.AppDataUtf8)
    Self.SQLiteAsyncConnections.RootPathUtf16      &= Self.BitConverterClass.BinaryCopy(Self.AppDataUtf16)    
    
    Self.AppSqliteFileNameUtf8                      &= Self.BitConverterClass.AnsiToUtf8(Self.ApplicationNameUtf8 & '.sqlite')
    Self.AppSqliteFileNameUtf16                      &= Self.BitConverterClass.AnsiToUtf16(Self.ApplicationNameUtf8 & '.sqlite')
    
    
    Self.SQLiteAsyncConnections.FileNameUtf8       &= Self.BitConverterClass.BinaryCopy(Self.AppSqliteFileNameUtf8)
    Self.SQLiteAsyncConnections.FileNameUtf16      &= Self.BitConverterClass.BinaryCopy(Self.AppSqliteFileNameUtf16)    
        
    
    Self.AppSqliteFullPathUtf8 &= Self.BitConverterClass.ConcatUtf8(True, , Self.SQLiteAsyncConnections.RootPathUtf8, '\', Self.AppSqliteFileNameUtf8, Chr(0) & Chr(0))
    Self.SQLiteAsyncConnections.FullPathAndFilenameUtf8 &= Self.BitConverterClass.BinaryCopy(Self.AppSqliteFullPathUtf8)
    
    Self.AppSqliteFullPathUtf16 &= Self.BitConverterClass.ConcatUtf16(True, , Self.SQLiteAsyncConnections.RootPathUtf16, '\' & Chr(0) , Self.AppSqliteFileNameUtf16, Chr(0) & Chr(0))
    Self.SQLiteAsyncConnections.FullPathAndFilenameUtf16 &= Self.BitConverterClass.BinaryCopy(Self.AppSqliteFullPathUtf16)
    
   
    Self.SQLiteAsyncConnections.ConnectionString &= Self.BitConverterClass.BinaryCopy(Self.SQLiteAsyncConnections.FullPathAndFilenameUtf8 & Chr(0) )
    
    Self.SQLiteAsyncConnections.RemoveWhenExisting  = True
    Self.SQLiteAsyncConnections.ToCreate            = True
    Self.SQLiteAsyncConnections.Creating            = 0
    Self.SQLiteAsyncConnections.Created             = 0
    Self.SQLiteAsyncConnections.Alias               = ''
    Self.SQLiteAsyncConnections.IsMain              = True
    Self.SQLiteAsyncConnections.SqliteTables &= NEW SqliteTable_TYPE()
    Add(Self.SQLiteAsyncConnections)
    
    
!    Include('Populate_SqliteTables_NavigationTree.clw')
!    Include('Populate_SqliteTables_NavTree_DbHooks.clw')
    
    Return 0


c25_ProgramHandlerClass.RegisterWM                              Procedure(string _messageName)

RegMesStringA   String(250)

	Code

		RegMesStringA = Clip(_messageName) & Chr(0)
        Return c25_RegisterWindowMessageA(Address(RegMesStringA))

C25_ProgramHandlerClass.RegisterWMs                              Procedure()

Code

    INCLUDE('RegisterWMs.clw')
    Return 0

c25_ProgramHandlerClass.SetC25WinMes_ReturnInt32      Procedure(long _valueInt32)

CODE

    Self.WinMesObjectClass.C25WinMes.ReturnInt32 = _valueInt32
    Self.WinMesObjectClass.SetC25WinMes()


c25_ProgramHandlerClass.SetC25WinMes_ReturnBufferPtr      Procedure(long _bufferPtr, long _bufferSizeLo, <long _bufferSizeHi>)

CODE

    Self.WinMesObjectClass.C25WinMes.ReturnBufferPtr = _bufferPtr
    Self.WinMesObjectClass.C25WinMes.ReturnBufferSizeHi = _bufferSizeHi
    Self.WinMesObjectClass.C25WinMes.ReturnBufferSizeLo = _bufferSizeLo
    Self.WinMesObjectClass.SetC25WinMes()

c25_ProgramHandlerClass.SetC25WinMes_ReturnString16K      Procedure(string _message)

CODE

    Self.WinMesObjectClass.C25WinMes.ReturnString16K = _message
    Self.WinMesObjectClass.C25WinMes.ReturnString16KLength = Len(Clip(Self.WinMesObjectClass.C25WinMes.ReturnString16K))
    Self.WinMesObjectClass.SetC25WinMes()

c25_ProgramHandlerClass.GetCWM_C25WinMesName     Procedure(long _c25MessageId)

CODE

    Case _c25MessageId
    Of C25MessageId:GetProccessId
        Return 'GetProccessId'
    Of C25MessageId:GetProccessHandle
        Return 'GetProccessHandle'
    End
    Return ''

c25_ProgramHandlerClass.ProcessC25WinMes    Procedure()

Tuple4              Group
v1                      LONG
v2                      ULONG
v3                      LONG
v4                      LONG
                    End
Buffer16K           string(17000)
DataTableId         Long
DataTableHandle     Long
Tuple2                                                                      Group
V1                                                                              LONG
V2                                                                              LONG
                                                                            End



    CODE

    Case Self.WinMesObjectClass.C25WinMes.C25MessageId
    Of C25MessageId:GetProccessId
       Self.SetC25WinMes_ReturnInt32(c25_GetProcessId(c25_GetCurrentProcess()))
    Of C25MessageId:GetProccessHandle
        Self.SetC25WinMes_ReturnInt32(Self.WinApiClass.GetProcessHandle())
    Of C25MessageId:GetProcessHeap
        Self.SetC25WinMes_ReturnInt32(c25_GetProcessHeap())
    Of C25MessageId:LoadQDllIntoMemory
        Self.SetC25WinMes_ReturnString16K('OK')
    Of C25MessageId:CopyQDllBytesToBuffer
        Tuple4 =  Self.QueueCreateClass.CopyDllBytesToBuffer()
        Self.SetC25WinMes_ReturnBufferPtr(Tuple4.v1,Tuple4.v3,Tuple4.v2)
        Self.SetC25WinMes_ReturnInt32(Self.QueueCreateClass.ModuleInfo.BaseOfDll)
    Of C25MessageId:CreateQueue
        If Self.WinMesObjectClass.C25WinMes.DataTableId = 0 And Len(Clip(Self.WinMesObjectClass.C25WinMes.DataTableName)) = 0
            Self.BitConverterClass.GetValueByPtr(Self.WinMesObjectClass.C25WinMes.ReturnBufferPtr, Self.WinMesObjectClass.C25WinMes.ReturnBufferSizeLo, Self.BitConverterClass.St3)
            DataTableId = Self.DataManagerClass.CreateDataTableInstance()
            Self.DataManagerClass.CreateQueue(DataTableId, , Self.BitConverterClass.St3.GetValue())
        End
    Of C25MessageId:AnalyzeDll
        Self.DllDataReflectionClass.AnalyzeDll(Self.QueueCreateClass.DLLAddress, Self.QueueCreateClass.DLLSize,,False)
        Self.SetC25WinMes_ReturnString16K('OK')
    Of C25MessageId:GetQBytesDll
        Self.DllDataReflectionClass.GetQBytesDll(Tuple2.V1,Tuple2.V2)
        Self.SetC25WinMes_ReturnBufferPtr(Tuple2.V1,Tuple2.V2)
    Of C25MessageId:GetQDLLSections
        Self.DllDataReflectionClass.GetQDLLSections(Tuple2.V1,Tuple2.V2)
        Self.SetC25WinMes_ReturnBufferPtr(Tuple2.V1,Tuple2.V2)
    Of C25MessageId:FindPosMagicField
        If Self.QueueCreateClass.FieldMagic7Pos = 0
            Self.QueueCreateClass.FieldMagic7Pos = Self.ObjectClass.FindInByteArray('FIELDMAGIC7',Self.QueueCreateClass.DLLAddress, Self.QueueCreateClass.DLLSize)
        End
        Self.SetC25WinMes_ReturnInt32(Self.QueueCreateClass.FieldMagic7Pos)
    Of C25MessageId:GetPtrQDllMagicFieldSection
        Get(Self.DllDataReflectionClass.QDLLSections, 2)
        Self.SetC25WinMes_ReturnBufferPtr(Self.QueueCreateClass.DLLAddress + Self.DllDataReflectionClass.QDLLSections.VirtualAddress, Self.DllDataReflectionClass.QDLLSections.VirtualSize)
    Of C25MessageId:WriteQDllMagicFieldSection

    End



c25_ProgramHandlerClass.WndProc_Process  Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, long ReturnVal, <*bool processNormal>)

ValInt      Long
SomeQ       &QUEUE

	CODE

        
        
        
        Case _message
        Of C25_Wm_Timer
            If Self.AutoCloseDownTimer.IsTimeOut()
                Message('timeout')
                C25_PostMessageA(Self.WindowHandle, C25_Wm_Close,0,0)
            End
            !Self.AutoCloseDownTimer                                                          &c25_NanoSyncClass
!        Of Self.CWM_GetPHPtr
!            Message('got CWM_GetPHPtr')
!            processNormal = FALSE
!            Clear(Self.ReturnVal)
        
        of Self.CWM_C25WinMes
            processNormal = FALSE
            Clear(Self.ReturnVal)

            Self.WinMesObjectClass.GetC25WinMes(_lParam)
            Self.SetC25WinMes_ReturnString16K(Self.GetCWM_C25WinMesName(Self.WinMesObjectClass.C25WinMes.C25MessageId))

            If Self.WinMesObjectClass.C25WinMes.WinHandle <> _windowHandle And Self.WinMesObjectClass.C25WinMes.WinHandle <> 0
                If Self.WinMesObjectClass.C25WinMes.Timeout = 0
                    Self.WinMesObjectClass.C25WinMes.Timeout = 30000
                End
                c25_SendMessageTimeoutA(Self.WinMesObjectClass.C25WinMes.WinHandle, _message, _wParam, _lParam, c25_SMTO_ABORTIFHUNG, Self.WinMesObjectClass.C25WinMes.Timeout, Address(Self.ReturnVal))
            Else
                Self.ProcessC25WinMes()
            End
		End





C25_ProgramHandlerClass.SetCurrentWindowByName      Procedure(string _name)

WinHandle    long

Code

    WinHandle = Self.GetWindow(_name)
    Return WinHandle


C25_ProgramHandlerClass.PostMessageA                             Procedure(string _windowName, ULong _message, ULong _wParam, Long _lParam)


Code


    Return 0

C25_ProgramHandlerClass.PostMessageA                             Procedure(string _windowName, string _tabName, ULong _message, ULong _wParam, Long _lParam)


Code


    Return 0

C25_ProgramHandlerClass.SendMessageTimeoutA                           Procedure(string _windowName, string _tabName, ULong _message, ULong _wParam, Long _lParam, <string _retWhenFailed>)


Code

    Return 0







C25_ProgramHandlerClass.CreateMainAppWindow Procedure(<bool _hideParentWindow>)

    CODE

        Self.WindowHandle           = 0{Prop:Handle}
        Self.WindowClientHandle     = 0{Prop:ClientHandle}
        Self.WNDProc                = 0{PROP:WNDProc}
        Self.ClientWNDProc          = 0{PROP:ClientWNDProc}

        If Omitted(_hideParentWindow) = False
            0{Prop:Hide} = _hideParentWindow
        End
        Self.CreateNewWindow('Main', True)
!        Self.CurrentWindowHandler.StartXPos     = 100
!        Self.CurrentWindowHandler.StartYPos     = 100
!        Self.CurrentWindowHandler.StartWidth    = 1100
!        Self.CurrentWindowHandler.StartHeight   = 800
        Self.OpenNewWindow(False)
        Return 0






C25_ProgramHandlerClass.CreateNewWindow                      Procedure(String _name, <bool _wait>, <bool _hideParentWindow>, <string _functionName>)

!WindowHandler &c25_WindowHandlerClass

Code

!    If Omitted(_hideParentWindow) = False
!        0{Prop:Hide} = _hideParentWindow
!    End
!    Self.CurrentWindowHandler &= Null
!    WindowHandler &= NEW c25_WindowHandlerClass()
!    Clear(Self.WindowHandlers)
!    Self.WindowHandlers.ClassPtr = Address(WindowHandler)
!    Self.WindowHandlers.WindowHandler &= Address(WindowHandler)
!    Self.WindowHandlers.Name &= Self.BitConverterClass.BinaryCopy(Clip(Left(_name)))
!    Add(Self.WindowHandlers)
!
!    If Omitted(_name) = False
!        If omitted(_functionName) = False
!            WindowHandler.InitWindow(_name, _functionName)
!        Else
!            WindowHandler.InitWindow(_name)
!        End
!    Else
!        If omitted(_functionName) = False
!            WindowHandler.InitWindow(, _functionName)
!        Else
!            WindowHandler.InitWindow()
!        End
!    End
!    If omitted(_wait) = False
!        If _wait = False
!            WindowHandler.OpenWindow()
!        Else
!            Self.CurrentWindowHandler &= WindowHandler
!        End
!    Else
!        WindowHandler.OpenWindow()
!    End
    Return C25_SUCCESS

C25_ProgramHandlerClass.OpenNewWindow                      Procedure(<bool _hideParentWindow>)

Code

!    If Omitted(_hideParentWindow) = False
!        0{Prop:Hide} = _hideParentWindow
!    End
!    If Not Self.CurrentWindowHandler &= null
!        Self.CurrentWindowHandler.OpenWindow()
!        Self.CurrentWindowHandler &= null
!    Else
!        Message('error, first call CreateNewWindow')
!        Return C25_FAILED
!    End
    Return C25_SUCCESS

C25_ProgramHandlerClass.GetWindow                        Procedure(String _name)

Code

!    I# = 0
!    Loop
!        I# = I# + 1
!        Get(Self.WindowHandlers, I#)
!        If Errorcode() <> 0
!            BREAK
!        End
!        If Upper(Clip(Left(Self.WindowHandlers.Name))) = Upper(Clip(Left(_name)))
!            Self.CurrentWindowHandler &= (Self.WindowHandlers.ClassPtr)
!            Return Self.WindowHandlers.ClassPtr
!        End
!    End
    Return 0


INCLUDE('C25_LoadSqlite3Dll.CLW')