select *
from dept;
select *
from emp;
select *
from bonus;
select *
from salgrade;
select *
from dummy;
SELECT ENAME,
    SAL,
    DEPTNO
FROM EMP
WHERE SAL BETWEEN 1000 AND 2000;
select job
from emp;
select ename,
    empno
from emp
where deptno between 10 and 30;
select ename,
    deptno,
    hiredate
from emp
where hiredate like '%19%';
select ename
from emp
where ename like '%TH%'
    or ename like '%LL%';
select deptno,
    dname
from dept
order by dname;
select ename,
    job,
    sal,
    comm
from emp
where MGR is null;
select ename,
    empno,
    comm / sal
from emp
where job like '%SALESMAN%'
order by comm / sal desc;
select ename,
    empno,
    (sal + comm * 12)
from emp
where job like '%SALESMAN%';
select ename,
    empno
from emp
where deptno like '%30%'
    and sal >= 1500;
select count(MGR) as count
from emp;
select avg(sal + comm)
from emp
where job like '%SALESMAN%';
select ename,
    empno,
    sal
from emp
where sal in (
        (
            select max(sal)
            from emp
        ),
        (
            select min(sal)
            from emp
        )
    );
select max(sal) - min(sal)
from emp;
select max(length(dname))
from dept;
select count(sal),
    count(comm)
from emp
where deptno = 30;
select avg(comm)
from emp
where deptno = 30
    and comm is not null;
select avg(NVL(comm, 0))
from emp;
select avg(sal)
from emp
where deptno = 30
    AND sal is not null;
select avg(comm)
from emp
where deptno = 30
    AND comm is not null;
select avg(sal + comm)
from emp
where deptno = 30
    AND comm is not null;
select avg(sal + NVL(comm, 0))
from emp
where deptno = 30;
select ename,
    round(sal / 22, 2) as daily_sal,
    round(sal / 22 * 8, 2) as hourly_sal
from emp
where deptno = 30;
select ename,
    trunc(sal / 22, 2) as daily_sal_truncate,
    trunc(sal / 22 * 8, 2) as hourly_sal_truncate
from emp
where deptno = 30;