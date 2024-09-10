        Member

            Include('c25_UserClass.inc'),once
            Include('c25_Sqlite34Class.inc'),once
            Include('c25_NanoSyncClass.inc'),once
            Include('c25_TrueReflectionClass.inc'),once
            Include('c25_WinApi32Class.inc'),once
            Include('c25_WinNT_Errorcode_Equates.clw'),ONCE

            Include('windows.inc'),once
            Map
            End

UserClass.Destruct                      Procedure()

    Code

UserClass.Construct                     Procedure()

    Code

        Self.Buffer &= NULL
        Self.CRLF = Chr(13) & Chr(10)
        Self.js1 &= NEW JSONClass()
        Self.NanoClock &= NEW NanoSyncClass()
        Self.ReflectionCapesoft &= NEW ReflectClass()
        Self.Sqlite34 &= NEW Sqlite34Class()
        Self.st1 &= NEW StringTheory()
        Self.st2 &= NEW StringTheory()
        Self.st3 &= NEW StringTheory()
        Self.st4 &= NEW StringTheory()
        Self.st5 &= NEW StringTheory()
        Self.WinApi &= NEW WinApi32Class()
        Self.Zero = Chr(0)
        Self.Zero2 = Chr(0) & Chr(0)
        Self.LargeTree &= NEW LargeTree_TYPE()
        Self.ClarionFieldsLargeTree  &= NEW ClarionFields_TYPE()
        Clear(Self.LargeTree)
        Add(Self.LargeTree)
        Self.TrueReflection &= NEW TrueReflectionClass()
        Self.TrueReflection.Analyze(Self.LargeTree,Self.ClarionFieldsLargeTree)
        Free(Self.LargeTree)

UserClass.Init                          Procedure(<Long _userId>)

    Code

        Return 0

UserClass.DetectDeviceRootInstance      Procedure()

    Code

        Self.DeviceRootInstance = 0
        If not Self.MachineObjectTEMP &= NULL
            If not Self.MachineObjectTEMP.Devices &= null
                I# = 0
                Loop
                    I# = I# + 1
                    Get(Self.MachineObjectTEMP.Devices,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Self.MachineObjectTEMP.Devices.ParentInstance = 0
                        Self.DeviceRootInstance = Self.MachineObjectTEMP.Devices.Instance
                        Break
                    End
                End
            End
        End
        Return Self.DeviceRootInstance

UserClass.AddMachineToUserTree          Procedure(Long _machineObjectPtr, Long _startLevel, Long _parentNodeId)

Level                                   Long

    Code

        Clear(Self.LargeTree)
        If _machineObjectPtr = 0
            Return Self.LargeTree
        End
        Level = _startLevel
        Self.MachineObjectTEMP &= (_machineObjectPtr)
        Self.MachineId = Self.MachineObjectTEMP.Id
        Self.DetectDeviceRootInstance()
        If Len(Clip(Self.MachineObjectTEMP.BiosPage002.Manufacturer)) > 0
            If Len(Clip(Self.MachineObjectTEMP.BiosPage002.Product)) > 0
                If Len(Clip(Self.MachineObjectTEMP.BiosPage002.Serial)) > 0
                    Self.LargeTree.LineAnsi &= Self.WinApi.AnsiToAnsi(Self.MachineObjectTEMP.BiosPage002.Manufacturer & ', ' & Self.MachineObjectTEMP.BiosPage002.Product & ', ' & Self.MachineObjectTEMP.BiosPage002.Serial)
                Else
                    Self.LargeTree.LineAnsi &= Self.WinApi.AnsiToAnsi(Self.MachineObjectTEMP.BiosPage002.Manufacturer & ', ' & Self.MachineObjectTEMP.BiosPage002.Product)
                End
            Else
                Self.LargeTree.LineAnsi &= Self.WinApi.AnsiToAnsi(Self.MachineObjectTEMP.BiosPage002.Manufacturer)
            End

            If not Self.MachineObjectTEMP.WinObject &= NULL
            End

            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = Self.MachineId
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level
            Self.LargeTree.LineIconId       = 101
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.RowIdSource      = Self.MachineObjectTEMP.Id
            Self.LargeTree.NodeType         = NodeType:MachinesHeaderTitle
            Self.LargeTree.SectionType      = UserTreeSection:RootHeader
            Add(Self.LargeTree)
            Self.CreateUserTreeSection(UserTreeSection:ChildMachineHeaders, Level+1, Self.LargeTree.NodeId)

            I# = 0
            R# = Records(Self.LargeTree)
            LOOP R# Times
                I# = I#  + 1
                Get(Self.LargeTree,I#)
                If Self.LargeTree.LineIconId <> 0
                    CYCLE
                End

                Get(Self.LargeTree,I#+1)
                L# = Self.LargeTree.LineLevel
                Get(Self.LargeTree,I#)
                If L# > Self.LargeTree.LineLevel
                    Self.LargeTree.LineIconId = 2
                    Self.LargeTree.HasChildren = True
                Else
                    Self.LargeTree.LineIconId = 1
                    Self.LargeTree.HasChildren = 0
                End
                Put(Self.LargeTree)
            End
        End
        Return Self.LargeTree

UserClass.CreateUserTreeSection         Procedure(Long _userTreeSection, Long _startLevel, Long _parentNodeId)

Level                                   Long

Devices &Device_TYPE

    Code

        Clear(Self.LargeTree)
        Level = _startLevel
        Case _userTreeSection
        Of UserTreeSection:Header
            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Machines')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.NodeType         = NodeType:MachinesHeaderTitle
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)
        Of UserTreeSection:ChildMachineHeaders
            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Bios')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level
            Self.LargeTree.LineIconId       = 103
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.NodeType         = NodeType:BiosHeaderTitle
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)
            Self.AddBiosToTree(DevicesGroupType:All, Level)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Devices')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.NodeType         = NodeType:DevicesHeaderTitle
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)

            Self.AddDeviceToTree(DevicesGroupType:AllWithoutVolumeManager, Level)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Volume Manager')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.NodeType         = NodeType:DevicesHeaderTitle
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)
            Self.AddDeviceToTree(DevicesGroupType:VolumeManager, Level, true)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Microsoft Virtual Drive Enumerator')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)
            Self.AddDeviceToTree(DevicesGroupType:MicrosoftVirtualDriveEnumerator, Level, true)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Microsoft iSCSI Initiator')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)
            Self.AddDeviceToTree(DevicesGroupType:MicrosoftiSCSIInitiator, Level, true)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Microsoft Storage Spaces Controller')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)
            Self.AddDeviceToTree(DevicesGroupType:MicrosoftStorageSpacesController, Level, true)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Microsoft Hyper-V Virtual Disk Server')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)
            Self.AddDeviceToTree(DevicesGroupType:MicrosoftHyperVVirtualDiskServer, Level, true)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('Harddisks')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.NodeType         = NodeType:HarddisksHeaderTitle
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)

            Clear(Self.LargeTree)
            Self.LargeTree.LineAnsi        &= Self.WinApi.AnsiToAnsi('WinObjects')
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = Level * -1
            Self.LargeTree.LineIconId       = 2
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.NodeType         = NodeType:HarddisksHeaderTitle
            Self.LargeTree.SectionType      = _userTreeSection
            Add(Self.LargeTree)

            Self.AddWinObjectToTree(Level)

        End
        Return Self.LargeTree
        
UserClass.AddWinObjectToTree            Procedure(Long _level)

    Code

        StartLargeTreePointer# = Pointer(Self.LargeTree)
        Counter# = 0
        Self.WinObjectRootThisId = 1
        If not Self.MachineObjectTEMP &= null
            If not Self.MachineObjectTEMP.WinObject &= null
                If not Self.WinObjTEMP &= null
                    Dispose(Self.WinObjTEMP)
                End
                Self.WinObjTEMP &= NEW WinObject_TYPE

                If not Self.DictWinObjectTypes &= null
                    Dispose(Self.DictWinObjectTypes)
                End
                Self.DictWinObjectTypes &= NEW Dictionary_TYPE

                I# = 0
                Loop
                    I# = I# + 1
                    Get(Self.MachineObjectTEMP.WinObject,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    Self.WinObjTEMP = Self.MachineObjectTEMP.WinObject
                    Add(Self.WinObjTEMP)

                    Self.WinApi.DictAddKeyValue(Self.DictWinObjectTypes, Self.WinObjTEMP.Type, '')
                End

                I# = 0
                Loop
                    I# = I# + 1
                    Get(Self.WinObjTEMP,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Self.WinObjTEMP.InTree = TRUE
                        CYCLE
                    End
                    If Self.WinObjTEMP.ParentId <> Self.WinObjectRootThisId
                        CYCLE
                    End
                    Counter# = Counter# + 1
                    Self.AddWinObjectTEMPInTree(Self.LargeTree.NodeId, _level + 1)
                    R# = Self.RecursiveAddChildWinObject(Self.LargeTree.NodeId, Self.WinObjTEMP.ThisId, _level + 2)
                    Get(Self.WinObjTEMP,I#)
                    Self.WinObjTEMP.InTree = TRUE
                    Put(Self.WinObjTEMP)
                End
            End
        End

        I# = StartLargeTreePointer#
        LOOP
            I# = I#  + 1
            Get(Self.LargeTree,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.LargeTree.LineIconId <> 0
                CYCLE
            End

            Get(Self.LargeTree,I#+1)
            L# = Self.LargeTree.LineLevel
            Get(Self.LargeTree,I#)
            If L# > Self.LargeTree.LineLevel
                Self.LargeTree.LineIconId = 2
                Self.LargeTree.HasChildren = True
                Self.LargeTree.LineLevel = Self.LargeTree.LineLevel * -1
            Else
                Self.LargeTree.LineIconId = 1
                Self.LargeTree.HasChildren = 0
            End
            Put(Self.LargeTree)
        End

        Return 0
        
UserClass.RecursiveAddChildWinObject    Procedure(Long _parentNodeId, Long _parentId, Long _level)

Level   Long
Found   Byte
stLog   &StringTheory

    Code

        Level = _level
        I# = 0
        Loop !1 Times
            I# = I# + 1
            Get(Self.WinObjTEMP,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.WinObjTEMP.InTree = TRUE
                CYCLE
            End
            If Self.WinObjTEMP.ParentId <> _parentId
                CYCLE
            End
            Found = TRUE
            Self.AddWinObjectTEMPInTree(_parentNodeId, Level)
            T# = Records(Self.WinObjTEMP)
            X# = 0
            Loop 100000 Times
                X# = X# + 1
                R# = Self.RecursiveAddChildWinObject(Self.LargeTree.NodeId, Self.WinObjTEMP.ThisId, _level + 1)
                If R# = 0
                    BREAK
                End
            End
        End
        Return Found
UserClass.GetWinObjectTypeByThisId      Procedure(*WinObject_TYPE _winObj, Long _thisId)

    Code

        If _winObj &= NULL
            Return 0
        End
        P# = Pointer(_winObj)
        I# = 0
        Loop
            I# = I# + 1
            Get(_winObj,I#)
            If Errorcode() <> 0
                BREAK
            End
            If _winObj.ThisId <> _thisId
                CYCLE
            End
            Get(_winObj,P#)
            Return _winObj.Type
        End
        Get(_winObj,P#)
        Return ''
UserClass.AddWinObjectTEMPInTree        Procedure(Long _parentNodeId, Long _level)

    Code

        P# = Pointer(Self.WinObjTEMP)
        Self.WinObjTEMP.InTree = TRUE
        Put(Self.WinObjTEMP)

        If Self.LastWinObjectParentId <> Self.WinObjTEMP.ParentId
            Self.LastWinObjectParentId      = Self.WinObjTEMP.ParentId

            If Self.GetWinObjectTypeByThisId(Self.WinObjTEMP, Self.WinObjTEMP.ThisId) = 'Directory'
                Self.LargeTree.Name            &= Self.WinApi.BinaryCopy(Upper(Clip(Self.WinObjTEMP.NameAnsi)))
                Self.LargeTree.LineAnsi        &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.NameAnsi)

                Self.LargeTree.NodeId           = Self.NewNodeId()
                Self.LargeTree.NodeParentId     = _parentNodeId
                Self.LargeTree.MachineId        = 0
                Self.LargeTree.Tag1StyleId      = 0
                Self.LargeTree.Tag2StyleId      = 1000
                Self.LargeTree.LineLevel        = _level
                Self.LargeTree.LineIconId       = 0
                Self.LargeTree.LineStyleId      = 1
                Self.LargeTree.NodeType         = 0
                Self.LargeTree.SectionType      = 0
                Self.LargeTree.RowIdSource      = Self.WinObjTEMP.Id
                Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                Add(Self.LargeTree)

                Self.ParentWinObjectNameAnsi    &= Self.WinApi.BinaryCopy(Self.LargeTree.LineAnsi)
            Else
                Self.LargeTree.LineAnsi        &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.Type)
                Self.LargeTree.Name            &= Self.WinApi.BinaryCopy(Upper(Clip(Self.WinObjTEMP.Type)))

                Self.LargeTree.NodeId           = Self.NewNodeId()
                Self.LargeTree.NodeParentId     = _parentNodeId
                Self.LargeTree.MachineId        = 0
                Self.LargeTree.Tag1StyleId      = 0
                Self.LargeTree.Tag2StyleId      = 1000
                Self.LargeTree.LineLevel        = _level
                Self.LargeTree.LineIconId       = 0
                Self.LargeTree.LineStyleId      = 1
                Self.LargeTree.NodeType         = 0
                Self.LargeTree.SectionType      = 0
                Self.LargeTree.RowIdSource      = Self.WinObjTEMP.Id
                Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                Add(Self.LargeTree)

                Self.ParentWinObjectNameAnsi    &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.Type)

                Self.LargeTree.Name            &= Self.WinApi.BinaryCopy(Upper(Clip(Self.WinObjTEMP.NameAnsi)))
                Self.LargeTree.LineAnsi        &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.NameAnsi)
                Self.LargeTree.NodeId           = Self.NewNodeId()
                Self.LargeTree.NodeParentId     = _parentNodeId
                Self.LargeTree.MachineId        = 0
                Self.LargeTree.Tag1StyleId      = 0
                Self.LargeTree.Tag2StyleId      = 1000
                Self.LargeTree.LineLevel        = _level + 1
                Self.LargeTree.LineIconId       = 0
                Self.LargeTree.LineStyleId      = 1
                Self.LargeTree.NodeType         = 0
                Self.LargeTree.SectionType      = 0
                Self.LargeTree.RowIdSource      = Self.WinObjTEMP.Id
                Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                Add(Self.LargeTree)

                If not Self.WinObjTEMP.SymbolicLink &= NULL
                    If Len(Clip(Self.WinObjTEMP.SymbolicLink)) > 0
                        Self.LargeTree.LineAnsi        &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.SymbolicLink)
                        Self.LargeTree.Name            &= Self.WinApi.BinaryCopy(Upper(Clip(Self.WinObjTEMP.SymbolicLink)))
                        Self.LargeTree.NodeId           = Self.NewNodeId()
                        Self.LargeTree.NodeParentId     = _parentNodeId
                        Self.LargeTree.MachineId        = 0
                        Self.LargeTree.Tag1StyleId      = 0
                        Self.LargeTree.Tag2StyleId      = 1000
                        Self.LargeTree.LineLevel        = _level + 2
                        Self.LargeTree.LineIconId       = 0
                        Self.LargeTree.LineStyleId      = 1
                        Self.LargeTree.NodeType         = 0
                        Self.LargeTree.SectionType      = 0
                        Self.LargeTree.RowIdSource      = Self.WinObjTEMP.Id
                        Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                        Add(Self.LargeTree)
                    End
                End
            End
        Else
            If Self.ParentWinObjectNameAnsi <> Self.WinApi.BinaryCopy(Self.WinObjTEMP.Type) And Self.WinObjTEMP.Type <> 'Directory'
                Self.LargeTree.LineAnsi        &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.Type)
                Self.LargeTree.Name            &= Self.WinApi.BinaryCopy(Upper(Clip(Self.WinObjTEMP.Type)))

                Self.LargeTree.NodeId           = Self.NewNodeId()
                Self.LargeTree.NodeParentId     = _parentNodeId
                Self.LargeTree.MachineId        = 0
                Self.LargeTree.Tag1StyleId      = 0
                Self.LargeTree.Tag2StyleId      = 1000
                Self.LargeTree.LineLevel        = _level
                Self.LargeTree.LineIconId       = 0
                Self.LargeTree.LineStyleId      = 1
                Self.LargeTree.NodeType         = 0
                Self.LargeTree.SectionType      = 0
                Self.LargeTree.RowIdSource      = Self.WinObjTEMP.Id
                Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                Add(Self.LargeTree)

                Self.ParentWinObjectNameAnsi    &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.Type)
            End

            Self.LargeTree.Name            &= Self.WinApi.BinaryCopy(Upper(Clip(Self.WinObjTEMP.NameAnsi)))
            Self.LargeTree.LineAnsi        &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.NameAnsi)
            Self.LargeTree.NodeId           = Self.NewNodeId()
            Self.LargeTree.NodeParentId     = _parentNodeId
            Self.LargeTree.MachineId        = 0
            Self.LargeTree.Tag1StyleId      = 0
            Self.LargeTree.Tag2StyleId      = 1000
            Self.LargeTree.LineLevel        = _level + 1
            Self.LargeTree.LineIconId       = 0
            Self.LargeTree.LineStyleId      = 1
            Self.LargeTree.NodeType         = 0
            Self.LargeTree.SectionType      = 0
            Self.LargeTree.RowIdSource      = Self.WinObjTEMP.Id
            Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
            Add(Self.LargeTree)

            If not Self.WinObjTEMP.SymbolicLink &= NULL
                If Len(Clip(Self.WinObjTEMP.SymbolicLink)) > 0
                    Self.LargeTree.LineAnsi        &= Self.WinApi.BinaryCopy(Self.WinObjTEMP.SymbolicLink)
                    Self.LargeTree.Name            &= Self.WinApi.BinaryCopy(Upper(Clip(Self.WinObjTEMP.SymbolicLink)))
                    Self.LargeTree.NodeId           = Self.NewNodeId()
                    Self.LargeTree.NodeParentId     = _parentNodeId
                    Self.LargeTree.MachineId        = 0
                    Self.LargeTree.Tag1StyleId      = 0
                    Self.LargeTree.Tag2StyleId      = 1000
                    Self.LargeTree.LineLevel        = _level + 2
                    Self.LargeTree.LineIconId       = 0
                    Self.LargeTree.LineStyleId      = 1
                    Self.LargeTree.NodeType         = 0
                    Self.LargeTree.SectionType      = 0
                    Self.LargeTree.RowIdSource      = Self.WinObjTEMP.Id
                    Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                    Add(Self.LargeTree)
                End
            End
        End

        Return 0
UserClass.AddDeviceToTree               Procedure(Long _devicesGroupType, Long _level, <Byte _attachOnlyChildren>)

    Code

        Self.TopTreeBrancheType = 0
        If not Self.MachineObjectTEMP &= null
            If not Self.MachineObjectTEMP.Devices &= null
                If not Self.DevicesTEMP &= null
                    Dispose(Self.DevicesTEMP)
                End
                Self.DevicesTEMP &= NEW Device_TYPE

                I# = 0
                Loop
                    I# = I# + 1
                    Get(Self.MachineObjectTEMP.Devices,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    Self.DevicesTEMP = Self.MachineObjectTEMP.Devices
                    Add(Self.DevicesTEMP)
                End

                I# = 0
                Loop
                    I# = I# + 1
                    Get(Self.DevicesTEMP,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Self.DevicesTEMP.InTree = TRUE
                        CYCLE
                    End
                    If Self.DevicesTEMP.ParentInstance <> Self.DeviceRootInstance
                        CYCLE
                    End
                    If Self.DevicesTEMP.ParentInstance = Self.DeviceRootInstance
                        Self.TopTreeBrancheType = Self.DetectTreeBrancheType()
                    End
                    If omitted(_attachOnlyChildren) = False And _attachOnlyChildren = True
                        R# = Self.RecursiveAddChildDevice(Self.LargeTree.NodeId, Self.DevicesTEMP.Instance, _level + 1 , _devicesGroupType)
                    ELSE
                        Self.AddDeviceTEMPInTree(Self.LargeTree.NodeId, _level + 1, _devicesGroupType)
                        R# = Self.RecursiveAddChildDevice(Self.LargeTree.NodeId, Self.DevicesTEMP.Instance, _level + 2 , _devicesGroupType)
                    End
                    Get(Self.DevicesTEMP,I#)
                    Self.DevicesTEMP.InTree = TRUE
                    Put(Self.DevicesTEMP)
                End
            End
        End

        Return 0

UserClass.AddDeviceTEMPInTree           Procedure(Long _parentNodeId, Long _level, Long _devicesGroupType)

    Code

            Self.DevicesTEMP.InTree = TRUE
            Put(Self.DevicesTEMP)
            Clear(Self.LargeTree)
            If not Self.DevicesTEMP.FriendlyNameAnsi &= null
                Self.LargeTree.LineAnsi &= Self.WinApi.AnsiToAnsi(Self.DevicesTEMP.FriendlyNameAnsi)
                Self.LargeTree.Name &= Self.WinApi.AnsiToAnsi(Upper(Clip(Self.DevicesTEMP.FriendlyNameAnsi)))
            Else
                If not Self.MachineObjectTEMP.DPK_DeviceDesc &= null
                    I2# = 0
                    Loop
                        I2# = I2# + 1
                        Get(Self.MachineObjectTEMP.DPK_DeviceDesc,I2#)
                        If Errorcode() <> 0
                            BREAK
                        End
                        If Self.MachineObjectTEMP.DPK_DeviceDesc.DeviceInstance <> Self.DevicesTEMP.Instance
                            Cycle
                        End
                        If not Self.MachineObjectTEMP.DPK_DeviceDesc.ValueAnsi &= null
                            Self.LargeTree.LineAnsi &= Self.WinApi.AnsiToAnsi(Self.MachineObjectTEMP.DPK_DeviceDesc.ValueAnsi)
                            Self.LargeTree.Name &= Self.WinApi.AnsiToAnsi(Upper(Clip(Self.MachineObjectTEMP.DPK_DeviceDesc.ValueAnsi)))
                            BREAK
                        End
                    End
                End
            End
            Self.FilterSkip = 0
            If omitted(_devicesGroupType) = False
                If Self.FilterOnDevicesGroupType(_devicesGroupType) = False
                    Self.FilterSkip = True
                End
            End
            If Self.FilterSkip = 0
                Self.LargeTree.NodeId           = Self.NewNodeId()
                Self.LargeTree.NodeParentId     = _parentNodeId
                Self.LargeTree.MachineId        = 0
                Self.LargeTree.Tag1StyleId      = 0
                Self.LargeTree.Tag2StyleId      = 1000
                Self.LargeTree.LineLevel        = _level
                Self.LargeTree.LineIconId       = 0
                Self.LargeTree.LineStyleId      = 1
                Self.LargeTree.NodeType         = 0
                Self.LargeTree.SectionType      = 0
                Self.LargeTree.RowIdSource      = Self.DevicesTEMP.Id
                Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                Self.LargeTree.DeviceInstance   = Self.DevicesTEMP.Instance
                Self.LargeTree.NodeType         = NodeType:Device
                Add(Self.LargeTree)
            End
            Return 0
UserClass.RecursiveAddChildDevice       Procedure(Long _parentNodeId, Long _parentInstance, Long _level, <Long _devicesGroupType>)

Level   Long
Found   Byte
stLog   &StringTheory

    Code

        Level = _level
        I# = 0
        Loop
            I# = I# + 1
            Get(Self.DevicesTEMP,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.DevicesTEMP.InTree = TRUE
                CYCLE
            End
            If Self.DevicesTEMP.ParentInstance <> _parentInstance
                CYCLE
            End
            Found = TRUE
            Self.AddDeviceTEMPInTree(_parentNodeId, Level, _devicesGroupType)

            Loop 100000 Times
                If omitted(_devicesGroupType) = False
                    R# = Self.RecursiveAddChildDevice(Self.LargeTree.NodeId, Self.DevicesTEMP.Instance, Level + 1, _devicesGroupType)
                ELSE
                    R# = Self.RecursiveAddChildDevice(Self.LargeTree.NodeId, Self.DevicesTEMP.Instance, Level + 1)
                End
                If R# = 0
                    BREAK
                End
            End
        End
        Return Found
UserClass.DetectTreeBrancheType         Procedure()

stLog     &StringTheory

    Code

        If not Self.LineAnsiUpper &= null
            Dispose(Self.LineAnsiUpper)
        End
        If not Self.LineAnsi &= null
            Dispose(Self.LineAnsi)
        End

        If not Self.DevicesTEMP.FriendlyNameAnsi &= null
            Self.LineAnsiUpper &= Self.WinApi.BinaryCopy(Upper(Clip(Self.DevicesTEMP.FriendlyNameAnsi)))
            Self.LineAnsi &= Self.WinApi.BinaryCopy(Clip(Self.DevicesTEMP.FriendlyNameAnsi))
        Else
            If not Self.MachineObjectTEMP.DPK_DeviceDesc &= null
                I2# = 0
                Loop
                    I2# = I2# + 1
                    Get(Self.MachineObjectTEMP.DPK_DeviceDesc,I2#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Self.MachineObjectTEMP.DPK_DeviceDesc.DeviceInstance <> Self.DevicesTEMP.Instance
                        Cycle
                    End
                    If not Self.MachineObjectTEMP.DPK_DeviceDesc.ValueAnsi &= null
                        Self.LineAnsiUpper &= Self.WinApi.BinaryCopy(Upper(Clip(Self.MachineObjectTEMP.DPK_DeviceDesc.ValueAnsi)))
                        Self.LineAnsi &= Self.WinApi.BinaryCopy(Clip(Self.MachineObjectTEMP.DPK_DeviceDesc.ValueAnsi))
                        BREAK
                    End
                End
            End
        End
        If not Self.LineAnsiUpper &= null

            Case Self.LineAnsiUpper
            Of 'VOLUME MANAGER'
                Return TreeBrancheType:VolumeManager
            Of 'MICROSOFT VIRTUAL DRIVE ENUMERATOR'
                Return TreeBrancheType:MicrosoftVirtualDriveEnumerator
            Of 'MICROSOFT ISCSI INITIATOR'
                Return TreeBrancheType:MicrosoftiSCSIInitiator
            Of 'MICROSOFT STORAGE SPACES CONTROLLER'
                Return TreeBrancheType:MicrosoftStorageSpacesController
            Of 'MICROSOFT HYPER-V VIRTUAL DISK SERVER'
                Return TreeBrancheType:MicrosoftHyperVVirtualDiskServer
            ELSE
                Return TreeBrancheType:Unknown
            End
        End

        Return 0
UserClass.FilterOnDevicesGroupType      Procedure(Long _devicesGroupType)

stLog  &StringTheory

    Code

        Case _devicesGroupType
        Of DevicesGroupType:All
            Return True
        Of DevicesGroupType:AllWithoutVolumeManager
            Case Self.TopTreeBrancheType
            Of TreeBrancheType:VolumeManager
                Return False
            End
        Of DevicesGroupType:VolumeManager
            Case Self.TopTreeBrancheType
            Of TreeBrancheType:VolumeManager
                Return True
            Else
                Return False
            End
        Of DevicesGroupType:MicrosoftVirtualDriveEnumerator
            Case Self.TopTreeBrancheType
            Of TreeBrancheType:MicrosoftVirtualDriveEnumerator
                Return True
            Else
                Return False
            End
        Of DevicesGroupType:MicrosoftiSCSIInitiator
            Case Self.TopTreeBrancheType
            Of TreeBrancheType:MicrosoftiSCSIInitiator
                Return True
            Else
                Return False
            End
        Of DevicesGroupType:MicrosoftStorageSpacesController
            Case Self.TopTreeBrancheType
            Of TreeBrancheType:MicrosoftStorageSpacesController
                Return True
            Else
                Return False
            End
        Of DevicesGroupType:MicrosoftHyperVVirtualDiskServer
            Case Self.TopTreeBrancheType
            Of TreeBrancheType:MicrosoftHyperVVirtualDiskServer
                Return True
            Else
                Return False
            End
        Of DevicesGroupType:StorageRelated
        Of DevicesGroupType:USB
        End
        Return True
UserClass.NewNodeId                     Procedure()

    Code

    Self.CurrentNodeId = Self.CurrentNodeId + 1
        Return Self.CurrentNodeId

UserClass.AddBiosToTree                 Procedure(Long _devicesGroupType, Long _level, <Byte _attachOnlyChildren>)

    Code

        StartLargeTreePointer# = Pointer(Self.LargeTree)
        Counter# = 0
        Self.WinObjectRootThisId = 1
        If not Self.MachineObjectTEMP &= null
            If not Self.MachineObjectTEMP.BiosBoardCpu &= null
                If not Self.BiosTEMP &= null
                    Dispose(Self.BiosTEMP)
                End
                Self.BiosTEMP &= NEW BiosBoardCpu_TYPE

                I# = 0
                Loop
                    I# = I# + 1
                    Get(Self.MachineObjectTEMP.BiosBoardCpu,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    Self.BiosTEMP = Self.MachineObjectTEMP.BiosBoardCpu
                    Add(Self.BiosTEMP)
                End

                I# = 0
                Loop
                    I# = I# + 1
                    Get(Self.BiosTEMP,I#)
                    If Errorcode() <> 0
                        BREAK
                    End
                    If Self.BiosTEMP.InTree = TRUE
                        CYCLE
                    End
                    Counter# = Counter# + 1
                    Self.AddBiosTEMPInTree(Self.LargeTree.NodeId, _level + 1)

                    Get(Self.BiosTEMP,I#)
                    Self.BiosTEMP.InTree = TRUE
                    Put(Self.BiosTEMP)
                End
            End
        End

        I# = StartLargeTreePointer#
        LOOP
            I# = I#  + 1
            Get(Self.LargeTree,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.LargeTree.LineIconId <> 0
                CYCLE
            End

            Get(Self.LargeTree,I#+1)
            L# = Self.LargeTree.LineLevel
            Get(Self.LargeTree,I#)
            If L# > Self.LargeTree.LineLevel
                Self.LargeTree.LineIconId = 2
                Self.LargeTree.HasChildren = True
                Self.LargeTree.LineLevel = Self.LargeTree.LineLevel * -1
            Else
                Self.LargeTree.LineIconId = 1
                Self.LargeTree.HasChildren = 0
            End
            Put(Self.LargeTree)
        End

        Return 0

UserClass.AddBiosTEMPInTree Procedure(Long _parentNodeId, Long _level, <Long _biosGroupType>)

NodeType Long

    Code

        Self.st1.Start()
        Self.st1.SetValue('')
        Clear(Self.LargeTree)

        If not Self.MachineObjectTEMP.BiosPage000 &= null
            Get(Self.MachineObjectTEMP.BiosPage000,1)
            If Errorcode()= 0
                If not Self.MachineObjectTEMP.BiosPage000.Vendor &= null
                    Self.st1.Append(Self.MachineObjectTEMP.BiosPage000.Vendor)
                End
                If not Self.MachineObjectTEMP.BiosPage000.BIOSVersion &= null
                    Self.st1.Append(', Version: ' & Self.MachineObjectTEMP.BiosPage000.BIOSVersion)
                End
                If not Self.MachineObjectTEMP.BiosPage000.BIOSReleaseDate &= null
                    Case Len(Clip(Self.MachineObjectTEMP.BiosPage000.BIOSReleaseDate))
                    Of 10
                        ClaDate# = Deformat(Self.MachineObjectTEMP.BiosPage000.BIOSReleaseDate,@D02)
                        Self.st1.Append(', ' & Format(ClaDate#,@D4))
                    Of 8
                        ClaDate# = Deformat(Self.MachineObjectTEMP.BiosPage000.BIOSReleaseDate,@D01)
                        Self.st1.Append(', ' & Format(ClaDate#,@D4))
                    Else
                        ClaDate# = Deformat(Self.MachineObjectTEMP.BiosPage000.BIOSReleaseDate,@D1)
                        Self.st1.Append(', ' & Format(ClaDate#,@D4))
                    End
                End

            End

            Self.FilterSkip = 0

            Self.LargeTree.LineAnsi     &= Self.WinApi.BinaryCopy(Self.st1.GetValue())
            Self.LargeTree.Name         &= Self.WinApi.BinaryCopy(Self.st1.GetValue())

            If Self.FilterSkip = 0
                Self.LargeTree.NodeId           = Self.NewNodeId()
                Self.LargeTree.NodeParentId     = _parentNodeId
                Self.LargeTree.MachineId        = 0
                Self.LargeTree.Tag1StyleId      = 0
                Self.LargeTree.Tag2StyleId      = 1000
                Self.LargeTree.LineLevel        = _level
                Self.LargeTree.LineIconId       = 0
                Self.LargeTree.LineStyleId      = 1
                Self.LargeTree.NodeType         = NodeType:BiosTitle
                Self.LargeTree.SectionType      = 0
                Self.LargeTree.RowIdSource      = Self.MachineObjectTEMP.BiosPage000.Id
                Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                Self.LargeTree.IndicatorId      = TreeIndicatorId:BiosTitle
                Add(Self.LargeTree)
            End
            P# = -1
            Loop
                P# = P# + 1
                If P# > 255
                    BREAK
                End
                If Self.BiosPageRowsCount(P#) > 0
                    Self.LargeTree.LineAnsi     &= Self.BiosPageTitle(P#)
                    Self.FilterSkip = 0
                    If Self.FilterSkip = 0
                        Self.LargeTree.NodeId           = Self.NewNodeId()
                        Self.LargeTree.NodeParentId     = _parentNodeId
                        Self.LargeTree.MachineId        = 0
                        Self.LargeTree.Tag1StyleId      = 0
                        Self.LargeTree.Tag2StyleId      = 1000
                        Self.LargeTree.LineLevel        = _level + 1
                        Self.LargeTree.LineIconId       = 0
                        Self.LargeTree.LineStyleId      = 1
                        Self.LargeTree.NodeType         = P#
                        Self.LargeTree.SectionType      = 0
                        Self.LargeTree.RowIdSource      = Self.MachineObjectTEMP.Id
                        Self.LargeTree.TreeBrancheType  = Self.TreeBrancheType
                        Execute P# + 1
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType00
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType01
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType02
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType03
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType04
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType05
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType06
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType07
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType08
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType09
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType10
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType11
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType12
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType13
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType14
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType15
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType16
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType17
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType18
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType19
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType20
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType21
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType22
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType23
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType24
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType25
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType26
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType27
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType28
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType29
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType30
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType31
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType32
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType33
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType34
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType35
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType36
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType37
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType38
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType39
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType40
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType41
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType42
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType43
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType44
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType45
                            Self.LargeTree.IndicatorId = TreeIndicatorId:BiosPageType46
                        End
                        Add(Self.LargeTree)
                    End
                End
            End
        End
        Return 0

UserClass.BiosPageRowsCount     Procedure(Long _pageId)

    Code

        Case _pageId
        Of 0
            If Self.MachineObjectTEMP.BiosPage000 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage000)
        Of 1
            If Self.MachineObjectTEMP.BiosPage001 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage001)
        Of 2
            If Self.MachineObjectTEMP.BiosPage002 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage002)
        Of 3
            If Self.MachineObjectTEMP.BiosPage003 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage003)
        Of 4
            If Self.MachineObjectTEMP.BiosPage004 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage004)
        Of 5
            If Self.MachineObjectTEMP.BiosPage005 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage005)
        Of 6
            If Self.MachineObjectTEMP.BiosPage006 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage006)
        Of 7
            If Self.MachineObjectTEMP.BiosPage007 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage007)
        Of 8
            If Self.MachineObjectTEMP.BiosPage008 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage008)
        Of 9
            If Self.MachineObjectTEMP.BiosPage009 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage009)
        Of 10
            If Self.MachineObjectTEMP.BiosPage010 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage010)
        Of 11
            If Self.MachineObjectTEMP.BiosPage011 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage011)
        Of 12
            If Self.MachineObjectTEMP.BiosPage012 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage012)
        Of 13
            If Self.MachineObjectTEMP.BiosPage013 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage013)
        Of 14
            If Self.MachineObjectTEMP.BiosPage014 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage014)
        Of 15
            If Self.MachineObjectTEMP.BiosPage015 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage015)
        Of 16
            If Self.MachineObjectTEMP.BiosPage016 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage016)
        Of 17
            If Self.MachineObjectTEMP.BiosPage017 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage017)
        Of 18
            If Self.MachineObjectTEMP.BiosPage018 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage018)
        Of 19
            If Self.MachineObjectTEMP.BiosPage019 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage019)
        Of 20
            If Self.MachineObjectTEMP.BiosPage020 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage020)
        Of 21
            If Self.MachineObjectTEMP.BiosPage021 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage021)
        Of 22
            If Self.MachineObjectTEMP.BiosPage022 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage022)
        Of 23
            If Self.MachineObjectTEMP.BiosPage023 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage023)
        Of 24
            If Self.MachineObjectTEMP.BiosPage024 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage024)
        Of 25
            If Self.MachineObjectTEMP.BiosPage025 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage025)
        Of 26
            If Self.MachineObjectTEMP.BiosPage026 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage026)
        Of 27
            If Self.MachineObjectTEMP.BiosPage027 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage027)
        Of 28
            If Self.MachineObjectTEMP.BiosPage028 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage028)
        Of 29
            If Self.MachineObjectTEMP.BiosPage029 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage029)
        Of 30
            If Self.MachineObjectTEMP.BiosPage030 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage030)
        Of 31
            If Self.MachineObjectTEMP.BiosPage031 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage031)
        Of 32
            If Self.MachineObjectTEMP.BiosPage032 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage032)
        Of 33
            If Self.MachineObjectTEMP.BiosPage033 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage033)
        Of 34
            If Self.MachineObjectTEMP.BiosPage034 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage034)
        Of 35
            If Self.MachineObjectTEMP.BiosPage035 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage035)
        Of 36
            If Self.MachineObjectTEMP.BiosPage036 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage036)
        Of 37
            If Self.MachineObjectTEMP.BiosPage037 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage037)
        Of 38
            If Self.MachineObjectTEMP.BiosPage038 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage038)
        Of 39
            If Self.MachineObjectTEMP.BiosPage039 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage039)
        Of 40
            If Self.MachineObjectTEMP.BiosPage040 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage040)
        Of 41
            If Self.MachineObjectTEMP.BiosPage041 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage001)
        Of 42
            If Self.MachineObjectTEMP.BiosPage042 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage042)
        Of 43
            If Self.MachineObjectTEMP.BiosPage043 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage043)
        Of 44
            If Self.MachineObjectTEMP.BiosPage044 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage044)
        Of 45
            If Self.MachineObjectTEMP.BiosPage045 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage045)
        Of 46
            If Self.MachineObjectTEMP.BiosPage046 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage046)
        Of 126
            If Self.MachineObjectTEMP.BiosPage126 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage126)
        Of 127
            If Self.MachineObjectTEMP.BiosPage127 &= NULL
                Return 0
            End
            Return Records(Self.MachineObjectTEMP.BiosPage127)
        ELSE
            If Self.MachineObjectTEMP.BiosPages &= NULL
                Return 0
            End
            T# = 0
            I# = 0
            Loop
                I# = I# + 1
                Get(Self.MachineObjectTEMP.BiosPages,I#)
                If Errorcode() <> 0
                    BREAK
                End
                If Self.MachineObjectTEMP.BiosPages.PageType <> _pageId
                    CYCLE
                End
                T# = T# + 1
            End
            Return T#
        End

        Return False

UserClass.BiosPageTitle     Procedure(Long _pageId)

    Code

        Execute _pageId + 1
            Return Self.WinApi.BinaryCopy('Type  0, BIOS Information')
            Return Self.WinApi.BinaryCopy('Type  1, System')
            Return Self.WinApi.BinaryCopy('Type  2, Baseboard or Module')
            Return Self.WinApi.BinaryCopy('Type  3, System Enclosure or Chassis')
            Return Self.WinApi.BinaryCopy('Type  4, Processor Information')
            Return Self.WinApi.BinaryCopy('Type  5, Memory Controller Information')
            Return Self.WinApi.BinaryCopy('Type  6, Memory Module Information')
            Return Self.WinApi.BinaryCopy('Type  7, Cache Information')
            Return Self.WinApi.BinaryCopy('Type  8, Port Connector Information')
            Return Self.WinApi.BinaryCopy('Type  9, System Slots')
            Return Self.WinApi.BinaryCopy('Type 10, On Board Devices Information')
            Return Self.WinApi.BinaryCopy('Type 11, OEM Strings')
            Return Self.WinApi.BinaryCopy('Type 12, System Configuration Options')
            Return Self.WinApi.BinaryCopy('Type 13, BIOS Language Information')
            Return Self.WinApi.BinaryCopy('Type 14, Group Associations')
            Return Self.WinApi.BinaryCopy('Type 15, System Event Log')
            Return Self.WinApi.BinaryCopy('Type 16, Physical Memory Array')
            Return Self.WinApi.BinaryCopy('Type 17, Memory Device')
            Return Self.WinApi.BinaryCopy('Type 18, 32-Bit Memory Error Information')
            Return Self.WinApi.BinaryCopy('Type 19, Memory Array Mapped Address')
            Return Self.WinApi.BinaryCopy('Type 20, Memory Device Mapped Address')
            Return Self.WinApi.BinaryCopy('Type 21, Built-in Pointing Device')
            Return Self.WinApi.BinaryCopy('Type 22, Portable Battery')
            Return Self.WinApi.BinaryCopy('Type 23, System Reset')
            Return Self.WinApi.BinaryCopy('Type 24, Hardware Security')
            Return Self.WinApi.BinaryCopy('Type 25, System Power Controls')
            Return Self.WinApi.BinaryCopy('Type 26, Voltage Probe')
            Return Self.WinApi.BinaryCopy('Type 27, Cooling Device')
            Return Self.WinApi.BinaryCopy('Type 28, Temperature Probe')
            Return Self.WinApi.BinaryCopy('Type 29, Electrical Current Probe')
            Return Self.WinApi.BinaryCopy('Type 30, Out-of-Band Remote Access')
            Return Self.WinApi.BinaryCopy('Type 31, Unknown')
            Return Self.WinApi.BinaryCopy('Type 32, System Boot Information')
            Return Self.WinApi.BinaryCopy('Type 33, 64-Bit Memory Error Information')
            Return Self.WinApi.BinaryCopy('Type 34, Management Device')
            Return Self.WinApi.BinaryCopy('Type 35, Management Device Component')
            Return Self.WinApi.BinaryCopy('Type 36, Management Device Threshold Data')
            Return Self.WinApi.BinaryCopy('Type 37, Memory Channel')
            Return Self.WinApi.BinaryCopy('Type 38, IPMI Device Information')
            Return Self.WinApi.BinaryCopy('Type 39, System Power Supply')
            Return Self.WinApi.BinaryCopy('Type 40, Additional Information')
            Return Self.WinApi.BinaryCopy('Type 41, Onboard Devices Extended Information')
            Return Self.WinApi.BinaryCopy('Type 42, Management Controller Host Interface')
            Return Self.WinApi.BinaryCopy('Type 43, TPM Device')
            Return Self.WinApi.BinaryCopy('Type 44, Processor Additional Information')
            Return Self.WinApi.BinaryCopy('Type 45, Firmware Inventory Information')
            Return Self.WinApi.BinaryCopy('Type 46, String Property')
        End
        If _pageId > 46
            Case _pageId
            Of 126
                Return Self.WinApi.BinaryCopy('Type 126, Inactive Structures')
            Of 127
                Return Self.WinApi.BinaryCopy('Type 127, End-of-Table')
            ELSE
                Return Self.WinApi.BinaryCopy('Type ' & Format(_pageId,@N_3) & ', OEM Specific')
            End
        End

        Return Self.WinApi.BinaryCopy('-')

