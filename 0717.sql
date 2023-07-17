----------------------------------------------------------2023-07-17--------
-- 페이징
-- rownum = 오라클에 페이징은 기본적으로 rownum으로 처리한다 .
-- rownum: select 해온 데이터에 일련번호 붙이기. ( 기본값 : 1 )
select rownum, emp. * from emp where rownum <= 10;  -- 뽑아 온 순서대로 번호 붙임 

-- 오라클 쿼리 순서 
-- 1. from/where 절이 먼저 처리된다.
-- 2. rownum이 할당되고 from/where절에서 절달되는 각각의 출력 로우에 대해 증가(increment)된다. 
-- 3. select가 적용된다.
-- 4. group by 조건이 적용된다.
-- 5. having이 적용된다
-- 6. order by 조건이 적용된다. 


select *
from (select rownum as rn, emp. * from emp) -- 일단 조건 가두고 
where rn between 5 and 10; -- 원하는 값 뽑아내기 

