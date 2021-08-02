table 61004 "SPLN_Parking Rates"
{

    fields
    {
        field(1; "Rate No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; MinParkingDuration; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Rec.Rate = xRec.Rate then exit;

                Item.SetRange("No. 2", "Rate No.");
                if Item.FindFirst then begin
                    Item."Unit Price" := Rate;
                    Item.Modify;
                end;
            end;
        }
        field(4; Interval; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Hourly,Monthly;
        }
        field(5; "Rate Type"; Option)
        {
            OptionMembers = "One-time Parking",Subscription,Account;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Rec."Rate Type" = xRec."Rate Type" then exit;

                case "Rate Type" of
                    "Rate Type"::Account:
                        Interval := Interval::Hourly;
                    "Rate Type"::"One-time Parking":
                        Interval := Interval::Hourly;
                    "Rate Type"::Subscription:
                        Interval := Interval::Monthly;
                end;
                // Update Item:
                Item.SetRange("No. 2", "Rate No.");
                if Item.FindFirst then begin
                    Item.UpdateFromRateType(Rec);
                    Item.Modify;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Rate No.", MinParkingDuration)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Item: Record Item;
    begin
        //Automatically create an Item (table 27) record which matches the parking rate
        Item.CreateForParkingRate(Rec);
    end;

    trigger OnDelete()
    var
        Item: Record Item;
    begin
        Item.SetRange("No. 2", "Rate No.");
        Item.DeleteAll();
    end;

    trigger OnRename()
    var
        Item: Record Item;
    begin
        Item.SetRange("No. 2", xRec."Rate No.");
        if Item.FindFirst then begin
            Item."No. 2" := Rec."Rate No.";
            Item.Modify;
        end;
    end;

    //[Scope('OnPrem')]
    procedure GetParkingRate("Parking Duration (Hours)": Decimal; PaymentType: Integer): Decimal
    var
        ParkingRateNo: Code[20];
        Customer: Record Customer;
    begin
        if PaymentType = Customer."SPLN_Payment type"::Subscription then exit(0);
        GetParkingRateRecord("Parking Duration (Hours)", PaymentType, Rec);
        exit(Rate);
    end;

    //[Scope('OnPrem')]
    procedure GetParkingRateRecord("Parking Duration (Hours)": Decimal; PaymentType: Integer; var ParkingRate: Record "SPLN_Parking Rates") Ok: Boolean
    var
        Customer: Record Customer;
    begin
        case PaymentType of
            Customer."SPLN_Payment type"::"One-time":
                begin
                    ParkingRate.SetFilter("Rate No.", '*OTP*');
                    ParkingRate.SetFilter(MinParkingDuration, '<=%1', "Parking Duration (Hours)");
                    ParkingRate.FindLast;
                    exit(true);
                end;

            Customer."SPLN_Payment type"::Account:
                begin
                    ParkingRate.Get('ACC');
                    exit(true);
                end;

            Customer."SPLN_Payment type"::Subscription:
                begin
                    ParkingRate.Get('SUB');
                    exit(true);
                end;
        end;
        exit(false);
    end;

    //[Scope('OnPrem')]
    procedure GetSubscriptionRate(): Decimal
    begin
        Get('SUB');
        exit(Rate);
    end;
}

