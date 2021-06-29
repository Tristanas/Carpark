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
                part(ParkingLotsList; "Parking Lot ListPart")
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
                RunObject = Page "Parking Customer Card";
                RunPageMode = Create;
            }
        }
        area(embedding)
        {
            action(ParkingLots)
            {
                ApplicationArea = All;
                Caption = 'Parking Lots';
                RunObject = Page "Parking Lot List";
            }
            action(Employees)
            {
                ApplicationArea = All;
                RunObject = Page "Employee List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page "Parking Customer List";
                RunPageView = WHERE(DemoCust = CONST(false));
            }
            action(ParkingPricing)
            {
                ApplicationArea = All;
                Caption = 'Parking Pricing';
                RunObject = Page "Parking Rate List";
            }
        }
    }
}

