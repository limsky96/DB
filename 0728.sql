create table mvc_board(
    bid NUMBER(4) PRIMARY KEY, -- 글번호
    bname VARCHAR2(20),
    btitle VARCHAR2(100),
    bcontent VARCHAR2(300),
    bdate DATE DEFAULT SYSDATE,
    bhit NUMBER(4) DEFAULT 0, 
    bgroup NUMBER(4),
    bstep NUMBER(4),
    bindent NUMBER(4)
);

commit;

--sequence 생성
create SEQUENCE mvc_board_seq;

-- 넣고싶은 만큼 행 삽입(삽입할 때마다 commit도 해줘야함)
insert into mvc_board(bid, bname, btitle, bcontent, bhit, bgroup, bstep, bindent)
values (mvc_board_seq.nextval, 'abcd', 'is title', 'is content', 0, 
mvc_board_seq.currval, 0, 0);

select * from mvc_board;

desc mvc_board;