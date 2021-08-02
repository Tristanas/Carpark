page 61031 "Customer Registration Page"
{
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Customer details")
            {
                field(Name; Customer.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field(Company; Customer.SPLN_Company)
                {
                    Caption = 'Company';
                    ApplicationArea = All;
                }
                field(PaymentType; Customer."SPLN_Payment type")
                {
                    Caption = 'Payment Type';
                    ApplicationArea = All;
                }
            }
            group(AddressDetails)
            {
                Caption = 'Address';
                field(Address; Customer.Address)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
                }
                field("Address 2"; Customer."Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies additional address information.';
                }
                field("Country/Region"; Customer."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field(City; Customer.City)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s city.';
                }
                group(Control26)
                {
                    ShowCaption = false;
                    field("Post Code"; Customer."Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the postal code.';
                    }
                }
                group(ContactDetails)
                {
                    Caption = 'Contact';
                    field(ContactCode; Customer."Primary Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the contact number for the customer.';
                    }
                    field(ContactName; Customer.Contact)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact Name';
                        Importance = Promoted;
                        ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';
                    }
                    field(PhoneNo; Customer."Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Phone No.';
                        ToolTip = 'Specifies the customer''s telephone number.';
                    }
                    field("Language Code"; Customer."Language Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies the language to be used on printouts for this customer.';
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Register Customer")
            {
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Customer.TESTFIELD(Name);
                    Car.TESTFIELD("No.");
                    Customer.INSERT(TRUE);
                    Car."Customer No." := Customer."No.";
                    Car.INSERT;
                    MESSAGE('Customer was registered successfully.');
                    CustomerRegistered := TRUE;
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        //MESSAGE('Window closing now. Bye Bye.');
    end;

    trigger OnOpenPage()
    begin
        Car.INIT;
        Customer.INIT;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CustomerRegistered THEN EXIT(TRUE);
        EXIT(CONFIRM('Leave page without registering a customer?'));
    end;

    var
        Car: Record Car;
        Customer: Record Customer;
        CustomerRegistered: Boolean;
}

