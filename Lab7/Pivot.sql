DROP TABLE BookSales
CREATE TABLE BookSales
(BookType VARCHAR(20), SalesYear INT, BookSales MONEY);
GO
 
INSERT INTO BookSales VALUES('Fiction', 2014, 11201);
INSERT INTO BookSales VALUES('Fiction', 2014, 12939);
INSERT INTO BookSales VALUES('Fiction', 2013, 10436);
INSERT INTO BookSales VALUES('Fiction', 2013, 9346);
INSERT INTO BookSales VALUES('Nonfiction', 2014, 7214);
INSERT INTO BookSales VALUES('Nonfiction', 2014, 5800);
INSERT INTO BookSales VALUES('Nonfiction', 2013, 8922);
INSERT INTO BookSales VALUES('Nonfiction', 2013, 7462);
 
SELECT * FROM BookSales;

/*
what if somebody wants to see the output this way

column names:	BookType	  2013		  2014
Data row 1:		Fiction		19782.00	24140.00
Data row 1:		Nonfiction	16384.00	13014.00

we're trying to make the data inside the row as columns of the output. You should think Pivot if that is the requirement.

*/

-- This will not work because it groups it with every unique booktype,year combination.
select BookType, SalesYear, sum(booksales)
FROM BookSales
group by BookType, SalesYear

-- This will not work either to meet the requirement
select BookType, sum(booksales)
FROM BookSales
group by BookType

-- That's when you need the pivot functionality
SELECT *
FROM BookSales
  PIVOT(SUM(BookSales)
  FOR SalesYear IN([2013], [2014])
  ) AS PivotSales;

-- The reason tables are built to grow row wise is when you don't want to have to 
-- to do a schema change when a new type -so to speak is added. For example, let's say
-- we add a book type of "Literary fiction"

INSERT INTO BookSales VALUES('Literary fiction', 2014, 7214);
INSERT INTO BookSales VALUES('Literary fiction', 2014, 5800);
INSERT INTO BookSales VALUES('Literary fiction', 2013, 8922);
INSERT INTO BookSales VALUES('Literary fiction', 2013, 7462);

-- All good
select * from BookSales
SELECT *
FROM BookSales
  PIVOT(SUM(BookSales)
  FOR SalesYear IN([2013], [2014])
  ) AS PivotSales;

-- let's say we are in a new year
INSERT INTO BookSales VALUES('Fiction', 2015, 11201);
INSERT INTO BookSales VALUES('Nonfiction', 2015, 7214);
INSERT INTO BookSales VALUES('Literary fiction', 2015, 7214);

SELECT *
FROM BookSales
  PIVOT(SUM(BookSales)
  FOR SalesYear IN([2013], [2014], [2015])
  ) AS PivotSales;

