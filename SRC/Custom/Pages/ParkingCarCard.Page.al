page 61018 "SPLN_Parking Car Card"
{
    PageType = Card;
    SourceTable = SPLN_Car;

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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
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

    //[Scope('OnPrem')]
    procedure InitCarForCustomer(CustomerNo: Code[20]; CarNo: Code[20])
    var
        Car: Record SPLN_Car;
    begin
        Car.Init;
        Car."Customer No." := CustomerNo;
        Car."No." := CarNo;
        Car.Insert;
        CurrPage.SetRecord(Car);
    end;
}

