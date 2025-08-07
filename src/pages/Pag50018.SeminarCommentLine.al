page 50018 "Seminar Comment Line"
{
    ApplicationArea = All;
    Caption = 'Seminar Comment Line';
    PageType = List;
    SourceTable = "Seminar Comment Line";
    UsageCategory = None;
    LinksAllowed = false;
    MultipleNewLines = true;
    DelayedInsert = true;
   // AutoSplitKey = true;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field( "Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
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
