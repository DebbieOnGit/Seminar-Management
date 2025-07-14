page 50012 "Seminar List"
{
    ApplicationArea = All;
    Caption = 'Seminars';
    PageType = List;
    SourceTable = Seminar;
    UsageCategory = Lists;
    CardPageId = "Seminar Card";
    Editable = false;
    

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
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ToolTip = 'Specifies the value of the Seminar Duration field.', Comment = '%';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ToolTip = 'Specifies the value of the Seminar Price field.', Comment = '%';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.', Comment = '%';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(SeminarLinks; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(SeminarNotes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
}
