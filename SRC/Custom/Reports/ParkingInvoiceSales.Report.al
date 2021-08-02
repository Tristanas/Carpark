report 61001 "SPLN_Parking Invoice (Sales)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'SRC/Custom/Reports/RdlcLayouts/ParkingInvoiceSales.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(DurationCaption; StrSubstNo(DurationCapt, DurationUnit))
            {
            }
            column(AmountCaption; StrSubstNo(AmountCapt, CurrencySymbol))
            {
            }
            column(UnitPriceCaption; StrSubstNo(UnitPriceCapt, CurrencySymbol))
            {
            }
            column(ParkingInvoiceCaption; ParkingInvoiceCapt)
            {
            }
            column(MonthEnd; MonthEnd)
            {
            }
            column(MonthStart; MonthStart)
            {
            }
            column(CustNo; CustomerNo)
            {
            }
            column(CustName; CustomerName)
            {
            }
            column(CustAddress; CustomerAddress)
            {
            }
            column(CustPostCode; CustomerPostCode)
            {
            }
            column(CustCity; CustomerCity)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(DocumentDate; "Sales Header"."Document Date")
            {
                IncludeCaption = true;
            }
            column(ServicesType; "Sales Header"."SPLN_Services Type")
            {
                IncludeCaption = true;
            }
            column(Issuer; "Sales Header"."SPLN_Issued By")
            {
                IncludeCaption = true;
            }
            column(DocumentNo; "Sales Header"."No.")
            {
                IncludeCaption = true;
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(CarNo; "Sales Line"."SPLN_Car No.")
                {
                    IncludeCaption = true;
                }
                column(EntryTime; "Sales Line"."Entry Time")
                {
                    IncludeCaption = true;
                }
                column(ParkingDuration; "Sales Line".Quantity)
                {
                    IncludeCaption = true;
                }
                column(ParkingRate; "Sales Line"."Unit Price")
                {
                    IncludeCaption = true;
                }
                column(Unit; "Sales Line"."Unit of Measure")
                {
                }
                column("Sum"; "Sales Line"."Amount Including VAT")
                {
                    IncludeCaption = true;
                }
            }

            trigger OnAfterGetRecord()
            begin
                if PostedParkingOrder.Get("Sales Header"."SPLN_Parking Order No.") then begin
                    MonthStart := PostedParkingOrder.Month;
                    MonthEnd := CalcDate('CM', MonthStart);
                end else begin
                    MonthEnd := CalcDate('CM');
                    MonthStart := MonthEnd + 1 - Date2DMY(MonthEnd, 1);
                end;

                if "SPLN_Services Type" = "SPLN_Services Type"::Subscription then
                    DurationUnit := 'Months'
                else
                    DurationUnit := 'Hours';

                if Customer.Get("Sales Header"."Bill-to Customer No.") then begin
                    CustomerName := Customer.Name;
                    CustomerNo := Customer."No.";
                    CustomerCity := Customer.City;
                    CustomerPostCode := Customer."Post Code";
                    CustomerAddress := Customer.Address;
                end else
                    Error('Failed to get customer information.');
            end;

            trigger OnPreDataItem()
            begin
                CurrencySymbol := CurrencyFormatCU.GetCurrencySymbol;
            end;
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
        CustomerNo = 'Customer No.';
        CustomerName = 'Customer Name.';
        CustomerPostCode = 'Post Code';
        CustomerCity = 'City';
        CustomerAddress = 'Address';
        InvoicePeriod = 'Invoice Period:';
    }

    var
        PostedParkingOrder: Record "SPLN_Posted Parking Header";
        CurrencyFormatCU: Codeunit "SPLN_Currency Format Setup";
        CustomerName: Text[50];
        CustomerNo: Code[20];
        CustomerCity: Text[20];
        CustomerAddress: Text[100];
        CustomerPostCode: Code[20];
        Customer: Record Customer;
        MonthStart: Date;
        MonthEnd: Date;
        ParkingInvoiceCapt: Label 'Parking Invoice';
        UnitPriceCapt: Label 'Unit Price (%1)';
        AmountCapt: Label 'Amount Incl. VAT (%1)';
        CurrencySymbol: Code[20];
        DurationCapt: Label 'Duration (%1)';
        DurationUnit: Text;
}

