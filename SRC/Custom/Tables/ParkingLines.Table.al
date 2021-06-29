table 61006 "Parking Lines"
{

    fields
    {
        field(1; "Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Car;
        }
        field(2; "Entry Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Duration; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Parking Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Parking Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Parking Lot";
        }
        field(7; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Parking Header"."No.";
        }
        field(8; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Unit; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Hour,Month;
        }
    }

    keys
    {
        key(Key1; "Header No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Line No." = 0 then "Line No." := GetNewLineNo("Header No.");
    end;

    local procedure GetNewLineNo(HeaderNo: Code[20]): Integer
    var
        Lines: Record "Parking Lines";
    begin
        Lines.SetRange("Header No.", HeaderNo);
        if Lines.FindLast then exit(Lines."Line No." + 100);
        exit(100);
    end;

    //[Scope('OnPrem')]
    procedure GetItem(var Item: Record Item) Ok: Boolean
    var
        ParkingRates: Record "Parking Rates";
        Rate: Record "Parking Rates";
        ParkingHeader: Record "Parking Header";
    begin
        if not ParkingHeader.Get("Header No.") then exit(false);

        if ParkingRates.GetParkingRateRecord(Duration, ParkingHeader."Services Type", Rate) then begin
            Item.SetRange("No. 2", Rate."Rate No.");
            exit(Item.FindFirst);
        end;
        exit(false);
    end;
}

