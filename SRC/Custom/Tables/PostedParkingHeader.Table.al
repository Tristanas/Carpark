table 61012 "SPLN_Posted Parking Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Month; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Issued By"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(5; "Total Park Visits"; Integer)
        {
            CalcFormula = Count("SPLN_Posted Parking Lines" WHERE("Header No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Total Hours Parked"; Decimal)
        {
            CalcFormula = Sum("SPLN_Posted Parking Lines".Duration WHERE("Header No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Services Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Subscription,"One-time",Account;
        }
        field(11; Sum; Decimal)
        {
            CalcFormula = Sum("SPLN_Posted Parking Lines".Sum WHERE("Header No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        ParkingSetup: Record "SPLN_Parking Setup";
    begin
        if "No." = '' then begin
            ParkingSetup.Get;
            ParkingSetup.TestField("Posted Parking Nos.");
            NoSeriesMgt.InitSeries(ParkingSetup."Posted Parking Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

