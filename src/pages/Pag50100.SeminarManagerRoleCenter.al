page 50100 "Seminar Manager Role Center"
{
    ApplicationArea = All;
    Caption = 'Seminar Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Headlines; "Seminar Headlines")
            {
                ApplicationArea = All;
                Caption = 'Seminar Headlines';
            }
            part(Cues; "Seminar Cues")
            {
                ApplicationArea = All;
                Caption = 'Seminar Cues';
            }
            // part(Insights; "Seminar Insights")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Seminar Insights';
            // }

        }
    }

    actions
    {

        area(Sections)
        {
            group("Setup")
            {
                action("Seminar Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Setup Seminar';
                    Image = Setup;
                    RunObject = page "Seminar Setup List";
                }
            }
            group("Navigate")
            {
                
                action("Seminar List")
                {
                    ApplicationArea = All;
                    Caption = 'View Seminars';
                    Image = List;
                    RunObject = page "Seminar List";
                }
                action("Seminar Registrations")
                {
                    ApplicationArea = All;
                    Caption = 'View Seminar Registrations';
                    Image = List;
                    RunObject = page "Seminar Registration List";
                }
                action("Seminar Comments")
                {
                    ApplicationArea = All;
                    Caption = 'View Comments';
                    Image = Comment;
                    RunObject = page "Seminar Comment List";
                }
                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'View Ledger Entries';
                    Image = LedgerEntries;
                    RunObject = page "Seminar Ledger Entries";
                }

            }

            group("Posted ")
            {
                action("View Posted Seminars")
                {
                    ApplicationArea = All;
                    Caption = 'View Posted Registrations';
                    Image = PostDocument;
                    RunObject = page "Posted Seminar Reg. List";
                }
            }

        }
        area(Creation)
        {
            group("New Seminar")
            {
                action(RegisterSeminar)
                {
                    ApplicationArea = All;
                    Caption = 'Register Seminar';
                    Image = NewDocument;
                    RunObject = page "Seminar Card";
                    RunPageMode = Create;               
                    
                }
            }
            group("Seminar Registration")
            {
                action("SeminarRegistrations")
                {
                    ApplicationArea = All;
                    Caption = 'Register Participants';
                    Image = Register;
                    RunObject = page "Seminar Registration Page";
                    RunPageMode = Create;
                }

            }
            group("Charges")
            {
                action("Seminar Charges")
                {
                    ApplicationArea = All;
                    Caption = 'Register Seminar Charges';
                    Image = Register;
                    RunObject = page "Seminar Charges";
                    RunPageMode = Create;
                }
            }
                
            
        }

        area(Processing)
        {
            group("Ready for Posting")
            {
                action("Seminar Registrations to Post")
                {
                    ApplicationArea = All;
                    Caption = 'View Registrations Ready for Posting';
                    Image = List;
                    RunObject = page "Seminar Registration List" ;
                    RunPageView = where(Status = const("Seminar Registration Status"::Closed));
                    RunPageMode = View;
                }
                
                
            }
            group("Reports")
            {
                action("Seminar Participant List")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Participant List';
                    Image = Report;
                    RunObject = report "Seminar Participant List";
                    RunPageMode = View;
                }

            }
        }

        

        area(Reporting)
        {     
                action("Seminar Report")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Report';
                    Image = Report;
                    //RunObject = report "Seminar Report";
                }
                action("Seminar Registration Report")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Registration Report';
                    Image = Report;
                    //RunObject = report "Seminar Registration Report";
                }  
        }

    }
}

profile "Seminar Manager"
{
    ProfileDescription = 'Seminar Manager Profile';
    RoleCenter = "Seminar Manager Role Center";
    Caption = 'Seminar Manager';
}