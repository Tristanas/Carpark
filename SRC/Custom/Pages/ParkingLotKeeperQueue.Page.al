page 61024 "Parking Lot Keeper Queue"
{
    PageType = CardPart;
    SourceTable = "Parking Lot";

    layout
    {
        area(content)
        {
            cuegroup("Parking Lot")
            {
                Caption = 'Parking Lot';
                field("Parking spots"; "Parking spots")
                {
                    ApplicationArea = All;
                    Caption = 'Parking lot size';
                }
                field("Parked cars count"; "Parked cars count")
                {
                    ApplicationArea = All;
                    Caption = 'Parked cars';
                }
                field("""Parking spots"" - ""Parked cars count"""; "Parking spots" - "Parked cars count")
                {
                    ApplicationArea = All;
                    Caption = 'Vacancies';
                }

                actions
                {
                    action("Select Parking Lot")
                    {
                        ApplicationArea = All;
                        Caption = 'Select Parking Lot';
                        RunObject = Page "Parking Lot List";
                        RunPageMode = View;
                    }
                    action("Register Cars")
                    {
                        ApplicationArea = All;
                        Caption = 'Register Cars';
                        RunObject = Page "Car Registration Page";
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        ParkingLotNo: Code[20];
        Employee: Record Employee;
    begin
        ParkingLotNo := Employee.GetWatchedLotNo;
        if ParkingLotNo <> '' then Get(ParkingLotNo);
    end;
}

