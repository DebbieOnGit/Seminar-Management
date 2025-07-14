page 50020 "Seminar Charges"
{
    ApplicationArea = All;
    Caption = 'Seminar Charges';
    PageType = List;
    SourceTable = "Seminar Charge";
    UsageCategory = Lists;
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Registration No. field.', Comment = '%';
                }
                field( "Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ToolTip = 'Specifies the value of the Charge Type field.', Comment = '%';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Speciifies the value of the Unit Price field', Comment = '%';
                }
                field("Quantity"; Rec.Quantity)
                {
                    ToolTip = 'Speciifies the value of the Quantity field', Comment = '%';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.', Comment = '%';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer Number field.', Comment = '%';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the value of the G/L Account No. field.', Comment = '%';
                }
                field(Registered; Rec.Registered)
                {
                    ToolTip = 'Specifies the value of the Registered field.', Comment = '%';
                }
            }
        }
    }
}
