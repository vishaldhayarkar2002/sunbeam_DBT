0.  Date-Time
Type	    Format	        Range
DATE	    YYYY-MM-DD	1000-01-01 to 9999-12-31
TIME	    HH:MM:SS	-838:59:59 to 838:59:59
DATETIME	YYYY-MM-DD  HH:MM:SS	1000 to 9999 (TZ-independent)
TIMESTAMP	YYYY-MM-DD  HH:MM:SS	1970 UTC to 2038 (TZ-aware, Unix epoch)
YEAR	    2/4-digit	1901–2155

-------------------------------------------------------------------------------
DECIMAL(m,n) — exact precision (money, percentages).
-------------------------------------------------------------------------------
CREATE TABLE temp(c1 CHAR(4), c2 VARCHAR(4), c3 TEXT(4));
INSERT INTO temp VALUES('abcd','abcd','abcdef');  -- works
INSERT INTO temp VALUES('abcde',...);  -- ERROR: Data too long for col1
-------------------------------------------------------------------------------
Alias not allowed in SELECT, but allowed in ORDER BY.
-------------------------------------------------------------------------------
DELETE marks rows deleted (not physically removed — can be undone).

TRUNCATE = permanent, resets table data, keeps structure.

DROP = deletes data + structure (DROP TABLE IF EXISTS t;).
-------------------------------------------------------------------------------
SELECT ROUND(12345.567);      -- 12346
SELECT ROUND(12345.567, 2);   -- 12345.57
SELECT ROUND(12345.567, -1);  -- 12350
SELECT TRUNCATE(12456.845, 2);-- 12456.84
-------------------------------------------------------------------------------
SELECT SUBSTRING("Sunbeam Info",5);
-- start from 5th char and give the substring till the last char
-- eam Info
SELECT SUBSTRING("Sunbeam Info" FROM 5);
-- eam Info

SELECT SUBSTRING("Sunbeam Info",5,3);
-- start from 5th char and returns only 3 chars after that.
-- eam


SELECT SUBSTRING("Sunbeam Info" FROM 5 FOR 3);

SELECT SUBSTRING("Sunbeam Info" FROM -5);
-- _Info

SELECT SUBSTRING("Sunbeam Info" FROM -5 for 3);
-- _In

-------------------------------------------------------------------------------
SELECT NOW(),SLEEP(5),NOW();

SELECT SYSDATE(),SLEEP(5),SYSDATE();
/*
NOW() returns the current date and time at which the query 
begins execution.
SYSDATE() returns the current date and time at which the function
actually executes.
*/
-------------------------------------------------------------------------------
-- NULLIF()
-- syntax : NULLIF(exp,value)
-- compares 2 parameter values , returns null if both are equal.
-- returns 1st parameter if not equal.
-- sales / orders
-- sales /0  -- division by 0 problem
-- sales / NULLIF(orders,0)
NULLIF(new_email,old_email)
--if the exp is equal to the value it gives NULL.
-------------------------------------------------------------------------------
SELECT IFNULL(comm, 0);        -- replace NULL
SELECT ISNULL(comm);           -- 1 if NULL else 0
SELECT NULLIF(sal, 3000);      -- NULL if equal else sal
SELECT COALESCE(a,b,c,'NA');   -- first non-NULL
SELECT GREATEST(sal, IFNULL(comm,0));
SELECT LEAST(sal, IFNULL(comm,0));
SELECT IF(sal >= 2500, 'Above Avg', 'Avg');
-------------------------------------------------------------------------------
Execution order: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
-------------------------------------------------------------------------------
CREATE TABLE emp_backup SELECT * FROM emp;   -- clones structure + data
-------------------------------------------------------------------------------
6. FULL JOIN (simulate via UNION)
MySQL doesn t support FULL JOIN → use LEFT UNION RIGHT.
UNION — removes duplicates; UNION ALL — keeps duplicates.
-------------------------------------------------------------------------------
Constraint name optional — auto-generated if not given; column-level cannot be named (only table-level can with CONSTRAINT name ...).

CREATE TABLE contacts (
  name VARCHAR(20) NOT NULL,
  email VARCHAR(20) UNIQUE,                            -- column-level
  phone_no CHAR(15),
  CONSTRAINT ph_unique UNIQUE(phone_no)                -- table-level w/ name
);
-------------------------------------------------------------------------------
Composite Primary Key (must be table-level only)
CREATE TABLE students (
  std INT, roll_no INT, name VARCHAR(20), marks DECIMAL(5,2),
  PRIMARY KEY(std, roll_no)
);
-------------------------------------------------------------------------------
FK can have duplicate values and NULLs.
Cannot delete/update parent row if child references it (unless CASCADE).
Self-referencing FK allowed (e.g., mgr_id → emp_id in same table).
ON DELETE CASCADE — auto-delete child rows.
ON UPDATE CASCADE — auto-update child rows.
-------------------------------------------------------------------------------
CREATE TABLE check_emp (
  age INT CHECK (age BETWEEN 20 AND 65),
  sal DECIMAL(8,2) CHECK (sal > 1000),
  CHECK(sal + IFNULL(comm,0) > 1200)   -- table-level
);
-------------------------------------------------------------------------------
3. Views
Virtual table — stored query (no data).
CREATE VIEW v_name AS SELECT ...;
Simple View — single table, no agg/join → DML allowed (updates base table).
Complex View — JOIN, GROUP BY, subquery → DML NOT allowed (often error).
-------------------------------------------------------------------------------
SELECT * FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);
ERROR (aggregate not allowed in WHERE).
-------------------------------------------------------------------------------
mysql> SELECT * FROM v_deptwise_sal;
+--------+-----------+---------+---------+-------------+
| deptno | total_sal | max_sal | min_sal | avg_sal     |
+--------+-----------+---------+---------+-------------+
|   NULL |      NULL |    NULL |    NULL |        NULL | 
|     10 |   8750.00 | 5000.00 | 1300.00 | 2916.666667 |
|     20 |  10875.00 | 3000.00 |  800.00 | 2175.000000 |
|     30 |   9400.00 | 2850.00 |  950.00 | 1566.666667 |
+--------+-----------+---------+---------+-------------+
4 rows in set (0.01 sec)

-- Shows the NULL in the first row because of the INSERT command in the above view v1_emp;
-------------------------------------------------------------------------------
-- <ANY considers LESS THAN MAXIMUM value coming frm the sub-query.
 -- >ANY considers greater than minimum value from all the values coming from
-- inner query.
  -- < ALL : Less than Minimum
  -- > ALL : Greater tha max
-------------------------------------------------------------------------------
SELECT 1, 'Hello' INTO v_a, v_b;
-------------------------------------------------------------------------------
-- IF / ELSEIF / ELSE
IF cond THEN ... ELSEIF cond THEN ... ELSE ... END IF;

-- WHILE
WHILE cond DO ... END WHILE;

-- REPEAT (do-while: runs at least once)
REPEAT ... UNTIL cond END REPEAT;

-- LOOP with LEAVE
label: LOOP
  IF cond THEN LEAVE label; END IF;
END LOOP;

-- CASE
CASE WHEN cond THEN ... ELSE ... END CASE;
-------------------------------------------------------------------------------
However COMMIT/ROLLBACK is not allowed in triggers.
-------------------------------------------------------------------------------
Mutating Table Error: When cascading triggers cause an earlier trigger to 
re-execute → prevents infinite loop, rolls back transaction
-------------------------------------------------------------------------------
Querying — Operators (Very Important)
-- Querying: RDBMS Operators and MongoDB Equivalents
--
-- RDBMS condition                         MongoDB filter
-- --------------------------------------  ----------------------------------------------
-- WHERE age = 25                          { age: 25 } or { age: { $eq: 25 } }
-- WHERE age != 25                         { age: { $ne: 25 } }
-- WHERE age > 25                          { age: { $gt: 25 } }
-- WHERE age < 25                          { age: { $lt: 25 } }
-- WHERE age >= 25                         { age: { $gte: 25 } }
-- WHERE age <= 25                         { age: { $lte: 25 } }
-- WHERE job IN ('A', 'B')                 { job: { $in: ['A', 'B'] } }
-- WHERE job NOT IN (...)                  { job: { $nin: [...] } }
-- WHERE deptno = 20 AND job = 'MANAGER'   { $and: [{ deptno: 20 }, { job: 'MANAGER' }] }
-- WHERE deptno = 10 OR job = 'ANALYST'    { $or: [{ deptno: 10 }, { job: 'ANALYST' }] }
-- WHERE comm IS NOT NULL                  { comm: { $exists: true } }
-- WHERE ename LIKE 'M%'                   { ename: /^M/ }
-- WHERE ename LIKE '%ER'                  { ename: /ER$/ }
-- Case-insensitive match                  { ename: /king/i }  -- i flag enables case-insensitive matching
-------------------------------------------------------------------------------
// Include only specific fields (1)
db.emp.find({}, { ename: 1, sal: 1, _id: 0 })

// Exclude specific fields (0)
db.emp.find({}, { _id: 0, job: 0, comm: 0 })
-- _id is included by default unless you set _id: 0.
-------------------------------------------------------------------------------
db.emp.find().sort({ sal: -1 })          // -1 = DESC, 1 = ASC
db.emp.find().sort({ deptno: 1, job: 1 })// multi-column sort
db.emp.find().limit(5)                    // first 5
db.emp.find().skip(2).limit(1)            // skip 2, take 1 (like LIMIT 2,1)
db.emp.find().count()                     // count result
-------------------------------------------------------------------------------
// Update one document
db.person.updateOne(
  { name: "Geeta" },
  { $set: { age: 30, city: "Mumbai" } }   // $set = set new values
)

// Increment a field
db.person.updateOne(
  { name: "Geeta" },
  { $inc: { age: 1 } }                    // $inc = increment/decrement
)

// Multiply a field (e.g., raise salary by 10%)
db.emp.updateMany(
  {},
  { $mul: { sal: 1.1 } }                  // $mul = multiply
)

// Upsert = update if exists, insert if not
db.emp.updateOne(
  { ename: 'JOHN', deptno: 30 },
  { $set: { sal: 5000 } },
  { upsert: true }
)


db.person.deleteOne({ name: "Seeta" })          // delete first match
db.emp.deleteMany({ sal: { $gt: 2500 } })       // delete many matches
db.person.deleteMany({})                        // delete ALL documents

// Drop entire collection (like DROP TABLE)
db.person.drop()

// Drop the whole database
db.dropDatabase("ac_classwork_db")
-------------------------------------------------------------------------------
WITH GRANT OPTION = "you can give this privilege to others too".
By default, a user cannot pass their privileges to others.
REVOKE UPDATE ON db.table FROM user@host;         -- remove specific privilege
REVOKE ALL PRIVILEGES ON db.* FROM user@host;     -- remove all on db
-------------------------------------------------------------------------------
Does FLUSH PRIVILEGES need to run after GRANT/REVOKE?	
No — auto-done. Only needed if you manually modify grant tables with DML.
-------------------------------------------------------------------------------
ROLLBACK TO SAVEPOINT name	Undo back to that point (transaction still active)
RELEASE SAVEPOINT name	Remove that savepoint
IMP - ROLLBACK TO SAVEPOINT does NOT end the transaction. Only COMMIT or ROLLBACK end it
-------------------------------------------------------------------------------
f you fire any DDL command (CREATE / ALTER / DROP / TRUNCATE) inside a transaction, 
it automatically commits all previous DMLs.
-------------------------------------------------------------------------------
Optimistic vs Pessimistic Locking
Type	How it works
Optimistic (automatic)	MySQL automatically locks rows/table when you UPDATE/DELETE inside a transaction. Releases after COMMIT/ROLLBACK.
Pessimistic (manual)	You explicitly lock rows using SELECT ... FOR UPDATE.
-------------------------------------------------------------------------------
What is a CTE?
A CTE is a named temporary result set defined at the top of a query using WITH. 
Its like a temporary table that only exists for the duration of that single query.
-------------------------------------------------------------------------------
FUNC() OVER (
    PARTITION BY col1, col2           -- split rows into groups (like GROUP BY)
    ORDER BY col3 DESC                -- sort within each partition
    ROWS BETWEEN ...                  -- define which rows the window includes
)
-------------------------------------------------------------------------------
SELECT empno, ename, sal, SUM(sal) OVER() AS total_sal FROM emp;
-- Every row shows its sal AND the company total
SELECT empno, ename, sal, deptno,
       SUM(sal) OVER(PARTITION BY deptno) AS dept_total
FROM emp;
--Show each employee's salary + their dept's total salary:
-------------------------------------------------------------------------------
Ranking Functions (Very Important Comparison)
Function	    Behavior with ties	        Behavior with gaps
ROW_NUMBER()	Always gives 1, 2, 3, 4...	No gaps (ties get different numbers)
RANK()	        Ties get same rank	        Next rank skips (1, 1, 3, 4...)
DENSE_RANK()	Ties get same rank	        No gaps (1, 1, 2, 3...)
-------------------------------------------------------------------------------
Visual example — Salaries: 5000, 3000, 3000, 2975
Row	sal	    ROW_NUMBER	RANK	DENSE_RANK
2	3000	    2	      2	        2
1	5000	    1	      1	        1
3	3000	    3	      2	        2
4	2975	    4	      4	        3

SELECT empno, ename, sal,
       ROW_NUMBER() OVER(ORDER BY sal DESC) AS row_num,
       RANK()       OVER(ORDER BY sal DESC) AS rnk,
       DENSE_RANK() OVER(ORDER BY sal DESC) AS drnk
FROM emp;
-------------------------------------------------------------------------------
--Named Window Clause (Cleaner syntax) IMP
SELECT
    ROW_NUMBER() OVER(w1) AS sr_no,
    RANK() OVER(w1) AS rnk,
    DENSE_RANK() OVER(w1) AS drnk,
    empno, ename, sal
FROM emp
WINDOW w1 AS (PARTITION BY deptno ORDER BY sal DESC);
-------------------------------------------------------------------------------

SELECT empno, ename, sal,
       LAG(sal)  OVER(ORDER BY sal) AS prev_sal,     -- previous row's sal
       LEAD(sal) OVER(ORDER BY sal) AS next_sal      -- next row's sal
FROM emp;
-------------------------------------------------------------------------------
SELECT empno, ename, deptno, sal,
       FIRST_VALUE(ename) OVER(w1) AS first_emp,
       LAST_VALUE(ename)  OVER(w1 ROWS BETWEEN UNBOUNDED PRECEDING
                                     AND UNBOUNDED FOLLOWING) AS last_emp,
       ROW_NUMBER() OVER(w1) AS sr_no
FROM emp
WINDOW w1 AS (PARTITION BY deptno ORDER BY sal DESC);
-------------------------------------------------------------------------------
2NF (Second Normal Form)
every non-key column depends on the ENTIRE composite primary key (no partial dependency).
Look at tables with composite PK (e.g., Order_Products with PK (O_id, P_id)).

Any non-key column that depends on only part of the composite PK → move to a new table.

-------------------------------------------------------------------------------
3NF (Third Normal Form)
Rule: Must be 2NF AND no transitive dependency (non-key → non-key).
Look only at non-key columns.
If non-key column A depends on non-key column B (not directly on PK), move both to a new table.
-------------------------------------------------------------------------------

4NF / BCNF (Boyce-Codd Normal Form)
Stricter 3NF — every determinant must be a candidate key.
 separate well-known data into lookup tables to minimize end-user data entry.

Example: If City determines Pin, and Pin determines City (one-to-one), one of them isnt a candidate key → BCNF violation → split.
-------------------------------------------------------------------------------


