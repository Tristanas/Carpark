page 61003 "Parking Header List"
{
    CardPageID = "Parking Header Card";
    PageType = List;
    SourceTable = "Parking Header";
    UsageCategory = Lists;
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
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
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
                field("Total Park Visits"; "Total Park Visits")
                {
                    ApplicationArea = All;
                }
                field("Total Hours Parked"; "Total Hours Parked")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Confirm Payment")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ParkingHeader: Record "Parking Header";
                    OrderPostingCU: Codeunit "Parking Order - Post";
                    Customer: Record Customer;
                    Ok: Boolean;
                begin
                    Ok := Customer.GET("Customer No.");
                    OrderPostingCU.PostOrder(Rec, TRUE);
                    IF Ok THEN BEGIN
                        Customer."Latest Monthly Payment" := Customer."Latest Billing Date";
                        Customer.MODIFY;
                    END;
                end;
            }
        }
    }
}

