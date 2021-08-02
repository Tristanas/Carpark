page 61042 "Park Accountant Role Center"
{
    PageType = RoleCenter;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group("Customer Information")
            {
                Caption = 'Customer Information';
                part(CustomerList; "SPLN_Customer ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Customer List';
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action(PaymentHistory)
            {
                ApplicationArea = All;
                Caption = 'Payment History';
                RunObject = Page "SPLN_Posted Parking Order List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page "SPLN_Parking Customer List";
            }
            action(Journal)
            {
                ApplicationArea = All;
                RunObject = Page "SPLN_Parking Journal Page";
                Visible = false;
            }
        }
        area(processing)
        {
            action(GenerateMonthlyReport)
            {
                ApplicationArea = All;
                Caption = 'Generate Monthly Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "SPLN_Monthly report (New)";
            }
        }
    }
}

