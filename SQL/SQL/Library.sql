CREATE TABLE Resources (
    ResourceID INT PRIMARY KEY,
    ResourceType VARCHAR(100) NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Author VARCHAR(200),
    ClassNumber INT,
    CopiesAvailable INT NOT NULL CHECK (CopiesAvailable >= 0),
    LoanType VARCHAR(50),
    FloorNumber INT,
    ShelfNumber INT,
    DigitalCopies INT CHECK (
        DigitalCopies IS NULL
        OR DigitalCopies >= 0
    ),
    TotalCopies INT,
    CONSTRAINT chk_resource_type CHECK (ResourceType IN ('Book', 'Device', 'Ebook')),
    CONSTRAINT chk_class_number CHECK (
        (
            ResourceType = 'Device'
            AND ClassNumber IS NULL
        )
        OR (
            ResourceType IN ('Book', 'Ebook')
            AND ClassNumber IS NOT NULL
        )
    ),
    CONSTRAINT chk_physical_loc CHECK (
        (
            ResourceType = 'Ebook'
            AND FloorNumber IS NULL
            AND ShelfNumber IS NULL
        )
        OR (
            ResourceType IN ('Book', 'Device')
            AND FloorNumber IS NOT NULL
            AND ShelfNumber IS NOT NULL
        )
    ),
    CONSTRAINT chk_digital_copies CHECK (
        (
            ResourceType = 'Ebook'
            AND DigitalCopies >= 0
        )
        OR (
            ResourceType != 'Ebook'
            AND DigitalCopies IS NULL
        )
    ),
    CONSTRAINT chk_total_copies CHECK (
        (
            ResourceType IN ('Book', 'Device')
            AND TotalCopies >= CopiesAvailable
        )
        OR (
            ResourceType = 'Ebook'
            AND TotalCopies IS NULL
        )
    ),
    CONSTRAINT chk_loan_type CHECK (
        LoanType IN ('3 Week', '3 Days', 'Library-Use Only')
    ),
    CONSTRAINT chk_author CHECK (
        (
            ResourceType = 'Device'
            AND Author IS NULL
        )
        OR (
            ResourceType IN ('Book', 'Ebook')
            AND Author IS NOT NULL
        )
    )
);
CREATE TABLE MemberType (
    MemberType VARCHAR(50) PRIMARY KEY,
    MaxLoanLimit INT NOT NULL CHECK (MaxLoanLimit > 0)
);
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    MemberFullName VARCHAR(200) NOT NULL,
    MemberEmail VARCHAR(200) UNIQUE NOT NULL,
    MemberPhone VARCHAR(15) UNIQUE,
    JoinDate DATE NOT NULL,
    MemberType VARCHAR(50) NOT NULL,
    FOREIGN KEY (MemberType) REFERENCES MemberType(MemberType)
);
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    LoanIssuedDate DATE NOT NULL,
    ReturnDate DATE,
    DueDate DATE NOT NULL,
    ResourceID INT NOT NULL,
    MemberID INT NOT NULL,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID) ON DELETE CASCADE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    CONSTRAINT chk_return_date CHECK (
        ReturnDate IS NULL
        OR ReturnDate >= LoanIssuedDate
    )
);
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    ReservationDate DATE NOT NULL,
    OfferDate DATE,
    OfferFailures INT DEFAULT 0 CHECK (OfferFailures >= 0),
    ResourceID INT NOT NULL,
    MemberID INT NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID) ON DELETE CASCADE
);
CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    LoanID INT NOT NULL,
    FineStatus VARCHAR(10) CHECK (FineStatus IN ('Paid', 'Unpaid')),
    FineAmount DECIMAL(10, 2) NOT NULL CHECK (FineAmount > 0),
    FineDate DATE NOT NULL,
    FinePaidDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID) ON DELETE CASCADE,
    CONSTRAINT chk_paid_date CHECK (
        (
            FineStatus = 'Paid'
            AND FinePaidDate IS NOT NULL
        )
        OR (
            FineStatus = 'Unpaid'
            AND FinePaidDate IS NULL
        )
    )
);
CREATE TABLE Suspensions (
    SuspensionID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    LoanID INT,
    FineID INT,
    SuspensionDate DATE NOT NULL,
    LiftedDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID) ON DELETE CASCADE,
    FOREIGN KEY (FineID) REFERENCES Fines(FineID) ON DELETE CASCADE
);
CREATE TABLE PreviousLoans (
    LoanID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    ResourceID INT NOT NULL,
    LoanDate DATE NOT NULL,
    PreviousLoanReturnedDate DATE NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID) ON DELETE CASCADE,
    FOREIGN KEY (ResourceID) REFERENCES Resources(ResourceID) ON DELETE CASCADE,
    CONSTRAINT chk_previous_loan_return_date CHECK (PreviousLoanReturnedDate >= LoanDate)
);
-- Insert Data into MemberType Table 
INSERT INTO MemberType
VALUES ('Student', 5);
INSERT INTO MemberType
VALUES ('Staff', 10);
-- Insert Data into Members Table 
INSERT INTO Members
VALUES (
        2001,
        'Emma Watson',
        'emma.watson@abc.com',
        '07299483277',
        TO_DATE('15-JAN-2021', 'DD-MON-YYYY'),
        'Student'
    );
INSERT INTO Members
VALUES (
        2002,
        'Michael Williams',
        'michael.williams@abc.com',
        '07482736488',
        TO_DATE('10-MAR-2022', 'DD-MON-YYYY'),
        'Student'
    );
INSERT INTO Members
VALUES (
        2003,
        'David Miller',
        'david.miller@abc.com',
        '07545567846',
        TO_DATE('06-OCT-2023', 'DD-MON-YYYY'),
        'Staff'
    );
INSERT INTO Members
VALUES (
        2004,
        'Sarah Brown',
        'sarah.brown@abc.com',
        '07583029477',
        TO_DATE('27-FEB-2024', 'DD-MON-YYYY'),
        'Student'
    );
INSERT INTO Members
VALUES (
        2005,
        'Emily Johnson',
        'emily.johnson@abc.com',
        '07736629365',
        TO_DATE('25-MAR-2024', 'DD-MON-YYYY'),
        'Staff'
    );
INSERT INTO Members
VALUES (
        2006,
        'James Smith',
        'james.smith@abc.com',
        '07123456789',
        TO_DATE('15-MAY-2024', 'DD-MON-YYYY'),
        'Student'
    );
-- Insert Data into Resources Table 
INSERT INTO Resources
VALUES (
        1001,
        'Book',
        'Database Systems',
        'John Doe',
        101,
        10,
        '3 Week',
        1,
        10,
        NULL,
        20
    );
INSERT INTO Resources
VALUES (
        1002,
        'Book',
        'Computer Programming',
        'Jane Doe',
        102,
        4,
        '3 Week',
        2,
        20,
        NULL,
        15
    );
INSERT INTO Resources
VALUES (
        1003,
        'Ebook',
        'Computer Programming',
        'Jane Doe',
        102,
        44,
        '3 Week',
        NULL,
        NULL,
        50,
        NULL
    );
INSERT INTO Resources
VALUES (
        1004,
        'Device',
        'Laptop Computer',
        NULL,
        NULL,
        1,
        '3 Days',
        2,
        5,
        NULL,
        25
    );
INSERT INTO Resources
VALUES (
        1005,
        'Device',
        'Tablet',
        NULL,
        NULL,
        14,
        'Library-Use Only',
        2,
        6,
        NULL,
        20
    );
INSERT INTO Resources
VALUES (
        1006,
        'Book',
        'Introduction into Software Engineering',
        'Jane Smith',
        103,
        1,
        '3 Week',
        1,
        50,
        NULL,
        15
    );
INSERT INTO Resources
VALUES (
        1007,
        'Ebook',
        'Computer Architecture and Networks',
        'John Smith',
        110,
        85,
        '3 Week',
        NULL,
        NULL,
        100,
        NULL
    );
-- Insert Data into Loan Table 
INSERT INTO Loans
VALUES (
        3001,
        TO_DATE('01-OCT-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('22-OCT-2024', 'DD-MON-YYYY'),
        1002,
        2001
    );
INSERT INTO Loans
VALUES (
        3002,
        TO_DATE('10-OCT-2024', 'DD-MON-YYYY'),
        TO_DATE('13-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('31-OCT-2024', 'DD-MON-YYYY'),
        1001,
        2006
    );
INSERT INTO Loans
VALUES (
        3003,
        TO_DATE('15-OCT-2024', 'DD-MON-YYYY'),
        TO_DATE('16-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('05-NOV-2024', 'DD-MON-YYYY'),
        1002,
        2002
    );
INSERT INTO Loans
VALUES (
        3004,
        TO_DATE('01-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('10-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('22-NOV-2024', 'DD-MON-YYYY'),
        1001,
        2001
    );
INSERT INTO Loans
VALUES (
        3005,
        TO_DATE('01-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('05-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('22-NOV-2024', 'DD-MON-YYYY'),
        1007,
        2003
    );
INSERT INTO Loans
VALUES (
        3006,
        TO_DATE('05-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('06-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('08-NOV-2024', 'DD-MON-YYYY'),
        1004,
        2005
    );
INSERT INTO Loans
VALUES (
        3007,
        TO_DATE('08-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('08-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('08-NOV-2024', 'DD-MON-YYYY'),
        1005,
        2006
    );
INSERT INTO Loans
VALUES (
        3008,
        TO_DATE('10-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('16-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('15-NOV-2024', 'DD-MON-YYYY'),
        1005,
        2004
    );
INSERT INTO Loans
VALUES (
        3009,
        TO_DATE('10-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('01-DEC-2024', 'DD-MON-YYYY'),
        1002,
        2001
    );
INSERT INTO Loans
VALUES (
        3010,
        TO_DATE('12-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('15-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('15-NOV-2024', 'DD-MON-YYYY'),
        1004,
        2002
    );
INSERT INTO Loans
VALUES (
        3011,
        TO_DATE('12-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('03-DEC-2024', 'DD-MON-YYYY'),
        1001,
        2003
    );
INSERT INTO Loans
VALUES (
        3012,
        TO_DATE('14-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('05-DEC-2024', 'DD-MON-YYYY'),
        1007,
        2006
    );
INSERT INTO Loans
VALUES (
        3013,
        TO_DATE('15-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('18-NOV-2024', 'DD-MON-YYYY'),
        1004,
        2005
    );
INSERT INTO Loans
VALUES (
        3014,
        TO_DATE('15-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('06-DEC-2024', 'DD-MON-YYYY'),
        1003,
        2004
    );
INSERT INTO Loans
VALUES (
        3015,
        TO_DATE('16-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('07-DEC-2024', 'DD-MON-YYYY'),
        1006,
        2003
    );
INSERT INTO Loans
VALUES (
        3016,
        TO_DATE('17-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        TO_DATE('19-NOV-2024', 'DD-MON-YYYY'),
        1004,
        2004
    );
-- Insert Data into Reservation Table 
INSERT INTO Reservations
VALUES (
        4001,
        TO_DATE('20-OCT-2024', 'DD-MON-YYYY'),
        TO_DATE('25-OCT-2024', 'DD-MON-YYYY'),
        0,
        1002,
        2004
    );
INSERT INTO Reservations
VALUES (
        4002,
        TO_DATE('10-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        1,
        1006,
        2004
    );
INSERT INTO Reservations
VALUES (
        4003,
        TO_DATE('11-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        0,
        1006,
        2003
    );
INSERT INTO Reservations
VALUES (
        4004,
        TO_DATE('11-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        0,
        1006,
        2005
    );
INSERT INTO Reservations
VALUES (
        4005,
        TO_DATE('12-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('09-NOV-2024', 'DD-MON-YYYY'),
        0,
        1004,
        2006
    );
INSERT INTO Reservations
VALUES (
        4006,
        TO_DATE('12-NOV-2024', 'DD-MON-YYYY'),
        NULL,
        4,
        1002,
        2005
    );
-- Insert Data into Fine Table 
INSERT INTO Fines
VALUES (
        5001,
        2001,
        3001,
        'Unpaid',
        26.00,
        TO_DATE('23-OCT-2024', 'DD-MON-YYYY'),
        NULL
    );
INSERT INTO Fines
VALUES (
        5002,
        2006,
        3002,
        'Paid',
        13.00,
        TO_DATE('01-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('13-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO Fines
VALUES (
        5003,
        2002,
        3003,
        'Unpaid',
        12.00,
        TO_DATE('06-NOV-2024', 'DD-MON-YYYY'),
        NULL
    );
INSERT INTO Fines
VALUES (
        5004,
        2005,
        3006,
        'Paid',
        2.00,
        TO_DATE('10-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('11-NOV-2024', 'DD-MON-YYYY')
    );
-- Insert Data into Suspension Table 
INSERT INTO Suspensions
VALUES (
        6001,
        2001,
        3001,
        5001,
        TO_DATE('03-NOV-2024', 'DD-MON-YYYY'),
        NULL
    );
INSERT INTO Suspensions
VALUES (
        6002,
        2006,
        3002,
        5002,
        TO_DATE('11-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('13-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO Suspensions
VALUES (
        6003,
        2002,
        3003,
        5003,
        TO_DATE('17-NOV-2024', 'DD-MON-YYYY'),
        NULL
    );
-- Insert Data into PreviousLoans Table 
INSERT INTO PreviousLoans
VALUES (
        3002,
        2006,
        1001,
        TO_DATE('10-OCT-2024', 'DD-MON-YYYY'),
        TO_DATE('13-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO PreviousLoans
VALUES (
        3003,
        2002,
        1002,
        TO_DATE('15-OCT-2024', 'DD-MON-YYYY'),
        TO_DATE('16-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO PreviousLoans
VALUES (
        3004,
        2001,
        1001,
        TO_DATE('01-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('10-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO PreviousLoans
VALUES (
        3005,
        2003,
        1007,
        TO_DATE('01-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('05-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO PreviousLoans
VALUES (
        3006,
        2005,
        1004,
        TO_DATE('05-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('06-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO PreviousLoans
VALUES (
        3007,
        2006,
        1005,
        TO_DATE('08-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('08-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO PreviousLoans
VALUES (
        3008,
        2004,
        1005,
        TO_DATE('10-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('16-NOV-2024', 'DD-MON-YYYY')
    );
INSERT INTO PreviousLoans
VALUES (
        3010,
        2002,
        1004,
        TO_DATE('12-NOV-2024', 'DD-MON-YYYY'),
        TO_DATE('15-NOV-2024', 'DD-MON-YYYY')
    );
-- ReservationStatus view: A view showing all relevant information about reservations, making it easy to review the status of each reservation, along with the associated resources and members, it also shows the derived attribute ‘Reservation Status’ on a table.
CREATE VIEW ReservationStatus AS
SELECT rv.ReservationID,
    rv.ResourceID,
    rv.MemberID,
    rv.ReservationDate,
    rv.OfferDate,
    rv.OfferFailures,
    R.Title,
    M.MemberFullName,
    M.MemberEmail,
    CASE
        WHEN rv.OfferDate IS NULL
        AND rv.OfferFailures <= 3 THEN 'Active'
        WHEN rv.OfferDate IS NOT NULL THEN 'Completed'
        WHEN rv.OfferFailures > 3 THEN 'Cancelled'
    END AS ReservationStatus
FROM Reservations rv
    JOIN Resources R ON rv.ResourceID = R.ResourceID
    JOIN Members M ON rv.MemberID = M.MemberID;
-- OverdueLoans view: A view displaying all overdue loans, including detailed information about the member and the associated resource. This view helps the library staff quickly identify overdue items, ensuring timely follow-up and efficient resource management.
CREATE VIEW OverdueLoans AS
SELECT L.LoanID,
    L.LoanIssuedDate,
    L.DueDate,
    L.ResourceID,
    R.Title,
    M.MemberID,
    M.MemberFullName,
    M.MemberEmail,
    M.MemberPhone,
    TRUNC(SYSDATE - L.DueDate) AS OverdueDays
FROM Loans L
    JOIN Resources R ON L.ResourceID = R.ResourceID
    JOIN Members M ON L.MemberID = M.MemberID
WHERE L.ReturnDate IS NULL
    AND L.DueDate < SYSDATE;
-- ReservationPriorityOrder view: This view shows the priority order of a reservation (derived attribute), this is important as their could be multiple reservations per resource and the library database must be able to identify who currently hold priority for a resource and also be able to let the next person be easily contacted if the person higher in priority has cancelled their reservation and update the priority order(s) if the person holding ‘1’ priority has had their reservation completed.
CREATE VIEW ReservationPriorityOrder AS
SELECT rv.ResourceID,
    r.Title,
    r.ResourceType,
    rv.MemberID,
    m.MemberFullName,
    m.MemberEmail,
    rv.ReservationID,
    rv.ReservationDate,
    rv.OfferFailures,
    ROW_NUMBER() OVER (
        PARTITION BY rv.ResourceID
        ORDER BY rv.ReservationDate ASC,
            rv.ReservationID ASC
    ) AS PriorityOrderRank
FROM Reservations rv
    JOIN Resources r ON rv.ResourceID = r.ResourceID
    JOIN Members m ON rv.MemberID = m.MemberID
WHERE rv.OfferDate IS NULL
    AND rv.OfferFailures <= 3
ORDER BY rv.ResourceID,
    PriorityOrderRank;
-- SuspensionStatusandReason view: This view has been created so it shows the derived attributes of ‘SuspensionStatus’ and ‘SuspensionReason’ (more details about them in the assumptions section), this is useful to see who is actively suspended and know the reason for the suspension so it would be easier to know how to resolve it.
CREATE VIEW SuspensionStatusandReason AS
SELECT s.SuspensionID,
    m.MemberID,
    m.MemberFullName,
    CASE
        WHEN s.LiftedDate IS NULL THEN 'Active'
        ELSE 'Lifted'
    END AS Status,
    CASE
        WHEN s.LiftedDate IS NOT NULL THEN NULL
        WHEN f.FineStatus = 'Unpaid'
        AND l.ReturnDate IS NOT NULL THEN 'Unpaid Fine'
        WHEN f.FineStatus = 'Unpaid'
        AND l.ReturnDate IS NULL THEN 'Resource Not Returned and Unpaid Fine'
        ELSE 'Other'
    END AS Reason,
    s.SuspensionDate
FROM Suspensions s
    JOIN Members m ON s.MemberID = m.MemberID
    LEFT JOIN Loans l ON s.LoanID = l.LoanID
    LEFT JOIN Fines f ON s.FineID = f.FineID;
-- Query1: List all available resources. This query retrieves all resources with copies available for borrowing, helping the database user or librarian to identify accessible items for members.
SELECT ResourceID,
    Title,
    ResourceType,
    CopiesAvailable
FROM Resources
WHERE CopiesAvailable > 0;
-- Query 2: Find all digital resources, this would show the user what ebooks’ the library has and therefore could help with knowing how many licenses each ebook has, this would help with knowing which ebooks’ may need their licenses renewed or additional licenses purchased (digital resource management).
SELECT ResourceID,
    Title,
    CopiesAvailable,
    DigitalCopies
FROM Resources
WHERE ResourceType = 'Ebook';
-- Query 3: This query shows which resources are limited to use in the library only, this would be useful as it would make it clear to the library staff which resources cannot leave the library and have a restriction on them, so they can inform the loanee, monitor the usage and make sure no-one removes the resource from library.
SELECT ResourceID,
    Title,
    LoanType,
    CopiesAvailable,
    TotalCopies
FROM Resources
WHERE LoanType = 'Library-Use Only';
-- Query 4: This query retrieves all members currently/actively suspended, based solely on the Suspensions table, it would be useful to know which members at present cannot use the library resources.
SELECT MemberID,
    SuspensionDate
FROM Suspensions
WHERE LiftedDate IS NULL;
-- Query 5: This query shows the total number of unpaid fines and paid fines a member has (if any), this could be useful to see a member’s fine history and to also help streamline payments as the total amount a member owes can be found out using this query.
SELECT m.MemberID,
    m.MemberFullName,
    (
        SELECT SUM(f.FineAmount)
        FROM Fines f
        WHERE f.MemberID = m.MemberID
            AND f.FineStatus = 'Paid'
    ) AS TotalPaidFines,
    (
        SELECT SUM(f.FineAmount)
        FROM Fines f
        WHERE f.MemberID = m.MemberID
            AND f.FineStatus = 'Unpaid'
    ) AS TotalUnpaidFines
FROM Members m
    LEFT JOIN Fines f ON m.MemberID = f.MemberID
ORDER BY TotalUnpaidFines DESC NULLS LAST,
    TotalPaidFines DESC NULLS LAST;
-- Query 6: Find all resources borrowed by a specific member (2001). This query lists all resources borrowed by a specific member, including the loan details. To search for a different member, simply update the MemberID.
SELECT L.LoanID,
    L.LoanIssuedDate,
    L.DueDate,
    R.ResourceID,
    R.Title AS ResourceTitle,
    R.ResourceType
FROM Loans L
    JOIN Resources R ON L.ResourceID = R.ResourceID
WHERE L.MemberID = 2001;
-- Query 7: Find all members who have borrowed a specific type of resource. This query retrieves all members who have borrowed a specific type of resource, such as 'Book'. It helps the library understand the demand for specific resource types and optimise their allocation or procurement of resources accordingly.
SELECT DISTINCT M.MemberID,
    M.MemberFullName,
    R.ResourceType
FROM Members M
    JOIN Loans L ON M.MemberID = L.MemberID
    JOIN Resources R ON L.ResourceID = R.ResourceID
WHERE R.ResourceType = 'Book';
-- Query 8: Find members with active reservations and the resources they reserved. This query retrieves all members with active reservations and the details of the reserved resources. Ensure that members are notified of resource availability in a timely manner.
SELECT M.MemberID,
    M.MemberFullName,
    M.MemberEmail,
    RV.ReservationID,
    R.ResourceID,
    R.Title AS ResourceTitle,
    R.ResourceType,
    RV.ReservationDate
FROM Members M
    JOIN Reservations RV ON M.MemberID = RV.MemberID
    JOIN Resources R ON RV.ResourceID = R.ResourceID
WHERE RV.OfferDate IS NULL;
-- Query 9: Query to see members who are active on the library system, could be useful to track borrowing and reservation activity (member engagement) and help with communication
SELECT m.MemberID,
    m.MemberFullName,
    m.MemberType,
    COUNT(DISTINCT l.LoanID) AS ActiveLoans,
    COUNT(DISTINCT rv.ReservationID) AS ActiveReservations
FROM Members m
    LEFT JOIN Loans l ON m.MemberID = l.MemberID
    AND l.ReturnDate IS NULL
    LEFT JOIN Reservations rv ON m.MemberID = rv.MemberID
    AND rv.OfferDate IS NULL
WHERE NOT EXISTS (
        SELECT 1
        FROM Suspensions s
        WHERE s.MemberID = m.MemberID
            AND s.LiftedDate IS NULL
    )
GROUP BY m.MemberID,
    m.MemberFullName,
    m.MemberType;
-- Query 10: This query shows which members have unpaid fines that sum up to over £10, this will be useful to for the database user to know which members to insert/add to the suspensions table (could be done with a trigger or manually)
SELECT m.MemberID,
    m.MemberFullName,
    SUM(f.FineAmount) AS TotalUnpaidFines
FROM Members m
    JOIN Suspensions s ON m.MemberID = s.MemberID
    JOIN Fines f ON s.FineID = f.FineID
WHERE f.FineStatus = 'Unpaid'
GROUP BY m.MemberID,
    m.MemberFullName
HAVING SUM(f.FineAmount) > 10;
-- Query 11: This query retrieves the top 5 most borrowed resources, helping in identifying popular items.
SELECT R.ResourceID,
    R.Title AS ResourceTitle,
    COUNT(L.LoanID) AS BorrowCount
FROM Loans L
    JOIN Resources R ON L.ResourceID = R.ResourceID
GROUP BY R.ResourceID,
    R.Title
ORDER BY BorrowCount DESC
FETCH FIRST 5 ROWS ONLY;
-- Query 12: This query shows how many loans a member has remaining based on their member type. This is useful
SELECT m.MemberID,
    m.MemberFullName,
    m.MemberType,
    mt.MaxLoanLimit - COUNT(l.LoanID) AS LoansRemaining
FROM Members m
    LEFT JOIN Loans l ON m.MemberID = l.MemberID
    JOIN MemberType mt ON m.MemberType = mt.MemberType
GROUP BY m.MemberID,
    m.MemberFullName,
    m.MemberType,
    mt.MaxLoanLimit;