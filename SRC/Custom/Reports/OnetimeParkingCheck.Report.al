report 61000 "SPLN_One-time Parking Check"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'SRC/Custom/Reports/RdlcLayouts/OnetimeParkingCheck.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("SPLN_Parking Registration"; "SPLN_Parking Registration")
        {
            column(SumCaption; StrSubstNo(SumCapt, CurrencySymbol))
            {
            }
            column(RateCaption; StrSubstNo(RateCapt, CurrencySymbol))
            {
            }
            column(CarNo; "SPLN_Parking Registration"."Car No.")
            {
                IncludeCaption = true;
            }
            column(EntryTime; "SPLN_Parking Registration"."Entry Time")
            {
                IncludeCaption = true;
            }
            column(ExitTime; "SPLN_Parking Registration"."Exit Time")
            {
                IncludeCaption = true;
            }
            column(ParkingRate; "SPLN_Parking Registration"."Parking Rate")
            {
            }
            column(ParkingDuration; "SPLN_Parking Registration"."Parking Duration (Hours)")
            {
                IncludeCaption = true;
            }
            column("Sum"; "SPLN_Parking Registration".Sum)
            {
            }
            column(LotNo; "SPLN_Parking Registration"."Parking Lot No.")
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
        CurrencyFormatCU: Codeunit "SPLN_Currency Format Setup";
        CurrencySymbol: Code[20];
}

