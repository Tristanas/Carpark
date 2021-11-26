page 61000 "SPLN_Cars List"
{
    PageType = List;
    SourceTable = SPLN_Car;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Yes"; "No.")
                {
                    ApplicationArea = All;
                }
                field(Brand; Brand)
                {
                    ApplicationArea = All;
                }
                field(Model; Model)
                {
                    ApplicationArea = All;
                }
                field(Colour; Colour)
                {
                    ApplicationArea = All;
                }
                field("Registration Country"; "Registration Country")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
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

