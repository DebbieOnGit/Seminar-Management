page 50101 "Seminar Headlines"
{
    ApplicationArea = All;
    Caption = 'Seminar Headlines';
    PageType = HeadlinePart;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Headline1; HeadlineText1)
                {
                    ApplicationArea = All;
                    
                }
                field(Headline2; HeadlineText2)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
    var
        HeadlineText1: Label 'Welcome to your Seminar Management System';
        HeadlineText2: Label 'Manage your seminars efficiently and effectively';
}
