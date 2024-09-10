                        Member

                        Include('c25_TabClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                            Module('c25_TabClass.clw')
                            End
                        End

c25_TabClass.Construct                                                     Procedure()

ClassStarter &c25_ClassStarter

Code

    Self.ClassTypeName = 'c25_TabClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)

    !Self.StLog &= NEW StringTheory()
    !Self.StLogFileName = 'm:\c25_TabClass.txt'
    !Remove(!Self.StLogFileName)
    !Self.StLog.SetValue('c25_TabClass.Construct<13><10>')
    !Self.StLog.SaveFile(!Self.StLogFileName,)

    Self.SQLiteAsyncConnections     &= Self.ProgramHandlerClass.SQLiteAsyncConnections

    Self.BitConverter               &= NEW c25_BitConverterClass()
    Self.NanoSync                   &= NEW c25_NanoSyncClass()
    Self.TabRenderEngineClass       &= NEW c25_TabRenderEngineClass()
    Self.ControlsFactoryClass       &= NEW c25_ControlsFactoryClass()
    Self.ControlsFactoryClass.ControlContainerPtr = Address(Self)
    Self.ControlsFactoryClass.ControlContainerType = ContainerType:TabClass

    Self.ControlRect                &= NEW WindowRect_TYPE()

    Self.TabHeaderTextW &= Self.BitConverter.AnsiToUtf16('Home',,true)
    Self.MessageOnlyWindowClass     &= NEW c25_MessageOnlyWindowClass()
    Self.MessageOnlyWindowClass.InitWindow(c25ClassTypes:TabClass , Address(Self))
    Self.MessageOnlyWindowClass.OpenWindow()

c25_TabClass.Destruct                                                       Procedure()

Code

c25_TabClass.WndProc_Process                                                Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)

I                                                                               Long
Control                                                                         &c25_ControlClass
RetVal                                                                          LONG

    Code

    Case _message
    Of C25_Wm_Size
    OrOf C25_Wm_Sizing
        Self.Resize()
    Of C25_Wm_Paint
        Self.Paint()
    End
        
    Case _message
    Of C25_Wm_Size
    OrOf C25_Wm_Sizing
        I = 0
        LOOP Self.ControlsFactoryClass.ControlsArrayMaximum Times
            I = I + 1
            If Self.ControlsFactoryClass.ControlsPtr[I] = 0
                CYCLE
            End
            Control &= (Self.ControlsFactoryClass.ControlsPtr[I])
            Control.WndProc_Process(_windowHandle,  _message,  _wParam,  _lParam, 0, RetVal)
            Control &= null
        End  
    End

c25_TabClass.Init                                                           Procedure()

CODE

    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.Init - START')
    
    If Self.Id < 1 Or Self.Id > Maximum(Self.ProgramHandlerClass.TabsWindowHandleArray,1)
        Message('our array')
    End

    Self.ProgramHandlerClass.TabsWindowHandleArray[Self.Id] = Self.MessageOnlyWindowClass.WindowHandle
    Self.ProgramHandlerClass.TabsClassPtrArray[Self.Id] = Address(Self)

    Self.ProgramHandlerClass.UpdateWindowRect()
    Self.ControlRect.Left       = 0
    Self.ControlRect.Top        = Self.ProgramHandlerClass.TabsOffsetY
    Self.ControlRect.Right      = Self.ProgramHandlerClass.WindowRect.Right
    Self.ControlRect.Bottom     = Self.ProgramHandlerClass.WindowRect.Height
    Self.ControlRect.Width      = Self.ControlRect.Right - Self.ControlRect.Left
    Self.ControlRect.Height     = Self.ControlRect.Bottom - Self.ControlRect.Top

    Self.TabHeaderDisplayOrdinalRow    = 1
    Self.TabHeaderDisplayOrdinalColumn = 1

    Self.TabHeaderOffsetX = 4
    Self.TabHeaderOffsetY = 4

    
    
    Self.TabRenderEngineClass.Init(Self)
    Self.PopulateControls()

    Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.Init - END')
    
    Return 0

c25_TabClass.LoadControls                                                   Procedure()

CODE

    Return 0

c25_TabClass.CreateSqliteDatabases                                          Procedure()

!SqliteClass &c25_SqliteClass
!I                                                                               LONG
!
CODE
!
!    If Self.SQLiteAsyncConnections &= NULL
!        Message('ERROR Self.SQLiteAsyncConnections is null error')
!    End
!    I = 0
!    LOOP
!        I = I + 1
!        Get(Self.SQLiteAsyncConnections,I)
!        If Errorcode() <> 0
!            BREAK
!        End
!
!        If Self.SQLiteAsyncConnections.SqliteClass &= NULL
!            Self.SQLiteAsyncConnections.SqliteClass &= NEW C25_SqliteClass()
!            Self.SQLiteAsyncConnections.SqliteClassPtr = Address(Self.SQLiteAsyncConnections.SqliteClass)
!            If Self.SQLiteAsyncConnections.ToCreate And Self.SQLiteAsyncConnections.Creating = 0 And Self.SQLiteAsyncConnections.Created = 0
!                Self.SQLiteAsyncConnections.Creating = True
!                If Self.SQLiteAsyncConnections.RemoveWhenExisting
!
!                    Self.ProgramHandlerClass.WinApiClass.RemoveFileUtf16(Self.SQLiteAsyncConnections.FullPathAndFilenameUtf16)
!                End
!
!                Self.SQLiteAsyncConnections.ConnHandle = Self.SQLiteAsyncConnections.SqliteClass.Connect(Self.SQLiteAsyncConnections.ConnectionString,,false)
!                If Self.SQLiteAsyncConnections.ConnHandle <> 0
!                    Self.SQLiteAsyncConnections.Creating = 0
!                    Self.SQLiteAsyncConnections.Created = True
!
!                    I = 0
!                    Loop
!                        I = I + 1
!                        Get(Self.SQLiteAsyncConnections.SqliteTables,I)
!                        If Errorcode() <> 0
!                            BREAK
!                        End
!
!                        Self.SQLiteAsyncConnections.SqliteClass.Exec(, Self.SQLiteAsyncConnections.SqliteTables.CreateStatement)
!
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
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Home')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:TopPanel
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Home')
!                            Self.NavigationTree.Flags           = NavigationTreeFlags:QuickAccess
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:Gallery
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Gallery')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:TopPanel
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Gallery')
!                            Self.NavigationTree.Flags           = NavigationTreeFlags:QuickAccess
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:Cloud
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Cloud')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:TopPanel
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Cloud')
!                            Self.NavigationTree.Flags           = NavigationTreeFlags:QuickAccess
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderDesktop
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Desktop')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Desktop')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderDownloads
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Downloads')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Downloads')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderDocuments
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Documents')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Documents')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderPictures
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Pictures')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Pictures')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderMusic
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Music')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Music')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:SpecialFolderVideos
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('Videos')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('Videos')
!                            Add(Self.NavigationTree)
!
!                            Self.NavigationTree.ParentId        = 0
!                            Self.NavigationTree.Level           = 1
!                            Self.NavigationTree.IconNumber      = IconLibrary:ThisPC
!                            Self.NavigationTree.Line           &= Self.BitConverter.AnsiToUtf16('This PC')
!                            Self.NavigationTree.TagId           = 0
!                            Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                            Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('This PC')
!                            Add(Self.NavigationTree)
!
!                            If not Self.ProgramHandlerClass.HardwareClass &= null
!                                If not Self.ProgramHandlerClass.HardwareClass.Devices &= null
!                                    H# = 0
!                                    LOOP
!                                        H# = H# + 1
!                                        Get(Self.ProgramHandlerClass.HardwareClass.Devices,H#)
!                                        If Errorcode() <> 0
!                                            BREAK
!                                        End
!                                        If Self.ProgramHandlerClass.HardwareClass.Devices.FriendlyNameUtf16 &= NULL
!                                            CYCLE
!                                        End
!                                        Self.NavigationTree.ParentId        = 0
!                                        Self.NavigationTree.Level           = 2
!                                        Self.NavigationTree.IconNumber      = IconLibrary:ThisPC
!                                        Self.NavigationTree.Line           &= Self.BitConverter.BinaryCopy(Self.ProgramHandlerClass.HardwareClass.Devices.FriendlyNameUtf16)
!                                        Self.NavigationTree.TagId           = Self.ProgramHandlerClass.HardwareClass.Devices.Id
!                                        Self.NavigationTree.NodeType        = NavigationTreeNodeType:QuickAccess
!                                        Self.NavigationTree.Name           &= Self.BitConverter.AnsiToUtf16('This PC')
!                                        Add(Self.NavigationTree)
!                                    End
!                                End
!                            End
!
!                            Self.NanoSync.StartStopwatch()
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
!                            SqliteClass &= null
!                        End
!                    End
!                End
!            End
!        End
!
!        Put(Self.SQLiteAsyncConnections)
!        Self.ProgramHandlerClass.CanUseSqliteForRendering = True
!    End

    Return 0

c25_TabClass.PopulateControls                                               Procedure()

Control                                                                     &c25_ControlClass
ButtonControl                                                               &c25_ControlButtonClass
TreeViewControl                                                             &c25_ControlTreeViewClass
XPos                                                                        Long
YPos                                                                        Long

CODE

    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - START')
    
    
    If Self.Id = 1
        Self.ProgramHandlerClass.UpdateWindowRect()
        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - START CREATE BUTTON CONTROLS')
        XPos = 10
        YPos = 42
        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('TabRibbonButtonBack')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = 10
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = Self.ProgramHandlerClass.ThemeManagerClass.GetWidth(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Height      = Self.ProgramHandlerClass.ThemeManagerClass.GetHeight(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        Self.ControlsFactoryClass.CreateControl(Control)

        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)
        
        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('BackButton_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('BackButton_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('BackButton_HotDimmed.png',,true)
        ButtonControl &= null
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        

        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('TabRibbonButtonForward')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos + 32 + 16 ; XPos = Control.ControlRect.Left
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = Self.ProgramHandlerClass.ThemeManagerClass.GetWidth(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Height      = Self.ProgramHandlerClass.ThemeManagerClass.GetHeight(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)
        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('ForwardButton_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('ForwardButton_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('ForwardButton_HotDimmed.png',,true)
        ButtonControl &= null
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        

        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('TabRibbonButtonUp')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos + 32 + 16 ; XPos = Control.ControlRect.Left
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = Self.ProgramHandlerClass.ThemeManagerClass.GetWidth(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Height      = Self.ProgramHandlerClass.ThemeManagerClass.GetHeight(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)
        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('UpButton_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('UpButton_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('UpButton_HotDimmed.png',,true)
        ButtonControl &= null
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        

        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('TabRibbonButtonRefresh')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos + 32 + 16 ;XPos = Control.ControlRect.Left
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = Self.ProgramHandlerClass.ThemeManagerClass.GetWidth(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Height      = Self.ProgramHandlerClass.ThemeManagerClass.GetHeight(ControlType:Button, Control.ThemeName, ButtonState:Normal)
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)
        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('RefreshButton_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('RefreshButton_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('RefreshButton_HotDimmed.png',,true)
        ButtonControl &= null
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - END CREATE BUTTON CONTROLS')
        
        
        
        
        
        
        XPos = 10
        YPos = YPos + 46
        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('TabRibbonButtonNew')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = 82
        Control.ControlRect.Height      = 38
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        XPos = Control.ControlRect.Left + Control.ControlRect.Width
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)

        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('NewButton_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('NewButton_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('NewButton_HotDimmed.png',,true)
        ButtonControl &= null
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        
        
        
        
        XPos = XPos + 7
        
        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('TabRibbonNewSeperator')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonSeperatorV')
        Control.ControlRect.Left        = XPos
        Control.ControlRect.Top         = YPos + 2
        Control.ControlRect.Width       = 1
        Control.ControlRect.Height      = 32
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)

        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('NewSeperatorV_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('NewSeperatorV_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('NewSeperatorV_HotDimmed.png',,true)
        ButtonControl &= null   
        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        
        
        
        
        
        !m:\HarddiskTools\ShortcutsBarButtonCut_Normal.png
        XPos = XPos + 7
        !YPos = YPos + 46
        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('ShortcutsBarButtonCut_Normal')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = 38
        Control.ControlRect.Height      = 38
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        XPos = Control.ControlRect.Left + Control.ControlRect.Width
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)

        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonCut_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonCut_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonCut_HotDimmed.png',,true)
        ButtonControl &= null        
        
        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        
        
        
        
        !m:\HarddiskTools\ShortcutsBarButtonCut_Normal.png
        XPos = XPos + 7
        !YPos = YPos + 46
        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('ShortcutsBarButtonCopy_Normal')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = 38
        Control.ControlRect.Height      = 38
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        XPos = Control.ControlRect.Left + Control.ControlRect.Width
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        

        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)

        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonCopy_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonCopy_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonCopy_HotDimmed.png',,true)
        ButtonControl &= null        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        
        
        
        
        XPos = XPos + 7
        !YPos = YPos + 46
        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('ShortcutsBarButtonPaste_Normal')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = 38
        Control.ControlRect.Height      = 38
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        XPos = Control.ControlRect.Left + Control.ControlRect.Width
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)

        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonPaste_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonPaste_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonPaste_HotDimmed.png',,true)
        ButtonControl &= null        
        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        
        
        
        
        

        XPos = XPos + 7
        !YPos = YPos + 46
        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:Button
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('ShortcutsBarButtonRename_Normal')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TabRibbonButton')
        Control.ControlRect.Left        = XPos
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = 38
        Control.ControlRect.Height      = 38
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        XPos = Control.ControlRect.Left + Control.ControlRect.Width
        
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')
        
        
        
        ButtonControl &= (Control.ClassPtr)
        ButtonControl.State = ButtonState:Normal
        !ButtonControl.NoText = Self.ProgramHandlerClass.ThemeManagerClass.HasText(ControlType:Button, Control.ThemeName)

        ButtonControl.IconFileName_Normal          &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonRename_Normal.png',,true)
        ButtonControl.IconFileName_Hot             &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonRename_Hot.png',,true)
        ButtonControl.IconFileName_HotDimmed       &= Self.BitConverter.AnsiToUtf16('ShortcutsBarButtonRename_HotDimmed.png',,true)
        ButtonControl &= null        
        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - DONE Control.Name: ' & Control.Name)
        
        
        
        
        
        
        
        
        
        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - END CREATE BUTTON CONTROLS')
        
        
!        !-------------------- TreeView
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - START CREATE TREEVIEW CONTROLS')
        
        XPos = 1
        YPos = Self.ProgramHandlerClass.RibbonHeight + Self.ProgramHandlerClass.RibbonShortCutBarHeight

        Control                        &= NEW c25_ControlClass()
        Control.TypeEnum                = ControlType:TreeView
        Control.ContainerType           = ContainerType:TabClass
        Control.ContainerClassPtr       = Address(Self)
        Control.Name                   &= Self.BitConverter.BinaryCopy('TreeViewNavigation')
        Control.ThemeName              &= Self.BitConverter.BinaryCopy('TreeView')
        Control.ControlRect.Left        = XPos
        Control.ControlRect.Top         = YPos
        Control.ControlRect.Width       = 300
        Control.ControlRect.Height      = Self.ProgramHandlerClass.WindowRect.Height - (Self.ProgramHandlerClass.RibbonHeight + Self.ProgramHandlerClass.RibbonShortCutBarHeight) - Self.ProgramHandlerClass.StatusBarHeight
        Control.ControlRect.Right       = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom      = Control.ControlRect.Top + Control.ControlRect.Height
        
        
        
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - START')
        Self.ControlsFactoryClass.CreateControl(Control)
        !Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - Self.ControlsFactoryClass.CreateControl(Control) - END')

        TreeViewControl &= (Control.ClassPtr)
        TreeViewControl.BindingSourceClass.TargetViewType = TargetViewType:TreeListView
        TreeViewControl.BindingSourceClass.Init(Control)
        
        TreeViewControl.BindingSourceClass.SetDataSource(DataSourceProviderType:ClarionQueue, ,Self.ProgramHandlerClass.NavigationTree)
        
        !TreeViewControl.BindingSourceClass.SetCursor('1')
        
!        TreeViewControl.Init(Control)
        TreeViewControl &= null        
        
        Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - END CREATE TREEVIEW CONTROLS')
        !-----------------------------
    End
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabClass.PopulateControls - END')
    Return 0

c25_TabClass.Resize                                                         Procedure()

Code

    If Self.TabRenderEngineClass &= NULL
        Return 0
    End
    If Self.ResizeTimeout > Self.NanoSync.GetSysTime()
    End
    Self.ResizeTimeout = Self.NanoSync.CalcSysTimeout(0,0,1,0)

    Self.ProgramHandlerClass.UpdateWindowRect()
    Self.ControlRect.Left       = 0
    Self.ControlRect.Top        = Self.ProgramHandlerClass.TabsOffsetY
    Self.ControlRect.Right      = Self.ProgramHandlerClass.WindowRect.Right
    Self.ControlRect.Bottom     = Self.ProgramHandlerClass.WindowRect.Height
    Self.ControlRect.Width      = Self.ControlRect.Right - Self.ControlRect.Left
    Self.ControlRect.Height     = Self.ControlRect.Bottom - Self.ControlRect.Top

    If Self.TabRenderEngineClass &= NULL
        Return 0
    END

    Self.TabRenderEngineClass.Resize()
    Self.Paint()

    Return 0

c25_TabClass.Paint                                                          Procedure()

Control                                                                         &c25_ControlClass
MsgStruct                       Group,Pre(MsgStruct)
lpMsg                               long
hWnd                                long
wMsgFilterMin                       long
wMsgFilterMax                       long
wRemoveMsg                          long
                                End
BoolReturn                      BOOL
Counter                         Long
I                               LONG

Code

    If Self.TabRenderEngineClass &= NULL
        Return 0
    END

    If Self.PaintTimeout > Self.NanoSync.GetSysTime()
        Self.ProgramHandlerClass.PaintTimeoutForced = Self.PaintTimeout
    End
    Self.PaintTimeout = Self.NanoSync.CalcSysTimeout(0,0,0,200)

    Self.TabRenderEngineClass.Paint()

    I = 0
    LOOP Self.ControlsFactoryClass.ControlsArrayMaximum Times
        I = I + 1
        If Self.ControlsFactoryClass.ControlsPtr[I] = 0
            CYCLE
        End
        Control &= (Self.ControlsFactoryClass.ControlsPtr[I])
        Case Self.ProgramHandlerClass.WinAppState
        Of WindowAppState:Active
            Control.Paint(CanvasState:Normal)
        Of WindowAppState:NotActive
            Control.Paint(CanvasState:NormalDimmed)
        End
        Control &= null
    End

    Return True

c25_TabClass.ProcessMouseEvent                                                  Procedure()

ControlTreeViewClass                                                            &c25_ControlTreeViewClass
Control                                                                         &c25_ControlClass
ButtonControl                                                                   &c25_ControlButtonClass
TextMes                                                                         cstring(255)
ForceRedraw                                                                     BOOL
I                                                                               LONG


Code

    If Self.TabRenderEngineClass &= NULL
        Return 0
    END
    If Self.PaintTimeout > Self.NanoSync.GetSysTime()
    End
    I = 0
    LOOP Self.ControlsFactoryClass.ControlsArrayMaximum Times
        I = I + 1
        If Self.ControlsFactoryClass.ControlsPtr[I] = 0
            CYCLE
        End

        Control &= (Self.ControlsFactoryClass.ControlsPtr[I])
        If Control.ClassPtr = 0
            Control &= null
            CYCLE
        End

        Case Control.TypeEnum
        Of ControlType:Button
            ButtonControl &= (Control.ClassPtr)
        Of ControlType:TreeView
            Control &= null ! toddoooooooooooooooooooooooooooooo!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            !ButtonControl &= (Control.ClassPtr)     
            CYCLE
        End

        If Self.ProgramHandlerClass.RenderEngineClass.RawMouse.AppMouseX > ButtonControl.BaseControl.ControlRect.Left And |
            Self.ProgramHandlerClass.RenderEngineClass.RawMouse.AppMouseX < ButtonControl.BaseControl.ControlRect.Right And |
            Self.ProgramHandlerClass.RenderEngineClass.RawMouse.AppMouseY > ButtonControl.BaseControl.ControlRect.Top And |
            Self.ProgramHandlerClass.RenderEngineClass.RawMouse.AppMouseY < ButtonControl.BaseControl.ControlRect.Bottom

            If Control.MouseIn = False
                Control.MouseIn = True
                Case Control.TypeEnum
                Of ControlType:Button
                    ButtonControl.ProcessEvent(EVENT:MouseIn)
                End
            End
            TextMes = 'MouseIn'
        ELSE
            If Control.MouseIn = True
                Control.MouseIn = False
                Case Control.TypeEnum
                Of ControlType:Button
                    ButtonControl.ProcessEvent(EVENT:MouseOut)
                End
            End
        End

        Case Control.TypeEnum
        Of ControlType:Button
            ButtonControl &= null
        End

        Control &= null
    End
    If ForceRedraw
         C25_SetWindowPos(Self.ProgramHandlerClass.ClientWindowHandle, 0, 0, 0, 0, 0, C25_SWP_FRAMECHANGED + C25_SWP_NOMOVE + C25_SWP_NOSIZE + C25_SWP_NOZORDER + C25_SWP_NOOWNERZORDER)
    End

    Return True

