table 50012 "Seminar Registration Line"
{
    Caption = 'Seminar Registration Line';
    DataClassification = ToBeClassified;
    LookupPageId = "Seminar Registration Line";
    DrillDownPageId = "Seminar Registration Line";

    // TODO: Round off using  GLSetup instead of hard coding

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

            trigger OnValidate()

            begin
                if "Line No." = xRec."Line No."
                then
                    exit;
                "Seminar Price" := SeminarRegHeader."Price";
            end;

        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer where(Blocked = const(" "));


        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact where(Type = const(Person));


            trigger OnValidate()
            begin
                // if not Contact.Get("Participant Contact No.")then
                //     Error('Contact %1 does not exist', "Participant Contact No.");
                ValidateParticipantContact();

            end;

            trigger OnLookup()

            begin
                LookUpParticipantContact();

            end;
        }
        field(5; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            TableRelation = Contact where(Type = const(Person));
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = FIELD("Participant Contact No.")));

        }
        field(15; "Is individual Participant"; Boolean)
        {
            Caption = 'Is Individual Customer';
            Description = 'Indicates if the Bill-to Customer is an individual person instead of a company. ';
        }
        field(6; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            Editable = false;
        }
        field(7; "To invoice"; Boolean)
        {
            Caption = 'To invoice';
            InitValue = true;
        }
        // field(8; Participated; Boolean)
        // {
        //     Caption = 'Participated';
        //     InitValue = false;
        // }
        field(9; "Seminar Price"; Decimal)
        {
            Caption = 'Price';
            AutoFormatType = 2;

            trigger OnValidate()

            begin

                Validate("Line Discount %");
            end;
        }
        field(10; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 4;

            trigger OnValidate()

            begin
                
                "Line Discount Amount" := Round("Line Discount %" * SeminarRegHeader.Price * 0.01, GLSetup."Amount Rounding Precision"); 
                
                UpdateAmount();
            end;
        }
        field(11; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            trigger OnValidate()

            begin
                
                "Line Discount Amount" := SeminarRegHeader.Price - Amount;
                "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, 0.01);
                
                UpdateAmount();
            end;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()

            begin
                TestField("Bill-to Customer No.");
                
                Amount := Round(Amount, GLSetup."Amount Rounding Precision");
                
                "Line Discount %" := Round("Line Discount Amount" / SeminarRegHeader.Price * 100, 0.01);
                
                UpdateAmount();
            end;
        }
        field(13; Registered; Boolean)
        {
            Caption = 'Registered';
            Editable = false;
            InitValue = false;

        }
        field(14; Invoiced; Boolean)
        {
            Caption = 'Invoiced';
            Editable = false;
            InitValue = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        ContactList: Page "Contact List";
        GLSetup: Record "General Ledger Setup";

    trigger OnInsert()

    begin
        if SeminarRegHeader."No." <> "Document No." then
            SeminarRegHeader.Get("Document No.");

        if SeminarRegHeader.Status <> SeminarRegHeader.Status::Registration then
            Error('Participants can only be added when the seminar registration is in registration status.');

        Rec."Registration Date" := Today;
        Rec."Seminar Price" := SeminarRegHeader."Price";
        //Amount := SeminarRegHeader."Price";

    end;

    trigger OnDelete()

    begin
        TestField(Registered, false);
    end;


    /// <summary>
    /// UpdateAmount.
    /// This procedure updates the Amount that should be paid for a seminar after a discount.
    /// </summary>
    procedure UpdateAmount()

    begin
        Amount := Round("Seminar Price" - "Line Discount Amount", 0.0001);
    end;


    /// <summary>
    /// ValidateParticipantContact.
    /// This procedure checks if the "Participant Contact No." is not empty and retrieves the contact's name.
    /// If the contact does not exist, it raises an error.
    /// </summary>
    procedure ValidateParticipantContact()
    begin
        if "Participant Contact No." <> '' then begin
            if not Contact.Get("Participant Contact No.") then
                Error('The selected participant contact does not exist');

            "Participant Name" := Contact.Name;

        end else
            "Participant Name" := '';
    end;


    /// <summary>
    /// LookUpParticipantContact.
    /// This procedure opens a lookup page for selecting a participant contact.
    /// It filters the contacts to only show those of type Person.
    /// </summary>
    procedure LookUpParticipantContact()
    begin
        Contact.Reset();
        Contact.SetRange(Type, Contact.Type::Person);
        if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then
            Validate("Participant Contact No.", Contact."No.");
    end;

}
