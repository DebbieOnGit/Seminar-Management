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
