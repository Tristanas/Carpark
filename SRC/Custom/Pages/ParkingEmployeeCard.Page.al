page 61011 "Parking Employee Card"
{
    PageType = Card;
    SourceTable = Employee;
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
                field("First Name"; "First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
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

