codeunit 50014 "Seminar Status Validation"
{
    //TableNo = "Seminar Registration Header";
    
    Subtype = Normal;

    procedure ValidateStatusChange(CurrentStatus: Enum "Seminar Registration Status"; NewStatus: Enum "Seminar Registration Status")
    begin
        case  CurrentStatus of
            CurrentStatus::Planning:
            if not (NewStatus in [NewStatus::Registration, NewStatus::Cancelled]) then
                Error('You can only move from Planning to Registration or Cancelled.');

            CurrentStatus::Registration:
            if not (NewStatus in [NewStatus::Closed, NewStatus::Cancelled]) then
                Error('You can only move from Registration to Closed or Cancelled.');

            CurrentStatus::Closed:
                Error('Closed registrations cannot be reopened.');

            CurrentStatus::Cancelled:
                Error('Cancelled registrations cannot be reopened or modified.');

        end;

    end;

    procedure ValidateUndoCancel(Header: Record "Seminar Registration Header")
    begin
        if Header.Status <> Header.Status::Cancelled then
            Error('Only cancelled registrations can be reopened.');
        if Header."Last Date Modified" < CalcDate('-5D, Today') then
            Error('You can only reopen within 5 days of cancellation');
    end;
    
    procedure CanPost(Status: Enum "Seminar Registration Status")
    begin
        if Status <> Status::Closed then
            Error('The registration must be closed before it can be posted.');
    end;
}
