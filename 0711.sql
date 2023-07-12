----------------------------------------------------------2023-07-11-------------------------------

-- 부서의 최대값과 최소값을 구하되, 최대 급여가 2900 이상인 부서만 출력하는 쿼리문
select deptno, max(sal), min(sal) from emp group by deptno having max(sal) >= 2900;

-- join
-- 여러 테이블에 흩어져 있는 정보 중에서 사용자가 필요한 정보만 가져와서 가상의 테이블처럼 만들어서 결과를 보여준다.
-- join은 기본적으로 카테이션 곱 
select * from emp, dept;

-- 사원 정보를 출력할 때, 각 사원이 소속된 부서의 상세 정보를 출력하기 위해 두 개의 테이블을 조인하는 쿼리문
select * from emp, dept where emp.deptno = dept.deptno;

-- smith인 사람의 부서명을 출력해 보는 쿼리문
SELECT ENAME, DNAME FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND ENAME = 'SMITH';

-- 급여에 대한 등급을 총 5등급으로 구분한 테이블이다.
select * from salgrade;

-- 각 사원의 급여가 몇 등급인지 살펴보는 쿼리문
SELECT ENAME, SAL, GRADE FROM EMP, SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

-- 한 명의 사원 이름과 소속 부서명, 급여의 등급을 출력하는 쿼리문
SELECT E.ENAME, D.DNAME, S.GRADE FROM EMP E, DEPT D, SALGRADE S WHERE E.DEPTNO = D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 해당 사원의 매니저는 누구인가?
SELECT EMPLOYEE.ENAME||'의 매니저는 '|| MANAGER.ENAME||'입니다.' FROM EMP EMPLOYEE, EMP MANAGER WHERE EMPLOYEE.MGR = MANAGER.EMPNO;

----- anci조인 ----- 
-- 1. 등가조인
-- emp와 dept 테이블을 deptno칼럼으로
select * from emp, dept where emp.deptno = dept.deptno;

-- emp와 dept 테이블을 inner join, 같은 게 여러개있다면 여러 조합으로 join
select * from emp inner join dept on emp.deptno=dept.deptno;

-- 2. 비등가조인
-- (1) outer join
-- left outer join
select * from dept left join emp on emp.deptno = dept.deptno; -- left 뒤에 outer 생략 ~ 

-- 오라클에서는 outer join
-- select * from dept left outer join emp on emp.deptno=dept.deptno;
select * from dept, emp where emp.deptno(+) = dept.deptno; -- (+) : 아래 한 자리 더 만듦

-- right outer join
select * from dept right join emp on emp.deptno=dept.deptno; -- right는 잘 안씀 !! 레프트로쓰고 앞뒤테이블명만 바꾸면 되니까

----- 유니온 -----  
select job, deptno from emp where sal >= 3000
union -- 합집합 
select job, deptno from emp where deptno = 10;

-- 조인 : 테이블이 옆으로, 유니온 밑으로 

----- 서브쿼리 -----
-- 하나의 select 문장 내에 포함된 또 하나의 select 문장이 있는 쿼리문이다.
-- 비교 연산자의 오른쪽에 기술해야 하고, 반드시 괄호 안에 넣어야 한다.
-- 서브쿼리는 단일행 서브 쿼리와 다중행 서브 쿼리로 나뉜다.
select deptno from emp where ename = 'SMITH';
select dname from dept where deptno = 20;

select dname from emp, dept where emp.deptno = dept.deptno and ename = 'SMITH'; -- join
select dname from dept where deptno = (select deptno from emp where ename = 'SMITH'); -- 서브쿼리 , select안에 select

-- 사원들의 평균 급여보다 더 많은 급여를 받는 사원을 검색하는 쿼리문
SELECT ENAME, SAL FROM EMP WHERE SAL > (SELECT AVG(SAL) FROM EMP);

-- SMITH의 급여와 동일하거나 급여를 더 많이 받는 사원과 급여를 출력하는 쿼리문
SELECT ENAME, SAL FROM EMP WHERE SAL>= (SELECT SAL FROM EMP WHERE ENAME = 'SMITH');



desc emp;
