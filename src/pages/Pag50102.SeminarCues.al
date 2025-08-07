page 50102 "Seminar Cues"
{
    ApplicationArea = All;
    Caption = 'Seminar Cues';
    PageType = CardPart;
    SourceTable = "Seminar Cues";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(RevenueCosts)
            {
                Caption = 'Seminar revenue and costs';
                cuegroup(costs)
                {
                    CuegroupLayout = Wide;
                    Caption = 'Internal Costs';
                    field("Internal Costs"; Rec."Internal Costs")
                    {
                        ApplicationArea = All;
                        TableRelation = "Posted Seminar Charges";
                        DrillDown = true;
                        DrillDownPageId = "Posted Seminar Charges";
                        AutoFormatType = 10;
                        AutoFormatExpression = '1, KES ';
                    }
                }
                cuegroup(revenue)
                {
                    CuegroupLayout = Wide;
                    Caption = 'Total Revenue';
                    field("Total Revenue"; Rec."Total Revenue")
                    {
                        ApplicationArea = All;
                        TableRelation = "Sales Invoice Header";
                        DrillDown = true;
                        DrillDownPageId = "Sales Invoice List";
                        AutoFormatType = 10;
                        AutoFormatExpression = '1, KES ';
                    }
                }

            }

            group(SeminarRegStatus)
            {
                Caption = 'Seminar Registration Overview';

                cuegroup(Planning)
                {
                    Caption = 'Planning';

                    field("Seminars in Planning"; Rec."Seminars in Planning")
                    {
                        ApplicationArea = All;
                        TableRelation = "Seminar Registration Header" where(Status = const(Planning));
                        DrillDown = true;
                        DrillDownPageId = "Seminar Registration List";
                        ToolTip = 'Specifies the value of the Seminars in Planning field.', Comment = '%';
                    }

                }
                cuegroup(Registration)
                {
                    Caption = 'Registration';

                    field("Seminars in Registration"; Rec."Seminars in Registration")
                    {
                        ApplicationArea = All;
                        TableRelation = "Seminar Registration Header" where(Status = const(Registration));
                        DrillDown = true;
                        DrillDownPageId = "Seminar Registration List";
                        ToolTip = 'Specifies the value of the Seminars Registering Participants field.', Comment = '%';
                    }
                }
                cuegroup(Closed)
                {
                    Caption = 'Closed';

                    field("Closed Seminar Registrations"; Rec."Closed Seminar Registrations")
                    {
                        ApplicationArea = All;
                        TableRelation = "Seminar Registration Header" where(Status = const(Closed));
                        DrillDown = true;
                        DrillDownPageId = "Seminar Registration List";
                        ToolTip = 'Specifies the value of the Closed Seminar Registrations field.', Comment = '%';
                    }
                }

                // cuegroup(Cancelled)
                // {
                //     Caption = 'Cancelled';

                //     field("Cancelled Registrations"; Rec."Cancelled Registrations")
                //     {
                //         ApplicationArea = All;
                //         TableRelation = "Seminar Registration Header" where(Status = const(Cancelled));
                //         DrillDown = true;
                //         DrillDownPageId = "Seminar Registration List";
                //         ToolTip = 'Specifies the value of the Cancelled Seminar Registrations field.', Comment = '%';
                //     }
                // }

                cuegroup(PostedRegistrations)
                {
                    Caption = 'Posted Registrations';
                    field("Posted Registrations"; Rec."Posted Registrations")
                    {
                        ApplicationArea = All;
                        TableRelation = "Posted Seminar Reg. Header";
                        DrillDown = true;
                        DrillDownPageId = "Posted Seminar Reg. List";
                        ToolTip = 'Specifies the value of the Posted Seminar Registrations field.', Comment = '%';
                    }
                }

            }

            group(Seminar)
            {
                Caption = 'Seminar Overview';
                cuegroup("Seminars")
                {
                    field("Total Seminars"; Rec."Total Seminars")
                    {
                        ToolTip = 'Specifies the value of the Total Seminars field.', Comment = '%';
                        ApplicationArea = All;
                        TableRelation = Seminar;
                        DrillDown = true;
                        DrillDownPageId = "Seminar List";

                    }
                }
                // cuegroup("ActiveSeminars")
                // {
                //     field("Active Seminars"; Rec."Active Seminars")
                //     {
                //         ToolTip = 'Specifies the value of the Active Seminars field.', Comment = '%';
                //         ApplicationArea = All;
                //         TableRelation = Seminar where(Blocked = const(false));
                //         DrillDown = true;
                //         DrillDownPageId = "Seminar List";
                //     }
                // }
            }

            group(Invoices)
            {
                Caption = 'Pending Invoices';

                cuegroup("PendingInvoices")
                {
                    Caption = 'Pending Invoices';
                    field("Pending Invoices"; Rec."Pending Invoices")
                    {
                        ApplicationArea = All;
                        TableRelation = "Seminar Registration Line" where("To invoice" = const(true));
                        DrillDown = true;
                        DrillDownPageId = "Seminar Registration List";
                        ToolTip = 'Specifies the value of the Pending Invoices field.', Comment = '%';
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            if not Rec.Insert() then
                Error('Could not initialize Seminar Cues.');
        end;

    end;
}
