report 50100 "Seminar Participant List"
{
    ApplicationArea = All;
    Caption = 'Seminar Participant List';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reports/Rep50100.SeminarParticipantList.rdlc';
    dataset
    {
        dataitem("Seminar Registration Header"; "Seminar Registration Header")
        {
            DataItemTableView = sorting("No.");
            column(Seminar_No; "Seminar No."){}
            column(Seminar_Name;"Seminar Name"){}
            column(Starting_Date;"Starting Date"){}
            column(Ending_Date;"Ending Date"){}
            column(Instructor_Name;"Instructor Name"){}
            column(Room_Name;"Room Name"){}
            
            dataitem("Seminar Registration Line";"Seminar Registration Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                
                column(Bill_to_Customer_No; "Bill-to Customer No."){}
                column(Participant_Name; "Participant Name"){}
                column(Participant_Contact_No; "Participant Contact No."){}
                column(Is_Individual_Participant; "Is individual Participant"){}
                column(Registration_Date; "Registration Date"){}
                
                trigger OnAfterGetRecord()
                begin
                    
                end;
            }
            
        }
        dataitem(CompanyInfo; "Company Information")
        {
            column(CompanyName; Company_Info.Name){}
            column(CompanyLogo; Company_Info.Picture){}
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Seminar Filters")
                {
                    field("Seminar No."; "Seminar Registration Header"."Seminar No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Seminar No.';
                        ToolTip = 'Specifies the seminar number to filter the report by.';
                    }
                    field("Seminar Name"; "Seminar Registration Header"."Seminar Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Seminar Name';
                        ToolTip = 'Specifies the seminar name to filter the report by.';
                    }
                    field("No."; "Seminar Registration Header"."No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Seminar Registration No.';
                        ToolTip = 'Specifies the Seminar Registration No. to filter the report by.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
                // action(Print)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Print';
                //     Image = Print;
                //     ToolTip = 'Print the Seminar Participant List report.';
                //     trigger OnAction()
                //     begin
                //         CurrReport.Run();
                //     end;
                // }
            }
        }
    }
    labels
    {
        // label(SeminarHeaderLabel)
        // {
        //     Caption = 'Seminar Registration List';
           
        // }
    }
    var
        Company_Info: Record "Company Information";
}
