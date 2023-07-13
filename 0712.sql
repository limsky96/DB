----------------------------------------------------------2023-07-12-------------------------------
--◍<다중행 서브쿼리> :서브쿼리에서의 결과가 두건 이상 출력되는 것
--다중행 연산자(IN,ANY,ALL)와 함께 사용

--연봉을 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원들의 정보를 출력하는 쿼리문
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO in (SELECT DISTINCt DEPTNO FROM EMP WHERE SAL >= 3000);

--◉다중행 연산자 Any------------------------
--부서번호가 30번인 사원들의 급여 중 가장 낮은 값(950)보다 높은 급여를 받는 사원의 이름, 급여를 출력하는 쿼리문

SELECT ENAME, SAL FROM EMP WHERE DEPTNO = 30 and sal > (select min(sal) from emp); --보통
SELECT ENAME, SAL FROM EMP WHERE SAL> ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30); --다중쿼리사용

--//ANY 연습 : 조건을 만족하는 값이 하나라도 있다면 결과를 리턴=or연산자
select* from emp where sal = any(1000,2000,3000); --//100,200,300중 어떤거든 하나라도 만족하면
select* from emp where sal > any(1000,2000,3000); -- =min(1000)
select* from emp where sal >= any(1000,2000,3000); -- >=1000
select* from emp where sal < any(1000,2000,3000); -- =max(3000)

--◉다중행 연산자 ALL----------------------
--30번 소속 사원들중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사람의 이름과 급여를 출력하는 쿼리문
SELECT ename, sal FROM emp WHERE sal > (SELECT MAX(sal) FROM emp where deptno =30);
select ename, sal from emp where sal > all(select sal from emp where deptno = 30);

--//ALL 연습(모든 값을 만족해야함) = and연산자
select* from emp where sal = all(1000,2000,3000); --//100,200,300 모두 만족해야함(값안나오는게정상)
select* from emp where sal > all(1000,2000,3000); 
select* from emp where sal >= all(1000,2000,3000); 
select* from emp where sal < all(1000,2000,3000);

------ DDL------
-- 테이블 구조를 정의하는 create table 
create table emp01(
    empno number(4), -- 4자리수(0~9999)
    ename varchar2(2), --char와 다르게 가변형! 무조건 varchar2 (최대크기20)
    sal number(7,2)  -- 앞 : 전체길이 / 뒤 : 소수점 (40자리까지 가능)
);

desc emp01; --생성된 테이블 확인

create table emp02 as select * from emp; -- emp02가 그존의 emp를 복사 ~ 
desc emp02;
select * from emp02; -- data까지 복사됨 와우 

create table emp03 as select empno, ename from emp;

select * from emp03;
-- 테이블 구조를 변경하는 alter table
-- 기존 테이블의 구조를 변경하기 위한 DDL명령문이다.
-- 테이블에 대한 구조 변경은 칼럼의 추가, 수정, 삭제 시 사용된다.
 ALTER TABLE EMP01 ADD (JOB VARCHAR(9));
desc emp01;

ALTER TABLE EMP01 MODIFY (JOB VARCHAR(30));
ALTER TABLE EMP01 DROP COLUMN JOB;

-- drop table 
-- 기존 테이블의 존재를 제거한다.
-- 한번 제거한 데이터들은 다시 복구하기 힘들기 때문에 유의하기 바란다.

drop table emp01;

-- 테이블 삭제와 무결성 제약 조건
-- 삭제하고자 하는 테이블의 기본 키나 고유 키를 다른 테이블에서 참조해서 사용하는 경우에는 해당 테이블을 제거할 수 없다.
-- 이러한 경우에는 참조하는 테이블들을 먼저 제거한 후에 해당 테이블을 삭제해야 한다.

-- truncate table (테이블의 '모든' 로우를 제거)
-- drop table 과의 차이점 : truncate는 내용만 제거 
truncate table emp02;
select * from emp02;

-- 테이블명 변경
rename emp02 to test; -- test로 변경
desc emp02; -- 확인 

rename test to emp02; -- 다시 emp02로 

desc user_tables;
select * from user_tables;
-- 현재 접속한 사용자(SCOTT)가 생성한 테이블 이름을 알려주는 table_name 컬럼의 내용을 확인
select table_name from user_tables;
desc all_tables;
select * from all_tables;

-- 테이블의 내용을 추가, 수정, 삭제하는 DML
-- CRUD
-- 실습을 위해 DEPT테이블을 DEPT02테이블로로 구조만 복사한 후 데이터를 추가한 후 데이터를 조회하는 쿼리문
create table dept02 as select * from dept;

select * from dept02;
truncate table dept02; -- 테이블의 모든 로우 제거 
-- insert 예제
insert into dept02(deptno, dname, loc) values (10, 'ACCOUNTING', 'NEW YORK');
insert into dept02(deptno, dname, loc) values (20, 'RESEARCH', 'DALLAS');
insert into dept02 values (20, 'RESEARCH', 'DALLAS');

create table dept03 as select * from dept where 1=0;
select * from dept03; -- 빈 테이블로 나옴 / why : select(전체)를 뽑는데, 조건 where 1=0;이 있음! 뽑으려면 위에서부터 찾음(내부적if문) -> 조건을 따지기 때문에 안나옴 
desc dept03; -- 

desc dept02;

commit; -- 영구 저장 


-- where 1 = 0; 무조건 false 때리기 = 아무것도 보여주지 않겠다 = 구조만 복사 하겠다.
create table dept03 as select * from dept where 1=0;
select * from dept03;
-- update 명령문
drop table emp01;
create table emp01 as select * from emp;
-- 모든 사원의 부서 번호를 30번으로 수정 후 확인하는 쿼리문
update emp01 set deptno = 30;
select * from emp01;
--사원의 급여를 10% 인상싴ㅣsms update문을 만드는  쿼리문
UPDATE EMP01 SET SAL = SAL*1.1;
-- 모든 입사일을 오늘로 수정하는 쿼리문 
update emp01 set hiredate = sysdate;
--v부서 번호가 10번인 사원의 부서 번호를 40번으로 수정하고 확인하는 쿼리문
UPDATE EMP01 SET DEPTNO = 40 WHERE DEPTNO = 10;
SELECT * FROM EMP01;
-- JOB 컬럼값이 MANAGER인 경우, 급여를 10% 인상하는 쿼리문
UPDATE EMP01 SET SAL = SAL * 1.1 WHERE JOB = 'MANAGER';
-- 1987년에 입사한 사원의 입사일을 오늘로 수정하는 쿼리문
UPDATE EMP01 SET HIREDATE = SYSDATE WHERE SUBSTR(HIREDATE, 1, 2) = '87';
-- update emp01 set hiredate = stsdate where hiredate between '82/01/01' and '82/12/31';  으로 해두 댐

--  SMITH 사원의 부서번호는 20번으로, JOB 컬럼값은 MANAGER로 한꺼번에 수정하는 쿼리문
UPDATE EMP01 SET DEPTNO=20, JOB='MANAGER' WHERE ENAME='SMITH';

-- SMITH 사원의 입사 날짜는 오늘로, 급여는 50으로, 커미션은 4000으로 수정하는 쿼리문
UPDATE EMP01 SET HIREDATE = SYSDATE, SAL=50, COMM=4000 WHERE ENAME='SMITH';

DROP TABLE DEPT01;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
select * from dept01;

-- 20번 부서의 지역명을 40번 부서의 지역명으로 변경하기 위해서 서브 쿼리문을 사용한 쿼리문
UPDATE DEPT01 SET LOC = (SELECT LOC FROM DEPT01 WHERE DEPTNO=40) WHERE DEPTNO=20;

-- 20번 부서의 지역명이 40번 부서의 지역명으로 변경된 것을 확인하는 쿼리문
SELECT * FROM DEPT01;

-- delete 명령문 
-- DEPT01 부서 테이블의 모든 데이터를 삭제하는 쿼리문
DELETE FROM DEPT01;
commit;
rollback; -- 커밋하면 롤백안됨 

-- 30번 부서를 삭제한 후 부서 테이블을 확인하는 쿼리문
DELETE FROM DEPT01 WHERE DEPTNO = 30;
SELECT * FROM DEPT01;

-- 서브 쿼리문으로 부서명이 SALES인 부서의 번호부터 알아낸 뒤 SALES 부서 소속의 사원을 삭제하는 쿼리문
DELETE FROM EMP01 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');


drop table dept01;
create table dept01 as select * from dept;
select * from dept01;


----- 트랜잭션 관리 -----
-- 일련의 작업 단위
-- 완전히 처리되거나 all-or-nothing
delete from dept01; -- 딜리트 특징 : 롤백
rollback;

delete from dept01 where deptno = 20;
commit; -- 커밋하면 롤백 불가 ~
-- 커밋을 수행하여 영구저장 했으므로 롤백을 해도 특정 로우를 삭제하기 이전의 이전 상태로 되돌릴 수 없다.
-- 롤백의 기준은 커밋이전까지

-- 자동 commit

-- DDL 구문은 자동으로 commit을 실행하기 때문ㅇㅔ rollback이 안됨
-- create, alter, drop, rename, truncate = DDL 
-- delete가 롤백이 되는 이유는  - DML - insert, delete, update, select


-- *데이터 무결성(결점이 없음)을 위한 제약 조건
-- 무결성 (결점) = 데이터의 정확성을 유지하는 것. = 제약 조건(5가지)를 거는 것 
-- 1. not null
DROP TABLE EMP02;

CREATE TABLE EMP02(
    EMPNO NUMBER(4) NOT NULL, 
    ENAME VARCHAR2(10) NOT NULL, 
    JOB VARCHAR2(9), 
    DEPTNO NUMBER(2)
);

desc emp02;
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO) VALUES (1, '홍길동','SALESMAN', 20);

select * from emp02;

-- 2. unique
DROP TABLE EMP03;
CREATE TABLE EMP03(
    EMPNO NUMBER(4) unique, -- primary key = not null + unique
    ENAME VARCHAR2(10) NOT NULL, 
    JOB VARCHAR2(9), 
    DEPTNO NUMBER(2)
);
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO) VALUES (1, '홍길동',null, null);
select * from emp03;

-- 3. 프라이머리키(PK) = Primary Key
DROP TABLE EMP05;

CREATE TABLE EMP05(EMPNO NUMBER(4)
    CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY,
    ENAMR VARCHAR2(10) CONSTRAINT EMP05_ENAME_NN NOT NULL,
    JOB VARCHAR(9), DEPTNO NUMBER(2)
    );
    
