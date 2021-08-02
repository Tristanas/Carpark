codeunit 61001 "SPLN_Currency Format Setup"
{

    trigger OnRun()
    begin
    end;

    //[Scope('OnPrem')]
    procedure GetParkingRateFormat(): Text
    var
        CurrencyCode: Code[20];
    begin
        CurrencyCode := GetCurrencySymbol;
        exit(StrSubstNo('<precision, 2:2><standard format,0> %1/h', CurrencyCode));
    end;

    //[Scope('OnPrem')]
    procedure GetPriceFormat(): Text
    var
        CurrencyCode: Code[20];
    begin
        CurrencyCode := GetCurrencySymbol;
        exit(StrSubstNo('<precision, 2:2><standard format,0> %1', CurrencyCode));
    end;

    //[Scope('OnPrem')]
    procedure GetCurrencySymbol(): Code[20]
    var
        CompanyInfo: Record "Company Information";
        Currency: Record Currency;
    begin
        CompanyInfo.FindFirst;
        Currency.Get(CompanyInfo.SPLN_Currency);

        exit(Currency.GetCurrencySymbol);
    end;
}

