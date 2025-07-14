table 50015 "Posted Seminar Reg. Header"
{
    Caption = 'Posted Seminar Reg. Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Posted Seminar Reg. List";
    
    // field nos. should be the same as those of Seminar Registration Header Table to ensure TransferFields() does not cause errors.

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
        }
        field(3; "Seminar Name"; Text[100])
        {
            Caption = 'Seminar Name';
        }
        field(4; "Room No."; Code[20])
        {
            Caption = 'Room No.';
        }
        field(5; "Room Name"; Text[100])
        {
            Caption = 'Room Name';
        }
        field(6; "Room Address"; Text[100])
        {
            Caption = 'Room Address';
        }
        field(7; "Insructor No."; Code[20])
        {
            Caption = 'Insructor No.';
        }
        field(8; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
        }
        field(9; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(10; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(11; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(12; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(13; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(14; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(15; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
        }
        field(16; "Duration"; Integer)
        {
            Caption = 'Duration';
        }
        
        field(17; "User ID";Code[50])
        {
            Caption = 'User ID' ;
            TableRelation = User."User Name";
            Editable = false;

        }
        field(18; Comment ; Boolean)
        {
            Caption = 'Comment';
        }
        field(19; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(20; "Document Date"; Date)
        {
            Caption = 'Document Date'; 
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }

        // Posted entries in BC arre assigned a source code so transactions can be traced to their origin. 
        // Set up source codes in BC Tell Me
        // Reason codes may also be used to indicate WHY an entry was created
        field(22; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Index2; "Room No.")
        {
            SumIndexFields = Duration;
        }
    }
}
