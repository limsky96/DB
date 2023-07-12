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
-- 8. 