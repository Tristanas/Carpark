page 61027 "SPLN_Customer ListPart"
{
    PageType = ListPart;
    SourceTable = Customer;
    SourceTableView = WHERE(SPLN_DemoCust = CONST(false));

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
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Payment type"; "SPLN_Payment type")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field(Company; SPLN_Company)
                {
                    ApplicationArea = All;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = All;
                }
                field("Balance Due"; "Balance Due")
                {
                    ApplicationArea = All;
                }
                field(Payments; Payments)
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

