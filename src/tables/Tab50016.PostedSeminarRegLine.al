table 50016 "Posted Seminar Reg Line"
{
    Caption = 'Posted Seminar Reg Line';
    DataClassification = ToBeClassified;
    
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
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
        }
        field(5; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
        }
        field(6; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(7; "To invoice"; Boolean)
        {
            Caption = 'To invoice';
        }
        // field(8; Participated; Boolean)
        // {
        //     Caption = 'Participated';
        // }
        field(9; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
        }
        field(10; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
        }
        field(11; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(13; Registered; Boolean)
        {
            Caption = 'Registered';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
