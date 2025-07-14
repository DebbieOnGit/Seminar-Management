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
        field(8; Participated;Boolean)
        {
            Caption = 'Participated';
            InitValue = false;
        }
        field(9; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
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
            DecimalPlaces = 0:4;

            trigger OnValidate()
            
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount Amount" := 0;
                end else begin 
                    "Line Discount Amount" := Round("Line Discount %" * "Seminar Price" * 0.01, 0.0001);
                end;
                UpdateAmount();
            end;
        }
        field(11; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            trigger OnValidate()
            
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0;
                end else begin
                    "Line Discount Amount" := "Seminar Price" - Amount;
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, 0.01);
                end;
                UpdateAmount();
            end;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                Amount := Round(Amount, 0.0001);
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0;
                    "Line Discount Amount" := 0;
                end else begin
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, 0.01);
                end;
            end;
        }
        field(13; Registered; Boolean)
        {
            Caption = 'Registered';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.","Line No.")
        {
            Clustered = true;
        }
    }

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        ContactList: Page "Contact List";

    trigger OnInsert()
   
    begin
        if SeminarRegHeader."No." <> "Document No." then
            SeminarRegHeader.Get("Document No.");

        if SeminarRegHeader.Status <> SeminarRegHeader.Status::Registration then
            Error('Participants can only be added when the seminar registration is in registration status.');
    
        "Registration Date" := WorkDate();    
        "Seminar Price" := SeminarRegHeader."Price";
        Amount := SeminarRegHeader."Price" ;
        
    end;

    trigger OnDelete()
    
    begin
        TestField(Registered, false);
    end;


    procedure UpdateAmount()

    begin
        Amount:= Round("Seminar Price" - "Line Discount Amount", 0.0001);
    end;

    // procedure ValidateParticipantContact()
    // var
    //     CompanyContactNo: Code[20];
    // begin
    //     if not ShouldValidateParticipantContact() then
    //         exit;
    //     if not Contact.Get("Participant Contact No.") then
    //         Error('Contact %1 does not exist.', "Participant Contact No.");
        
    //     CompanyContactNo := GetBillToCustomerCompanyContact();
    //     if CompanyContactNo = '' then
    //         Error('Bill-to Customer %1 does not have a company contact.', "Bill-to Customer No.");
    //         exit;
        
    //     if not ContactBusinessRelation.Get(Contact.Type::Company, CompanyContactNo, Contact."No.") then
    //         Error('The contact %1 is not linked to the company contact %2.', Contact."No.", CompanyContactNo);
    // end;

    procedure ValidateParticipantContact()
    begin
        if "Participant Contact No." <> '' then begin
            if not Contact.Get("Participant Contact No.") then
            Error('The selected participant contact does not exist');

            "Participant Name" := Contact.Name;

        end else
            "Participant Name" := '';
    end;

    procedure ShouldValidateParticipantContact(): Boolean
    begin
        exit(("Bill-to Customer No." <> '') and
             ("Participant Contact No." <> ''));
    end;

    procedure GetBillToCustomerCompanyContact(): Code[20]

    begin
        ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
        if ContactBusinessRelation.FindFirst() then
            exit(ContactBusinessRelation."Contact No.");
    end;

    // procedure LookUpParticipantContact()
    // var
    //     CompanyContactNo: Code[20];

    // begin
    //     if "Bill-to Customer No." = '' then
    //         Message('Bill-to Customer No. must be specified before selecting a participant contact.');
    //         exit;
    //     CompanyContactNo := GetBillToCustomerCompanyContact();
    //     if CompanyContactNo = '' then begin
    //         Message('Bill-to Customer %1 does not have a company contact.', "Bill-to Customer No.");
    //         exit;
    //     end;

    //     Contact.Reset();
    //     Contact.SetRange("Company No.", CompanyContactNo);
    //     Contact.SetRange(Type, Contact.Type::Person);
    //     ContactList.SetTableView(Contact);
    //     ContactList.LookupMode := true;
    //     if ContactList.RunModal() = Action::LookupOK then begin
    //         ContactList.GetRecord(Contact);
    //         Validate("Participant Contact No.", Contact."No.");
    //     end;
    // end;

    procedure LookUpParticipantContact()
    begin
        Contact.Reset();
        Contact.SetRange(Type, Contact.Type::Person);
        if Page.RunModal(Page::"Contact List", Contact) = Action::LookupOK then
        Validate("Participant Contact No.", Contact."No.");
    end;
}
