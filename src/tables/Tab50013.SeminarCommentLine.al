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
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = if ("Document Type" = const("Seminar Registration")) "Seminar Registration Header" else if ("Document Type" = const("Posted Seminar Registration")) "Posted Seminar Reg. Header";
            Editable = false;
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
        field(6; "Seminar Name"; Text[100])
        {
            Caption = 'Seminar Name';
            TableRelation = if ("Document Type" = const("Seminar Registration")) "Seminar Registration Header" else if ("Document Type" = const("Posted Seminar Registration")) "Posted Seminar Reg. Header";
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
        SeminarRegheader: Record "Seminar Registration Header";
        PostedReg: Record "Posted Seminar Reg. Header";
    begin
        case "Document Type" of
            "Document Type"::"Seminar Registration":
                if not SeminarRegheader.Get("Document No.") then
                    Error('Seminar Registration does not exist');
            "Document Type"::"Posted Seminar Registration":
                if not PostedReg.Get("Document No.") then
                    Error('Posted Seminar Registration does not exist');

        end;
        Date := Today();
    end;
}
