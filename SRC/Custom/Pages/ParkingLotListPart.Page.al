page 61026 "Parking Lot ListPart"
{
    PageType = ListPart;
    SourceTable = "Parking Lot";

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
                field("Address"; Address)
                {
                    ApplicationArea = All;
                }
                field("City"; City)
                {
                    ApplicationArea = All;
                }
                field("Country"; Country)
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
            }
        }
    }

    actions
    {
    }
}

