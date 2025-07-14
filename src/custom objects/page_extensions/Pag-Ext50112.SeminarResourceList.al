pageextension 50112 "Seminar Resource List" extends "Resource List"
{


    layout
    {
        addafter(Name)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                Caption = 'Internal/External';
                ApplicationArea = All;
                ToolTip = 'Specifies whether the resource is internal or external';
                Visible = ShowType;
            }
            field("Maximum Participants"; Rec."Maximum Participants")
            {
                Caption = 'Maximum Participants';
                ApplicationArea = All;
                ToolTip = 'Specifies the maximum number of participants the room can accommodate.';
                Visible = ShowMaxParticipants;
            }
        }

    }
    var
        ShowType: Boolean;
        ShowMaxParticipants: Boolean;

    trigger OnAfterGetRecord()

    begin

        ShowType := (Rec.Type in [Rec.Type::Person, Rec.Type::Machine]);
        ShowMaxParticipants := (Rec.Type = Rec.Type::Machine);
    end;
}
