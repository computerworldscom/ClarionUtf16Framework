        Member

    Include('c25_TreeClass.inc'),ONCE

SavedProc1          Long
Q45068              Queue,Pre(Q45068)
Value                   Long
Count                   Long
                    End
TreeClassPtr        long
PaintFirst          BOOL


        Map
            Include('i64.inc')
            Include('cwutil.inc')
            Include('c25_WinApiPrototypes.inc')
            SubClass(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam),LONG,pascal
            GetMessageNameFromId(ULong _id),string

            !VLBProcList(long _valProc, LONG _row, USHORT _col),string
        End

        

c25_TreeClass.Construct                      Procedure()

SomeLong                                            Long
ClassStarter &c25_ClassStarter

Code

    Self.ClassTypeName = 'c25_TreeClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)

!    Self.GraphicsClass          &= NEW c25GraphicsClass()
!    Self.BitConverter           &= New c25BitConverterClass()
!    Self.MsSql                  &= New c25MsSqlClass()
!    Self.TreeBufferSelected     &= NEW TreeNode_TYPE()
!    Self.TreeBuffer             &= NEW TreeNode_TYPE()
!    Self.TreeBufferTEMP         &= NEW TreeNode_TYPE()
!    
!    Self.CurrentNode            &= NEW c25TreeNodeClass()
!    Self.CurrentNode.Init(Self)

c25_TreeClass.Destruct                       Procedure()

    Code

c25_TreeClass.Init                           Procedure(<long _claListBox>, <string _connString>, <long _dbEngine>, <*queue _q>, <string _name>, <string _tableNameFull>, <string _databaseName>)

!    ListMenuTreeFEQ{PROP:VLBval}        = VLBval
!    ListMenuTreeFEQ{PROP:VLBProc}       = Address(VLBProcListMenuTree)
!    ListMenuTreeFEQ{PROP:LineHeight}    = 22
!!!    If TrueReflection &= NULL
!!!        TrueReflection &= NEW TrueReflectionClass()
!!!    End
!!    Free(MTReflectionFields)
!!    TrueReflection.Analyze(MachinesTree,MTReflectionFields)
!!    !Dispose(TrueReflection)
!    ?LISTSelf.TreeBuffer{PROP:LineHeight} = 21
!    ?LISTSelf.TreeBuffer{PROP:Format} = '19L(2)Y@s1@300L(2)JYT@s255@'
!    Init_VLBProcListMenuTree()

Code
    
!!!!!!    If omitted(_tableNameFull) = FALSE
!!!!!!        Dispose(Self.TableNameFull)
!!!!!!        Self.TableNameFull &= Self.BitConverter.BinaryCopy(Clip(_tableNameFull))
!!!!!!    ELSE
!!!!!!        Self.TableNameFull &= Self.BitConverter.BinaryCopy('Cla25ClassesTree')
!!!!!!    End    
!!!!!!    If omitted(_name) = FALSE
!!!!!!        Dispose(Self.Name)
!!!!!!        Self.Name &= Self.BitConverter.BinaryCopy('TreeObject-' & Random(1,2^31) )
!!!!!!    End
!!!!!!    If omitted(_databaseName) = FALSE
!!!!!!        Dispose(Self.DatabaseName)
!!!!!!        Self.DatabaseName &= Self.BitConverter.BinaryCopy(Clip(_databaseName))
!!!!!!    Else
!!!!!!        Self.DatabaseName &= Self.BitConverter.BinaryCopy('Clarion25Framework')
!!!!!!    End
!!!!!!    If omitted(_connString) = FALSE
!!!!!!        Dispose(Self.ConnString)
!!!!!!        Self.ConnString &= Self.BitConverter.BinaryCopy(Clip(_connString))
!!!!!!    Else
!!!!!!        Self.ConnString &= Self.BitConverter.BinaryCopy('Driver=' & Chr(07Bh) & 'SQL Server Native Client 11.0' & Chr(07Dh) & ';Server=.;Database=' & Self.DatabaseName & ';Trusted_Connection=Yes;Packet Size=32768;MultipleActiveResultSets=True')
!!!!!!    End
!!!!!!
!!!!!!    If OMITTED(_claListBox) = False
!!!!!!        Self.ClaControl &= NEW ClaControl_TYPE()
!!!!!!        Self.ClaControl.Handle              = _claListBox{Prop:Handle}
!!!!!!        Self.ClaControl.Feq                 = _claListBox{Prop:Feq}
!!!!!!        Self.ClaControl.Use                 = _claListBox{Prop:Use}
!!!!!!        Self.ClaControl.XPos                = _claListBox{Prop:XPos}
!!!!!!        Self.ClaControl.YPos                = _claListBox{Prop:YPos}
!!!!!!        Self.ClaControl.Width               = _claListBox{Prop:Width}
!!!!!!        Self.ClaControl.Height              = _claListBox{Prop:Height}
!!!!!!        Self.ClaControl.OldWndProc          = _claListBox{Prop:WndProc}
!!!!!!        Self.ClaControl.Pixels              = _claListBox{Prop:Pixels}
!!!!!!        Self.ClaControl.Buffer              = _claListBox{Prop:Buffer}
!!!!!!        SavedProc1 = Self.ClaControl.OldWndProc
!!!!!!        Self.ClaControl.OldClientWndProc    = _claListBox{Prop:ClientWndProc}
!!!!!!        Self.ClaControl.WndProc             = 0
!!!!!!        Self.ClaControl.ClientWndProc       = 0
!!!!!!        Self.ClaControl.Text               &= Self.BitConverter.BinaryCopy(_claListBox{Prop:Text})
!!!!!!        Self.ClaControl.VLBval              = _claListBox{Prop:VLBval}
!!!!!!        Self.ClaControl.VLBProc             = _claListBox{Prop:VLBProc}
!!!!!!        Self.ClaControl.LineHeight          = _claListBox{Prop:LineHeight}
!!!!!!        
!!!!!!        !_claListBox{Prop:Format} = '4L(2)JY@s1@1020L(2)JYT(1)S(500)@s255@' !'4L(2)Y@s1@1020L(2)JYT(1)S(500)@s255@'
!!!!!!        _claListBox{Prop:Format} = '300L(2)@s255@'
!!!!!!        Self.ClaControl.Format             &= Self.BitConverter.BinaryCopy(_claListBox{Prop:Format})
!!!!!!        Self.ClaControl.From                = _claListBox{Prop:From}
!!!!!!        Self.ClaControl.Parent              = _claListBox{Prop:Parent}
!!!!!!
!!!!!!        Add(Self.ClaControl)
!!!!!!        !Self.BitConverter.QueueToJsonString(Self.ClaControl, , , ,'m:\ClaListBox.json')
!!!!!!
!!!!!!    End
!!!!!!    Self.RowsCount = 0
!!!!!!    
!!!!!!      
!!!!!!    Self.MsSql.DebugLog = True
!!!!!!    Self.MsSql.Connect(Self.ConnString)
!!!!!!
!!!!!!    Self.VLBProc()
!!!!!!    
!!!!!!    Self.BitConverter.st1.Start()
!!!!!!    Self.BitConverter.st1.SetValue('')
!!!!!!    Self.BitConverter.st1.SaveFile('m:\listbox_messages.txt')
!!!!!!    
!!!!!!    _claListBox{Prop:WndProc} = Address(SubClass)
    
    Return 0
    
c25_TreeClass.GetClaControlEvent             Procedure(long _event)

Code
    
!!!!!!    CASE _event
!!!!!!
!!!!!!    OF EVENT:Selecting
!!!!!!        S# = Self.ClaControl.Feq{Prop:Selected}
!!!!!!        If S# > 0 And S# <= Records(Self.TreeBuffer)
!!!!!!            Self.SetCurrentNode(S#)
!!!!!!        End        
!!!!!!    OF EVENT:Expanding
!!!!!!        ! to reshuffle the rendering canvas
!!!!!!        ! in order to show an contracted or expanded
!!!!!!        ! tree (or subrow cells etc)
!!!!!!    OF EVENT:Contracting
!!!!!!
!!!!!!    OF EVENT:Expanded
!!!!!!
!!!!!!    OF EVENT:Contracted
!!!!!!
!!!!!!    ELSE
!!!!!!
!!!!!!    END
!!!!!!    If Self.CurrentCellRowIndex <> Self.ClaControl.Feq{Prop:Selected}
!!!!!!        Self.CurrentCellRowIndex = Self.ClaControl.Feq{Prop:Selected}
!!!!!!        Self.CurrentCellRowIndex_Changed = True
!!!!!!
!!!!!!    End
    
c25_TreeClass.SetCurrentNode                 Procedure(<long _indexTreeBuffer>)

Code
   
!!!!!!!    If omitted(_indexTreeBuffer) = False
!!!!!!!        If _indexTreeBuffer > 0 And _indexTreeBuffer <= Records(Self.TreeBuffer)
!!!!!!!            Get(Self.TreeBuffer, _indexTreeBuffer)
!!!!!!!            Self.CurrentNode.SetFromTreeBuffer(Self.TreeBuffer, _indexTreeBuffer)
!!!!!!!        End
!!!!!!!    End
!!!!!!!    
c25_TreeClass.Free_TreeBuffer                Procedure(<TreeNode_TYPE _TreeNode>)

TreeNode &TreeNode_TYPE

CODE
        
    
!!!!!!!    If omitted(_TreeNode) = False
!!!!!!!        TreeNode &= _TreeNode
!!!!!!!    ELSE
!!!!!!!        TreeNode &= Self.TreeBuffer
!!!!!!!    END
!!!!!!!    
!!!!!!!    I# = 0
!!!!!!!    Loop
!!!!!!!        Get(TreeNode,I#)
!!!!!!!        If Errorcode() <> 0
!!!!!!!            break
!!!!!!!        END
!!!!!!!        If Not TreeNode.HierarchyId
!!!!!!!            Dispose(TreeNode.HierarchyId)
!!!!!!!        End
!!!!!!!        If Not TreeNode.HierarchyIdString
!!!!!!!            Dispose(TreeNode.HierarchyIdString)
!!!!!!!        End
!!!!!!!        If Not TreeNode.IconName
!!!!!!!            Dispose(TreeNode.IconName)
!!!!!!!        End
!!!!!!!        If Not TreeNode.Name
!!!!!!!            Dispose(TreeNode.Name)
!!!!!!!        End
!!!!!!!        If Not TreeNode.Text_UTF8
!!!!!!!            Dispose(TreeNode.Text_UTF8)
!!!!!!!        End
!!!!!!!        If Not TreeNode.TextIconName
!!!!!!!            Dispose(TreeNode.TextIconName)
!!!!!!!        End 
!!!!!!!        Put(TreeNode)
!!!!!!!    End
!!!!!!!    Free(TreeNode)
!!!!!!!    
!!!!!!!    TreeNode &= NULL
    
    Return 0

c25_TreeClass.ExecuteQuery                   Procedure(string _sql, <string _sqlCount>, <bool _noFreeQ>)

CODE
        
!!!!!!!    If omitted(_noFreeQ) = True Or _noFreeQ = 0
!!!!!!!        Self.Free_TreeBuffer()
!!!!!!!    End
!!!!!!!        
!!!!!!!    Self.MsSql.GetMetaColumns(Clip(_sql), Self.TreeBuffer)
!!!!!!!    
!!!!!!!    If omitted(_sqlCount) = FALSE
!!!!!!!        !Self.MsSql.SQLFetch_Init(,,True,_sqlCount)
!!!!!!!        !Message('Self.MsSql.SQLRowCount ' & Self.MsSql.SQLRowCount)
!!!!!!!    End
!!!!!!!    Self.MsSql.SQLFetch_Rows(_sql, Self.TreeBuffer)
!!!!!!!    
!!!!!!!    Self.RowsCount          = Records(Self.TreeBuffer)
!!!!!!!    Self.IsBuffered         = true
!!!!!!!    Self.UseTreeBuffer      = True
!!!!!!!    Self.RecordsLoaded      = True
!!!!!!!    Self.ListChanged        = True
    Return ''
    
c25_TreeClass.RetrieveRecord                 Procedure(long _rowId, <*TreeNode_TYPE _treeNode>)

Sql    cstring(1024)

CODE
        
!!!!!!!    Sql = 'select * from [Clarion25Framework].[dbo].[Cla25ClassesTree] WHERE ROWID = ' & _rowId
!!!!!!!    self.Free_TreeBuffer(Self.TreeBufferTEMP)
!!!!!!!    
!!!!!!!    Self.MsSql.GetMetaColumns(Clip(Sql), Self.TreeBufferTEMP)
!!!!!!!    Self.MsSql.SQLFetch_Rows(Clip(Sql), Self.TreeBufferTEMP)
!!!!!!!
!!!!!!!    If omitted(_treeNode) = FALSE
!!!!!!!        _treeNode = Self.TreeBufferTEMP
!!!!!!!    End
    Return Self.TreeBufferTEMP
    
c25_TreeClass.GetHierarchyId                 Procedure(<long _rowIndex>)

    Code
        
!!!!!!!        Self.RowSelectedStart = Self.ClaControl.Feq{Prop:Selected} 
!!!!!!!        Get(Self.TreeBuffer,Self.RowSelectedStart)
!!!!!!!        If Errorcode() = 0
!!!!!!!            Message(Self.TreeBuffer.HierarchyIdString)
!!!!!!!        Else
!!!!!!!            Message('errorcode ' & ErrorCode())
!!!!!!!        End

        Return ''
        
!c25_TreeClass.GetAncestor                                    Procedure(<long _nth>, <long _rowIndex>)
!
!    Code
!        
!        Self.RowSelectedStart = Self.ClaControl.Feq{Prop:Selected} 
!        Get(Self.TreeBuffer,Self.RowSelectedStart)
!        If Errorcode() = 0
!           ! Message(Self.TreeBuffer.HierarchyIdString)
!        Else
!            !Message('errorcode ' & ErrorCode())
!        End
!        !Message('Self.RowSelectedStart ' & Self.RowSelectedStart)
!        
!        Return ''
        
        !https://purebasic.developpez.com/tutoriels/gdi/documentation/GdiPlus/String_Format/html/
        !https://purebasic.developpez.com/tutoriels/gdi/documentation/
        !https://purebasic.developpez.com/tutoriels/gdi/
        
        
        
        

c25_TreeClass.VLBProc                            Procedure()

Code
        

!!!!!!!    Self.ClaControl.Feq{PROP:VLBval}        = Address(Self)
!!!!!!!    Self.ClaControl.Feq{PROP:VLBProc}       = Address(Self.VLBProcList)
!!!!!!!!    Self.ClaControl.Feq{PROP:LineHeight}    = 22    
    
    Return 0
    
    !https://www.oreilly.com/library/view/microsoft-sql-server/9781118282175/c13_level1_2.xhtml#:~:text=The%20GetAncestor()%20method%20accepts,in%20the%20first%20SELECT%20statement.
    !https://learn.microsoft.com/en-us/sql/t-sql/data-types/getreparentedvalue-database-engine?view=sql-server-ver16
c25_TreeClass.VLBProcList                        Procedure(LONG _row, USHORT _col)

CODE
 
        Case _row
        OF -1
            Return Self.RowsCount
            
!            If Self.RecordsLoaded
!                RETURN Self.RowsCount
!            ELSE
!                Return 0
!            End
        OF -2
            RETURN 1
        OF -3
!             If Self.IsBuffered
!                If Self.UseTreeBuffer
!                    Get(Self.TreeBuffer, _row)
!                    If Errorcode() <> 0
!                        Return True
!                    END
!                    If Self.TreeBuffer.Synced
!                        Return 0
!                    End
!                    Self.TreeBuffer.Synced = TRUE
!                    Put(Self.TreeBuffer)
!                 End
!             End
            If Self.ListChanged
                Self.ListChanged = 0
                Return TRUE
            End
            Return 0
        Else
             If Self.IsBuffered
                If Self.UseTreeBuffer
                    Get(Self.TreeBuffer,_row)
                    If Errorcode() <> 0
                        Return Self.EmptyRecord(_col)
                    END
                    
                    Case _col
                    Of 1
                        Return ''
                    Of 2
                        Return Self.TreeBuffer.StyleId
                    Of 3
                        Return Self.TreeBuffer.IconId                        
                    Of 4
                        Return Self.TreeBuffer.Text_UTF8
                    Of 5
                        Return Self.TreeBuffer.TextIconId
                    Of 6
                        Return Self.TreeBuffer.NodeLevelCalc
                    Of 7
                        Return Self.TreeBuffer.TextStyleId
                    End
                        
                    Return 0
                END
            END
        END
        Return 0
                

    
    
c25_TreeClass.EmptyRecord                        Procedure(long _col)

CODE
    
    
    Case _col
    Of 1 ! Dummy01
        Return ''
    Of 2 ! Dummy01Style
        Return Self.DefaultColStyle[_col]
    Of 3 ! Line
        Return ''
    Of 4 ! LineIcon
        Return Self.DefaultColIcon[_col]
    Of 5 ! LineLevel
        Return 0
    Of 6 ! LineStyle
        Return Self.DefaultColStyle[_col]
    End
        
    Return 0     
    
c25_TreeClass.PaintFirstTime                     Procedure(<string _name>)

Code
    
    
    !!!Self.BackBufferCanvasId = Self.GraphicsClass.CreateCanvas(Self.ClaControl, 2000,10000, Clip(_name),0,0, 2)
    Return Self.BackBufferCanvasId   
    
    
    
    
    
    
Include('c25_GetMessageNameFromId.clw')
    
SubClass            Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)

TreeClass               &c25_TreeClass

CODE

    Case _message
    Of C25_WM_DESTROY                                                        !  2
!    OrOf C25_WM_MOUSEFIRST
!    OrOf C25_WM_CAPTURECHANGED                                                 !533
!    OrOf C25_WM_CONTEXTMENU                                                    !123
!    OrOf C25_WM_CTLCOLORSCROLLBAR                                              !311
!    OrOf C25_WM_GETDLGCODE                                                     !135
!    OrOf C25_WM_HSCROLL                                                        !276
!    OrOf C25_WM_IME_NOTIFY                                                     !642
!    OrOf C25_WM_IME_SETCONTEXT                                                 !641
!    OrOf C25_WM_KILLFOCUS                                                      !  8
!    OrOf C25_WM_LBUTTONDBLCLK                                                  !515
!    OrOf C25_WM_LBUTTONDOWN                                                    !513
!    OrOf C25_WM_LBUTTONUP                                                      !514
!    OrOf C25_WM_MOUSEACTIVATE                                                  ! 33
!    OrOf C25_WM_MOUSEFIRST                                                     !512
!    OrOf C25_WM_MOUSEWHEEL                                                     !522
!    OrOf C25_WM_NCDESTROY                                                      !130
!    OrOf C25_WM_NCHITTEST                                                      !132
!    OrOf C25_WM_NCMOUSEMOVE                                                    !160
!    OrOf C25_WM_NCPAINT                                                        !133
!    OrOf C25_WM_PARENTNOTIFY                                                   !528
!    OrOf C25_WM_RBUTTONDBLCLK                                                  !518
!    OrOf C25_WM_RBUTTONDOWN                                                    !516
!    OrOf C25_WM_RBUTTONUP                                                      !517
!    OrOf C25_WM_SETCURSOR                                                      ! 32
!    OrOf C25_WM_SETFOCUS                                                       !  7
!    OrOf C25_WM_TIMER                                                          !275
!    OrOf C25_WM_VSCROLL                                                        !277
!    OrOf C25_WM_WINDOWPOSCHANGING                                              ! 70
!    OrOf C25_WM_NCCALCSIZE                                                     !131
!    OrOf C25_WM_WINDOWPOSCHANGED                                               ! 71
!    OrOf C25_WM_NCMOUSELEAVE                                                   !674
!    OrOf C25_WM_NCLBUTTONDOWN                                                  !161
!    OrOf C25_WM_SYSCOMMAND                                                     !274
!    OrOf C25_WM_SIZE                                                           !  5 
!    Of 45068
!        Return 0
!    Of 45101
!        Return 0
!    Of 49722
!        Return 0
!    Of C25_WM_ERASEBKGND                                                     ! 20
    Else
!!!!!!        Case _message
!!!!!!        Of C25_WM_PAINT     
!!!!!!            If TreeClassPtr = 0
!!!!!!                Return C25_CallWindowProcA(SavedProc1,_windowHandle,_message,_wParam,_lParam)  
!!!!!!            End
!!!!!!            TreeClass &= (TreeClassPtr)
!!!!!!            
!!!!!!            If PaintFirst = 0 And Records(TreeClass.TreeBuffer) > 0
!!!!!!                PaintFirst = True
!!!!!!                TreeClass.WMPaintCanvasId = TreeClass.PaintFirstTime('TREE')
!!!!!!                TreeClass.GraphicsClass.SetRowTemplate()
!!!!!!                
!!!!!!                I# = 0
!!!!!!                T# = Records(TreeClass.TreeBuffer)
!!!!!!               
!!!!!!                Loop T# TIMES
!!!!!!                    I# = I# + 1
!!!!!!                    TreeClass.GraphicsClass.RenderRow(TreeClass.WMPaintCanvasId, I#, TreeClass.TreeBuffer)
!!!!!!                End
!!!!!!!            ELSE
!!!!!!!                 Return (C25_CallWindowProcA(SavedProc1,_windowHandle,_message,_wParam,_lParam))
!!!!!!            End
!!!!!!            
!!!!!!            If c25_GetUpdateRect(_windowHandle, 0 , 0)
!!!!!!                TreeClass.WMPaintDC = c25_BeginPaint(_windowHandle,Address(TreeClass.WMPaintStruct))
!!!!!!                c25_GdipCreateFromHDC(TreeClass.WMPaintDC ,Address(TreeClass.WMPaintGraphics))
!!!!!!                If TreeClass.WMPaintGraphics = 0
!!!!!!                    Message('error TreeClass.WMPaintGraphics = 0')
!!!!!!                End
!!!!!!                If TreeClass.GraphicsClass.GetCanvas_ImagePtr('TREE') <> 0
!!!!!!                    !(PROP:YOrigin
!!!!!!                    !TreeClass.WMPaintStruct
!!!!!!                    !C25_GdipDrawImageI(TreeClass.WMPaintGraphics, TreeClass.GraphicsClass.GetCanvas_ImagePtr('TREE'), 0, 0)
!!!!!!                    !PROP:Scroll
!!!!!!                    
!!!!!! 
!!!!!!
!!!!!!
!!!!!!                    !TreeClass.BitConverter.st1.SetValue( TreeClass.ClaControl.Feq{PROP:YOrigin} & ' , ' & TreeClass.ClaControl.Feq{PROP:Items} & ' , '  & TreeClass.ClaControl.Feq{PROP:YOrigin} & Chr(13) & Chr(10) )
!!!!!!                    TreeClass.BitConverter.st1.SetValue(TreeClass.GraphicsClass.GetCanvas_ImagePtr('TREE') & Chr(13) & Chr(10) )
!!!!!!                    TreeClass.BitConverter.st1.SaveFile('m:\listbox_messages.txt', True)
!!!!!!                    
!!!!!!                    OffsetY# = (TreeClass.ClaControl.Feq{PROP:YOrigin} * TreeClass.ClaControl.LineHeight) - TreeClass.ClaControl.LineHeight
!!!!!!                    C25_GdipDrawImagePointRectI(TreeClass.WMPaintGraphics, TreeClass.GraphicsClass.GetCanvas_ImagePtr('TREE'), TreeClass.WMPaintStruct.X , TreeClass.WMPaintStruct.Y, TreeClass.WMPaintStruct.X , TreeClass.WMPaintStruct.Y + OffsetY#, TreeClass.WMPaintStruct.W, TreeClass.WMPaintStruct.H, C25_Unitpixel)
!!!!!!                Else
!!!!!!                    Message('error not found')
!!!!!!                End
!!!!!!                c25_GdipDeleteGraphics(TreeClass.WMPaintGraphics)
!!!!!!                c25_EndPaint(_windowHandle, Address(TreeClass.WMPaintStruct))      
!!!!!!            End
!!!!!!        End
    End
    Return (C25_CallWindowProcA(SavedProc1,_windowHandle,_message,_wParam,_lParam))            

    

!PROPLIST:BackColor
!PROPLIST:BackSelected
!PROPLIST:BarFrame
!PROPLIST:CellStyle
!PROPLIST:Center
!PROPLIST:CenterOffset
!PROPLIST:Color
!PROPLIST:ColStyle
!PROPLIST:Decimal
!PROPLIST:DecimalOffset
!PROPLIST:DefaultTip
!PROPLIST:Exists
!PROPLIST:FieldNo
!PROPLIST:Fixed
!PROPLIST:Format
!PROPLIST:Grid
!PROPLIST:Group
!PROPLIST:GroupNo
!PROPLIST:HdrSortBackColor   
!PROPLIST:HdrSortTextColor 
!PROPLIST:Header
!PROPLIST:HeaderCenter
!PROPLIST:HeaderCenterOffset
!PROPLIST:HeaderDecimal
!PROPLIST:HeaderDecimalOffset
!PROPLIST:HeaderLeft
!PROPLIST:HeaderLeftOffset
!PROPLIST:HeaderRight
!PROPLIST:HeaderRightOffset
!PROPLIST:Icon
!PROPLIST:IconTrn
!PROPLIST:LastOnLine
!PROPLIST:Left
!PROPLIST:LeftOffset
!PROPLIST:Locator
!PROPLIST:MouseDownField
!PROPLIST:MouseDownRow
!PROPLIST:MouseDownZone
!PROPLIST:MouseMoveField
!PROPLIST:MouseMoveRow
!PROPLIST:MouseMoveZone
!PROPLIST:MouseUpField
!PROPLIST:MouseUpRow
!PROPLIST:MouseUpZone
!PROPLIST:OldTreeColor
!PROPLIST:Picture
!PROPLIST:Resize
!PROPLIST:Right
!PROPLIST:RightBorder
!PROPLIST:RightOffset
!PROPLIST:Scroll
!PROPLIST:SortBackColor
!PROPLIST:SortTextColor
!PROPLIST:Style
!PROPLIST:TextColor
!PROPLIST:TextSelected
!PROPLIST:Tip
!PROPLIST:Tree
!PROPLIST:TreeBoxes
!PROPLIST:TreeIndent
!PROPLIST:TreeLines
!PROPLIST:TreeOffset
!PROPLIST:TreeRoot
!PROPLIST:Underline
!PROPLIST:Width
!    
    
    
    
    
    
    
    
    
    
    
            
!!!            
!!!            !Get(TreeClass.TreeBuffer,1)
!!!            !Message('records ' & records(TreeClass.TreeBuffer))
!!!            !C25_CallWindowProcA(SavedProc1,_windowHandle,_message,_wParam,_lParam)
!!!            
!!!            Paint# = True
!!!            !Paint# = 0
!!!            If Paint#
!!!    !            Self.GetWindowRect(Self.WindowHandle, Self.DcRect)
!!!                !Ret# =  C25_CallWindowProcA(SavedProc1,_windowHandle,_message,_wParam,_lParam)
!!!                
!!!                
!!!                ToUpdate = c25_GetUpdateRect(_windowHandle, 0, Address(bErase))
!!!                
!!!                BitConverter.St1.Start()
!!!                
!!!                If ToUpdate = 0
!!!                    
!!!                    R# = C25_CallWindowProcA(SavedProc1, _windowHandle, _message, _wParam, _lParam)
!!!                    BitConverter.St1.Append('c25_GetUpdateRect = 0, R: ' & R# & Chr(13) & Chr(10) )
!!!                    BitConverter.St1.SaveFile('m:\logGetUpdateRect.txt', true)
!!!                    Return R# !C25_CallWindowProcA(SavedProc1, _windowHandle, _message, _wParam, _lParam)
!!!                End
!!!                
!!!                !BitConverter.St1.Append('c25_GetUpdateRect = True' & Chr(13) & Chr(10) )
!!!                BitConverter.St1.Append('c25_GetUpdateRect = True, ' )
!!!                              
!!!                
!!!                BeginPaintDC = c25_BeginPaint(_windowHandle,Address(PaintStruct))
!!!                UpdateRect.Left         = PaintStruct.X
!!!                UpdateRect.Top          = PaintStruct.Y
!!!                UpdateRect.Right        = PaintStruct.X + PaintStruct.W
!!!                UpdateRect.Bottom       = PaintStruct.Y + PaintStruct.H
!!!                UpdateRect.Width        = PaintStruct.W
!!!                UpdateRect.Height       = PaintStruct.H
!!!                
!!!                BitConverter.St1.Append(UpdateRect.Left & ', ' & UpdateRect.Top & ', ' & UpdateRect.Right & ', ' & UpdateRect.Bottom & ', ' & UpdateRect.Width & ', ' & UpdateRect.Height)
!!!                
!!!                BitConverter.St1.Append(Chr(13) & Chr(10) )
!!!                
!!!                BitConverter.St1.SaveFile('m:\logGetUpdateRect.txt', true)  
!!!                
!!!!                BitConverter.St1.Start()
!!!!                BitConverter.St1.Append(
!!!
!!!!PaintStruct                     Group,Pre(PaintStruct)
!!!!DC                                  Long,Name('DC')
!!!!Erase                               Long,Name('Erase')
!!!!X                                   Long,Name('X')
!!!!Y                                   Long,Name('Y')
!!!!W                                   Long,Name('W')
!!!!H                                   Long,Name('H')
!!!!Restore                             Long,Name('Restore')
!!!!IncUpdate                           Long,Name('IncUpdate')
!!!!Reserved                            String(255),Name('Reserved')                
!!!                
!!!                
!!!                c25_GetBoundsRect(BeginPaintDC, Address(WindowRect), 0)
!!!                
!!!                c25_GetClientRect(c25_WindowFromDC(BeginPaintDC),Address(WindowRect))
!!!                !Self.DC = Self.BeginPaintDC
!!!                !Message(WindowRect.right)
!!!                
!!!                c25_GdipCreateFromHDC(BeginPaintDC ,Address(Graphics))
!!!                If Graphics <> 0
!!!                    c25_GdipSetCompositingMode(Graphics,c25_CompositingModeSourceOver)
!!!                    c25_GdipSetCompositingQuality(Graphics,4)
!!!                    c25_GdipSetInterpolationMode(Graphics,7)
!!!                    c25_GdipSetSmoothingMode(Graphics,4)
!!!                    c25_GdipSetTextRenderingHint(Graphics,6)
!!!                    !c25_GdipGetClipBoundsI(Graphics, Address(WindowRect))
!!!                    
!!!                    !green
!!!!                    SolidBrushColorARGB.B = 64
!!!!                    SolidBrushColorARGB.G = 155
!!!!                    SolidBrushColorARGB.R = 255
!!!!                    SolidBrushColorARGB.A = 255 
!!!!                    
!!!!                    WindowRect.Width        = WindowRect.Right - WindowRect.Left
!!!!                    WindowRect.Height       = WindowRect.Bottom - WindowRect.Top
!!!!                    c25_GdipCreateSolidFill(SolidBrushColor,Address(GdiPlusSolidBrushHandle))
!!!                    
!!!                    !Message(WindowRect.Width & ', ' & WindowRect.Height)
!!!!                    c25_GdipFillRectangleI(Graphics, GdiPlusSolidBrushHandle, 0, 0, WindowRect.Width , WindowRect.Height)
!!!                    
!!!                    
!!!                    
!!!                    
!!!                    !FontFamilyNameA &= BitConverter.BinaryCopy('Arial' & Chr(0))
!!!                    FontFamilyNameW &= BitConverter.AnsiToUtf16('Arial', , True)
!!!                    
!!!                    c25_GdipCreateFontFamilyFromName(Address(FontFamilyNameW), 0, Address(FontFamilyHandle))
!!!                    !Message('FontFamilyHandle ' & FontFamilyHandle)
!!!                    
!!!                    emSize = 14
!!!                    c25_GdipCreateFont(FontFamilyHandle, emSize, 0, 2, Address(FontObjectHandle))   
!!!                    !Message('FontObjectHandle ' & FontObjectHandle)
!!!                    
!!!                    !c25_GdipDeleteFontFamily(FontFamilyHandle)
!!!                    c25_GdipCreateStringFormat(0,0,Address(StringFormatHandle))     
!!!                    
!!!                    !Message('StringFormatHandle ' & StringFormatHandle)
!!!                    SolidBrushColorARGB.B = 64
!!!                    SolidBrushColorARGB.G = 155
!!!                    SolidBrushColorARGB.R = 255
!!!                    SolidBrushColorARGB.A = 255 
!!!                    
!!!                    WindowRect.Width        = WindowRect.Right - WindowRect.Left
!!!                    WindowRect.Height       = WindowRect.Bottom - WindowRect.Top
!!!                    c25_GdipCreateSolidFill(SolidBrushColor,Address(GdiPlusSolidBrushHandle))                       
!!!                    
!!!                    
!!!                   
!!!                    GdipTextFillColorBGRA.B     = 10
!!!                    GdipTextFillColorBGRA.G     = 5
!!!                    GdipTextFillColorBGRA.R     = 5
!!!                    GdipTextFillColorBGRA.A     = 255
!!!                    !GdipTextFillColor.Color = (GdipTextFillColor.Alpha*256*256*256) + (GdipTextFillColor.Blue*256*256) + (GdipTextFillColor.Green*256) + GdipTextFillColor.Red
!!!                    !If GdipTextBrushHandle <> 0
!!!                     !   c25_GdipDeleteBrush(GdipTextBrushHandle)
!!!                    !End
!!!                    c25_GdipCreateSolidFill(GdipTextFillColor, Address(GdipTextBrushHandle))
!!!                    
!!!                    !GdipTextA               = 'just Testing here and there'
!!!                    
!!!                    !GdipTextW               &= BitConverter.ToUtf16('testing',True)
!!!                    !GdipTextW               &= BitConverter.AnsiToUtf16('testing',,True)
!!!                    GdipTextW               &= BitConverter.Utf8ToUtf16('testing',, true)
!!!                    GdipTextRect.Left       = 10
!!!                    GdipTextRect.Top        = 1
!!!                    GdipTextRect.Right      = 800
!!!                    GdipTextRect.Bottom     = 50
!!!                    
!!!                    If GdipTextBrushHandle = 0
!!!                        Message('error GdipTextBrushHandle')
!!!                    END
!!!                    
!!!                    If FontObjectHandle = 0
!!!                        Message('error FontObjectHandle')
!!!                    END
!!!                    
!!!                    I# = 0
!!!                    Loop 100 times
!!!                        I# = I# + 1
!!!                        Get(TreeClass.TreeBuffer,I#)
!!!                        If not GdipTextW &= NULL
!!!                            Dispose(GdipTextW)
!!!                        End
!!!                        GdipTextW &= BitConverter.BinaryCopy(Clip(TreeClass.TreeBuffer.Text_UTF8))
!!!                        
!!!                        c25_GdipFillRectangleI(Graphics, GdiPlusSolidBrushHandle, 10, GdipTextRect.Top + 4, WindowRect.Width - 20 , 16)
!!!                     
!!!                        
!!!                        R# = c25_GdipDrawString(Graphics, Address(GdipTextW),Size(GdipTextW)/2, FontObjectHandle, Address(GdipTextRect),0, GdipTextBrushHandle)    
!!!                        GdipTextRect.Top = GdipTextRect.Top + 21
!!!                        GdipTextRect.Bottom = GdipTextRect.Bottom + 21                        
!!!                    End
!!!
!!!                ELSE
!!!                    Message('Graphics = 0')
!!!                End
!!!    !            Self.GraphicsClass.TargetDC = Self.DC
!!!    !            Self.GraphicsClass.TargetGraphics = Self.Graphics
!!!    !                
!!!    !        !    If Self.PaintStruct.Erase
!!!    !        !        Self.EraseBkgnd()
!!!    !        !    END
!!!    !        !    If Self.WindowRectLast <> Self.WindowRect
!!!    !        !        Self.GetWindowRect()
!!!    !        !        Self.WindowRectLast = Self.WindowRect
!!!    !        !        Self.RepaintAll = True
!!!    !        !    End
!!!    !        !    Self.PaintControls(,)
!!!    !            
!!!    !            !C25_GdipDrawImageI(Self.Graphics, Self.GraphicsClass.FileImagePtr, 0, 0)
!!!    !            
!!!                
!!!                
!!!                !c25_Describepixelformat(BeginPaintDC
!!!                c25_GdipDeleteGraphics(Graphics)
!!!                
!!!                c25_EndPaint(_windowHandle, Address(PaintStruct)) 
!!!                    
!!!                !C25_CallWindowProcA(SavedProc1,_windowHandle,_message,_wParam,_lParam)
!!!                
!!!    !            Self.DC = 0
!!!    !            Self.BeginPaintDC = 0
!!!
!!!                Dispose(BitConverter)
!!!                    
!!!                Return Ret#
!!!                !Self.ReturnWndProc.Processed = True
!!!                !Self.ReturnWndProc.ReturnVal = 0    
!!!            End
!!!        END
        
!        UNKNOWN                                                         45068
!        UNKNOWN                                                         45101
!        UNKNOWN                                                         49722        
        !177 notify https://learn.microsoft.com/en-us/windows/win32/controls/lvn-getdispinfo
        !https://learn.microsoft.com/en-us/windows/win32/controls/control-messages
        !https://learn.microsoft.com/en-us/windows/win32/controls/wm-hscroll
        !https://www.codeproject.com/Questions/5272572/Anyone-can-help-me-with-a-list-view-winapi
        
!        Clear(Q45068)
!        If _message = 45068
!            Q45068.Value = _wParam
!            Get(Q45068,+Q45068.Value)
!            If Errorcode() = 0
!                Q45068.Count = Q45068.Count + 1
!                Put(Q45068)
!            ELSE
!                Q45068.Count = Q45068.Count + 1
!                Add(Q45068)
!            End        
!        End
        
        !st1 &= NEW StringTheory()
!!!!!!        st1.Start()
!!!!!!        
!!!!!!        TheLine = GetMessageNameFromId(_message)
!!!!!!        TheLine[64 : Size(TheLine)] = Format(_message,@N_6)
!!!!!!        TheLine[72 : Size(TheLine)] = Format(_wParam,@N_11)
!!!!!!        TheLine[86 : Size(TheLine)] = Format(_lParam,@N_11)
!!!!!!
!!!!!!        HiLowIntStr4 = _wParam
!!!!!!        TheLine[100 : Size(TheLine)] = Format(HiLowInt.Hi,@N_7)
!!!!!!        TheLine[110 : Size(TheLine)] = Format(HiLowInt.Lo,@N_7)
!!!!!!        
!!!!!!        TheLine[120 : Size(TheLine)] = Format(Q45068.Count,@N_7)
!!!!!!        
!!!!!!
!!!!!!!Q45068              Queue,Pre(Q45068)
!!!!!!!Value                   Long
!!!!!!!Count                   Long
!!!!!!!                    End        
!!!!!!        
!!!!!!        st1.SetValue(Clip(TheLine) & Chr(13) & Chr(10))
!!!!!!        st1.SaveFile('m:\listbox_messages.txt',true)
!        Dispose(st1)
!    End
!    
!    RETURN (C25_CallWindowProcA(SavedProc1,_windowHandle,_message,_wParam,_lParam))
!Pass control to SavedProc2

    !Return !c25_DefWindowProcA(_windowHandle, _message, _wParam, _lParam)
        
        
!UNKNOWN                                                         45068    318835012             0
!UNKNOWN                                                         45068    570498083             0
!UNKNOWN                                                         45068    755047393             0
!UNKNOWN                                                         45068   1510021245             0
!UNKNOWN                                                         45068   1963007208             0
!UNKNOWN                                                         45068   2164333606             0
!UNKNOWN                                                         45068   2751536360             0
!UNKNOWN                                                         45068   2969640161             0
!UNKNOWN                                                         45068   3405847836             0
!UNKNOWN                                                         45068   3523285780             0
!UNKNOWN                                                         45068   4211151717             0
!UNKNOWN                                                         45101            0             0
!UNKNOWN                                                         45101            1             0
!UNKNOWN                                                         49722            0             0
!WM_CAPTURECHANGED                                                 533            0             0
!WM_CTLCOLORSCROLLBAR                                              311    335615414       1446058
!WM_CTLCOLORSCROLLBAR                                              311   1291916064       1446058
!WM_DESTROY                                                          2            0             0
!WM_GETDLGCODE                                                     135            0             0
!WM_IME_NOTIFY                                                     642            1             0
!WM_IME_SETCONTEXT                                                 641            0    1073741809
!WM_IME_SETCONTEXT                                                 641            1    1073741809
!WM_KILLFOCUS                                                        8            0             0
!WM_LBUTTONDOWN                                                    513            1       7733585
!WM_LBUTTONDOWN                                                    513            1      14090583
!WM_LBUTTONDOWN                                                    513            1      19267879
!WM_LBUTTONUP                                                      514            0       7733585
!WM_LBUTTONUP                                                      514            0      14025047
!WM_LBUTTONUP                                                      514            0      19267879
!WM_MOUSEACTIVATE                                                   33       725032      33619969
!WM_MOUSEFIRST                                                     512            0       5308844
!WM_NCDESTROY                                                      130            0             0
!
!WM_NCMOUSEMOVE                                                    160           18      14156293
!WM_NCPAINT                                                        133            1             0
!WM_NCPAINT                                                        133    923016227             0
!WM_NCPAINT                                                        133   1040451908             0
!WM_NCPAINT                                                        133   1426331773             0
!WM_NCPAINT                                                        133   1426332710             0
!WM_NCPAINT                                                        133   1543768388             0
!WM_NCPAINT                                                        133   2818841825             0
!WM_NCPAINT                                                        133   3087277361             0
!WM_PAINT                                                           15            0             0
!WM_SETCURSOR                                                       32       659494      33554433
!WM_SETCURSOR                                                       32       659494      33554450
!WM_SETCURSOR                                                       32       659494      33619969
!WM_SETFOCUS                                                         7       331758             0
