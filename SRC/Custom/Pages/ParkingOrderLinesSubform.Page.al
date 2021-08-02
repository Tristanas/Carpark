page 61025 "Parking Order Lines Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "SPLN_Parking Lines";

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
                field("Duration"; Duration)
                {
                    ApplicationArea = All;
                }
                field(Unit; Unit)
                {
                    ApplicationArea = All;
                }
                field("Parking Rate"; "Parking Rate")
                {
                    ApplicationArea = All;
                }
                field(Sum; Sum)
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
}

