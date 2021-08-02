page 61013 "SPLN_Posted Parking Order List"
{
    PageType = List;
    SourceTable = "SPLN_Posted Parking Header";
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
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Total Park Visits"; "Total Park Visits")
                {
                    ApplicationArea = All;
                }
                field("Total Hours Parked"; "Total Hours Parked")
                {
                    ApplicationArea = All;
                }
                field(Sum; Sum)
                {
                    ApplicationArea = All;
                }
                field("Issued By"; "Issued By")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Month; Month)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Services Type"; "Services Type")
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

