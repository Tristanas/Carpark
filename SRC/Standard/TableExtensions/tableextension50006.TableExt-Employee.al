tableextension 50006 tableextension50006 extends Employee
{
    fields
    {
        field(50000; "Parking Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Parking Lot";
            //This property is currently not supported
            //TestTableRelation = true;
        }
        field(50001; UserName; Code[50])
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
        SetRange(UserName, UserId);
        if FindFirst then begin
            "Parking Lot No." := LotNo;
            Modify;
            exit(true);
        end;
        exit(false);
    end;

    procedure GetWatchedLotNo(): Code[20]
    begin
        SetRange(UserName, UserId);
        if FindFirst then exit("Parking Lot No.") else exit('');
    end;
}

