page 61014 "SPLN_Parking Header Card"
{
    PageType = Card;
    SourceTable = "SPLN_Parking Header";
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Month; Month)
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
            }
            group(Totals)
            {
                field("Total Park Visits"; "Total Park Visits")
                {
                    ApplicationArea = All;
                }
                field("Total Hours Parked"; "Total Hours Parked")
                {
                    ApplicationArea = All;
                }
                field("Total Sum"; "Total Sum")
                {
                    ApplicationArea = All;
                }
            }
            group("Customer Information")
            {
                field("Customer No."; "Customer No.")
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
            part("Order Lines"; "Parking Order Lines Subform")
            {
                ApplicationArea = All;
                Caption = 'Order Lines';
                SubPageLink = "Header No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

