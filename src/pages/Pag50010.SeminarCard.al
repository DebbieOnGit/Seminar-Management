page 50010 "Seminar Card"
{
    ApplicationArea = All;
    Caption = 'Seminar Card';
    PageType = Card;
    SourceTable = Seminar;


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.") 
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    Editable = false;
                    // Importance = Standard;
                    trigger OnAssistEdit()

                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ToolTip = 'Specifies the value of the Seminar Duration field.', Comment = '%';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ToolTip = 'Specifies the value of the Minimum Participants field.', Comment = '%';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.', Comment = '%';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.', Comment = '%';
                }
            }
            group(Invoicing)
            {
                Caption = ' Invoicing';

                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.', Comment = '%';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.', Comment = '%';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ToolTip = 'Specifies the value of the Seminar Price field.', Comment = '%';
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
    actions
    {
        area(Processing)
        {
            action(Setup)
            {
                ApplicationArea = All;
                Caption = 'Setup';
                Image = Setup;
                RunObject = Page "Seminar Setup Page";
                ToolTip = 'Open the seminar setup page.';

            }


        }
    }
}
