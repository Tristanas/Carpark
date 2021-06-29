table 61011 "Posted Parking Lines"
{

    fields
    {
        field(1; "Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Entry Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Duration; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Parking Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Sum"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Parking Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Posted Parking Header"."No.";
        }
        field(8; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Unit; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Hour,Month;
        }
    }

    keys
    {
        key(Key1; "Header No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

