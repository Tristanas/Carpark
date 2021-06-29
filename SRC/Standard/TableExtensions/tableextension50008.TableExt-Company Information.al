tableextension 50008 tableextension50008 extends "Company Information"
{
    fields
    {
        field(50000; Currency; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
    }
}

