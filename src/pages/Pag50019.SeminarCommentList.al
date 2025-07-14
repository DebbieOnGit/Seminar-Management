page 50019 "Seminar Comment List"
{
    ApplicationArea = All;
    Caption = 'Seminar Comment List';
    PageType = List;
    SourceTable = "Seminar Comment Line";
    UsageCategory = None;
    Editable = false;
    LinksAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
            }
        }
    }
}
