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
-- 22.  커미션이 책정되어 있는 모든 사원의 이름, 부서이름 및 위치를 출력하라.
select e.ename, d.dname, d.LOC from emp e, dept d where e.deptno=d.deptno and comm is not null;
-- 23. 이름에 A가 들어가는 모든 사원의 이름과 부서 이름을 출력하라.
select e.ename, d.dname from emp e, dept d where e.deptno=d.deptno and e.ename like '%A%';
-- 24. Dallas에서 근무하는 모든 사원의 이름, 직업, 부서번호 및 부서이름을 출력하라.
select e.ename, e.job, e.deptno, d.dname from emp e, dept d where e.deptno=d.deptno and d.loc = 'DALLAS';
-- 25. 사원이름 및 사원번호, 해당 관리자이름 및 관리자 번호를 출력하되, 각 컬럼명을 employee,emp#,manager,mgr#으로 표시하여 출력하라.
select e.ename as "employee", e.empno as "emp#", m.ename as "manager", m.empno as "mgr#" from emp e, emp m where e.mgr=m.empno;
-- 26. 모든 사원의 이름,직업,부서이름,급여 및 등급을 출력하라
select e.ename, e.job, d.dname, e.sal, s.grade from emp e, dept d, salgrade s where e.deptno=d.deptno and e.sal between s.losal and s.hisal;
-- 27. Smith보다 늦게 입사한 사원의 이름 및 입사일을 출력하라.
select ename, hiredate
from emp 
where hiredate > (select hiredate from emp where ename='SMITH'); -- > : 늦게 입사 ( 현재 날짜보다 큰 )
-- 28. 자신의 관리자보다 먼저 입사한 모든 사원의 이름, 입사일, 관리자의 이름, 관리자의 입사일을 출력하되 각각 컬럼명을 Employee,EmpHiredate, Manager,MgrHiredate로 표시하여 출력하라.
select e.ename as "Employee", e.hiredate as "EmpHiredate", m.ename as "Manager", m.hiredate as "MgrHiredate"
from emp e, emp m
where e.mgr = m.empno and e.hiredate < m.hiredate;
-- 30. 모든 사원의 급여 최고액,최저액,총액 및 평균액을 출력하되 각 컬럼명을 Maximum, Minimum, Sum, Average로 지정하여 출력하라
select max(sal) as "Maximum", min(sal) as "Minimum", sum(sal) as "Sum", avg(sal) as "Average" from emp;
-- 31. 각 직업별로 급여 최저액.최고액,총액 및 평균액을 출력하라.
select job, max(sal), min(sal), sum(sal), avg(sal) from emp group by job;
-- 32. 직업이 동일한 사람 수를 직업과 같이 출력하라.
select job, count(job) from emp group by job;
-- 33. 관리자의 수를 출력하되, 관리자 번호가 중복되지 않게하라. 그리고, 컬럼명을 Number of Manager로 지정하여 출력하라.
select count(distinct(mgr)) as "Number of Manager" from emp;
-- 34. 최고 급여와 최저 급여의 차액을 출력하라.
select max(sal)-min(sal) from emp;
-- 35. 관리자 번호 및 해당 관리자에 속한 사원들의 최저 급여를 출력하라. 단, 관리자가 없는 사원 및 최저 급여가 1000 미만인 그룹은 제외시키고 급여를 기준으로 출력 결과를 내림차순으로 정렬하라.
select mgr, min(sal) from emp where mgr is not null group by mgr having min(sal)>=1000 order by min(sal);
-- 36. 부서별로 부서이름, 부서위치, 사원 수 및 평균 급여를 출력하라. 그리고 각각의 컬럼명을 부서명,위치,사원의 수,평균급여로 표시하라.
select e.deptno as "부서명", d.dname as "부서이름", d.loc as "위치", count(e.empno) as "사원의 수", avg(e.sal) as "평균급여"
from emp e, dept d where e.deptno=d.deptno group by e.deptno, d.dname, d.loc;
-- 37. Smith와 동일한 부서에 속한 모든 사원의 이름 및 입사일을 출력하라. 단, Smith는 제외하고 출력하시오
select ename, to_char(hiredate, 'YYYY-MM-DD') from emp
where deptno in(select deptno from emp where ename='SMITH') and ename != 'SMITH';
-- 38. 자신의 급여가 평균 급여보다 많은 모든 사원의 사원 번호, 이름, 급여를 표시하는 질의를 작성하고 급여를 기준으로 결과를 내림차순으로 정렬하라.
select empno, ename, sal from emp where sal > (select avg(sal) from emp) order by sal desc;
-- 38-1. 평균 추가 
select empno, ename, sal, (select avg(sal) from emp) as "평균" from emp
where sal > (select avg(sal) from emp) order by sal desc;
-- 39. 이름에 T가 들어가는 사원이 속한 부서에서 근무하는 모든 사원의 사원번호 및 이름을 출력하라.
select empno, ename from emp where deptno in(select deptno from emp where ename like '%T%');
-- 40. 부서위치가 Dallas인 모든 사원의 이름,부서번호 및 직위를 출력하라.
SELECT E.ENAME, E.DEPTNO, E.JOB
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND D.LOC='DALLAS'
