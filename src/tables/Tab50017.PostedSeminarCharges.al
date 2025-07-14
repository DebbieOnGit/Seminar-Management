table 50017 "Posted Seminar Charges"
{
    Caption = 'Posted Seminar Charges';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Charges";
    
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Charge Type"; Enum "Seminar Charge Type")
        {
            Caption = 'Charge Type';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(9; "G/L Account No."; Decimal)
        {
            Caption = 'G/L Account No.';
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
        }
        field(11; Registered; Boolean)
        {
            Caption = 'Registered';
        }
        field(12; "To invoice"; Boolean)
        {
            Caption = 'To invoice';
        }
    }
    keys
    {
        key(PK; "Document No.","Line No.")
        {
            Clustered = true;
        }
    }
}
