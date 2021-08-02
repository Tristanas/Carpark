page 61101 "Car Registration Request Page"
{

    layout
    {
        area(content)
        {
            group("Enter the registration number:")
            {
                Caption = 'Enter the registration number:';
                field(CarNo; CarNo)
                {
                    Caption = 'Car No.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        CarCard.InitCarForCustomer(CustomerNo, CarNo);
        CarCard.Run;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CarNo = '' then begin
            Message('Please enter the car number.');
            exit(false);
        end;

        exit(true);
    end;

    var
        CarNo: Code[20];
        CustomerNo: Code[20];
        CarCard: Page "SPLN_Parking Car Card";

    //[Scope('OnPrem')]
    procedure SetCustomerNo(No: Code[20])
    begin
        CustomerNo := No;
    end;
}

