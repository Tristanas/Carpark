pageextension 50003 "SPLN_pageextension50003" extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field("SPLN_CurrCode"; SPLN_Currency)
            {
                ApplicationArea = All;
            }
        }
    }
}