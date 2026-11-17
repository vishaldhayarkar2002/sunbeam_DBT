-- A row and a column in a relational table are respectively called:
-- A. Tuple and attribute

-- Degree - total columns
-- Cardinality - Total rows

31. Which clause is used with ALTER TABLE in MySQL to rename an existing column and
change its data type simultaneously?
Explanation: CHANGE COLUMN old_col new_col datatype renames and redefines a column, whereas
MODIFY only alters its definition.

CREATE TABLE new_tbl LIKE old_tbl;  
All are trivial because the right-hand side is already included in the left-hand side.
Because A is already present in AB. Therefore, AB → A is trivial.

-- The three fundamental Armstrong axioms are reflexivity, augmentation and transitivity.
-- BCNF - Every non-trivial functional dependency X → Y must have X as a superkey.

-- An attribute belonging to at least one candidate key is called a prime attribute. 
-- Other attributes are non-prime attributes.
-- Decomposition divides a larger relation into smaller relations to reduce redundancy and anomalies.

-- 4NF eliminates non-trivial multivalued dependencies unless the determinant is a superkey.
-- 5NF, also called Project-Join Normal Form (PJNF), deals with join dependencies that cannot be explained by candidate keys.

-- 1. BCNF (Boyce-Codd Normal Form)
-- Rule: For every non-trivial functional dependency \(X \rightarrow Y\), X must be a Super Key.

-- In simple words: The left-hand side of every functional dependency must be a Super Key.


-- 2. 4NF (Fourth Normal Form)
-- Rule: A table must be in BCNF and should not contain any non-trivial multivalued dependency unless its determinant is a super key.

-- In simple words: Avoid storing two independent multivalued facts in the same table.

-- 3. 5NF (Fifth Normal Form)
-- Also called Project-Join Normal Form (PJNF).

-- Rule: A table must not contain non-trivial join dependencies that cannot be explained by candidate keys.

-- In simple words: Decompose a table into smaller tables when a complex relationship can be reconstructed by joining those tables without introducing incorrect rows

-- Candidate Key - Minimal Super Keys
-- Super Key     - All attribute combinations that uniquely identify rows
-- Primary Key   - Candidate key selected to identify records
-- Prime Attribute - if it is part of at least one Candidate Key.
-- Simple Key   : Candidate Key containing only one attribute.
-- Composite Key: Candidate Key containing two or more attributes.

-- A dependency X → Y is trivial when Y is a subset of X.

-- Formal condition for 3NF for every non-trivial dependency X → A, where A is a single attribute? -> X is a superkey, or A is a prime attribute.

--  in BCNF if, for every non-trivial functional dependency X → Y: - > X is a superkey

-- COUNT(column) ignores NULL values
-- B. Selection chooses rows; projection chooses columns

-- correct logical execution order of clauses 
-- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY

WITH a AS (...), b AS (SELECT ... FROM a) SELECT ... FROM b; --chained CTE syntax
-- SUM() OVER(ORDER BY ...) calculates a cumulative sum by default for this ordered window.

-- Variable → Cursor → Handler

-- SQLSTATE conditions outside the success 00, warning 01 and not-found 02 classes

-- find() returns a cursor; findOne() returns one matching document
-- $addToSet prevents adding duplicate values to an array.
-- $unset	Remove field