Include('c25_ProgramHandlerClass.inc'),Once


c25TreeNodeClass                                    Class(),type, Module('c25_TreeNodeClass.clw'), Link('c25_TreeNodeClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                               Procedure()
Destruct                                                Procedure()

ProgramHandler                                          &c25ProgramHandlerClass()

!ParentTreeClass                                         &c25TreeClass()
!BitConverter                                            &c25BitConverterClass()
!MsSql                                                   &c25MsSqlClass()
!
!TreeBuffer                                              &TreeNode_TYPE()
!
!TreeRecord                                              &TreeNode_TYPE()
!
!Init                                                    Procedure(*c25TreeClass _c25TreeClass)
!SetFromTreeBuffer                                       Procedure(*TreeNode_TYPE _treeNode, <long _index>)
!UpdateRecord                                            Procedure(<bool _fromDb>, <bool _fromBuffer>, <bool _fromScreen>),string,proc
!TreeBufferIndex                                         long
                                                    End



