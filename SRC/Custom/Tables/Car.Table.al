table 61000 "SPLN_Car"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Brand; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Model; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Colour; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Registration Country"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(6; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
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

