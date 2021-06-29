page 61002 "Parked Car List"
{
    PageType = List;
    SourceTable = "Parking Registration";
    SourceTableView = WHERE("Exit Time" = CONST());
    UsageCategory = Lists;
    ApplicationArea = All;

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
                field("Hours parked"; (CURRENTDATETIME - "Entry Time") / 3600000)
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
    begin
        ParkingLotNo := Employee.GetWatchedLotNo;
        IF ParkingLotNo <> '' THEN SETRANGE("Parking Lot No.", ParkingLotNo);
        SETRANGE("Exit Time", 0DT);
    end;

    var
        ParkingLotNo: Code[20];
        Employee: Record Employee;
}

