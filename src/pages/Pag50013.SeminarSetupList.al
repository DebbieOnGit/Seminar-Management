page 50013 "Seminar Setup List"
{
    ApplicationArea = All;
    Caption = 'Seminar Setup';
    PageType = List;
    SourceTable = "Seminar Setup";
    UsageCategory = Lists;
    CardPageId = "Seminar Setup Page";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
}
