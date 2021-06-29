page 61027 "Customer ListPart"
{
    PageType = ListPart;
    SourceTable = Customer;
    SourceTableView = WHERE(DemoCust = CONST(false));

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
                field("Payment type"; "Payment type")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field(Company; Company)
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

