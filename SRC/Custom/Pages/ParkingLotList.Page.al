page 61001 "Parking Lot List"
{
    PageType = List;
    SourceTable = "Parking Lot";
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
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field(Country; Country)
                {
                    ApplicationArea = All;
                }
                field("Parking spots"; "Parking spots")
                {
                    ApplicationArea = All;
                }
                field("Parked cars count"; "Parked cars count")
                {
                    ApplicationArea = All;
                }
                field("Vacant Spots"; ("Parking spots" - "Parked cars count"))
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
            action("View Parked Cars")
            {
                ApplicationArea = All;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Parked Car List";
                RunPageLink = "Parking Lot No." = FIELD("No."), "Exit Time" = CONST();
                RunPageMode = View;
            }
            action("Set Current Lot")
            {
                ApplicationArea = All;
                Caption = 'Set Watched Lot';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Employee: Record Employee;
                begin
                    IF Employee.SetWatchedLot("No.") THEN
                        MESSAGE('Parking lot set successfully. New lot No.: %1', "No.");
                end;
            }
            action("View Current Lot")
            {
                ApplicationArea = All;
                Caption = 'View Watched Lot';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ParkedCars: Record "Parking Registration";
                    Employee: Record Employee;
                begin
                    ParkedCars.SETRANGE("Exit Time", 0DT);
                    ParkedCars.SETRANGE("Parking Lot No.", Employee.GetWatchedLotNo);
                    PAGE.RUN(61006, ParkedCars);
                end;
            }
        }
    }
}

