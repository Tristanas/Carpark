table 61008 "SPLN_Parking Journal Line"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "One-time Park",Account,Subscription;
        }
        field(5; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(7; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Actual Date of Entry"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

