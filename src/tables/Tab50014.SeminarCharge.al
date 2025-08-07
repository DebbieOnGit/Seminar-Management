table 50014 "Seminar Charge"
{
    Caption = 'Seminar Charge';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Seminar Registration Header";
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
            TableRelation = if ("Charge Type" = const(Resource)) Resource where(Type = const(Person), Blocked = const(false))
            else if ("Charge Type" = const("G/L Account")) "G/L Account" where(Blocked = const(false));

        }
        field(5; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(6; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()

            begin
                "Total Amount" := "Unit Price" * "Quantity";
            end;
        }
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';

        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(9; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "General Ledger Setup";
        }
        
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        SeminarRegHeader: Record "Seminar Registration Header";
    begin
        if not SeminarRegHeader.Get("Document No.") then
            Error('Seminar registration does not exist. Cannot add charge.');
    end;


}
