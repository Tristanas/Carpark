table 61010 "Parking Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Parking Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(3; "Posted Parking Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

