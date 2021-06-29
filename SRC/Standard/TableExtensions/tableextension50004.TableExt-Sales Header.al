tableextension 50004 tableextension50004 extends "Sales Header"
{
    fields
    {
        field(50000; "Parking Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Posted Parking Header"."No.";
        }
        field(50001; "Issued By"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(50002; "Services Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Subscription,"One-time",Account;
        }
    }

    local procedure SPLN_CUSTOM_FUNCTIONS()
    begin
    end;

    procedure InitFromParkingHeader(ParkingHeader: Record "Parking Header")
    var
        ParkingLines: Record "Parking Lines";
    begin
        Init;
        InitRecord; // Various dates and document no. will be set due to this function call.
        "Currency Code" := 'EUR';
        "Language Code" := 'ENG';
        "Salesperson Code" := UserId;
        "Due Date" := WorkDate + 14; // Order must be paid within 14 days;
        "Document Type" := "Document Type"::Order;
        "Services Type" := ParkingHeader."Services Type";
        "Issued By" := ParkingHeader."Issued By";

        "Bill-to Customer No." := ParkingHeader."Customer No.";
        "Bill-to Name" := ParkingHeader."Customer Name";
        "Sell-to Customer No." := ParkingHeader."Customer No.";
        "Sell-to Customer Name" := ParkingHeader."Customer Name"; // More Customer-related fields can be filled here.
        // Could copy address as well

        "Due Date" := ParkingHeader.Month + 13; // 14th day of the new month
        "Currency Factor" := 1;
        "Prices Including VAT" := false;
        "Customer Posting Group" := 'DOMESTIC';
        "VAT Bus. Posting Group" := 'DOMESTIC';
        "Gen. Bus. Posting Group" := 'DOMESTIC';
        "Order Date" := Today;
        Invoice := true;

        if not Insert(true) then Error(ErrorText1);

        "Currency Code" := 'EUR';
    end;

    //[Scope('OnPrem')]
    procedure TransferParkingHeaderLines(ParkingHeader: Record "Parking Header")
    var
        ParkingLine: Record "Parking Lines";
        Item: Record Item;
        recSalesLine: Record "Sales Line";
    begin
        ParkingLine.SetRange("Header No.", ParkingHeader."No.");
        if ParkingLine.FindSet then begin
            repeat
                recSalesLine.Init;
                recSalesLine."Document No." := Rec."No.";
                recSalesLine."Document Type" := Rec."Document Type";
                recSalesLine."Line No." := ParkingLine."Line No.";
                recSalesLine."Currency Code" := 'EUR';
                recSalesLine."Gen. Bus. Posting Group" := 'DOMESTIC'; // Whatever posting groups are
                recSalesLine."Gen. Prod. Posting Group" := 'SERVICE';
                recSalesLine.Quantity := ParkingLine.Duration;

                // Get Item information for the parking service:
                recSalesLine.Type := recSalesLine.Type::Item;
                if not ParkingLine.GetItem(Item) then
                    Error(StrSubstNo(ErrorText2, ParkingLine."Line No.", ParkingHeader."No."));
                recSalesLine."No." := Item."No.";

                // Automatically calculate fields:
                recSalesLine.Validate("No.");
                recSalesLine.Validate(Quantity);

                // Set custom Sales Line fields. For some reason these fields are nullified if set before validation.
                recSalesLine."Car No." := ParkingLine."Car No.";
                recSalesLine."Entry Time" := ParkingLine."Entry Time";

                if not recSalesLine.Insert then Error(ErrorText3);
            until ParkingLine.Next = 0;
        end;
    end;

    var
        ErrorText1: Label 'Failed to create Sales Order';
        ErrorText2: Label 'Failed to get Item information for Parking Line no. %1, Header No %2.';
        ErrorText3: Label 'Failed to transfer parking registrations to parking order.';
}

