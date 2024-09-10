    Member()

        Map
        End

        Include('c25_DbTableColumnClass.inc'), once

c25DbTableColumnClass.Construct              Procedure()

    Code

    Self.GetSelfAddress()

c25DbTableColumnClass.Destruct       Procedure()

    Code

c25DbTableColumnClass.GetSelfAddress       Procedure()

    Code

        Self.SelfAddress = Address(Self)

        Return Self.SelfAddress

