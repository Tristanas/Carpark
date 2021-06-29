page 61023 "Parked Cars ListPart"
{
    PageType = ListPart;
    SourceTable = "Parking Registration";
    SourceTableView = WHERE("Car No." = FILTER(<> ''),
                            "Entry Time" = FILTER(<> ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Car No."; "Car No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Time"; "Entry Time")
                {
                    ApplicationArea = All;
                }
                field("Hours parked"; (CurrentDateTime - "Entry Time") / 3600000)
                {
                    ApplicationArea = All;
                }
                field("Parking Lot No."; "Parking Lot No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        ParkingLotNo: Code[20];
        Employee: Record Employee;
    begin
        ParkingLotNo := Employee.GetWatchedLotNo;
        if ParkingLotNo <> '' then SetRange("Parking Lot No.", ParkingLotNo);
        SetRange("Exit Time", 0DT);
    end;
}

