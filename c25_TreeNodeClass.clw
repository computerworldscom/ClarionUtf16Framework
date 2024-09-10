    Member


    Map
        Include('i64.inc')
        Include('cwutil.inc')
        Include('c25_WinApiPrototypes.clw')
    End

    Include('c25_TreeNodeClass.inc'),ONCE

c25TreeNodeClass.Construct                          Procedure()

SomeLong    Long

Code

    Self.ProgramHandler &= New c25ProgramHandlerClass()
    Self.ProgramHandler &= Self.ProgramHandler.Singleton.GetPointer()
    Self.ProgramHandler.Singleton.Start()
!    Self.TreeRecord &= NEW TreeNode_TYPE()


c25TreeNodeClass.Destruct                           Procedure()

Code

!!    
!!c25TreeNodeClass.Init                               Procedure(*c25TreeClass _c25TreeClass)
!!
!!Code
!!
!!    Self.ParentTreeClass &= _c25TreeClass
!!    
!!    Self.BitConverter       &= Self.ParentTreeClass.BitConverter
!!    Self.MsSql              &= Self.ParentTreeClass.MsSql
!!    Self.TreeBuffer         &= Self.ParentTreeClass.TreeBuffer
!!
!!c25TreeNodeClass.SetFromTreeBuffer                  Procedure(*TreeNode_TYPE _treeNode, <long _index>)
!!
!!Code
!!    
!!    Self.TreeRecord = _treeNode
!!    Self.TreeBufferIndex = _index
!!    Self.UpdateRecord(true)
!!    
!!    
!!c25TreeNodeClass.UpdateRecord       Procedure(<bool _fromDb>, <bool _fromBuffer>, <bool _fromScreen>)    
!!
!!Temp   &string
!!
!!Code
!!        
!!    If _fromDb = TRUE
!!
!!!        If Self.TreeBuffer &= null
!!!            Message('error')
!!!        End
!!!        Get(Self.TreeBuffer,Self.TreeBufferIndex)
!!!        If Errorcode() = 0
!!!            If not Self.TreeBuffer.Text &= null
!!!                Temp &= Self.TreeBuffer.Text
!!!            End
!!!            Self.TreeBuffer.Text &= Self.BitConverter.BinaryCopy('noujazeg')
!!!            
!!!            !Self.MsSql.
!!!            
!!!            Self.TreeBuffer.Synced = FALSE ! per field? todo
!!!            Put(Self.TreeBuffer)
!!!            
!!!            If not Temp &= null
!!!                Dispose(Temp)
!!!            End
!!!        End
!!    End
!!    Return 0
!!    
!!    
!!    