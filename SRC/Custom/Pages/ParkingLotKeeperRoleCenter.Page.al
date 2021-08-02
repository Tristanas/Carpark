page 61040 "Parking Lot Keeper Role Center"
{
    PageType = RoleCenter;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Information)
            {
                Caption = 'Information';
                part("Parking Lot Summary"; "SPLN_Parking Lot Keeper Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Lot Summary';
                }
            }
            group("SPLN_Parking Lot")
            {
                part("Parked Cars"; "SPLN_Parked Cars ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Parked Cars';
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
            action("Register Parking Cars")
            {
                ApplicationArea = All;
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "SPLN_Car Registration Page";
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
            action(ParkedCars)
            {
                ApplicationArea = All;
                Caption = 'Parked Cars';
                RunObject = Page "SPLN_Parked Car List";
            }
            action(ParkingRegistration)
            {
                ApplicationArea = All;
                Caption = 'All Parking Registrations';
                RunObject = Page "SPLN_Parking Registration List";
            }
            action(CustomerCars)
            {
                ApplicationArea = All;
                Caption = 'Customer Cars';
                RunObject = Page "SPLN_Cars List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page "SPLN_Parking Customer List";
            }
        }
        area(sections)
        {
        }
    }
}

