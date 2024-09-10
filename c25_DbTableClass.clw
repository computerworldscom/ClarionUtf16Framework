    Member()

        Map
        End

        Include('c25_DbTableClass.inc'), once

c25DbTableClass.Construct              Procedure()

    Code

        Self.GetSelfAddress()

c25DbTableClass.Destruct       Procedure()

    Code

c25DbTableClass.GetSelfAddress       Procedure()

    Code

        Self.SelfAddress = Address(Self)

        Return Self.SelfAddress

