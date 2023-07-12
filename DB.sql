----------------------------------------------------------2023-07-07-------------------------------
-- between, not, in(or)  잘 알아두기 


--------------------------------------

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

----------------------------------------------------------2023-07-10-------------------------------

-- 이름이 F로 시작하는 사람을 찾는 쿼리문
-- 와일드 카드 % (위치와 종류)
-- 검색하고자 하는 값을  정확히 모를 경우 와일드 카드와 함께 사용할 수 있다.
select * from emp where ename like 'F%';

-- 위치 상관 없이 이름 중에 A가 들어있는 사람을 찾는 쿼리문
select * from emp where ename like '%A%';

select * from emp where ename like '%N';

select * from emp where ename like '_A%'; -- n(_)번째 글자에 대한 와일드 카드 

select * from emp where ename not like '%A%'; -- A를 포함하지 않는 사람만 검색하는 쿼리문

-- null을 위한 연산자
-- null의 의미 : 미확정, 알 수 없는 값
-- 고로 연산, 할당, 비교가 불가능

-- 커미션(comm)을 받지 못하는 사원을 검색하는 쿼리문
select * from emp where comm is null;
--select * from emp where comm is not null;

-- 정렬을 위한 ORDER BY 절
select * from emp order by sal asc; -- 오름차순 
select * from emp order by sal desc; -- 내림차순

select * from emp order by hiredate desc;

-- 이름을 사전순 출력하는 쿼리문
select * from emp order by ename asc;

-- 월급이 3000 이상인 사원을 이름 사전순 출력
select * from emp where sal >= 3000 order by ename asc;

-- distinct
-- 사원들이 소속되어 있는 부서의 번호를 출력하는 쿼리문
select distinct deptno from emp; -- 중복없이 출력

-- as 별칭, 컬럼에 연산을 하게 되면 컬럼에 해당되는 데이터를 같이 연산한다.
select sal *12 as sal from emp; -- 연봉

-- || 수직바 (컬럼 내에 문자열을 추가)
select ename || ' is a ' || JOB as "연결정의 예" from emp; -- as생략 가능 (가독성을 위해 붙이기)

-- 테이블 데이터 타입 확인 
desc dept; -- 부서
desc emp;

-- dual
-- 한 행으로 결과를 출력하기 위한 테이블
-- 산술 연산이나 가상 컬럼 등의 값을 한 번만 출력하고 싶을 때 많이 사용 
select 24 * 26 from dual; -- 연산 
select sysdate from dual; -- 현재 날짜 

-- 오라클에서 제공하는 내장 함수들(숫자형, 문자형, 날짜형)
-- -10에 대한 절대값을 구하는 쿼리문
select abs (-10) from dual; -- abs() : 절대값 
-- 소수점 아래를 버리는 함수
select 34.5432, floor (32.5432) from dual;
-- 특정 자릿수에서 반올림
select 34.5667, round (34.5667, 2) from dual; -- 둘째 자리수에서 반올림 
-- 나누기 연산을 한 후 나머지를 결과 (자바 연산자 %)
select mod (27, 2), mod (27, 5), mod (27, 7) from dual;

-- 문자 처리 함수 
select 'oracle', upper('oracle') from dual; -- 대문자 
select lower('ORACLE') from dual; -- 소문자  

-- emp ename을 소문자로 
select lower(ename) from emp;

select initcap('oracle') from dual; -- 첫 글자만 대문자 
select initcap(ename) from emp;

-- 문자 길이를 구하는 함수
select length(ename), ename from emp;

-- dubstr(1,2) 시작 위치부터 선택 개수만큼의 문자를 추출 
select substr('oracle', 0, 1) from emp;

-- 원래는 
select substr(ename, 1, 2) from emp;


select ename, 19 || substr(hiredate, 1, 2)year, substr(hiredate, 4, 2)month from emp;
-- 9월에 입사한 사원을 출력하는 쿼리문
select ename, 19 || substr (hiredate, 1, 2)year, substr(hiredate, 4, 2)month from emp where substr( hiredate, 4, 2)='09';

-- 공백 제거
select ltrim('                    ORACLE') from dual; -- left trim
select rtrim(          'ORACLE         ') from dual;

-- 날짜 함수
select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from dual;

-- 두 날짜 사이의 개월수 
select ename, sysdate, hiredate, round(months_between(sysdate, hiredate)) 근무개월수 from emp; -- round올림  floor버림

-- 입사 날짜에서 4개월 추가 
select ename, hiredate, add_months(hiredate, 4) from emp;

-- 오늘을 기준으로 가장 가까운 다음주 수요일은?
select sysdate, next_day(sysdate, '수요일') from dual;

-- 입사한 달의 마지막 날 
select hiredate, last_day(hiredate) from emp;

-- 현재 날짜를 문자형으로 변환하여 출력하는 커ㅜ리문
select sysdate, to_char(sysdate, 'YYYY-MM-DD') from dual;

-- 입사일을 출력하되, 요일까지 함꼐 출력
select sysdate, to_char(sysdate, 'YY::MM::DD DAY') as 입사일 from dual;

-- 현재 날짜와 시간을 출력하는 쿼리문
select to_char(sysdate, 'YYYY/MM/DD, HH24:MI:SS') from dual;

-- 각 지역별 통화 기호를 앞에 붙이고 천 단위마다 콤마를 붙여서 출력하는 쿼리문 (예: \1,234,000)
desc emp;
select ename, sal, to_char(sal, 'L999,999') from emp;

-- to_date 문자를 -> data 타입
-- 문자형을 날짜형으로 변환하는 함수이다.
-- 1981년 2월 20일에 입사한 사원을 검색하는 쿼리문 
select ename, hiredate from emp where hiredate = '1981/02/20'; --to_char('1981/02/20');으로 해도 출력됨. 기본형이 충족되었기 때문 
select ename, hiredate from emp where hiredate = to_date(19810220, 'YYYYMMDD');

-- 올해 며칠이 지났는지 현재 날짜에서 2016-01-01을 뺸 결과를 출력
select sysdate - to_date('2016/01/01', 'YYYY/MM/DD') from dual; -- to_date : 문자형이나 숫자형을 dateType으로 바꿈

-- to_number 사용법 = 문자를 숫자로 바꿈.
select to_number('20,000', '99,999')-to_number('10,000', '99,999') from dual;

-- null을 다른 값으로 변환하는 nvl함수*   nvl 함수 = null value, null이 있으면 0으로 바꾸기 
-- 연봉 계산 하는 쿼리문
select ename, sal, sal *12 + comm from emp;
select ename, sal, sal *12 + nvl(comm, 0) 연봉, nvl(comm,0) from emp;

-- 선택을 위한 decode 함수 명령어
-- 여러가지 경우에 대해서 선택할 수 있도록 하는 기능을 제공한다. (switch case문)

-- decode 함수
select deptno from emp order by deptno;
select deptno, decode (deptno, 10, 'A', 20, 'B', 30, 'C') from emp order by deptno;
select deptno, decode (deptno, 10, 'Accounting', 20, 'Research', 30, 'Sales') as dname from emp order by deptno;

-- case 함수 if 문 
select ename, deptno,
    case when deptno=10 then 'Accounting'
         when deptno=20 then 'Research'
         when deptno=30 then 'Sales'
         when deptno=40 then 'Operations'
         end as ename
from emp;

-- sal 2500 이상이면 수, 2500 미만이면 가 (컬럼명 등급)
select ename, sal,
    case when sal>=2500 then '수'
         when sal<2500 then '가'
         end as grade
from emp; 

-- 사원의 급여를 출력하되 단일행 함수 round로 천단위 이하를 반올림하는 쿼리문
select deptno, sal, round(sal,-3) from emp; -- (-3)이 3만큼 반올림 

-- 함수 = 단일행 함수 외 그룹함수.
-- 단일행 함수는 각 행에 대해서 함수
-- 그룹함수 복수의 행에 대해서 1개의 행으로 출력되는 거 
-- 그룹함수의 결과값은 하나인데, 그룹 함수를 적용하지 않은 단순 칼럼의 로우의 개수는 14개 이기 때문에 산출되는 로우의 수가 달라 둘을 매치 시킬 수 없다.

-- 그룹 함수를 이용해서 사원의 총 급여를 구하는 쿼리문
select * from emp;
SELECT SUM(SAL) FROM EMP;

-- 급여 평균
select avg(sal) from emp;
-- 가장 높은/낮은
SELECT MAX(SAL), MIN(SAL) FROM EMP;
-- 총 사원수
SELECT COUNT(*) FROM EMP;
-- 중복 제거를 반영하여 담당업무의 개수를 구하는 쿼리문 
SELECT COUNT(DISTINCT JOB) 업무수 FROM EMP;
