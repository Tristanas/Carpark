pageextension 50001 "SPLN_pageextension50001" extends "Posted Sales Invoices"
{
    actions
    {
        // In order to remove the number of steps required to confirm a payment -
        // a cust. ledger entry has to be created together with the gen. journal entry
        // so that there will be no need to manually apply which invoice is paid for.
        addfirst(Processing)
        {
            action("SPLN_ConfirmUser")
            {
                ApplicationArea = All;
                Caption = 'Confirm User';
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
            }
            action("SPLN_ConfirmPayment")
            {
                ApplicationArea = All;
                Caption = 'Confirm Payment';
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunPageMode = Edit;

                trigger OnAction()
                var
                    genJournalLine: Record "Gen. Journal Line";
                    SalesHeader: Record "Sales Header";
                    lastJournalLine: Record "Gen. Journal Line";
                    CashReceiptJournal: Page "Cash Receipt Journal";
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    lastJournalLine.SetRange("Journal Batch Name", 'BANK');
                    lastJournalLine.SetRange("Journal Template Name", 'CASHRCPT');

                    // Checking if payment confirmation began previously:
                    if not lastJournalLine.FindLast then begin
                        // Create a new journal line for the confirmation:
                        CurrPage.GetRecord(SalesInvHeader);
                        genJournalLine.InitFromSalesInvoice(SalesInvHeader, lastJournalLine);
                        if not genJournalLine.Insert(true) // Move to ^, text constants
                        then
                            Error('Failed to initialise payment confirmation process.');
                    end else
                        Message('Please finish confirming previous payments first.');

                    CashReceiptJournal.Run;
                end;
            }
        }
    }
}

