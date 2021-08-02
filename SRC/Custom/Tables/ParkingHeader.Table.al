table 61003 "SPLN_Parking Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if (Rec."Customer No." <> xRec."Customer No.") and ("Customer No." <> '') then
                    FillCustInfo("Customer No.");
            end;
        }
        field(3; Month; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Issued By"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(5; "Total Park Visits"; Integer)
        {
            CalcFormula = Count("SPLN_Parking Lines" WHERE("Header No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(6; "Total Hours Parked"; Decimal)
        {
            CalcFormula = Sum("SPLN_Parking Lines".Duration WHERE("Header No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(7; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Services Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Subscription,"One-time",Account;
        }
        field(11; "Total Sum"; Decimal)
        {
            CalcFormula = Sum("SPLN_Parking Lines".Sum WHERE("Header No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ParkingLines: Record "SPLN_Parking Lines";
    begin
        ParkingLines.SetRange("Header No.", "No.");
        ParkingLines.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            ParkingSetup.Get;
            ParkingSetup.TestField("Parking Nos.");
            NoSeriesMgt.InitSeries(ParkingSetup."Parking Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        ParkingSetup: Record "Parking Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        errorText1: Label 'Failed to update order.';
        errorText2: Label 'Customer No. %1 has no registered cars. Order cannot be created.';
        errorText3: Label 'Failed to get information for Customer No. %1.';

    local procedure FillCustInfo("Customer No.": Code[20])
    var
        Customer: Record Customer;
    begin
        if Customer.Get("Customer No.") then begin
            "Customer Name" := Customer.Name;
            "Services Type" := Customer."SPLN_Payment type"
        end else
            Message(StrSubstNo(errorText3, Customer."No."));


    end;

    // Returns the ID of the current parking header of a given customer.
    // If there is no parking header for the given month, returns ''
    procedure GetParkingHeader(CustomerNo: Code[20]): Code[20]
    var
        FirstMonthDay: Date;
        LastMonthDay: Date;
    begin
        FirstMonthDay := Today - Date2DMY(Today, 1) + 1;
        SetFilter(Month, '>=%1', FirstMonthDay);
        SetRange("Customer No.", CustomerNo);
        if FindFirst then exit("No.") else exit('');


        // "No." is set by number series.
    end;

    //[Scope('OnPrem')]
    procedure InitParkingHeader(CustomerNo: Code[20]): Code[20]
    begin
        Init;
        if CustomerNo <> '' then begin
            "Customer No." := CustomerNo;
            FillCustInfo(CustomerNo);
        end
        else begin
            "Services Type" := "Services Type"::"One-time";
        end;

        Month := Today - Date2DMY(Today, 1) + 1;
        "Issued By" := UserId;
        "Document Date" := Today;
        Insert(true);
        exit("No.");
    end;

    //[Scope('OnPrem')]
    procedure UpdateOrder(ParkingRegistration: Record "SPLN_Parking Registration"; OrderNo: Code[20])
    var
        ParkingLine: Record "SPLN_Parking Lines";
    begin
        with ParkingLine do begin
            SetRange("Header No.", OrderNo);
            if FindFirst then begin
                "Entry Time" := ParkingRegistration."Entry Time";
                Duration := ParkingRegistration."Parking Duration (Hours)";
                "Parking Rate" := ParkingRegistration."Parking Rate";
                Sum := ParkingRegistration.Sum;
                Modify(true);
            end else
                Error(errorText1);
        end;
    end;

    // Creates a monthly order for a customer with a subscription or an account.
    // A header alongside with lines will be created.
    //[Scope('OnPrem')]

    procedure CreateMonthlyOrder(Customer: Record Customer; var ParkingHeader: Record "SPLN_Parking Header")
    var
        CustomerCars: Record Car;
        ParkingRegistration: Record "SPLN_Parking Registration";
        MonthStart: DateTime;
        MonthEnd: DateTime;
    begin
        InitParkingHeader(Customer."No.");

        // Find customer's cars:
        CustomerCars.SetRange("Customer No.", Customer."No.");
        if not CustomerCars.FindSet then Error(StrSubstNo(errorText2, Customer."No."));

        case Customer."SPLN_Payment type" of
            Customer."SPLN_Payment type"::Account:
                begin
                    // Additional filters may be required to bill the correct sum in case
                    // the client paid late for previous order and made one-time visits
                    MonthStart := CreateDateTime(CalcDate('CM - 1M + 1D'), 0T);
                    MonthEnd := CreateDateTime(CalcDate('CM'), 235959T);
                    ParkingRegistration.SetRange("Exit Time", MonthStart, MonthEnd);
                    repeat
                        ParkingRegistration.SetRange("Car No.", CustomerCars."No.");
                        if ParkingRegistration.FindSet then
                            repeat
                                ParkingRegistration.CreateParkingLine("No.");
                            until ParkingRegistration.Next = 0;
                    until CustomerCars.Next = 0;
                end;

            Customer."SPLN_Payment type"::Subscription:
                begin
                    if CustomerCars.FindSet then
                        repeat
                            ParkingRegistration.CreateLineForCar("No.", CustomerCars."No.");
                        until CustomerCars.Next = 0;
                end;
        end;
    end;
}

