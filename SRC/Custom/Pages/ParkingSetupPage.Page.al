page 61100 "SPLN_Parking Setup Page"
{
    PageType = Card;
    SourceTable = "Parking Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Parking Nos."; "Parking Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Parking Nos."; "Posted Parking Nos.")
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

