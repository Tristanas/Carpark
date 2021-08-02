tableextension 50008 "SPLN_tableextension50008" extends "Company Information"
{
    fields
    {
        field(50000; "SPLN_Currency"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
    }
}

