table 61001 "SPLN_Parking Lot"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Address; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Address 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Country; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Parking spots"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Parked cars count"; Integer)
        {
            CalcFormula = Count("SPLN_Parking Registration" WHERE("Parking Lot No." = FIELD("No."),
                                                              "Exit Time" = CONST()));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

