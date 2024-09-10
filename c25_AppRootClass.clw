    Member

        Map
        End
        Include('c25_AppRootClass.inc'), once

c25AppRootClass.Construct              Procedure()

    Code

        Self.SelfAddress                = Address(Self)
        Self.c25AppObjects              &= NEW c25AppObjects_TYPE
        Self.Properties                 &= NEW c25AppObj_TYPE
        Self.Properties.AppNameAnsi     &= NEW String(LEN('AppName'))
        Self.Properties.AppNameAnsi     = 'AppName'

c25AppRootClass.Destruct       Procedure()

    Code

c25AppRootClass.GetSelfAddress       Procedure()

    Code

        Return Self.SelfAddress

c25AppRootClass.Populatec25AppObjects  Procedure()

    Code

        Self.c25AppObjects.Id = 0
        Self.c25AppObjects.Index = 0
        Self.c25AppObjects.Level = 0
        Self.c25AppObjects.Ordinal = 0
        Self.c25AppObjects.ParentId = 0
        Self.c25AppObjects.ChildrenCount = 0
        Self.c25AppObjects.ObjectType = 100
        Self.c25AppObjects.ObjectName = 0
        Add(Self.c25AppObjects)

        Return 0

