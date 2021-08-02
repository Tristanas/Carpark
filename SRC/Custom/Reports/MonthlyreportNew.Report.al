report 61010 "SPLN_Monthly report (New)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'SRC/Custom/Reports/RdlcLayouts/MonthlyreportNew.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("SPLN_Parking Lot"; "SPLN_Parking Lot")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            column(LotNo; "SPLN_Parking Lot"."No.")
            {
            }
            column(LotAddress; "SPLN_Parking Lot".Address)
            {
            }
            column(LotCity; "SPLN_Parking Lot".City)
            {
            }
            column(LotCountry; "SPLN_Parking Lot".Country)
            {
            }
            column(SelectedLotNo; ParkingLotNo)
            {
            }
            column(DocumentName; DocName)
            {
            }
            column(CurrencySymbol; CurrencySymbol)
            {
            }
            column(SumHeader; StrSubstNo(SumLabel, CurrencySymbol))
            {
            }
            column(SubDurationHeader; StrSubstNo(DurationLabel, 'Months'))
            {
            }
            column(RateHeader; StrSubstNo(RateLabel, CurrencySymbol))
            {
            }
            column(SubRateHeader; StrSubstNo(SubRateLabel, CurrencySymbol))
            {
            }
            column(DurationHeader; StrSubstNo(DurationLabel, 'Hour'))
            {
            }
            column(StartDate; ReportStartDate)
            {
            }
            column(EndDate; ReportEndDate)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            dataitem("Posted Parking Lines"; "SPLN_Posted Parking Lines")
            {
                DataItemLink = "Parking Lot No." = FIELD("No.");
                DataItemTableView = SORTING("Header No.", "Line No.") WHERE("Parking Lot No." = FILTER(<> ''));
                column(CarNo; "Posted Parking Lines"."Car No.")
                {
                    IncludeCaption = true;
                }
                column(Duration; "Posted Parking Lines".Duration)
                {
                    IncludeCaption = true;
                }
                column(HeaderNo; "Posted Parking Lines"."Header No.")
                {
                }
                column("Sum"; "Posted Parking Lines".Sum)
                {
                    IncludeCaption = true;
                }
                dataitem("Posted Parking Header"; "SPLN_Posted Parking Header")
                {
                    DataItemLink = "No." = FIELD("Header No.");
                    DataItemTableView = SORTING("No.");
                    column(ServicesType; "Posted Parking Header"."Services Type")
                    {
                        IncludeCaption = true;
                    }
                    column(HeaderMonth; "Posted Parking Header".Month)
                    {
                    }
                    column(Name; "Posted Parking Header"."Customer Name")
                    {
                        IncludeCaption = true;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        with "Posted Parking Header" do begin
                            if "Services Type" = "Services Type"::Subscription then
                                DurationUnit := 'Months'
                            else
                                DurationUnit := 'Hours';
                        end;

                        if "Posted Parking Header"."Customer No." = '' then
                            "Posted Parking Header"."Customer Name" := 'Unregistered';
                    end;

                    trigger OnPreDataItem()
                    var
                        PostedParkingHeader: Record "SPLN_Posted Parking Header";
                    begin
                        //MESSAGE('Setting a filter for orders, interval: %1 - %2', ReportStartDate, ReportEndDate);

                        if ParkingLotNo <> '' then begin
                            SetFilter("Services Type", '%1 | %2', "Services Type"::Account, "Services Type"::"One-time");
                            "Posted Parking Lines".SetRange("Parking Lot No.", ParkingLotNo);
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TestParkingLotNo := "Posted Parking Lines"."Parking Lot No.";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Entry Time",
                      CreateDateTime(ReportStartDate, 0T),
                      CreateDateTime(ReportEndDate, 235959T));
                end;
            }

            trigger OnPreDataItem()
            begin
                if ParkingLotNo <> '' then "SPLN_Parking Lot".SetRange("No.", ParkingLotNo);
            end;
        }
        dataitem("Subscription Orders"; "SPLN_Posted Parking Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Services Type" = CONST(Subscription));
            PrintOnlyIfDetail = true;
            column(SubCustomerName; "Subscription Orders"."Customer Name")
            {
            }
            column(SubHeaderMonth; "Subscription Orders".Month)
            {
            }
            dataitem("Subscription Lines"; "SPLN_Posted Parking Lines")
            {
                DataItemLink = "Header No." = FIELD("No.");
                DataItemTableView = SORTING("Header No.", "Line No.");
                column(SubCarNo; "Subscription Lines"."Car No.")
                {
                    IncludeCaption = true;
                }
                column(SubDuration; "Subscription Lines".Duration)
                {
                }
                column(SubRate; "Subscription Lines"."Parking Rate")
                {
                }
                column(SubSum; "Subscription Lines".Sum)
                {
                    IncludeCaption = true;
                }
            }

            trigger OnPreDataItem()
            begin
                //MESSAGE('Setting a filter for orders, interval: %1 - %2', ReportStartDate, ReportEndDate);
                SetRange(Month, ReportStartDate, ReportEndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(ReportInterval)
                {
                    Caption = 'Report Interval Dates';
                    field(ReportStartDate; ReportStartDate)
                    {
                        Caption = 'Start Date';
                        NotBlank = true;
                        ApplicationArea = All;
                    }
                    field(ReportEndDate; ReportEndDate)
                    {
                        Caption = 'End Date';
                        NotBlank = true;
                        ApplicationArea = All;
                    }
                }
                group("Select Parking Lot")
                {
                    Caption = 'Select Parking Lot';
                    field("SPLN_Parking Lot"; ParkingLotNo)
                    {
                        Caption = 'Lot Number';
                        TableRelation = "SPLN_Parking Lot"."No.";
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        OneTimeVisit = 'One-time Parking (Unregistered)';
        Interval = 'Time Interval:';
        OVDurationCaption = 'Duration (Hours)';
    }

    trigger OnPreReport()
    begin
        CurrencySymbol := CurrencyFormatCU.GetCurrencySymbol;
    end;

    var
        CurrencyFormatCU: Codeunit "SPLN_Currency Format Setup";
        ParkingLot: Record "SPLN_Parking Lot";
        ReportStartDate: Date;
        ReportEndDate: Date;
        ParkingLotNo: Code[20];
        DurationLabel: Label 'Duration (%1)';
        DurationUnit: Text;
        RateLabel: Label 'Rate (%1/h)';
        SumLabel: Label 'Sum (%1)';
        CurrencySymbol: Text;
        SubRateLabel: Label 'Rate (%1/M)';
        DocName: Label 'Customers and Services Report';
        ParkingLotAddress: Text;
        ParkingLotLocation: Text;
        TestParkingLotNo: Code[20];
}

