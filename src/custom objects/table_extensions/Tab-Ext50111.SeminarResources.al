tableextension 50111 "Seminar Resources" extends Resource
{
    fields
    {
        field(50000; "Internal/External"; Option)
        {
            Caption = 'Internal/External';
            DataClassification = ToBeClassified;
            OptionMembers = "Internal","External";
        }
        field(50001; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;
        }
        field(50002; "Quantity Per Day"; Decimal)
        {
            Caption = 'Quantity Per Day';
            DataClassification = ToBeClassified;
        }
    }
}
