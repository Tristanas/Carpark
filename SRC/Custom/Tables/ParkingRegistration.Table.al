table 61002 "SPLN_Parking Registration"
{

    fields
    {
        field(1; "Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = SPLN_Car;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(2; "Entry Time"; DateTime)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec."Entry Time" <> xRec."Entry Time" then begin
                    "Entry Time" := RoundToMinutes("Entry Time");
                    UpdateParkingInformation;
                end;
            end;
        }
        field(3; "Exit Time"; DateTime)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec."Exit Time" <> xRec."Exit Time" then begin
                    "Exit Time" := RoundToMinutes("Exit Time");
                    UpdateParkingInformation;
                end;
            end;
        }
        field(5; "Parking Duration (Hours)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Parking Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Sum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Parking Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "SPLN_Parking Lot";
        }
        field(9; "Parking Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "SPLN_Parking Header";
        }
    }

    keys
    {
        key(Key1; "Car No.", "Entry Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Parking Order No." <> '' then begin
            // Delete related parking order:
            ParkingHeader."No." := "Parking Order No.";
            ParkingHeader.Delete(true);
        end;
    end;

    trigger OnInsert()
    begin
        Validate("Entry Time");
        Validate("Exit Time");
    end;

    trigger OnModify()
    var
        ParkingHeader: Record "SPLN_Parking Header";
    begin
        Validate("Entry Time");
        Validate("Exit Time");

        if (Rec."Entry Time" <> xRec."Entry Time")
          or (Rec."Exit Time" <> xRec."Exit Time")
        then
            UpdateParkingInformation;
    end;

    trigger OnRename()
    begin
        UpdateParkingInformation;
    end;

    var
        ParkingRates: Record "SPLN_Parking Rates";
        ParkingLines: Record "SPLN_Parking Lines";
        Car: Record SPLN_Car;
        Customer: Record Customer;
        ParkingHeader: Record "SPLN_Parking Header";

    //[Scope('OnPrem')]
    procedure RegisterCarEntry(CarNo: Code[20]; ParkingLotNo: Code[20]): Text
    begin
        Init;
        "Car No." := CarNo;
        "Entry Time" := RoundToMinutes(CurrentDateTime);
        "Parking Lot No." := ParkingLotNo;
        Insert;
    end;

    // Creates a parking order only in case of one-time parking.
    //[Scope('OnPrem')]
    procedure RegisterCarExit()
    var
        ParkingOrderNo: Code[20];
    begin
        "Exit Time" := RoundToMinutes(CurrentDateTime);
        CalculateParkingDetails;
        "Parking Order No." := ManageLineCreation('');
        Modify;
    end;

    //[Scope('OnPrem')]
    procedure GetOwnerPaymentType(): Integer
    begin
        if Car.Get("Car No.") and (Car."Customer No." <> '')
          and (Customer.Get(Car."Customer No."))
          and not IsMonthlyPaymentLate
        then
            exit(Customer."SPLN_Payment type");

        // If the car has no registered owner, the customer has to pay a one-time fee
        exit(Customer."SPLN_Payment type"::"One-time");
    end;

    //[Scope('OnPrem')]
    procedure CreateParkingLine(HeaderNo: Code[20])
    begin
        if (Rec."Exit Time" <> 0DT) and (Rec."Entry Time" <> 0DT)
        then
            with ParkingLines do begin
                Init;
                "Car No." := "Car No.";
                "Entry Time" := "Entry Time";
                "Header No." := HeaderNo;
                "Line No." := 0; // Required for automatic Line No. generation.
                Duration := "Parking Duration (Hours)";
                Unit := Unit::Hour;
                "Parking Lot No." := "Parking Lot No.";
                "Parking Rate" := "Parking Rate";
                Sum := Rec.Sum;
                Insert(true);
            end;
    end;

    local procedure ManageLineCreation(HeaderNo: Code[20]): Code[20]
    var
        PaymentType: Integer;
        CustomerNo: Code[20];
    begin
        PaymentType := GetOwnerPaymentType;
        if PaymentType = Customer."SPLN_Payment type"::"One-time" then begin
            //MESSAGE('One-time payment required. Please print a check.');
            // Creating a header with a single line for a one time payment.
            if Car.Get("Car No.") then CustomerNo := Car."Customer No.";
            HeaderNo := ParkingHeader.InitParkingHeader(CustomerNo);
            CreateParkingLine(HeaderNo);
            exit(HeaderNo);
        end;

        // For subscriptions and accounts, lines are created when generating an invoice.
        exit('');
    end;

    //[Scope('OnPrem')]
    // Creates a Parking Line entry for a car that is covered by a subscription:
    procedure CreateLineForCar(HeaderNo: Code[20]; CarNo: Code[20])
    begin
        with ParkingLines do begin
            Init;
            "Car No." := CarNo;
            "Header No." := HeaderNo;
            "Line No." := 0; // Required for automatic Line No. generation.
            Duration := 1;
            Unit := Unit::Month;
            "Parking Rate" := ParkingRates.GetSubscriptionRate;
            Sum := ParkingRates.Rate;
            Insert(true);
        end;
    end;

    //[Scope('OnPrem')]
    procedure CalculateParkingDetails()
    var
        PaymentType: Integer;
    begin
        "Parking Duration (Hours)" := ("Exit Time" - "Entry Time") / 3600000; // Duration kintamasis
        PaymentType := GetOwnerPaymentType;
        "Parking Rate" := ParkingRates.GetParkingRate("Parking Duration (Hours)", PaymentType);
        Sum := Round("Parking Duration (Hours)" * "Parking Rate", 0.01);
    end;

    //[Scope('OnPrem')]
    procedure IsMonthlyPaymentLate(): Boolean
    var
        notPaid: Boolean;
        toleranceIntervalPassed: Boolean;
    begin
        if (Car.Get("Car No.")) and (Car."Customer No." <> '')
          and Customer.Get(Car."Customer No.") then
            exit(Customer."Balance Due" > 0);
        exit(false);
    end;

    local procedure UpdateParkingInformation()
    begin
        if "Exit Time" <> 0DT then
            CalculateParkingDetails;
        if "Parking Order No." <> ''
        then
            ParkingHeader.UpdateOrder(Rec, "Parking Order No.");
    end;

    local procedure RoundToMinutes(dTime: DateTime): DateTime
    begin
        exit(RoundDateTime(dTime, 60000));
    end;
}

