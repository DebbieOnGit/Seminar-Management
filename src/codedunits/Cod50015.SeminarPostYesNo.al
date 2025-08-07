codeunit 50015 "Seminar-Post-Yes/No"
{
    Subtype = Normal;

    procedure RunPosting(SeminarHeader: Record "Seminar Registration Header")
    var
        SeminarPost: Codeunit "Seminar-Post";
        StatusValidator: Codeunit "Seminar Status Validation";

    begin
        // Confirm user wants to post
        if not Confirm('Do you want to post seminar registration %1?', false, SeminarHeader."No.") then
            exit;
        
        // Validate document is ready to be posted
        StatusValidator.CanPost(SeminarHeader.Status);

        //Run posting
        SeminarPost.PostSeminarRegistration(SeminarHeader);
        Message('Seminar registration %1 has been posted successfully.', SeminarHeader."No.");
    end;
}
