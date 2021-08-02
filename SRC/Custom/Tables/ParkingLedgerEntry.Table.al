table 61007 "SPLN_Parking Ledger Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "One-time Park",Account,Subscription;
        }
        field(4; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer;
        }
        field(6; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Actual Date of Entry"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

