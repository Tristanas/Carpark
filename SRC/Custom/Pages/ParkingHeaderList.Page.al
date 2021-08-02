page 61003 "SPLN_Parking Header List"
{
    CardPageID = "SPLN_Parking Header Card";
    PageType = List;
    SourceTable = "SPLN_Parking Header";
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
                    ParkingHeader: Record "SPLN_Parking Header";
                    OrderPostingCU: Codeunit "SPLN_Parking Order - Post";
                    Customer: Record Customer;
                    Ok: Boolean;
                begin
                    Ok := Customer.GET("Customer No.");
                    OrderPostingCU.PostOrder(Rec, TRUE);
                    IF Ok THEN BEGIN
                        Customer."SPLN_Latest Monthly Payment" := Customer."SPLN_Latest Billing Date";
                        Customer.MODIFY;
                    END;
                end;
            }
        }
    }
}

