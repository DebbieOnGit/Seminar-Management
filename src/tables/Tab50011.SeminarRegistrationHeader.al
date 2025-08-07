table 50011 "Seminar Registration Header"
{
    Caption = 'Seminar Registration Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Registration List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()

            begin
                if "No." <> xRec."No." then begin
                    GetSeminarSetup();
                    NoSeries.TestManual(SeminarSetup."Seminar Registration Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }

        field(2; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar where(Blocked = const(false));
            NotBlank = true;

            trigger OnValidate()

            begin
                if "Seminar No." = xRec."Seminar No." then
                    exit;

                Seminar.Get("Seminar No.");
                Seminar.Testfield(Blocked, false);
                Seminar.TestField("Gen. Prod. Posting Group");
                Seminar.TestField("VAT Prod. Posting Group");
                "Seminar Name" := Seminar.Name;
                Duration := Seminar."Seminar Duration";
                Price := Seminar."Seminar Price";
                "Gen. Prod. Posting Group" := Seminar."Gen. Prod. Posting Group";
                "VAT Prod. Posting Group" := Seminar."VAT Prod. Posting Group";
                "Maximum Participants" := Seminar."Maximum Participants";
                "Minimum Participants" := Seminar."Minimum Participants";
            end;
        }
        field(3; "Seminar Name"; Text[100])
        {
            Caption = 'Seminar Name';
        }
        field(4; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            TableRelation = Resource where(Type = const(Room));

            trigger OnValidate()
            var
                SeminarRoom: Record Resource;
            begin
                if "Room No." = xRec."Room No." then
                    exit;

                if "Room No." = '' then begin
                    "Room Name" := '';
                    "Room Address" := '';
                end else begin
                    SeminarRoom.Get("Room No.");
                    "Room Name" := SeminarRoom.Name;
                    "Room Address" := SeminarRoom.Address;
                end;

                if (SeminarRoom."Maximum Participants" <> 0) and
                   (SeminarRoom."Maximum Participants" < "Maximum Participants") then
                    Error('The maximum number of participants in the seminar is %1, which is more than the maximum number of participants in the room. The room chosen cannot hold this capacity.', Seminar."Maximum Participants");
                "Maximum Participants" := SeminarRoom."Maximum Participants";

                CheckRoomAvailability();

            end;
        }
        field(5; "Room Name"; Text[100])
        {
            Caption = 'Room Name';

        }
        field(6; "Room Address"; Text[100])
        {
            Caption = 'Room Address';
        }
        field(7; "Instructor No."; Code[20])
        {
            Caption = 'Instructor No.';
            TableRelation = Resource where(Type = const(Person));

            trigger OnValidate()
            var
                Instructor: Record Resource;
            begin
                if "Instructor No." = '' then
                    "Instructor Name" := ''
                else begin
                    Instructor.Get("Instructor No.");
                    "Instructor Name" := Instructor.Name;
                end;
            end;
        }
        field(8; "Instructor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;

            trigger OnValidate()

            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Status::Planning);
                if "Starting Date" < Today() then
                    Error('Starting Date cannot be earlier than today.');
            end;
        }
        field(10; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            NotBlank = true;

            trigger OnValidate()
            var
                Today: Date;
            begin
                Today := Today();
                if Rec."Ending Date" < Rec."Starting Date" then
                    Error('Ending Date cannot be earlier than Starting Date.');
                // if Rec."Ending Date" < Today then
                //     Error('Ending Date cannot be earlier than today.');
            end;
        }
        field(11; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(12; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(13; Price; Decimal)
        {
            Caption = 'Price';
            //TableRelation 
        }

        field(14; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

        }
        field(15; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

        }
        field(16; Duration; Integer)
        {
            Caption = 'Duration';

        }
        field(17; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(18; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
        }
        field(19; Status; Enum "Seminar Registration Status")
        {
            Caption = 'Status';
            Editable = false;

            // Reset to remove previous filters, then set registered as true
            // so all lines are registered when a seminar registration is closed 
            trigger OnValidate()
            var
                SeminarRegLine: Record "Seminar Registration Line";
            begin
                if Status in [Status::Closed] then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.ModifyAll(Registered, true);
                end
            end;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        SeminarSetup: Record "Seminar Setup";
        NoSeries: Codeunit "No. Series";
        SetupRead: Boolean;
        Seminar: Record Seminar;
        SeminarRegLine: Record "Seminar Registration Line";
        CannotDeleteRegisteredLinesErr: Label 'Cannot delete registered lines because there are %2 lines with %3 set to %4. Please cancel the registrations first.'; // %1 = Table Name, %2 = Count, %3 = Field Name, %4 = Value
        CannotDeleteWithChargesErr: Label 'Cannot delete registration with charges. Please remove the charges first.';

    trigger OnModify()

    begin
        "Last Date Modified" := Today();
        if Status in [Status::Cancelled, Status::Closed] then
            Error('You cannot modify a seminar registration that is cancelled or closed.');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GetSeminarSetup();
            TestNoSeries();
            "No. Series" := SeminarSetup."Seminar Registration Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series", WorkDate());
        end;
    end;

    trigger OnDelete()

    begin
        // Delete all lines related to this header and are registered
        TestField(Status, Status::Cancelled);
        SeminarRegLine.Reset(); // clear any filters while deleting
        SeminarRegLine.SetRange("Document No.", "No."); // filter lines for this header, Document No. matches No.
        SeminarRegLine.SetRange(Registered, true); // only delete lines that are registered
        if not SeminarRegLine.IsEmpty() then
            Error(CannotDeleteRegisteredLinesErr,
                  SeminarRegLine.TableCaption(),
                  SeminarRegLine.Count(),
                  SeminarRegLine.FieldCaption(Registered),
                  Format(true));
        // call procedure to validate that lines being deleted do not have charges          
        ValidateNoCharges();
        DeleteRelatedRecords();
    end;

    /// <summary>
    /// AssistEdit.
    /// This procedure is used to assist in editing the seminar registration header.
    /// It checks if the No. Series is related to the Seminar Registration Nos. and updates
    /// the No. Series and No. fields accordingly.
    /// If the No. Series is not related, it returns false.
    /// </summary>
    /// <param name="OldReg">The old seminar registration header record.</param>
    /// <returns>True if the No. Series is related and updated, otherwise false.</returns>

    procedure AssistEdit(OldReg: Record "Seminar Registration Header"): Boolean
    var
        NewReg: Record "Seminar Registration Header";
    begin
        NewReg := Rec;
        GetSeminarSetup();
        TestNoSeries();

        if NoSeries.LookupRelatedNoSeries(SeminarSetup."Seminar Registration Nos.", OldReg."No. Series", NewReg."No. Series") then begin
            NewReg."No." := NoSeries.GetNextNo(NewReg."No. Series", WorkDate());
            Rec := NewReg;

            exit(true);
        end;
        exit(false);
    end;

    /// <summary>
    /// GetSeminarSetup.
    /// This procedure retrieves the Seminar Setup record.
    /// It checks if the setup has already been read to avoid unnecessary database calls.
    /// If the setup has not been read, it retrieves the record and sets the SetupRead flag to true.
    /// This is used to ensure that the Seminar Setup is available for operations related to seminar registrations
    /// </summary>

    local procedure GetSeminarSetup()
    begin
        if SetupRead then
            exit;

        SeminarSetup.GetRecordOnce();
        SetupRead := true;
    end;

    local procedure TestNoSeries()
    begin
        GetSeminarSetup();
        SeminarSetup.TestField("Seminar Registration Nos.");
    end;

    /// <summary>
    /// ValidateNoCharges.
    /// This procedure checks if there are any charges associated with the seminar registration.
    /// If there are charges with a total amount not equal to zero,
    /// it raises an error indicating that the registration cannot be deleted.
    /// </summary>
    local procedure ValidateNoCharges()
    var
        SeminarCharge: Record "Seminar Charge";
    begin
        SeminarCharge.SetLoadFields("Document No."); // load only the Document No. field ; helps to optimize performance 
        SeminarCharge.SetRange("Document No.", "No.");

        if not SeminarCharge.IsEmpty() then begin
            SeminarCharge.CalcFields("Total Amount");
            if SeminarCharge."Total Amount" <> 0 then
                Error(CannotDeleteWithChargesErr,
                      SeminarCharge.TableCaption());
        end;
    end;

    local procedure DeleteRelatedRecords()
    var
        SeminarRegLine: Record "Seminar Registration Line";
        SeminarComment: Record "Seminar Comment Line";

    begin
        // delete all lines related to this header
        SeminarRegLine.SetRange("Document No.", "No.");
        if not SeminarRegLine.IsEmpty() then
            SeminarRegLine.DeleteAll(true);

        // delete all related records in the Seminar Comment table
        SeminarComment.SetRange("Document Type", SeminarComment."Document Type"::"Seminar Registration");
        SeminarComment.SetRange("Document No.", "No.");
        if not SeminarComment.IsEmpty() then
            SeminarComment.DeleteAll(true);
    end;

    // 'SetRange' is a cumulative filter, meaning that it adds to any existing filters on the record.
    // set a filter on the starting date field to check records where starting data falls within the same date range as the seminar registration
    // set another flter on the ending date field to check records where ending date falls within the same date range as the seminar registration 
    local procedure CheckRoomAvailability()
    var
        SeminarRoom: Record Resource;
        SeminarRegHeader: Record "Seminar Registration Header";
    begin
        SeminarRegHeader.SetRange("Room No.", "Room No.");
        SeminarRegHeader.SetRange("Starting Date", "Starting Date", "Ending Date");
        SeminarRegHeader.SetRange("Ending Date", "Starting Date", "Ending Date");
        if SeminarRegHeader.FindFirst() then
            Error('The room %1 is already booked for the period from %2 to %3.', "Room No.", Format("Starting Date"), Format("Ending Date"));
    end;
}
