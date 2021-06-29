tableextension 50010 tableextension50010 extends Item
{
    procedure CreateForParkingRate(Rate: Record "Parking Rates"): Boolean
    begin
        if Rate."Rate No." = '' then exit(false);

        Rec.Init;
        "No. 2" := Rate."Rate No.";
        "Unit Price" := Rate.Rate;
        Type := Type::Service;
        "Gen. Prod. Posting Group" := 'SERVICES';
        "VAT Prod. Posting Group" := 'VAT10';
        "VAT Bus. Posting Gr. (Price)" := 'DOMESTIC';

        UpdateFromRateType(Rate);

        exit(Insert(true));
    end;

    procedure UpdateFromRateType(Rate: Record "Parking Rates")
    begin
        case Rate."Rate Type" of
            Rate."Rate Type"::Account:
                begin
                    Description := 'Hourly parking fee for account';
                    "Base Unit of Measure" := 'HOUR';
                end;

            Rate."Rate Type"::"One-time Parking":
                begin
                    Description := 'Hourly parking fee';
                    "Base Unit of Measure" := 'HOUR';
                end;
            Rate."Rate Type"::Subscription:
                begin
                    Description := 'Parking fee for monthly subscription';
                    "Base Unit of Measure" := 'PCS';
                end;
        end;
        Validate("Base Unit of Measure");
    end;
}