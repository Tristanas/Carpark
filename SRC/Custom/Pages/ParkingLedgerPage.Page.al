page 61016 "SPLN_Parking Ledger Page"
{
    PageType = List;
    SourceTable = "SPLN_Parking Ledger Entry";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Date of Entry"; "Actual Date of Entry")
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

