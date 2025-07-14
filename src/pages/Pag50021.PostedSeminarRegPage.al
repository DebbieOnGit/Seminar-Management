page 50021 "Posted Seminar Reg. Page"
{
    ApplicationArea = All;
    Caption = 'Posted Seminar Reg. Page';
    PageType = Document;
    SourceTable = "Posted Seminar Reg. Header";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ToolTip = 'Specifies the value of the Seminar No. field.', Comment = '%';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ToolTip = 'Specifies the value of the Seminar Name field.', Comment = '%';
                }
                field("Insructor No."; Rec."Insructor No.")
                {
                    ToolTip = 'Specifies the value of the Insructor No. field.', Comment = '%';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ToolTip = 'Specifies the value of the Instructor Name field.', Comment = '%';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.', Comment = '%';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.', Comment = '%';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.', Comment = '%';
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ToolTip = 'Specifies the value of the Minimum Participants field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
            }

            part("Seminar Registration Lines"; "Posted Seminar Reg. Line")
            {
                SubPageLink = "Document No." = field("No.");
            }
            group("Seminar Room")
            {
                Caption = ' Seminar Room';
                
                field("Room No."; Rec."Room No.")
                {
                    ToolTip = 'Specifies the value of the Room No. field.', Comment = '%';
                }
                field("Room Name"; Rec."Room Name")
                {
                    ToolTip = 'Specifies the value of the Room Name field.', Comment = '%';
                }
                field("Room Address"; Rec."Room Address")
                {
                    ToolTip = 'Specifies the value of the Room Address field.', Comment = '%';
                }
            }
            group( Invoicing)
            {
                Caption = ' Invoicing';
                
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.', Comment = '%';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.', Comment = '%';
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Specifies the value of the Price field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part(SeminarDetails; "Seminar Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Seminar No.");
            }
            // part(CustomerDetails; "Customer Details FactBox")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "No." = field(Bill)
            // }

            systempart(RecordLinks; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
        
    }

    actions
    {
        area(Navigation)
        {
            group("Seminar Registration")
            {
                action("Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = Comment;
                    RunObject = page "Seminar Comment Line";
                    RunPageLink = "No." = field("No.");
                    RunPageView = where("Document Type" = const("Posted Seminar Registration"));
                }

                action("Charges")
                {
                    ApplicationArea = All;
                    Caption = 'Charges';
                    Image = Cost;
                    RunObject = page "Seminar Charges";
                    RunPageLink = "Document No." = field("No.");

                }
            }
        }
        
    }
}
