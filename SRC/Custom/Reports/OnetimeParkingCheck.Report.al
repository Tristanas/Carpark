report 61000 "One-time Parking Check"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'SRC/Custom/Reports/RdlcLayouts/OnetimeParkingCheck.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Parking Registration"; "Parking Registration")
        {
            column(SumCaption; StrSubstNo(SumCapt, CurrencySymbol))
            {
            }
            column(RateCaption; StrSubstNo(RateCapt, CurrencySymbol))
            {
            }
            column(CarNo; "Parking Registration"."Car No.")
            {
                IncludeCaption = true;
            }
            column(EntryTime; "Parking Registration"."Entry Time")
            {
                IncludeCaption = true;
            }
            column(ExitTime; "Parking Registration"."Exit Time")
            {
                IncludeCaption = true;
            }
            column(ParkingRate; "Parking Registration"."Parking Rate")
            {
            }
            column(ParkingDuration; "Parking Registration"."Parking Duration (Hours)")
            {
                IncludeCaption = true;
            }
            column("Sum"; "Parking Registration".Sum)
            {
            }
            column(LotNo; "Parking Registration"."Parking Lot No.")
            {
                IncludeCaption = true;
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CurrencySymbol := CurrencyFormatCU.GetCurrencySymbol;
    end;

    var
        DurationCapt: Label 'Val.';
        RateCapt: Label 'Tarifas (%1/val.)';
        SumCapt: Label 'Suma (%1)';
        CurrencyFormatCU: Codeunit "Currency Format Setup";
        CurrencySymbol: Code[20];
}

