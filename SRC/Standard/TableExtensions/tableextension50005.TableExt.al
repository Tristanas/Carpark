tableextension 50005 "SPLN_tableextension50005" extends "Sales Line"
{
    fields
    {
        field(50001; "SPLN_Car No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Entry Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
    }

    local procedure CopyFromParkingService()
    begin
    end;
}

