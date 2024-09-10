    Member()

        Map
        End

        Include('c25_DbDatabaseClass.inc'), once

c25DbDatabaseClass.Construct              Procedure()

    Code

c25DbDatabaseClass.Destruct       Procedure()

    Code

c25DbDatabaseClass.GetSelfAddress       Procedure()

    Code

        Self.SelfAddress = Address(Self)

        Return Self.SelfAddress

