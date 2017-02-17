

--
-- Table structure for mysql
--

DROP TABLE IF EXISTS tasks_t;

CREATE TABLE tasks_t (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(45) DEFAULT NULL,
  description varchar(45) DEFAULT NULL,
  category_name varchar(45) DEFAULT NULL,
  date_created datetime DEFAULT NULL,
  finished bit(1) DEFAULT b'0',
  PRIMARY KEY (id)
);


--
-- Table structure for postgres
--


CREATE TABLE tasks_t (
	id	SERIAL PRIMARY KEY,
	name	varchar(40) NOT NULL,
	description	varchar(40) NOT NULL,
	category_name	varchar(40) NOT NULL,
	date_created   date,
	finished BIT(1)
);

INSERT INTO tasks_t (
name,description,category_name,date_created,finished)
VALUES ('Paul','WorkHard','CATEGORY 1', '2001-07-13',B'0');
