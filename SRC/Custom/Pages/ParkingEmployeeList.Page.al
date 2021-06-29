page 61005 "Parking Employee List"
{
    CardPageID = "Parking Employee Card";
    PageType = List;
    SourceTable = Employee;
    UsageCategory = Tasks;
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
                field(City; City)
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

