table 50019 "Seminar Cues"
{
    Caption = 'Seminar Cues';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(10; "Total Revenue"; Decimal)
        {
            Caption = 'Total Revenue';
            FieldClass = FlowField;
            CalcFormula = sum("Posted Seminar Reg Line".Amount);
        }
        field(11; "Internal Costs"; Decimal)
        {
            Caption = 'Internal Costs';
            FieldClass = FlowField;
            CalcFormula = sum("Posted Seminar Charges"."Total Amount");
        }
        field(2; "Total Seminars"; Integer)
        {
            Caption = 'Total Seminars';
            FieldClass = FlowField;
            CalcFormula = count("Seminar");
            
        }
        field(9; "Active Seminars"; Integer)
        {
            Caption = 'Active Seminars';
            FieldClass = FlowField;
            CalcFormula = count("Seminar" where(Blocked = const(false)));
        }
        field(3; "Seminars in Planning"; Integer)
        {
            Caption = 'Seminars in Planning';
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Planning)));
        }
        field(4; "Seminars in Registration"; Integer)
        {
            Caption = 'Registering Participants';
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Registration)));
        }
        field(5; "Closed Seminar Registrations"; Integer)
        {
            Caption = 'Closed Seminar Registrations';
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Closed)));
        }
        field(6; "Cancelled Registrations"; Integer)
        {
            Caption = 'Cancelled Seminar Registrations';
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Cancelled)));
        }
        field(7; "Posted Registrations"; Integer)
        {
            Caption = 'Posted Seminar Registrations';
            FieldClass = FlowField;
            CalcFormula = count("Posted Seminar Reg. Header");
        }
        field(8; "Pending Invoices"; Integer)
        {
            Caption = 'Pending Invoices';
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Line" where("To invoice" = const(true)));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
