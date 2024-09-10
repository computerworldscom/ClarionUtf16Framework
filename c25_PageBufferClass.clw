                        Member

                        Include('c25_PageBufferClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_PageBufferClass.Construct                                       Procedure()

Code
   
    Self.BitConverterClass &= NEW c25_BitConverterClass()
    Self.DataRowsCapacity = Maximum(Self.DataRows,1)
    Self.DataRowsCount = 0
    Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    Self.PageAreaOffsetX = 100
    Self.PageAreaOffsetY = 100
    Self.GuidId = Self.BitConverterClass.CreateGuid36()
    Self.SomeRectF &= NEW RectF_TYPE()
    Self.SomeRectI &= NEW RectI_TYPE()
    Self.ControlRect &= NEW WindowRect_TYPE()
    
!    Self.DataReflectionClass &= NEW c25_DataReflectionClass()
!    Self.ClarionFieldsQ &= NEW ClarionFields_TYPE()
!    !Self.TreeViewNodeMapping &= NEW TreeViewNodeMapping_TYPE()
!    Self.SourceDataColumns &= NEW c25_DataColumnsCollectionClass()
!    
!    !Clear(Self.TreeViewNodeMapSourceArray)

c25_PageBufferClass.Destruct                                        Procedure()

Code

c25_PageBufferClass.Init                                            Procedure(*c25_BindingSourceClass _bindingSourceClass)

Code

    
    Self.BindingSourceClass &= _bindingSourceClass
    Self.ProgramHandlerClass &= Self.BindingSourceClass.ProgramHandlerClass
    Self.ControlType = Self.BindingSourceClass.ControlClass.TypeEnum
    Self.BaseControl &= Self.BindingSourceClass.ControlClass
    
    !Self.GdiPlusClass &= Self.BaseControl.ControlRenderClass.GdiPlusClass
    
    Return 0
    
c25_PageBufferClass.AddNewRow                                       Procedure()

DataRowClass  &c25_DataRowClass

Code

    
    Self.DataRowsCount = Self.DataRowsCount + 1
    If Self.DataRowsCount > Self.DataRowsCapacity
        Message('error Self.DataRowsCount > Self.DataRowsCapacity')
        Return NULL
    End
    DataRowClass &= NEW c25_DataRowClass()
    DataRowClass.PageBufferIndex = Self.DataRowsCount
    Self.DataRows[Self.DataRowsCount] = Address(DataRowClass)

    Return DataRowClass
    

c25_PageBufferClass.DataRowFromIndex                                Procedure(long _index)
                                

Code
    
    Self.DataRow &= NULL
    
    If _index < 1 or _index > Self.DataRowsCapacity
        Return NULL
    End
    If Self.DataRows[_index] = 0
        Return NULL
    End
    
    Self.DataRow &= (Self.DataRows[_index])

    Return Self.DataRow

    
c25_PageBufferClass.SetCanvasSize   Procedure(long _width, long _height)

Code

    If Self.PageAreaWidth <> _width Or Self.PageAreaHeight <> _height
        Self.CanvasReady            = False 
        
        If not Self.BaseControl &= NULL
            Self.ControlRect = Self.BaseControl.ControlRect
        END
        
        Self.PageAreaWidth          = _width
        Self.PageAreaHeight         = _height
        
        Self.CanvasWidth            = Self.PageAreaWidth + 1000
        Self.CanvasHeight           = Self.PageAreaHeight + 200        
        
        Self.CreateCanvas(CanvasState:Normal)
        Self.CreateCanvas(CanvasState:NormalDimmed)
        
        Self.CanvasChanged          = True
        Self.CanvasReady            = True  
    End
    Return 0

    
c25_PageBufferClass.CreateCanvas                                    Procedure(long _canvasState)

CanvasWidth                     Long
CanvasHeight                    Long
CanvasGraphics                  Long
CanvasImagePtr                  Long
CanvasScan0                     Long
CanvasBitmapAllocSize           Long
CanvasStride                    Long
CanvasPixelFormat               Long

OldCanvasGraphics               Long
OldCanvasImagePtr               Long
OldCanvasScan0                  Long
OldCanvasBitmapAllocSize        Long
OldCanvasStride                 Long


Code


    OldCanvasGraphics               = Self.CanvasGraphics[_canvasState]
    OldCanvasImagePtr               = Self.CanvasImagePtr[_canvasState]
    OldCanvasScan0                  = Self.CanvasScan0[_canvasState]
    OldCanvasBitmapAllocSize        = Self.CanvasBitmapAllocSize[_canvasState]
    OldCanvasStride                 = Self.CanvasStride[_canvasState]

    CanvasWidth                     = Self.CanvasWidth
    CanvasHeight                    = Self.CanvasHeight
    CanvasGraphics                  = 0
    CanvasImagePtr                  = 0
    CanvasScan0                     = 0
    CanvasBitmapAllocSize           = 0
    CanvasStride                    = 0
    CanvasPixelFormat               = 0

    Case _canvasState
    Of CanvasState:Normal
        !Message('CanvasState:Normal')
        Self.GdiPlusClass.CreateCanvas(CanvasWidth, CanvasHeight, CanvasGraphics, CanvasImagePtr, CanvasScan0, CanvasBitmapAllocSize, CanvasStride, CanvasPixelFormat, DisplayStateMode:Buffer, Self.GdiPlusClass.GetColorMacro(255,245,245,245) )
    Of CanvasState:NormalDimmed
        !Message('CanvasState:NormalDimmed')
        Self.GdiPlusClass.CreateCanvas(CanvasWidth, CanvasHeight, CanvasGraphics, CanvasImagePtr, CanvasScan0, CanvasBitmapAllocSize, CanvasStride, CanvasPixelFormat, DisplayStateMode:Buffer, Self.GdiPlusClass.GetColorMacro(255,205,205,205) )
    End

    !Self.GdiPlusClass.CreateCanvas(CanvasWidth, CanvasHeight, CanvasGraphics, CanvasImagePtr, CanvasScan0, CanvasBitmapAllocSize, CanvasStride, CanvasPixelFormat, DisplayStateMode:Buffer, Self.GdiPlusClass.GetColorMacro(255,255,155,255) )

    Self.CanvasGraphics[_canvasState]           = CanvasGraphics
    Self.CanvasImagePtr[_canvasState]           = CanvasImagePtr
    Self.CanvasScan0[_canvasState]              = CanvasScan0
    Self.CanvasBitmapAllocSize[_canvasState]    = CanvasBitmapAllocSize
    Self.CanvasStride[_canvasState]             = CanvasStride
    Self.CanvasPixelFormat[_canvasState]        = CanvasPixelFormat


    If OldCanvasGraphics <> 0 And OldCanvasImagePtr <> 0 And OldCanvasScan0 <> 0 And OldCanvasBitmapAllocSize <> 0
        Self.GdiPlusClass.DeleteCanvas(OldCanvasGraphics, OldCanvasImagePtr, OldCanvasScan0, OldCanvasBitmapAllocSize)
    End
    
    Self.RenderBackground(_canvasState)
    Self.RenderRowsBackground(_canvasState)
    
    Self.Paint(_canvasState) ! for debug only
    
    Return 0
    
    
c25_PageBufferClass.RenderBackground   Procedure(long _canvasState)

CODE
    
    
    If Self.CanvasGraphics[_canvasState] = 0
        Return 0
    End
    
    Self.GdiPlusClass.NewSolidBrush(Self.SomeBrush, ,255, Random(0,255), 232, 255)

    !LineHeight = 21
    !XOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
    !YOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Top

    Self.SomeRectI.Left     = Self.PageAreaOffsetX + 1
    Self.SomeRectI.Top      = Self.PageAreaOffsetY + 1
    Self.SomeRectI.Right    = Self.PageAreaOffsetX + Self.PageAreaWidth
    Self.SomeRectI.Bottom   = Self.PageAreaOffsetY + Self.PageAreaHeight
    Self.SomeRectI.Width    = Self.PageAreaWidth
    Self.SomeRectI.Height   = Self.PageAreaHeight

    c25_GdipFillRectangleI(Self.CanvasGraphics[_canvasState], Self.SomeBrush, Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)  
    
    
    Return 0    
    
c25_PageBufferClass.Paint   Procedure(long _canvasState)

CODE
    
    
    If Self.CanvasGraphics[_canvasState] = 0
        Return 0
    End
    
    Self.GdiPlusClass.NewSolidBrush(Self.SomeBrush, ,255, Random(0,255), 232, 255)

    !LineHeight = 21
    !XOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
    !YOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Top

    Self.SomeRectI.Left     = Self.PageAreaOffsetX + 1
    Self.SomeRectI.Top      = Self.PageAreaOffsetY + 1
    Self.SomeRectI.Right    = Self.PageAreaOffsetX + Self.PageAreaWidth
    Self.SomeRectI.Bottom   = Self.PageAreaOffsetY + Self.PageAreaHeight
    Self.SomeRectI.Width    = Self.PageAreaWidth
    Self.SomeRectI.Height   = Self.PageAreaHeight

    c25_GdipFillRectangleI(Self.CanvasGraphics[_canvasState], Self.SomeBrush, Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)  
    
    
    Return 0
    
    