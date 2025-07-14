    // TODO: Implement DataClassification for Privacy
table 50018 "Seminar Ledger Entry"
{
    Caption = 'Seminar Ledger Entry';
    DataClassification = ToBeClassified;

    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "Seminar Registration Header";
        }
        field(7; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(8; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact where (Type = const(Person));
        }
        field(9; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
        }
        field(10; "Entry Type"; Enum "Seminar Entry Type")
        {
            Caption = 'Entry Type';
        }
        // field(11; "Charge Type"; Enum "Seminar Charge Type")
        // {
        //     Caption = 'Charge Type';
        // }
        field(12; "Instructor No."; Code[20])
        {
            Caption = 'Instructor No.';
            TableRelation = Resource where (Type = const(Person));
        }
        field(13; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            TableRelation = Resource where ( Type = const(Room));
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(15; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(16; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
        }
        field(17; "Source Type"; Enum "Source Type")
        {
            Caption = 'Source Type';
        }
        field(18; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(19; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(20; "Res. Ledger Entry No."; Integer)
        {
            Caption = 'Res. Ledger Entry No.';
        }
        field(21; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
            
        }
        field(22; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(23; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field (24; Description ; Text[100])
        {
            Caption = 'Description'; 
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
