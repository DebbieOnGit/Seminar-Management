page 50019 "Seminar Comment List"
{
    ApplicationArea = All;
    Caption = 'Seminar Comments';
    PageType = List;
    SourceTable = "Seminar Comment Line";
    UsageCategory = Lists;
    Editable = false;
    LinksAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ToolTip = 'Specifies the value of the Seminar Name field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                
            }
        }
    }
}
