codeunit 61000 "SPLN_Parking Order - Post"
{

    trigger OnRun()
    begin

    end;

    var
        Text1: Label 'Parking Line %1 is missing required fields: %2';
        Text2: Label 'Parking order is ready for posting.';
        Text3: Label 'Failed to post Parking Header No. %1.';
        Text4: Label 'Failed to Post Parking Line No.: %1';
        Text5: Label 'Failed to create Parking Journal Entry for Parking document No. %1';
        Text6: Label 'Failed to create General Ledger record for Parking Journal Line No.: %1';
        Text7: Label 'Posting to General Ledger succeeded.';


    // Checks an order for a specific customer.
    // Fails in case of a one-time visit.
    //[Scope('OnPrem')]
    procedure CheckOrder(ParkingOrder: Record "SPLN_Parking Header")
    var
        ParkingHeader: Record "SPLN_Parking Header";
        ParkingLine: Record "SPLN_Parking Lines";
    begin
        ParkingOrder.TestField("Customer No.");
        ParkingOrder.TestField("Posting Date");
        ParkingOrder.TestField(Month);

        //2. Check Rental lines:
        ParkingLine.SetRange("Header No.", ParkingOrder."No.");
        if ParkingLine.FindSet then begin
            repeat
                if (ParkingLine."Line No." = 0) or (ParkingLine.Sum = 0)
                then
                    Error(StrSubstNo(Text1, ParkingLine."Line No.", ParkingLine.FieldCaption(Sum)));
            until ParkingLine.Next = 0;
        end;

        // Checks passed, rental order is OK:
        Message(Text2);

    end;

    // Returns posted parking order No.
    //[Scope('OnPrem')]
    procedure PostOrder(ParkingOrder: Record "SPLN_Parking Header"; PostToLedger: Boolean): Code[20]
    var
        ParkingHeader: Record "SPLN_Parking Header";
        ParkingLine: Record "SPLN_Parking Lines";
        ParkingJournal: Record "Parking Journal Line";
        PostedParkingLine: Record "SPLN_Posted Parking Lines";
        PostedParkingHeader: Record "SPLN_Posted Parking Header";
        ParkingOrderNo: Code[20];
    begin
        //1. Copy information to Posted Parking Header talbe:
        with PostedParkingHeader do begin
            Init;
            TransferFields(ParkingOrder);
            "Posting Date" := Today;
            "No." := '';
            if not Insert(true)
            then
                Error(StrSubstNo(Text3, ParkingOrder."No."));
        end;

        //2. Create Parking Journal line records:
        ParkingLine.SetRange("Header No.", ParkingOrder."No.");
        if ParkingLine.FindSet then begin
            repeat
                with ParkingJournal do begin
                    Init;
                    "Entry Type" := GetEntryType(ParkingOrder);
                    "Actual Date of Entry" := Today;
                    "Posting Date" := Today;
                    "Customer No." := ParkingOrder."Customer No.";
                    "Document No." := PostedParkingHeader."No.";
                    "Line No." := 0;
                    if not Insert then
                        Error(StrSubstNo(Text5, "Document No."));
                end;

                // 3. Also copy line information to Posted Parking Line:
                with PostedParkingLine do begin
                    Init;
                    TransferFields(ParkingLine);
                    "Header No." := PostedParkingHeader."No.";
                    if not Insert then Error(StrSubstNo(Text4, ParkingLine."Line No."));
                end;
            until ParkingLine.Next = 0;
        end;

        ParkingOrderNo := PostedParkingHeader."No.";
        ParkingLine.DeleteAll;
        ParkingOrder.Delete;

        if PostToLedger then PostJournalToLedger(PostedParkingHeader);

        exit(ParkingOrderNo);
    end;

    //[Scope('OnPrem')]
    procedure PostJournalToLedger(PostedParkingOrder: Record "SPLN_Posted Parking Header")
    var
        ParkingJournal: Record "Parking Journal Line";
        GeneralLedger: Record "SPLN_Parking Ledger Entry";
    begin
        ParkingJournal.SetRange("Document No.", PostedParkingOrder."No.");
        ParkingJournal.FindFirst;

        //ParkingJournal.TESTFIELD("Customer No."); // Customers can park without being registered
        ParkingJournal.TestField("Document No.");

        with GeneralLedger do repeat
                                  Init;
                                  "Entry No." := 0;
                                  "Document No." := ParkingJournal."Document No.";
                                  "Entry Type" := ParkingJournal."Entry Type";
                                  "Customer No." := ParkingJournal."Customer No.";
                                  Description := ParkingJournal.Description;
                                  "Posting Date" := ParkingJournal."Posting Date";
                                  "Actual Date of Entry" := Today;

                                  if not Insert then Error(StrSubstNo(Text6, ParkingJournal."Document No."));
                                  ParkingJournal.Delete;
            until ParkingJournal.Next = 0;
        Message(Text7);
    end;

    //[Scope('OnPrem')]
    procedure PostOneTimeVisit(ParkingOrder: Record "SPLN_Parking Header")
    begin
        PostOrder(ParkingOrder, true);

    end;

    // Maps Parking Header "Services type" to Journal "Entry Type".
    local procedure GetEntryType(ParkingOrder: Record "SPLN_Parking Header"): Integer
    var
        ParkingJournal: Record "Parking Journal Line";
    begin
        case ParkingOrder."Services Type" of
            ParkingOrder."Services Type"::Account:
                exit(ParkingJournal."Entry Type"::Account);

            ParkingOrder."Services Type"::"One-time":
                exit(ParkingJournal."Entry Type"::"One-time Park");

            ParkingOrder."Services Type"::Subscription:
                exit(ParkingJournal."Entry Type"::Subscription);
        end;
    end;
}

