tableextension 50009 "SPLN_tableextension50009" extends "Gen. Journal Line"
{
    local procedure SPLN_TRIAL_CUSTOM_FUNCTIONS()
    begin
    end;

    procedure InitFromSalesInvoice(SalesInvoice: Record "Sales Invoice Header"; lastJournalLine: Record "Gen. Journal Line")
    begin
        Init;
        "Journal Batch Name" := 'BANK';
        "Journal Template Name" := 'CASHRCPT';
        SetUpNewLine(lastJournalLine, 0, true);
        Amount := -SalesInvoice."Amount Including VAT";
        "Amount (LCY)" := -SalesInvoice."Amount Including VAT";
        "Account Type" := "Account Type"::Customer;
        "Account No." := SalesInvoice."Bill-to Customer No.";
        "Bal. Account Type" := "Bal. Account Type"::"Bank Account";
        "Applies-to Doc. Type" := "Applies-to Doc. Type"::Invoice;
        "Applies-to Doc. No." := SalesInvoice."No.";
        "Line No." := GetNewLineNo("Journal Template Name", "Journal Batch Name");
        //"Applied Automatically" := TRUE;
        Validate("Account No.");
        Validate("Applies-to Doc. No.");
        "Document Type" := "Document Type"::Payment;
    end;
}

