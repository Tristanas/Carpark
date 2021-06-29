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
                part(CustomerList; "Customer ListPart")
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
                RunObject = Page "Posted Parking Order List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page "Parking Customer List";
            }
            action(Journal)
            {
                ApplicationArea = All;
                RunObject = Page "Parking Journal Page";
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
                RunObject = Report "Monthly report (New)";
            }
        }
    }
}

