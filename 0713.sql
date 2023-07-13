----------------------------------------------------------2023-07-13-------------------------------
-- 데이터의 무결성
-- 4. Foreign key 
DROP TABLE EMP06;

CREATE TABLE EMP06(
    EMPNO NUMBER(4) CONSTRAINT EMP06_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10) CONSTRAINT EMP06_ENAME_NN NOT NULL,
    JOB VARCHAR(9),
    DEPTNO NUMBER(2) CONSTRAINT EMP06_DEPTNO_FK REFERENCES DEPT(DEPTNO)); -- references : foreignkey 만드는 문법 

insert into emp06 values(7499, ' allen', 'salesman', 30); -- 행 삽입
insert into emp06 values(7800, ' 홍길동', 'salesman', 30);

-- delete from dept where deptno =30; -- child record found오류남 ! foreign key의 특징 

select * from emp06; -- 결과 확인

-- 5. check (좋은데 개발자들이 잘 안 씀)
create table student(
    id number(4) primary key, 
    score number(3) not null,
    constraint score_check check (score >= 0) -- 제약조건 
);

-- 제약조건 추가하는 문장 
-- alter table 테이블명 add constraint 제약조건명 check(조건 또는 범위);

insert into student values (1, 100);

----- 시퀀스 ----- 
drop sequence emp_seq; -- 시퀀스 삭제 
CREATE SEQUENCE EMP_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 100000; -- 스타트번호 1 ~ 

DROP TABLE EMP01;
CREATE TABLE EMP01(
    EMPNO NUMBER(4) PRIMARY KEY, 
    ENAME VARCHAR(10), 
    HIREDATE DATE
);

insert into emp01 values (emp_seq.nextval, '홍길동',sysdate);
select * from emp01;

select emp_seq.currval from dual; -- currval : current values
select emp_seq.nextval from dual;

alter sequence emp_seq increment by 2;

--Database 카디널리티.
