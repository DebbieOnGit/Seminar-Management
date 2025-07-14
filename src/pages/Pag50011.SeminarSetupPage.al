page 50011 "Seminar Setup Page"
{
    ApplicationArea = All;
    Caption = 'Seminar Setup Page';
    PageType = Card;
    SourceTable = "Seminar Setup";
    
    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    ToolTip = 'Specifies the value of the Seminar Nos. field.', Comment = '%';
                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ToolTip = 'Specifies the value of the Seminar Registration Nos. field.', Comment = '%';
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ToolTip = 'Specifies the value of the Posted Seminar Reg. Nos. field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    
    begin
        Rec.GetRecordOnce();
    end;
}
