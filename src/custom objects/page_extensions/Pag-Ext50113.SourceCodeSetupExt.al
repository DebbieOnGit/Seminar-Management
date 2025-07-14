pageextension 50113 "Source Code Setup Ext" extends "Source Code Setup"
{
    layout
    {
        addafter(General)
        {
            group("Seminar Management")
            {
                field(Seminar;Rec.Seminar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source code used for Seminar Postings.';
                }
            }
            
        }
    }
}
