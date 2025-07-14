page 50023 "Posted Seminar Reg. List"
{
    ApplicationArea = All;
    Caption = 'Posted Seminar Reg. List';
    PageType = List;
    SourceTable = "Posted Seminar Reg. Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Posted Seminar Reg. Page";
    
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
                field("Seminar No."; Rec."Seminar No.")
                {
                    ToolTip = 'Specifies the value of the Seminar No. field.', Comment = '%';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ToolTip = 'Specifies the value of the Seminar Name field.', Comment = '%';
                }
                field("Room No."; Rec."Room No.")
                {
                    ToolTip = 'Specifies the value of the Room No. field.', Comment = '%';
                }
                field("Insructor No."; Rec."Insructor No.")
                {
                    ToolTip = 'Specifies the value of the Insructor No. field.', Comment = '%';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.', Comment = '%';
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Specifies the value of the Price field.', Comment = '%';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the value of the Source Code field.', Comment = '%';
                }
            }
            systempart(RecordLinks; Links)
            {
                ApplicationArea = RecordLinks;

            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
        
    }
}
