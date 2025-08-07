page 50014 "Seminar Registration Page"
{
    ApplicationArea = All;
    Caption = 'Seminar Registration Card';
    PageType = Document;
    SourceTable = "Seminar Registration Header";
    PromotedActionCategories = 'New, Process, Report, Registration, Setup, Comments, Charges, Posting';

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
                    ApplicationArea = All;

                    trigger OnAssistEdit()

                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ToolTip = 'Specifies the value of the Seminar No. field.', Comment = '%';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Instructor No."; Rec."Instructor No.")
                {
                    ToolTip = 'Specifies the value of the Instructor No. field.', Comment = '%';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ToolTip = 'Specifies the value of the Instructor Name field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.', Comment = '%';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.', Comment = '%';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ToolTip = 'Specifies the value of the Maximum Participants field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Participants field.', Comment = '%';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the duration of the seminar in hours.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status.', Comment = '%';
                    ApplicationArea = All;
                }
            }
            part(SeminarRegistrationLines; "Seminar Registration Line")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }

            group("Seminar Room")
            {
                Caption = 'Seminar Room';
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = All;
                }
                field("Room Address"; Rec."Room Address")
                {
                    ApplicationArea = All;
                }
            }
            group("Invoicing")
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;

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
            part(CustomerDetails; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Instructor No.");
            }


            systempart(RecordLinks; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {

        area(Navigation)
        {


            action("Comments")
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = Comment;
                RunObject = page "Seminar Comment Line";
                RunPageLink = "Document No." = field("No.");
                RunPageView = where("Document Type" = const("Seminar Registration"));
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Add comments to this document';
            }

            action("Charges")
            {
                ApplicationArea = All;
                Caption = 'Charges';
                Image = CalculateCost;
                RunObject = page "Seminar Charges";
                //RunPageLink
                Promoted = true;
                PromotedCategory = Category7;
            }

        }

        area(Processing)
        {

            action("Seminar Setup")
            {
                ApplicationArea = All;
                Caption = 'Seminar Setup';
                //Image = Setup;
                RunObject = page "Seminar Setup Page";
                Promoted = true;
                PromotedCategory = Category5;
            }

            group(Registration)
            {
                Caption = 'Registration';
                //Image = RegisteredDocs;

                action("Start Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Register participants';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        StatusValid: Codeunit "Seminar Status Validation";
                    begin
                        StatusValid.ValidateStatusChange(Rec.Status, Rec.Status::Registration);
                        Rec.Validate(Status, Rec.Status::Registration);
                        Rec.Modify(true);
                    end;
                }
                action("Close Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Close registration';
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        StatusValid: Codeunit "Seminar Status Validation";
                        SeminarInvoice: Codeunit SeminarInvoice;
                        SeminarRegLine: Record "Seminar Registration Line";

                    begin
                        SeminarRegLine.SetRange("Document No.", Rec."No.");
                        if SeminarRegLine.Count < Rec."Minimum Participants" then
                            Error('Cannot close seminar. Minimum participants required is %1, but only %2 participants are registered.', Rec."Minimum Participants", SeminarRegLine.Count);
                        if Confirm('Are you sure you want to close this registration? Closed registrations cannot be editted or reopened. All invoices will be sent', false) then begin
                            StatusValid.ValidateStatusChange(Rec.Status, Rec.Status::Closed);
                            Rec.Validate(Status, Rec.Status::Closed);
                            Rec.Modify(true);
                            SeminarInvoice.CreateInvoice();
                        end;

                    end;
                }
                action("Cancel Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Registration';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        StatusValid: Codeunit "Seminar Status Validation";
                    begin
                        if Confirm('Are you sure you want to cancel this registration? Cancelled registrations cannot be editted.', false) then begin
                            StatusValid.ValidateStatusChange(Rec.Status, Rec.Status::Cancelled);
                            Rec.Validate(Status, Rec.Status::Cancelled);
                            Rec.Modify(true);
                        end;

                    end;
                }
                action("Reopen Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Reopen Registration';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        StatusValid: Codeunit "Seminar Status Validation";
                    begin
                        if Confirm('Are you sure you want to reopen this registration?', false) then begin
                            StatusValid.ValidateUndoCancel(Rec);
                            Rec.Validate(Status, Rec.Status::Planning);
                            Rec.Modify(true);
                        end;

                    end;

                }
            }
            group(Posting)
            {
                Image = PostDocument;
                Caption = 'Posting';

                action("Post Registration")
                {
                    Caption = 'Post Seminar';
                    ApplicationArea = All;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        SeminarPostYesNo: Codeunit "Seminar-Post-Yes/No";
                    begin
                        SeminarPostYesNo.RunPosting(Rec);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()

    begin
        if Rec.Status = Rec.Status::Planning then
            Message('Tip: This seminar is still in Planning. To register participants, change the status to Registration using the Actions button above.');
    end;
}