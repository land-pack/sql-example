# How to use trigger in MySQL


-- mysql> select * from account;
-- +------+---------+
-- | uid  | money   |
-- +------+---------+
-- |  103 | 1000.00 |
-- |  102 | 1890.00 |
-- |  101 | 2230.00 |
-- |  104 |  430.00 |
-- +------+---------+

# Create a audit table for account

CREATE TABLE account_audit (
	id INT AUTO_INCREMENT PRIMARY KEY,
	uid INT NOT NULL,
	changedat DATETIME DEFAULT NULL,
	money DECIMAL(10, 2),
	action VARCHAR(50) DEFAULT NULL
)

# create trigger for account 

DELIMITER $$
CREATE TRIGGER before_account_update
	BEFORE UPDATE ON account
	FOR EACH ROW
BEGIN 
	INSERT INTO account_audit
	SET action = 'update',
	uid = OLD.uid,
	money = OLD.money,
	changedat = NOW();
END$$
DELIMITER;


# After do a update on `account` table
-- +----+-----+---------------------+---------+--------+
-- | id | uid | changedat           | money   | action |
-- +----+-----+---------------------+---------+--------+
-- |  1 | 101 | 2017-09-28 11:44:53 | 2230.00 | update |
-- +----+-----+---------------------+---------+--------+

# create a snap account audit
CREATE TABLE account_audit_snap (
	id INT AUTO_INCREMENT PRIMARY KEY,
	uid INT NOT NULL,
	changedat DATETIME DEFAULT NULL,
	money DECIMAL(10, 2),
	action VARCHAR(50) DEFAULT NULL
)

# create a snap trigger with some conndition is true will trigger

# create trigger for account only when the current time more than given time

DELIMITER $$
CREATE TRIGGER before_account_update_snap
	BEFORE UPDATE ON account
	FOR EACH ROW
BEGIN 
	IF curtime() > "23:30:00" THEN 
	INSERT INTO account_audit_snap
	SET action = 'update',
	uid = OLD.uid,
	money = OLD.money,
	changedat = NOW();
	END IF;
END$$
DELIMITER;

# If you account has update before given time, will not trigger any thing~