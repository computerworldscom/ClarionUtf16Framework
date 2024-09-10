    Member()

    Include('c25_TreeViewClass.inc'),ONCE

            Map
                Include('c25_WinApiPrototypes.inc')
                Include('i64.inc')
            End

c25_TreeViewClass.Construct                                         Procedure()

ClassStarter  &c25_ClassStarter

Code

    Self.ClassTypeName = 'c25_TreeViewClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    Self.GdiPlusClass               &= Self.ProgramHandlerClass.GdiPlusClass
    Self.HardwareClass              &= Self.ProgramHandlerClass.HardwareClass

    Self.st1                        &= New StringTheory()
    Self.stBuffer                   &= New StringTheory()
    Self.stLog                      &= New StringTheory()
    Self.PaintPages                 &= New PaintPage_TYPE()
    Self.SqliteClass                &= New c25_SqliteClass()
    Self.NavigationTree             &= New NavigationTree_TYPE
    Self.NavTreeRecord              &= New NavigationTree_TYPE
    Self.GradientRect               &= New WindowRect_TYPE
    Self.BitConverter               &= New c25_BitConverterClass()
    Self.SomeRect                   &= New WindowRect_TYPE
    Self.TextRectF                  &= New RectF_TYPE
    Self.RowHeight                  = 32
    Self.ObjectClass                &= NEW c25_ObjectClass()
    Self.UpdateRect                 &= NEW WindowRect_TYPE()
    Self.DictImageCache             &= NEW c25_DictionaryClass()
    

    Self.MessageOnlyWindowClass                 &= NEW c25_MessageOnlyWindowClass()
    Self.MessageOnlyWindowClass.InitWindow(c25ClassTypes:TreeViewClass , Address(Self))
    Self.MessageOnlyWindowClass.OpenWindow()

    
    Self.stLogFileName = 'm:\c25_TreeViewClass.txt'
    Remove(Self.stLogFileName)
    Self.stLog.SetValue('START' & Chr(13) & Chr(10))
    Self.stLog.SaveFile(Self.stLogFileName)
    
    Self.CreateCanvas()
    

c25_TreeViewClass.Destruct                                          Procedure()

    Code
        
        
c25_TreeViewClass.CreateCanvas                                      Procedure()

Code
        
    Self.CanvasWidth = 5000
    Self.CanvasHeigth = 5000
    Self.GdiPlusClass.CreateCanvas(Self.CanvasWidth, Self.CanvasHeigth, Self.CanvasGraphics, Self.CanvasImagePtr, Self.CanvasScan0, Self.CanvasBitmapAllocSize, Self.CanvasStride, Self.CanvasPixelFormat, DisplayStateMode:Buffer)
    
    Self.stLog.Append('Self.CanvasGraphics : '          & Self.CanvasGraphics & '<13><10>')
    Self.stLog.Append('Self.CanvasImagePtr : '          & Self.CanvasImagePtr & '<13><10>')
    Self.stLog.Append('Self.CanvasScan0 : '             & Self.CanvasScan0 & '<13><10>')
    Self.stLog.Append('Self.CanvasBitmapAllocSize : '   & Self.CanvasBitmapAllocSize & '<13><10>')
    Self.stLog.Append('Self.CanvasStride : '            & Self.CanvasStride & '<13><10>')
    Self.stLog.Append('Self.CanvasPixelFormat : '       & Self.CanvasPixelFormat & '<13><10>')

    Self.GdiPlusClass.SetRenderType(Self.CanvasGraphics, GdiplusRenderType:LineArt)
    !c25_GdipFillRectangleI(Self.CanvasGraphics, Self.GdiPlusClass.GetSolidBrush( ,255,0,255,0), 0 , 0 ,Self.CanvasWidth, Self.CanvasHeigth)
    c25_GdipFillRectangleI(Self.CanvasGraphics, Self.GdiPlusClass.NewSolidBrush(,,255,0,255,0), 0 , 0 ,Self.CanvasWidth, Self.CanvasHeigth)
    
    Self.stLog.SaveFile(Self.stLogFileName)
    
    Return 0


c25_TreeViewClass.Init                                             Procedure()

OldControl  &Control_TYPE

Code

!    OldControl &= Self.BaseControl
!    Self.BaseControl &= _BaseControl
!    If not OldControl &= NULL
!        Dispose(OldControl)
!    End
    
    
    !Self.ProgramHandlerClass.UpdateWindowRect
        
    !Self.UpdateLayout(Self.BaseControl, Self.ProgramHandlerClass.WindowRect)

!    If Records(Self.PaintPages) = 0
!        If Records(Self.NavigationTree) = 0
!            X# = Self.SqliteClass.Connect(Self.ProgramHandlerClass.AppSqliteFullPathUtf8)
!        End
!        Self.CreatePage(_graphics, _control)
!    End
!    Self.RenderPages(_graphics, _control)
    
    !Self.InitCompleted = true

    Return 0        

c25_TreeViewClass.WndProc_Process                                   Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)

    CODE


    !Self.ProgramHandlerClass.UpdateWindowRect()
        
    Case _message
    Of C25_Wm_Mousemove
        Self.DesktopMouseXY = _lParam
        If Self.LastDesktopMouseXY <> Self.DesktopMouseXY !and 1 > 2
            !Self.stLog.SaveFile(Self.stLogFileName)
            Self.stLog.Start()
            Self.stLog.Append('Self.LastDesktopMouseXY : '       & Self.LastDesktopMouseXY & '<13><10>')
            Self.stLog.SaveFile(Self.stLogFileName, true)
            
            Self.LastDesktopMouseXY = Self.DesktopMouseXY
            Self.MouseMoved = TRUE

            If Self.ProgramHandlerClass.WindowHandle <> 0

                Self.ProgramHandlerClass.DC = C25_GetWindowDC(Self.ProgramHandlerClass.WindowHandle)
                c25_GdipCreateFromHDC(Self.ProgramHandlerClass.DC ,Address(Self.PaintGraphics))

!                Self.ProgramHandlerClass.WindowRect = Self.ProgramHandlerClass.WinApiClass.GetWindowRect( Self.ProgramHandlerClass.WindowHandle)
!                Self.UpdateLayout() !Self.BaseControl, Self.ProgramHandlerClass.WindowRect)
!                
!                If Self.PaintPages.Normal_Graphics <> 0
!                    Self.ResetPaintPages()
!                    Self.RenderPages() !Self.PaintPages.Normal_Graphics, Self.BaseControl)
!                End
                If Self.CanvasImagePtr <> 0 And Self.BaseControl.ControlRect.Width > 0
                    Self.GdiPlusClass.DrawImageRectRectI(Self.PaintGraphics, Self.CanvasImagePtr, Self.BaseControl.ControlRect.Left, Self.BaseControl.ControlRect.Top, Self.BaseControl.ControlRect.Width, Self.BaseControl.ControlRect.Height, | &
                    0,      | &
                    0,       | &
                    Self.BaseControl.ControlRect.Width,     | &
                    Self.BaseControl.ControlRect.Height,    | &
                    UnitPixel,  | &
                    0,  | &
                    0,  | &
                    0)
                End
                
!        Self.GdiPlusClass.DrawImageRectRectI(_graphics, Self.PaintPages.Normal_ImagePtr, Control.Left, Control.Top, Control.Width, Control.Height, | &
!        Self.PaintPages.Crop_Left,      | &
!        Self.PaintPages.Crop_Top,       | &
!        Self.PaintPages.Crop_Width-1,     | &
!        Self.PaintPages.Crop_Height-1,    | &
!        UnitPixel,  | &
!        0,  | &
!        0,  | &
!        0)                

                c25_GdipDeleteGraphics(Self.PaintGraphics)

                c25_ReleaseDC(Self.ProgramHandlerClass.WindowHandle, Self.ProgramHandlerClass.DC)

            End

        ELSE
            Self.MouseMoved = 0
        End

    END

c25_TreeViewClass.UpdateLayout      Procedure()

CODE

!    Self               Self.ProgramHandlerClass.WinApiClass.GetWindowRect( Self.ProgramHandlerClass.WindowHandle)
!    UpdateWindowRect
!    
!    
!    Self.BaseControl.Left                      = 4
!    Self.BaseControl.Top                       = Self.ProgramHandlerClass.RibbonHeight + Self.ProgramHandlerClass.RibbonShortCutBarHeight + 1
!    Self.BaseControl.Bottom                    = _windowRect.Height - 23
!    Self.BaseControl.Width                     = 395
!    Self.BaseControl.Height                    = Self.BaseControl.Bottom - Self.BaseControl.Top
!    Self.BaseControl.Right                     = Self.BaseControl.Width + Self.BaseControl.Left
!
!    Put(_control)
!
!    If Self.BaseControl <> _control
!        Self.BaseControl = _control
!        Self.BaseControl.SizeChanged = True
!    End

    Return 0



c25_TreeViewClass.RenderPages                                       Procedure() !long _graphics, *Control_TYPE _control)

StateMode           Long
ColumsCount         Long
PageId              Long
ReturnValRef        &STRING

Code

    Self.IsFirstNode = True

    ColumsCount = Self.SqliteClass.EnumRowsPrepare('NavigationTree',)

    Loop 1 Times
        StateMode = StateMode + 1

        Case StateMode
        Of DisplayStateMode:Normal
            If Self.Normal_FontFamily = 0
                Self.Normal_FontFamilyNameW &= Self.BitConverter.AnsiToUtf16('Segoe UI',,True)
                c25_GdipCreateFontFamilyFromName(Address(Self.Normal_FontFamilyNameW), 0, Address(Self.Normal_FontFamily))
                If Self.Normal_FontFamily = 0
                    Message('error creating font Normal family')
                End
            End
            If Self.Normal_Font = 0
                Self.Normal_FontSize = 12
                c25_GdipCreateFont(Self.Normal_FontFamily, Self.Normal_FontSize, 0, 2, Address(Self.Normal_Font))
                If Self.Normal_Font = 0
                    Message('error create font')
                End
            End
            If Self.Normal_StringFormat = 0
                c25_GdipCreateStringFormat(0, 0, Address(Self.Normal_StringFormat))
            End
            If Self.Normal_FontBrush = 0
                Self.Normal_FontBrush = Self.GdiPlusClass.NewSolidBrush( , ,255,28,28,28)
            End
        End

        Self.X = 58
        Self.Y = 27 - Self.RowHeight

        PageId = 1
        Get(Self.PaintPages,PageId)
        If Errorcode() <> 0
        End

        Self.GdiPlusClass.SetRenderType(Self.PaintPages.Normal_Graphics, GdiplusRenderType:LineArt)
        c25_GdipFillRectangleI(Self.PaintPages.Normal_Graphics, Self.GdiPlusClass.NewSolidBrush( , ,255,0,255,0), 0 , 0 ,Self.PaintPages.Canvas_Width, Self.PaintPages.Canvas_Height)
        c25_GdipFillRectangleI(Self.PaintPages.Normal_Graphics, Self.GdiPlusClass.NewSolidBrush( , ,255,250,250,250), Self.PaintPages.Crop_Left , Self.PaintPages.Crop_Top ,Self.PaintPages.Crop_Width, Self.PaintPages.Crop_Height)

        Loop
            If Self.SqliteClass.EnumRows() = False
                BREAK
            End

            Self.LastField = False

            Dispose(Self.NavTreeRecord.JsonExtra)
            Dispose(Self.NavTreeRecord.Line)
            Dispose(Self.NavTreeRecord.Name)
            Clear(Self.NavTreeRecord)
            Loop

                Self.ObjectClass.Reset()

                If Self.SqliteClass.EnumFields(Self.ObjectClass) = False
                    Self.LastField = True
                End

                Case upper(Self.ObjectClass.Name)
                Of 'NODETYPE'
                    Self.NavTreeRecord.NodeType = Self.ObjectClass.ValueLong
                Of 'ICONNUMBER'
                    Self.NavTreeRecord.IconNumber = Self.ObjectClass.ValueLong
                Of 'LINE'
                    If not Self.ObjectClass.Value &= null
                        Self.NavTreeRecord.Line &= Self.BitConverter.AnsiToUtf16(Self.DesktopMousePos.X & ', ' & Self.DesktopMousePos.Y & ', ' & Random(0,2^21))
                    End
                END

                If Self.LastField

                    If Self.NavTreeRecord.NodeType <> Self.LastNodeType
                        If Self.IsFirstNode
                            Self.IsFirstNode = False
                        Else
                            Self.DrawSeperator = True
                        End
                        Self.LastNodeType = Self.NavTreeRecord.NodeType
                    End

                    If Self.DrawSeperator
                        Self.Y = Self.Y + Self.RowHeight

                        Self.DrawSeperator = False
                        If Self.PenHandle = 0
                            c25_GdipCreatePen1(Self.GdiPlusClass.GetColorMacro(255, 214, 214, 214), 1, 0,  Address(Self.PenHandle))
                        Else
                            C25_Gdipsetpencolor(Self.PenHandle, Self.GdiPlusClass.GetColorMacro(255, 214, 214, 214))

                        END
                        C25_Gdipdrawlinei(Self.PaintPages.Normal_Graphics, Self.PenHandle, Self.PaintPages.Crop_Left + 11, Self.Y + 9, Self.PaintPages.Crop_Right - 11, Self.Y + 9 )
                        Self.Y = Self.Y + Self.RowHeight
                    Else
                        Self.Y = Self.Y + Self.RowHeight
                    End

                    Self.TextRectF.Left      = Self.X
                    Self.TextRectF.Top       = Self.Y
                    Self.TextRectF.Right     = 370
                    Self.TextRectF.Bottom    = Self.TextRectF.Top + Self.RowHeight

                    If Not Self.StringW &= NULL
                        Dispose(Self.StringW)
                    End

                    If not Self.NavTreeRecord.Line &= null
                        Self.StringW  &= Self.BitConverter.BinaryCopy(Self.NavTreeRecord.Line)
                    ELSE
                        Self.StringW  &= Self.BitConverter.AnsiToUtf16('helaas')
                    End

                    c25_GdipDrawString(Self.PaintPages.Normal_Graphics, Address(Self.StringW),Size(Self.StringW)/2, Self.Normal_Font, Address(Self.TextRectF), 0 , Self.Normal_FontBrush)

                    If not Self.IconFilenameW &= NULL
                        Dispose(Self.IconFilenameW)
                    END

                    Self.IconImageHandle = 0
                    Case Self.NavTreeRecord.IconNumber
                    Of IconLibrary:None
                    Of IconLibrary:Home
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Home.ico',,true)
                    Of IconLibrary:FolderClosed
                    Of IconLibrary:FolderOpen
                    Of IconLibrary:ThisPc
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\ThisPC.ico',,true)
                    Of IconLibrary:Gallery
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Gallery.ico',,true)
                    Of IconLibrary:Cloud
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Cloud.ico',,true)
                    Of IconLibrary:SpecialFolderDesktop
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Desktop.ico',,true)
                    Of IconLibrary:SpecialFolderDownloads
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Downloads.ico',,true)
                    Of IconLibrary:SpecialFolderDocuments
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Documents.ico',,true)
                    Of IconLibrary:SpecialFolderPictures
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Pictures.ico',,true)
                    Of IconLibrary:SpecialFolderMusic
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Music.ico',,true)
                    Of IconLibrary:SpecialFolderVideos
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Videos.ico',,true)
                    Of IconLibrary:SpecialFolderNetwork
                        Self.IconFilenameW &= Self.BitConverter.AnsiToUtf16('.\Ico\Network.ico',,true)
                    Of IconLibrary:SourceFileName
                    Of IconLibrary:SourceExe
                    Of IconLibrary:SourceDll
                    Of IconLibrary:SourceIconDb
                    End

                    Self.IconImageHandle = 0
                    If not Self.IconFilenameW &= NULL
                        Self.IconImageHandle = Self.DictImageCache.TryGetValue(Self.IconFilenameW)
                        If Self.IconImageHandle = 0
                            C25_GdipLoadImageFromFile( Address(Self.IconFilenameW) , Address(Self.IconImageHandle))
                            Self.DictImageCache.Add(Self.IconFilenameW, Self.IconImageHandle)
                        End
                        Dispose(Self.IconFilenameW)
                    End
                    If Self.IconImageHandle <> 0
                        C25_GdipDrawImageRectI(Self.PaintPages.Normal_Graphics, Self.IconImageHandle, Self.X - 19, Self.Y, 16, 16)
                    End

                    Break
                End
            End

        END

!        Self.GdiPlusClass.DrawImageRectRectI(_graphics, Self.PaintPages.Normal_ImagePtr, Control.Left, Control.Top, Control.Width, Control.Height, | &
!        Self.PaintPages.Crop_Left,      | &
!        Self.PaintPages.Crop_Top,       | &
!        Self.PaintPages.Crop_Width-1,     | &
!        Self.PaintPages.Crop_Height-1,    | &
!        UnitPixel,  | &
!        0,  | &
!        0,  | &
!        0)

    End
    Return 0

c25_TreeViewClass.CreatePage                                        Procedure()

Tuple  Like(Tuple2_TYPE)

Code

    Free(Self.PaintPages)

!    If not Self.BaseControl.Name &= null
!        If Self.BaseControl.Name = 'Navigation Tree'
!            Self.BaseControl.WinHandleControl = Self.MessageOnlyWindowClass.WindowHandle
!            Put(_control)
!            If Self.ProgramHandlerClass.NavigationTreeControl &= null
!                Self.ProgramHandlerClass.NavigationTreeControl &= SELF
!            End
!        End
!    End

    Clear(Self.PaintPages)
    Self.PaintPages.Id                                                          = 0
    Self.PaintPages.Canvas_Margin                                               = 10
    Self.PaintPages.Canvas_Width                                                = Self.BaseControl.ControlRect.Width + (Self.PaintPages.Canvas_Margin * 2)
    Self.PaintPages.Canvas_Height                                               = Self.BaseControl.ControlRect.Height + (Self.PaintPages.Canvas_Margin * 2)

    Self.PaintPages.Crop_Left                                                   = Self.PaintPages.Canvas_Margin
    Self.PaintPages.Crop_Top                                                    = Self.PaintPages.Canvas_Margin
    Self.PaintPages.Crop_Right                                                  = Self.PaintPages.Canvas_Width      - Self.PaintPages.Canvas_Margin - 2
    Self.PaintPages.Crop_Bottom                                                 = Self.PaintPages.Canvas_Height     - Self.PaintPages.Canvas_Margin - 2
    Self.PaintPages.Crop_Width                                                  = Self.PaintPages.Crop_Right        - Self.PaintPages.Crop_Left + 2
    Self.PaintPages.Crop_Height                                                 = Self.PaintPages.Crop_Bottom       - Self.PaintPages.Crop_Top + 2

    Self.PaintPages.DC                                                          = 0
    Self.PaintPages.DIBHandle                                                   = 0
    Self.PaintPages.PixelMemPtr                                                 = 0
    Self.PaintPages.PixelMemSize                                                = 0
    Self.PaintPages.Normal_Scan0                                                = 0
    Self.PaintPages.Normal_Graphics                                             = 0
    Self.PaintPages.Normal_ImagePtr                                             = 0
    Self.PaintPages.MouseOver_Scan0                                             = 0
    Self.PaintPages.MouseOver_Graphics                                          = 0
    Self.PaintPages.MouseOver_ImagePtr                                          = 0
    Self.PaintPages.Selected_Scan0                                              = 0
    Self.PaintPages.Selected_Graphics                                           = 0
    Self.PaintPages.Selected_ImagePtr                                           = 0
    Self.PaintPages.Disabled_Scan0                                              = 0
    Self.PaintPages.Disabled_Graphics                                           = 0
    Self.PaintPages.Disabled_ImagePtr                                           = 0
    Self.PaintPages.SourceStartRowId                                            = 0
    Self.PaintPages.SourceStartRowIndex                                         = 0
    Self.PaintPages.SourceUntilRowIndex                                         = 0
    Self.PaintPages.SourceUntilRowId                                            = 0
    Self.PaintPages.SourceRowsCount                                             = 0
    Self.PaintPages.SourceRowsRenderedHeight                                    = 0

    Tuple = Self.GdiPlusClass.CreateCanvas(Self.PaintPages.Canvas_Width, Self.PaintPages.Canvas_Height, Self.PaintPages.Normal_Graphics, Self.PaintPages.Normal_ImagePtr, Self.PaintPages.Normal_Scan0, Self.PaintPages.BitmapAllocSize, Self.PaintPages.Stride, Self.PaintPages.PixelFormat, DisplayStateMode:Normal)
    Self.PaintPages.MouseOver_Graphics = Tuple.V1
    Self.PaintPages.MouseOver_ImagePtr = Tuple.V2

    Tuple = Self.GdiPlusClass.CreateCanvas(Self.PaintPages.Canvas_Width, Self.PaintPages.Canvas_Height, Self.PaintPages.MouseOver_Graphics, Self.PaintPages.MouseOver_ImagePtr, Self.PaintPages.MouseOver_Scan0, Self.PaintPages.BitmapAllocSize, Self.PaintPages.Stride, Self.PaintPages.PixelFormat, DisplayStateMode:Hot)
    Self.PaintPages.MouseOver_Graphics = Tuple.V1
    Self.PaintPages.MouseOver_ImagePtr = Tuple.V2

    Tuple = Self.GdiPlusClass.CreateCanvas(Self.PaintPages.Canvas_Width, Self.PaintPages.Canvas_Height, Self.PaintPages.Selected_Graphics, Self.PaintPages.Selected_ImagePtr, Self.PaintPages.Selected_Scan0, Self.PaintPages.BitmapAllocSize, Self.PaintPages.Stride, Self.PaintPages.PixelFormat, DisplayStateMode:Selected)
    Self.PaintPages.Selected_Graphics = Tuple.V1
    Self.PaintPages.Selected_ImagePtr = Tuple.V2

    Tuple = Self.GdiPlusClass.CreateCanvas(Self.PaintPages.Canvas_Width, Self.PaintPages.Canvas_Height, Self.PaintPages.Disabled_Graphics, Self.PaintPages.Disabled_ImagePtr, Self.PaintPages.Disabled_Scan0, Self.PaintPages.BitmapAllocSize, Self.PaintPages.Stride, Self.PaintPages.PixelFormat, DisplayStateMode:Disabled)
    Self.PaintPages.Disabled_Graphics = Tuple.V1
    Self.PaintPages.Disabled_ImagePtr = Tuple.V2

    Add(Self.PaintPages)

    Return 0

c25_TreeViewClass.ResetPaintPages                                   Procedure()

Tuple           Like(Tuple2_TYPE)

Code

    I# = 0
    Loop
        I# = I# + 1
        Get(Self.PaintPages,I#)
        If Errorcode() <> 0
            Break
        End

        If Self.PaintPages.Normal_Graphics <> 0
            C25_Gdipdeletegraphics(Self.PaintPages.Normal_Graphics)
            Self.PaintPages.Normal_Graphics = 0
        End

        If Self.PaintPages.Normal_ImagePtr <> 0
            C25_GdipDisposeImage(Self.PaintPages.Normal_ImagePtr)
            Self.PaintPages.Normal_ImagePtr = 0
        End
        If Self.PaintPages.Normal_Scan0 <> 0
            c25_HeapFree(C25_Getprocessheap(), 0, Self.PaintPages.Normal_Scan0)
            Self.PaintPages.Normal_Scan0 = 0
        End

        If Self.PaintPages.MouseOver_Graphics <> 0
            C25_Gdipdeletegraphics(Self.PaintPages.MouseOver_Graphics)
            Self.PaintPages.MouseOver_Graphics = 0
        End
        If Self.PaintPages.MouseOver_ImagePtr <> 0
            C25_GdipDisposeImage(Self.PaintPages.MouseOver_ImagePtr)
            Self.PaintPages.MouseOver_ImagePtr = 0
        End
        If Self.PaintPages.MouseOver_Scan0 <> 0
            c25_HeapFree(C25_Getprocessheap(), 0, Self.PaintPages.MouseOver_Scan0)
            Self.PaintPages.MouseOver_Scan0 = 0
        End

        If Self.PaintPages.Selected_Graphics <> 0
            C25_Gdipdeletegraphics(Self.PaintPages.Selected_Graphics)
            Self.PaintPages.Selected_Graphics = 0
        End

        If Self.PaintPages.Selected_ImagePtr <> 0
            C25_GdipDisposeImage(Self.PaintPages.Selected_ImagePtr)
            Self.PaintPages.Selected_ImagePtr = 0
        End
        If Self.PaintPages.Selected_Scan0 <> 0
            c25_HeapFree(C25_Getprocessheap(), 0, Self.PaintPages.Selected_Scan0)
            Self.PaintPages.Selected_Scan0 = 0
        End

        If Self.PaintPages.Disabled_Graphics <> 0
            C25_Gdipdeletegraphics(Self.PaintPages.Disabled_Graphics)
            Self.PaintPages.Disabled_Graphics = 0
        End

        If Self.PaintPages.Disabled_ImagePtr <> 0
            C25_GdipDisposeImage(Self.PaintPages.Disabled_ImagePtr)
            Self.PaintPages.Disabled_ImagePtr = 0
        End
        If Self.PaintPages.Disabled_Scan0 <> 0
            c25_HeapFree(C25_Getprocessheap(), 0, Self.PaintPages.Disabled_Scan0)
            Self.PaintPages.Disabled_Scan0 = 0
        End

        Put(Self.PaintPages)
    End
    Free(Self.PaintPages)

    Return 0

