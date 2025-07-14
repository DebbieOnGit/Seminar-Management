pageextension 50110 "Seminar Resource Card" extends "Resource Card"
{
    layout
    {
        // customize resource card General FastTab to add Internal/External field

        addafter(Type)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                Caption = 'Internal/External';
                ApplicationArea = All;
                ToolTip = 'Specifies whether the resource is internal or external.';
            }
            field("Quantity Per Day"; Rec."Quantity Per Day")
            {
                Caption = 'Quantity Per Day';
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity per day for the resource';
            }
        }

        addafter("Personal Data")
        {
            group(Room)
            {
                Caption = 'Room';

                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    Caption = 'Maximum Participants';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of participants the room can accommodate.';
                }
            }
        }
    }
}