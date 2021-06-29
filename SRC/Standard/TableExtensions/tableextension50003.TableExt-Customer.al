tableextension 50003 tableextension50003 extends Customer
{
    fields
    {
        field(50000; Company; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(50001; "Payment type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Subscription,"One-time",Account;
        }
        field(50002; DemoCust; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
        }
        field(50003; "Latest Monthly Payment"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Latest Billing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        // key(Key1; "Salesperson Code")
        // {
        // }
    }

    trigger OnBeforeDelete()
    begin
        Car.SetRange("Customer No.", "No.");
        Car.DeleteAll;
    end;

    trigger OnBeforeInsert()
    begin
        "Currency Code" := 'EUR';
    end;

    procedure UpdateCreditLimit(var NewCreditLimit: Decimal)
    begin
        NewCreditLimit := Round(NewCreditLimit, 10000);
        Rec.Validate("Credit Limit (LCY)", NewCreditLimit);
        Rec.Modify;
    end;

    procedure CalculateCreditLimit(): Decimal
    var
        Cust: Record Customer;
    begin
        Cust := Rec;
        Cust.SetRange("Date Filter", CalcDate('<-12M>', WorkDate), WorkDate);
        Cust.CalcFields("Sales (LCY)", "Balance (LCY)");
        exit(Round(Cust."Sales (LCY)" * 0.5));
    end;

    var
        Car: Record Car;
}

