select * from dept;
select * from emp;

select empno, ename from emp;
select ename from emp;

select * from emp where sal >3000;

select * from emp where deptno = 20;
select * from emp where sal <= 3000;
select * from emp where sal != 3000;

select * from emp where ename = 'SMITH'; --문자열 
select * from emp where job = 'PRESIDENT'; -- JOB or job 대/소문자 안가림 

select * from emp where hiredate >= '82/01/01';
select * from emp where deptno = '10' AND job = 'MANAGER'; -- 조건 2개는 AND
select * from emp where deptno = '10' OR job = 'MANAGER';
select * from emp where not deptno = '10';

select * from emp where sal >= 2000 AND sal <= 3000; -- between
select * from emp where sal between 2000 and 3000; -- and보다 between을 많이 사용

select * from emp where sal < 2000 or sal >3000;
select * from emp where sal not between 2000 and 3000;

select * from emp where hiredate between '82/01/01' and '82/12/31'; -- 날짜 표시할 때 / or . or - 사용가능 

select * from emp where comm = 300 or comm = 500 or  comm = 1400;
select * from emp where comm in(300, 500, 1400); -- in = or
select * from emp where comm not in(300,500,1400);