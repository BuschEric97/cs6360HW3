/**PART 1**/
/*CREATE TABLES*/
DROP TABLE if exists book;
CREATE TABLE book (
    book_id         integer,
    title           varchar(35) not null,
    publisher_name  varchar(30) not null,
    primary key (book_id)
);

DROP TABLE if exists book_authors;
CREATE TABLE book_authors (
    book_id         integer,
    author_name     varchar(30),
    primary key (book_id, author_name)
);

DROP TABLE if exists publisher;
CREATE TABLE publisher (
    publisher_name  varchar(30),
    address         varchar(50),
    phone           varchar(15),
    primary key (publisher_name)
);

DROP TABLE if exists book_copies;
CREATE TABLE book_copies (
    book_id         integer,
    branch_id       integer,
    no_of_copies    integer not null,
    primary key (book_id, branch_id)
);

DROP TABLE if exists book_loans;
CREATE TABLE book_loans (
    book_id         integer,
    branch_id       integer,
    card_no         integer,
    date_out        date,
    due_date        date not null,
    return_date     date,
    primary key (book_id, branch_id, card_no)
);

DROP TABLE if exists library_branch;
CREATE TABLE library_branch (
    branch_id       integer,
    branch_name     varchar(25) not null,
    address         varchar(50) not null,
    primary key (branch_id)
);

DROP TABLE if exists borrower;
CREATE TABLE borrower (
    card_no         integer,
    borrower_name   varchar(30),
    address         varchar(50),
    phone           varchar(15),
    primary key (card_no)
);

/*CONSTRAINTS*/
ALTER TABLE book ADD CONSTRAINT fkpub FOREIGN KEY(publisher_name) REFERENCES publisher(publisher_name);
ALTER TABLE book_authors ADD CONSTRAINT fkbid FOREIGN KEY(book_id) REFERENCES book(book_id);
ALTER TABLE book_copies ADD CONSTRAINT fkcpid FOREIGN KEY(book_id) REFERENCES book(book_id);
ALTER TABLE book_copies ADD CONSTRAINT fkcpbrid FOREIGN KEY(branch_id) REFERENCES library_branch(branch_id);
ALTER TABLE book_loans ADD CONSTRAINT fklnbid FOREIGN KEY(book_id) REFERENCES book(book_id);
ALTER TABLE book_loans ADD CONSTRAINT fklnbrid FOREIGN KEY(branch_id) REFERENCES library_branch(branch_id);
ALTER TABLE book_loans ADD CONSTRAINT fkcno FOREIGN KEY(card_no) REFERENCES borrower(card_no);


/**PART 2**/
SELECT dname, COUNT (ssn)
FROM (department NATURAL JOIN employee)
GROUP BY dname
HAVING AVG (salary) > 30000;

SELECT dname, COUNT (ssn)
FROM (department NATURAL JOIN employee)
WHERE gender = 'M'
GROUP BY dname
HAVING AVG (salary) > 30000;

SELECT fname, lname
FROM employee
WHERE dno IN (SELECT dno
              FROM (department NATURAL JOIN employee)
              GROUP BY dno, salary
              HAVING salary = MAX (salary));
              
SELECT fname, lname
FROM employee
GROUP BY fname, lname, salary
HAVING salary >= (MIN (salary)+ 10000);

SELECT fname, lname
FROM employee E, dependent D, department P
WHERE E.dno = P.dno AND D.essn = E.ssn
GROUP BY E.fname, E.lname, E.salary
HAVING E.salary = MIN (E.salary);