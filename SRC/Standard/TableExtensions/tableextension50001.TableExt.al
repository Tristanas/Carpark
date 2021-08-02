tableextension 50001 "SPLN_tableextension50001" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "SPLN_Parking Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "SPLN_Posted Parking Header"."No.";
        }
    }
}

