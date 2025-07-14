page 50015 "Seminar Registration Line"
{
    ApplicationArea = All;
    Caption = 'Seminar Registration Lines';
    PageType = ListPart;
    SourceTable = "Seminar Registration Line";
    DelayedInsert = true;
    AutoSplitKey = true;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.', Comment = '%';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ToolTip = 'Specifies the value of the Participant Contact No. field.', Comment = '%';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ToolTip = 'Specifies the value of the Participant Name field.', Comment = '%';
                }
                field("Is individual Participant";Rec."Is individual Participant")
                {
                    ToolTip = 'Specifies if the Bill-to Customer is an individual person instead of a company. ';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ToolTip = 'Specifies the value of the Registration Date field.', Comment = '%';
                }
                field("To invoice"; Rec."To invoice")
                {
                    ToolTip = 'Specifies the value of the To invoice field.', Comment = '%';
                }
                field(Registered; Rec.Registered)
                {
                    ToolTip = 'Specifies the value of the Registered field.', Comment = '%';
                }
                field(Participated; Rec.Participated)
                {
                    ToolTip = 'Specifies the value of the Participated field.', Comment = '%';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ToolTip = 'Specifies the value of the Seminar Price field.', Comment = '%';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the value of the Line Discount % field.', Comment = '%';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Line Discount Amount field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
            }
        }
    }

}
