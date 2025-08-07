codeunit 50018 SeminarInvoice
{
    TableNo = "Seminar Registration Line";

    /// <summary>
    /// Create Invoice for all registered participants in a seminar.
    /// This function checks if the registration line is marked for invoicing and creates an invoice accordingly
    /// If a Bill-to Customer No. is present, then the Company is billed
    /// Otherwise, the participant contact is billed.
    /// If the registration line is already invoiced, it will raise an error.
    /// </summary>

    procedure CreateInvoice()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        Contact: Record Contact;
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Seminar Registration Line";

    begin
        if SeminarRegLine.Invoiced then
            Error('This registration line has already been invoiced.');
        exit;

        if SeminarRegLine.Registered then begin
            if SeminarRegLine."Bill-to Customer No." <> '' then begin
                Customer.Get(SeminarRegLine."Bill-to Customer No.");
                SalesHeader.Init();
                SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                SalesHeader."Sell-to Customer No." := Customer."No.";
                SalesHeader.Insert(true);
                SalesLine.Init();
                SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := 10000;
                SalesLine."Type" := SalesLine."Type"::" ";
                SalesLine."No." := SeminarRegHeader."Seminar No.";
                SalesLine."Description" := SeminarRegHeader."Seminar Name";
                SalesLine."Quantity" := 1;
                SalesLine."Unit Price" := SeminarRegLine.Amount;
                SalesLine.Insert(true);
                SeminarRegLine."To invoice" := false;
                SeminarRegLine.Invoiced := true;
                SeminarRegLine.Modify(true);
            end else begin
                Contact.Get(SeminarRegLine."Participant Contact No.");
                SalesHeader.Init();
                SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                SalesHeader."Sell-to Customer No." := Contact."No.";
                SalesHeader.Insert(true);
                SalesLine.Init();
                SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := 10000;
                SalesLine."Type" := SalesLine."Type"::" ";
                SalesLine."No." := SeminarRegHeader."Seminar No.";
                SalesLine."Description" := SeminarRegHeader."Seminar Name";
                SalesLine."Quantity" := 1;
                SalesLine."Unit Price" := SeminarRegLine.Amount;
                SalesLine.Insert(true);
                SeminarRegLine."To invoice" := false;
                SeminarRegLine.Invoiced := true;
                SeminarRegLine.Modify(true);
            end;
        end;


    end;

}
