SELECT * from article;
SELECT ref, designation from article WHERE prix >= 2;
SELECT * from article WHERE prix >= 2 AND prix <= 6.25;
SELECT * from article WHERE prix BETWEEN 2 AND 6.25;
SELECT * from article WHERE ID_FOU = 1 AND prix NOT BETWEEN 2 AND 6.25 ORDER BY prix DESC;
SELECT * from article WHERE ID_FOU = 1 OR ID_FOU = 3;
SELECT * from article WHERE ID_FOU IN (1, 3); 
SELECT * from article WHERE ID_FOU NOT IN (1, 3); 
SELECT * FROM bon WHERE DATE_CMDE BETWEEN '2019-02-01' AND '2019-04-30';