page 61006 "Parking Registration List"
{
    PageType = List;
    SourceTable = "Parking Registration";
    UsageCategory = History;
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
                field("Exit Time"; "Exit Time")
                {
                    ApplicationArea = All;
                }
                field("Parking Duration (Hours)"; "Parking Duration (Hours)")
                {
                    ApplicationArea = All;
                    Caption = 'Duration (Hours)';
                }
                field("Parking Rate"; "Parking Rate")
                {
                    ApplicationArea = All;
                }
                field("Sum"; Sum)
                {
                    ApplicationArea = All;
                    AutoFormatExpression = '<precision, 2:2><standard format,0>';
                    AutoFormatType = 10;
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
}

