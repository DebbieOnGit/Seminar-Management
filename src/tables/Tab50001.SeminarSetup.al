table 50001 "Seminar Setup"
{
    Caption = 'Seminar Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Setup List";
    
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Seminar Nos."; Code[20])
        {
            Caption = 'Seminar Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Seminar Registration Nos."; Code[20])
        {
            Caption = 'Seminar Registration Nos.';
            TableRelation = "No. Series";
        }
        field(4; "Posted Seminar Reg. Nos."; Code[20])
        {
            Caption = 'Posted Seminar Reg. Nos.';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    procedure GetRecordOnce()
    begin
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;
}
