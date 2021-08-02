page 61012 "SPLN_Parking Customer List"
{
    CardPageID = "SPLN_Parking Customer Card";
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE(SPLN_DemoCust = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field(Company; SPLN_Company)
                {
                    ApplicationArea = All;
                }
                field("Payment type"; "SPLN_Payment type")
                {
                    ApplicationArea = All;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        OpenCustomerLedgerEntries(FALSE);
                    end;
                }
                field("Balance Due"; "Balance Due")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';

                    trigger OnDrillDown()
                    begin
                        OpenCustomerLedgerEntries(TRUE);
                    end;
                }
                field("Sales (LCY)"; "Sales (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total net amount of sales to the customer in LCY.';
                }
                field(Payments; Payments)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of payments received from the customer.';
                }
                field("Latest Monthly Payment"; "SPLN_Latest Monthly Payment")
                {
                    ApplicationArea = All;
                }
                field("Latest Billing Date"; "SPLN_Latest Billing Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Monthly Order")
            {
                ApplicationArea = All;
                Caption = 'Create a Monthly Order';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ParkingHeader: Record "SPLN_Parking Header";
                    ParkingRegistration: Record "SPLN_Parking Registration";
                    ParkingLine: Record "SPLN_Parking Lines";
                    ParkingHeaderNo: Code[20];
                    CustomerCars: Record Car;
                    MonthStart: DateTime;
                    MonthEnd: DateTime;
                    ParkingRate: Record "SPLN_Parking Rates";
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    PostingCU: Codeunit "SPLN_Parking Order - Post";
                begin
                    // 1. Create Parking Order:
                    ParkingHeader.CreateMonthlyOrder(Rec, ParkingHeader);
                    COMMIT;

                    // 2. Create a Sales Order:
                    SalesHeader.InitFromParkingHeader(ParkingHeader);
                    SalesHeader.TransferParkingHeaderLines(ParkingHeader);

                    // 3. Post parking header and add its reference to the Sales order:
                    SalesHeader."SPLN_Parking Order No." := PostingCU.PostOrder(ParkingHeader, FALSE);
                    SalesHeader.MODIFY;

                    IF CONFIRM(STRSUBSTNO('Order no %1 has been created successfully. ' +
                        'Would you like to view it?', SalesHeader."No.")) THEN
                        PAGE.RUN(42, SalesHeader);
                end;
            }
            action("Check Orders")
            {
                ApplicationArea = All;
                Caption = 'Check Unpaid Orders';
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Sales Invoices";
                RunPageLink = "Bill-to Customer No." = FIELD("No.");
                RunPageView = WHERE("Remaining Amount" = FILTER(> 0));
            }
            action("Check Payment History")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Sales Invoices";
                RunPageLink = "Bill-to Customer No." = FIELD("No.");
            }
        }
    }
}

