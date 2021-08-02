page 61041 "Park Administrator Role Center"
{
    PageType = RoleCenter;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group("Hello Admin")
            {
                Caption = 'Hello Admin';
                part(ParkingLotsList; "SPLN_Parking Lot ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Lots';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Register New Customer")
            {
                ApplicationArea = All;
                Caption = 'Register New Customer';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "SPLN_Parking Customer Card";
                RunPageMode = Create;
            }
        }
        area(embedding)
        {
            action(ParkingLots)
            {
                ApplicationArea = All;
                Caption = 'Parking Lots';
                RunObject = Page "SPLN_Parking Lot List";
            }
            action(Employees)
            {
                ApplicationArea = All;
                RunObject = Page "Employee List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page "SPLN_Parking Customer List";
                RunPageView = WHERE(SPLN_DemoCust = CONST(false));
            }
            action(ParkingPricing)
            {
                ApplicationArea = All;
                Caption = 'Parking Pricing';
                RunObject = Page "SPLN_Parking Rate List";
            }
        }
    }
}

