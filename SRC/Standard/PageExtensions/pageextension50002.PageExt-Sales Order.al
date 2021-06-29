pageextension 50002 pageextension50002 extends "Sales Order"
{
    layout
    {
        addafter("Work Description")
        {
            field(newField; testText)
            {
                ApplicationArea = All;
                Editable = true;
                trigger OnValidate()
                begin
                    Message('Test messsage: test field was modified.');
                end;
            }
        }
    }
    actions
    {
        addfirst("&Order Confirmation")
        {
            action(PrintInvoice)
            {
                ApplicationArea = All;
                Caption = 'Print Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageOnRec = false;

                trigger OnAction()
                begin
                    Rec.SetRecFilter;
                    REPORT.Run(61001, true, true, Rec);
                end;
            }
        }
        moveafter(Customer; "Create Inventor&y Put-away/Pick")
    }
    // trigger OnOpenPage()
    // begin
    //     Message('Hello there');
    // end;

    var
        testText: Text;
}

