tableextension 50001 tableextension50001 extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Parking Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Posted Parking Header"."No.";
        }
    }
}

