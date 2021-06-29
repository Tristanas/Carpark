page 61030 "Car Registration Page"
{
    PageType = Card;
    SourceTable = "Parking Registration";
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Registration)
            {
                field(VisitingCarNo; CarNo)
                {
                    Caption = 'Car No.';
                    ApplicationArea = All;
                }
            }
            group(ParkingInfo)
            {
                Caption = 'Parking Information';
                field(CarNo; "Car No.")
                {
                    Caption = 'Car No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(EntryTime; "Entry Time")
                {
                    Caption = 'Entry Time';
                    NotBlank = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        "Entry Time" := ROUNDDATETIME("Entry Time", 100000);
                    end;
                }
                field(ExitTime; "Exit Time")
                {
                    Caption = 'Exit Time';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        "Exit Time" := ROUNDDATETIME("Exit Time", 100000);
                    end;
                }
                field(TimeParkedHours; "Parking Duration (Hours)")
                {
                    Caption = 'Time Parked (hours)';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ParkingRate; "Parking Rate")
                {
                    AutoFormatExpression = RateFormat;
                    AutoFormatType = 10;
                    ApplicationArea = All;
                    Caption = 'Applied Rate';
                    Editable = false;
                }
                field("Sum"; Sum)
                {
                    AutoFormatExpression = PriceFormat;
                    AutoFormatType = 10;
                    ApplicationArea = All;
                    Caption = 'Sum';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
            group(ClientInfo)
            {
                Caption = 'Client Information';
                Visible = CarHasOwner;
                field(Name; Customer.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Company; Customer.Company)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Type"; Customer."Payment type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(BalanceDue; Customer."Balance Due")
                {
                    Caption = 'Balance Due';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NeedMonthlyPayment; ParkedCars.IsMonthlyPaymentLate)
                {
                    Caption = 'Monthly Payment Required';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Register Car")
            {
                ApplicationArea = All;
                Image = SignUp;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = Edit;

                trigger OnAction()
                begin
                    // Make sure the previous one-time visit transaction is finished.
                    IF OneTimeVisit AND CanPrintCheck THEN BEGIN
                        // TODO Create text constant for the message.
                        MESSAGE(Text1);
                        EXIT;
                    END;

                    // Searching for a parking entry of a certain car that has not left yet
                    ParkedCars.SETRANGE("Car No.", CarNo);
                    ParkedCars.SETRANGE("Exit Time", 0DT);
                    IF ParkedCars.FINDLAST THEN BEGIN
                        ParkedCars.RegisterCarExit;
                        CanPrintCheck := TRUE;
                    END ELSE BEGIN
                        //Registered entering car:
                        ParkedCars.RegisterCarEntry(CarNo, ParkingLotNo);
                        CanPrintCheck := FALSE;
                    END;

                    // Update displayed parking registration:
                    GET(ParkedCars."Car No.", ParkedCars."Entry Time");

                    // Get Owner information:
                    IF RegisteredCars.GET(CarNo) AND
                       (RegisteredCars."Customer No." <> '') THEN BEGIN
                        Customer.GET(RegisteredCars."Customer No.");
                        CarHasOwner := TRUE;
                    END ELSE BEGIN
                        CarHasOwner := FALSE;
                    END;
                    OneTimeVisit := (NOT CarHasOwner) OR (Rec.GetOwnerPaymentType = Customer."Payment type"::"One-time");
                end;
            }
            action("Print Check")
            {
                ApplicationArea = All;
                Enabled = "CanPrintCheck";
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ParkingHeader: Record "Parking Header";
                    ParkingLines: Record "Parking Lines";
                    PostingCodeunit: Codeunit "Parking Order - Post";
                begin
                    SETRECFILTER; // Make sure the check is printed for only this parking instance.
                    REPORT.RUN(61000, TRUE, TRUE, Rec);

                    // Post Parking Header in case of a one-time visit:
                    IF OneTimeVisit THEN BEGIN
                        IF ("Parking Order No." <> '') AND (ParkingHeader.GET("Parking Order No."))
                        THEN
                            PostingCodeunit.PostOneTimeVisit(ParkingHeader)
                        ELSE
                            ERROR(Text2);
                    END;

                    SETRANGE("Car No.");
                    SETRANGE("Entry Time");
                    CanPrintCheck := FALSE;
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        IF GET('', 0DT) THEN DELETE;
    end;

    trigger OnInit()
    var
        Employee: Record Employee;
    begin
        CurrPage.EDITABLE(TRUE);
        ParkingLotNo := Employee.GetWatchedLotNo;
        IF ParkingLotNo = '' THEN ParkingLotNo := '10000'; // Standard parking lot number.
    end;

    trigger OnOpenPage()
    begin
        PriceFormat := CurrencyFormatSetup.GetPriceFormat;
        RateFormat := CurrencyFormatSetup.GetParkingRateFormat;
    end;

    var
        ParkedCars: Record "Parking Registration";
        ParkingRates: Record "Parking Rates";
        CanPrintCheck: Boolean;
        CarHasOwner: Boolean;
        RegisteredCars: Record Car;
        Customer: Record Customer;
        ParkingLotNo: Code[20];
        OneTimeVisit: Boolean;
        CarNo: Code[20];
        PriceFormat: Text;
        RateFormat: Text;
        CurrencyFormatSetup: Codeunit "Currency Format Setup";
        Text1: Label 'Please print a check for the exiting car first.';
        Text2: Label 'Failed to post one time visit to ledger.';
}

