select * from users;
select * from AUTHORITIES;
select * from AUTHORITIES, users where users.username = AUTHORITIES.username;

desc AUTHORITIES;
desc users;