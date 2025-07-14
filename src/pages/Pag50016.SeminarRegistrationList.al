page 50016 "Seminar Registration List"
{
    ApplicationArea = All;
    Caption = 'Seminar Registration List';
    PageType = List;
    SourceTable = "Seminar Registration Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Seminar Registration Page";
    
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
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.', Comment = '%';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.', Comment = '%';
                }
                field("Room No."; Rec."Room No.")
                {
                    ToolTip = 'Specifies the value of the Room No. field.', Comment = '%';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.', Comment = '%';
                }
            }

            //part
        }
    }
}
