codeunit 50016 "Seminar-Post"
{
    Subtype = Normal;

    procedure PostSeminarRegistration(SeminarHeader: Record "Seminar Registration Header")
    var
        PostedHeader: Record "Posted Seminar Reg. Header";
        PostedLine: Record "Posted Seminar Reg Line";
        SeminarLine: Record "Seminar Registration Line";
        NoSeriesMgt: Codeunit "No. Series";
        SeminarSetup: Record "Seminar Setup";
        SourceCodeSetup: Record "Source Code Setup";
        SeminarLedgerEntry: Record "Seminar Ledger Entry";

    begin
        SeminarHeader.TestField(Status, SeminarHeader.Status::Closed);
        SeminarHeader.TestField("Seminar No.");
        SeminarHeader.TestField("Instructor No.");
        SeminarHeader.TestField("Room No.");


        //Load Setup
        SeminarSetup.Get();
        SourceCodeSetup.Get();
        SeminarSetup.TestField("Posted Seminar Reg. Nos.");

        //Generate Posted Document No.
        PostedHeader.Init();
        PostedHeader.TransferFields(SeminarHeader, true, true);
        PostedHeader."No." := NoSeriesMgt.GetNextNo(SeminarSetup."Posted Seminar Reg. Nos.", WorkDate(), true);
        PostedHeader."No. Series" := SeminarSetup."Posted Seminar Reg. Nos.";
        PostedHeader."Source Code" := SourceCodeSetup.Seminar;
        PostedHeader."User ID" := UserId;
        PostedHeader.Insert(true);

        //Copy Lines
        SeminarLine.SetRange("Document No.", SeminarHeader."No.");
        if SeminarLine.FindSet() then begin
            repeat
                PostedLine.Init();
                PostedLine.TransferFields(SeminarLine, true, true);
                PostedLine."Document No." := PostedHeader."No.";
                PostedLine.Insert();

                if SeminarLine."To invoice" then begin
                    InsertLedgerEntry(
                        SeminarHeader."Seminar No.",
                        PostedHeader."No.",
                        SeminarLine."Bill-to Customer No.",
                        SeminarLine."Participant Contact No.",
                        SeminarLine."Participant Name",
                        SeminarLedgerEntry."Entry Type"::Participant,
                        //SeminarLedgerEntry."Charge Type"::Resource,
                        1,
                        SeminarLine.Amount,
                        SeminarHeader."Room No.",
                        SeminarHeader."Instructor No."
                    );
                end;
            until SeminarLine.Next() = 0;
            Message('Seminar Registation %1 has been posted successfully.');
        end;
    end;

    procedure InsertLedgerEntry(
        SeminarNo: Code[20];
        RegNo: Code[20];
        BillToCustNo: Code[20];
        ContactNo: Code[20];
        ParticipantName: Text[100];
        EntryType: Enum "Seminar Entry Type";
        //ChargeType: Enum "Seminar Charge Type";
        Qty: Decimal;
        UnitPrice: Decimal;
        RoomNo: Code[20];
        InstructorNo: Code[20]
    );
    var
        LedgerEntry: Record "Seminar Ledger Entry";
        SeminarSetup: Record "Seminar Setup";
        SourceCodeSetup: Record "Source Code Setup";

    begin
        SeminarSetup.Get();
        SourceCodeSetup.Get();

        LedgerEntry.Init();
        LedgerEntry."Entry No." := GetNextEntryNo();
        LedgerEntry."Seminar No." := SeminarNo;
        LedgerEntry."Seminar Registration No." := RegNo;
        LedgerEntry."Posting Date" := WorkDate();
        LedgerEntry."Document Date" := WorkDate();
        LedgerEntry."Document No." := RegNo;
        LedgerEntry."Entry Type" := EntryType;
        //LedgerEntry."Charge Type" := ChargeType;
        LedgerEntry.Quantity := Qty;
        LedgerEntry."Unit Price" := UnitPrice;
        LedgerEntry."Total Price" := Round(Qty * UnitPrice, 0.01);
        LedgerEntry."Participant Contact No." := ContactNo;
        LedgerEntry."Participant Name" := ParticipantName;
        LedgerEntry."Bill-to Customer No." := BillToCustNo;
        LedgerEntry."Room No." := RoomNo;
        LedgerEntry."Instructor No." := InstructorNo;
        LedgerEntry."Source Type" := LedgerEntry."Source Type"::Seminar;
        LedgerEntry."Source No." := SeminarNo;
        LedgerEntry."Source Code" := SourceCodeSetup.Seminar;
        LedgerEntry."User ID" := UserId;
        LedgerEntry.Insert(true);
    end;

    procedure GetNextEntryNo(): Integer
    var
        LedgerEntry: Record "Seminar Ledger Entry";

    begin
        LedgerEntry.LockTable();
        if LedgerEntry.FindLast() then
            exit(LedgerEntry."Entry No." + 1)
        else
            exit(1);
    end;
}
