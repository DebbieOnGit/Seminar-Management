codeunit 50017 "Seminar Management"
{
    // Simple CRUD operations for Seminar management via web services


    procedure CreateSeminar(
        Name: Text[50];
        SeminarDuration: Integer;
        MinimumParticipants: Integer;
        MaximumParticipants: Integer;
        SeminarPrice: Decimal;
        GenProdPostingGroup: Code[10];
        VATProdPostingGroup: Code[10];
        var SeminarNo: Code[20]) Success: Boolean
    var
        Seminar: Record "Seminar";
    begin
        if not ValidateSeminarInputs(
            Name,
            SeminarDuration,
            MinimumParticipants,
            MaximumParticipants)
        then
            exit(false);

        Seminar.Init();
        Seminar.Name := Name;
        Seminar."Seminar Duration" := SeminarDuration;
        Seminar."Minimum Participants" := MinimumParticipants;
        Seminar."Maximum Participants" := MaximumParticipants;
        Seminar."Seminar Price" := SeminarPrice;
        Seminar."Gen. Prod. Posting Group" := GenProdPostingGroup;
        Seminar."VAT Prod. Posting Group" := VATProdPostingGroup;
        Seminar."Search Name" := UpperCase(Name);

        Success := Seminar.Insert(true);
        if Success then
            SeminarNo := Seminar."No.";
    end;

    procedure GetSeminar(
        SeminarNo: Code[20];
        var Seminar: Record "Seminar") Success: Boolean
    begin
        // Explicitly find by primary key to handle hyphens
        Seminar.SetRange("No.", SeminarNo);
        Success := Seminar.FindFirst();
    end;

    procedure UpdateSeminar(
        SeminarNo: Code[20];
        Name: Text[50];
        SeminarDuration: Integer;
        MinimumParticipants: Integer;
        MaximumParticipants: Integer;
        SeminarPrice: Decimal;
        GenProdPostingGroup: Code[10];
        VATProdPostingGroup: Code[10];
        Blocked: Boolean) Success: Boolean
    var
        Seminar: Record "Seminar";
    begin
        if not Seminar.Get(SeminarNo) then
            exit(false);

        if not ValidateSeminarInputs(
            Name,
            SeminarDuration,
            MinimumParticipants,
            MaximumParticipants)
        then
            exit(false);

        Seminar.Name := Name;
        Seminar."Seminar Duration" := SeminarDuration;
        Seminar."Minimum Participants" := MinimumParticipants;
        Seminar."Maximum Participants" := MaximumParticipants;
        Seminar."Seminar Price" := SeminarPrice;
        Seminar."Gen. Prod. Posting Group" := GenProdPostingGroup;
        Seminar."VAT Prod. Posting Group" := VATProdPostingGroup;
        Seminar.Blocked := Blocked;
        Seminar."Search Name" := UpperCase(Name);

        Success := Seminar.Modify(true);
    end;

    procedure DeleteSeminar(SeminarNo: Code[20]) Success: Boolean
    var
        Seminar: Record "Seminar";
        SeminarRegHeader: Record "Seminar Registration Header";
    begin
        if not Seminar.Get(SeminarNo) then
            exit(false);

        SeminarRegHeader.SetRange("Seminar No.", SeminarNo);
        if not SeminarRegHeader.IsEmpty() then
            exit(false); // Don't use Error() in web services

        Success := Seminar.Delete(true);
    end;

    local procedure ValidateSeminarInputs(
        Name: Text[50];
        SeminarDuration: Integer;
        MinimumParticipants: Integer;
        MaximumParticipants: Integer) IsValid: Boolean
    begin
        if Name = '' then
            exit(false);
        if SeminarDuration <= 0 then
            exit(false);
        if MinimumParticipants <= 0 then
            exit(false);
        if MaximumParticipants < MinimumParticipants then
            exit(false);

        exit(true);
    end;

    // Optional: Simplified blocking procedures
    procedure BlockSeminar(SeminarNo: Code[20]) Success: Boolean
    begin
        Success := UpdateBlockedStatus(SeminarNo, true);
    end;

    procedure UnblockSeminar(SeminarNo: Code[20]) Success: Boolean
    begin
        Success := UpdateBlockedStatus(SeminarNo, false);
    end;

    local procedure UpdateBlockedStatus(SeminarNo: Code[20]; Blocked: Boolean) Success: Boolean
    var
        Seminar: Record "Seminar";
    begin
        if not Seminar.Get(SeminarNo) then
            exit(false);

        Seminar.Blocked := Blocked;
        Success := Seminar.Modify(true);
    end;

    procedure SeminarExists(SeminarNo: Code[20]) Exists: Boolean
    var
        Seminar: Record "Seminar";
    begin
        Exists := Seminar.Get(SeminarNo);
    end;

}