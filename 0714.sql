CREATE TABLE users ( -- 쌍따옴표가 들어가면 대소문자 구분함 !! 
	id	varchar2(50)		NULL,
	email	varchar2(100)		NOT NULL
);

ALTER TABLE users ADD CONSTRAINT PK_USERS PRIMARY KEY (
	"id"
);

----------------------------------------------------------
CREATE TABLE users (
	email	varchar2(100)		NOT NULL,
	images_id	number		NOT NULL
);


CREATE TABLE images (
	id	number		NOT NULL,
	path	varchar2(200)		NOT NULL,
	Field	VARCHAR(255)		NULL
);


ALTER TABLE images ADD CONSTRAINT PK_IMAGES PRIMARY KEY (
	id
);

