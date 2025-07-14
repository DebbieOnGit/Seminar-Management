table 50010 "Seminar"
{
    Caption = 'Seminar Table';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            
            begin
                if "No." <> xRec."No." then begin
                    GetSeminarSetup();
                    NoSeries.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
        }
        field(5; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            MinValue = 1;
        }
        field(6; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(7; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(8; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(9; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(10; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = exist("Comment Line" where ("Table Name" =  const (Seminar), "No." = field ("No.") )) ;
        }
        field(11; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
            MinValue = 0;
        }
        field(12; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(13; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key("No."; "Search Name")
        { }
    }
    var
        SeminarSetup: Record "Seminar Setup";
        NoSeries: Codeunit "No. Series";
        SetupRead: Boolean;
    
    trigger OnInsert()
    begin
        if "No." = '' then begin
            GetSeminarSetup();
            TestNoSeries();
            "No. Series" := SeminarSetup."Seminar Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
        
        // Clear the setup cache for next record
        Clear(SeminarSetup);
        SetupRead := false;
    end;
    
    procedure AssistEdit(OldSeminar: Record "Seminar"): Boolean
    var
        NewSeminar: Record "Seminar";
    begin
        NewSeminar := Rec;
        GetSeminarSetup();
        TestNoSeries();
        
        if NoSeries.LookupRelatedNoSeries(SeminarSetup."Seminar Nos.", OldSeminar."No. Series", NewSeminar."No. Series") then begin
            NewSeminar."No." := NoSeries.GetNextNo(NewSeminar."No. Series", WorkDate());
            Rec := NewSeminar;
            OnAfterAssistEdit(Rec, OldSeminar);
            exit(true);
        end;
        
        exit(false);
    end;
    
    local procedure GetSeminarSetup()
    begin
        if SetupRead then
            exit;
            
        if not SeminarSetup.Get() then
            SeminarSetup.Insert(true);
            
        SetupRead := true;
    end;
    
    local procedure TestNoSeries()
    begin
        GetSeminarSetup();
        SeminarSetup.TestField("Seminar Nos.");
    end;
    
    [IntegrationEvent(false, false)]
    local procedure OnAfterAssistEdit(var Seminar: Record "Seminar"; OldSeminar: Record "Seminar")
    begin
        // Integration event for extensibility
    end;
}
