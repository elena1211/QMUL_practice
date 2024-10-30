--Find all departments employing more than one clerk.
SELECT DEPTNO,
    COUNT(*) AS clerk_count
FROM EMP
WHERE JOB = 'CLERK'
GROUP BY DEPTNO
HAVING COUNT(*) > 1;
-- frind all employees grade
SELECT E.ENAME,
    E.SAL,
    S.GRADE
FROM EMP E
    JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;
-- 1) Create a new table called loans with columns named Lno number(3), empno number(4), type char(1), amnt number(8,2)
CREATE loans (
    LNO NUMBER(3),
    EMPNO NUMBER(4),
    TYPE CHAR(1),
    AMNT NUMBER(8, 2)
) -- 2) Insert the following data: Lno, empno, type, amnt 23, 7499, m, 20000.00 42, 7499, c, 2000.00 65, 7844, m, 3564.20
insert into loans (Lno, empno, type, amnt)
values (23, 7499, 'm', 20000.00),
    (42, 7499, 'c', 2000.00),
    (65, 7844, 'm', 3564.20);
-- 3) Check you have created 3 new records in loans table
select *
from loans;
-- 4) The loans table must be altered to include another column: outst number(8,2)
ALTER TABLE loans
ADD OUTST NUMBER(8, 2);
-- 5) Add 10% interest to all m-type loans
UPDATE loans
SET OUTST = AMNT * 1.1
WHERE TYPE = 'm';
-- 6) Remove all loans less than 3,000 pounds
DELETE FROM loans
WHERE AMNT < 3000;
-- 7) Change the name of the loans table to accounts
ALTER TABLE loans
    RENAME TO accounts;
-- 8) Change the name of column lno to loanno
ALTER TABLE accounts
    RENAME COLUMN LNO TO LOANNO;
-- 9) Create a view for use by personnel in department 30 showing employee name, number, job and hiredate.
CREATE VIEW dept30 AS
SELECT ENAME,
    EMPNO,
    JOB,
    HIREDATE
from emp
where deptno = 30;
-- 10) Use the view to show employees in department 30 having jobs which are not salesman
SELECT *
from dept30
WHERE job != 'SALESMAN';
-- 11) Drop column type from loans table.
ALTER TABLE accounts DROP COLUMN TYPE;
-- 12) Drop the view dept30
DROP VIEW dept30;