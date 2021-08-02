tableextension 50006 "SPLN_tableextension50006" extends Employee
{
    fields
    {
        field(50000; "SPLN_Parking Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "SPLN_Parking Lot";
            //This property is currently not supported
            //TestTableRelation = true;
        }
        field(50001; "SPLN_UserName"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    local procedure SPLN_TRIAL_CUSTOM_FUNCTIONS()
    begin
    end;

    procedure SetWatchedLot(LotNo: Code[20]): Boolean
    begin
        SetRange(SPLN_UserName, UserId);
        if FindFirst then begin
            "SPLN_Parking Lot No." := LotNo;
            Modify;
            exit(true);
        end;
        exit(false);
    end;

    procedure GetWatchedLotNo(): Code[20]
    begin
        SetRange(SPLN_UserName, UserId);
        if FindFirst then exit("SPLN_Parking Lot No.") else exit('');
    end;
}

