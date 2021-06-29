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
                part("Parking Lot Summary"; "Parking Lot Keeper Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Lot Summary';
                }
            }
            group("Parking Lot")
            {
                part("Parked Cars"; "Parked Cars ListPart")
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
                RunObject = Page "Parking Customer Card";
                RunPageMode = Create;
            }
            action("Register Parking Cars")
            {
                ApplicationArea = All;
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Car Registration Page";
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
            action(ParkedCars)
            {
                ApplicationArea = All;
                Caption = 'Parked Cars';
                RunObject = Page "Parked Car List";
            }
            action(ParkingRegistration)
            {
                ApplicationArea = All;
                Caption = 'All Parking Registrations';
                RunObject = Page "Parking Registration List";
            }
            action(CustomerCars)
            {
                ApplicationArea = All;
                Caption = 'Customer Cars';
                RunObject = Page "Cars List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page "Parking Customer List";
            }
        }
        area(sections)
        {
        }
    }
}

