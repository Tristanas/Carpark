pageextension 50003 pageextension50003 extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field(CurrCode; Currency)
            {
                ApplicationArea = All;
            }
        }
    }
}