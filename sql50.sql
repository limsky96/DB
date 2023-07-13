--sql50제
-- 1. 부서테이블의 모든 데이터를 출력하라 
select*from dept;
-- 2. EMP테이블에서 각 사원의 직업, 사원번호, 이름, 입사일을 출력하라
select job,empno,ename,hiredate from emp; 
-- 3. EMP테이블에서 직업을 출력하되, 각 항목이 중복되지 않게 출력
select distinct job from emp;
-- 4. 급여가 2850이상인 사원의 이름 및 급여를 표시하는 출력
select sal,ename from emp where sal > 2850;
-- 5. 사원번호가 7566인 사원의 이름 및 부서번호를 표시하는 출력하라
SELECT ENAME, EMPNO FROM EMP WHERE EMPNO = 7566;
-- 6. 급여가 1500이상 - 2350 이하의 범위에 속하지 않는 모든 사원의 이름 및 결과를 출력하라
select sal, ename from emp where sal not between 1500 and 2350;
-- 7. 1981년 2월 20일- 1981년 5월 1일에 입사한 사원의 이름, 직업 및 입사일을 출력하라. 입사일 기준 오름차순
select ename, job, hiredate from emp where hiredate between '1981-02-20' and '1981-05-01' order by hiredate asc;
-- 8. 10번 또는 30번 부서에 속하는 모든 사원의 이름과 부서 번호를 출력하되, 이름을 알파벳순으로 정렬하여 출력하라.
select ename, deptno from emp where deptno in(10,30) order by ename; -- 정렬 : order by
-- 9.  10번 및 30번 부서에 속하는 모든 사원 중 급여가 1500을 넘는 사원의 이름 및 급여를 출력하라.
-- (단 컬럼명을 각각 employee 및 Monthly Salary로 지정하시오)
select ename as employee, sal as "Monthly Salary" from emp where deptno in(10, 30) and sal>1500; --monthly salary 띄어쓰기 주의
-- 10. 관리자가 없는 모든 사원의 이름 및 직위를 출력하라.
select ename, job from emp where mgr is null;
-- 11. 커미션을 받는 모든 사원의 이름, 급여 및 커미션을 출력하되, 급여를 기준으로 내림차순으로 정렬하여 출력하라.
select ename, sal, comm from emp where comm is not null order by sal desc;
-- 12. 이름의 세 번째 문자가 A인 모든 사원의 이름을 출력하라.
select ename from emp where ename like '__A%';
-- 13. 이름에 L이 두 번 들어가며 부서 30에 속해있는 사원의 이름을 출력하라.
select ename from emp where ename like '%L%L%' and deptno=30;
 -- 14. 직업이 Clerk 또는 Analyst 이면서 급여가 1000,3000,5000 이 아닌 모든 사원의 이름, 직업 및 급여를 출력하라.
select ename, job, sal from emp where job in('CLERK', 'ANALYST') and sal not in(1000, 3000, 5000);
-- 15> 사원번호, 이름, 급여 그리고 15%인상된 급여를 정수로 표시하되 컬럼명을 New Salary로 지정하여 출력하라.
select empno, ename, sal, round(sal+(sal*0.15),0) as "new salary" from emp; -- round : 반올림
-- 16. 15번 문제와 동일한 데이타에서 급여 인상분(새 급여에서 이전 급여를 뺀 값)을 추가해서 출력하라.(컬럼명은 Increase로 하라).
select empno, ename, sal, round(sal+(sal*0.15)) as "new salary", (round(sal+(sal*0.15)))-sal as "Increase" from emp;
-- 17. 모든 사원의 이름(첫 글자는 대문자로, 나머지 글자는 소문자로 표시) 및 이름 길이를 표시하는 쿼리를 작성하고 컬럼 별칭은 적당히 넣어서 출력하라.
select upper(substr(ename,1,1)) || lower(substr(ename,2,12)) as "name", length(ename) as "lenename" from emp;
--select initcap(ename)as name, length(ename) as lenght from emp;
-- 18. 사원의 이름과 커미션을 출력하되, 커미션이 책정되지 않은 사원의 커미션은 'no commission'으로 출력하라.
select ename, nvl(to_char(comm), 'no commission') from emp; -- nvl(null value) : 첫 번째 값이 NULL인 경우 두 번째 값으로 대체하는 함수
-- 19. 모든 사원의 이름,부서번호,부서이름을 표시하는 질의를 작성하라.(DECODE)
select empno, deptno, decode(deptno, 10, 'ACCOUNTIG', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS') as "dname" from emp;
-- 20. 30번 부서에 속한 사원의 이름과 부서번호 그리고 부서이름을 출력하라.(조인)
select e.ename, e.deptno, d.dname from emp e, dept d where e.deptno=d.deptno and e.deptno=30;
-- 21. 30번 부서에 속한 사원들의 모든 직업과 부서위치를 출력하라.
-- (단, 직업 목록이 중복되지 않게 하라.)
select distinct e.job, d.loc from emp e, dept d where e.deptno = d.deptno and d.deptno = 30; -- loc : 부서 위치 , distinct 중복제거 
