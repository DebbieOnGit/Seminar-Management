table 50013 "Seminar Comment Line"
{
    Caption = 'Seminar Comment Line';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Comment Line";
    
    fields
    {
        field(1; "Document Type"; Enum "Seminar Comment Doc Type")
        {
            Caption = 'Document Type';
            
            TableRelation = Seminar;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Seminar;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(5; Date; Date)
        {
            Caption = 'Date';
        }
        field(6; Code; Code[20])
        {
            Caption = 'Code';
        }
    }
    keys
    {
        key(PK; "Document Type", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SeminarRec: Record Seminar;
    begin
        if not SeminarRec.Get("No.") then
            Error('Seminar does not exist. Cannot add comment');
    end;
}
