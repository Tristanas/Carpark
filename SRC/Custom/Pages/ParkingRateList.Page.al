page 61004 "Parking Rate List"
{
    PageType = List;
    SourceTable = "Parking Rates";
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Rate Type"; Rec."Rate Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(MinParkingDuration; Rec.MinParkingDuration)
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field(Interval; Rec.Interval)
                {
                    ApplicationArea = All;
                    Caption = 'Rate type';
                }
            }
        }
    }

    actions
    {
    }
}

