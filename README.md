# 📚 Library Management System – MySQL Project

This project demonstrates the database schema for a **Library Management System**, including table creation, relationships, and initial structure for managing members, books, employees, issues, returns, and branches.

---

## 🏗️ Database Schema

### ✅ Create Database
```sql
CREATE DATABASE Library_System;
USE Library_System;
```

---

## 📋 Table Structures

### 👤 Members Table
```sql
CREATE TABLE Members (
    member_id VARCHAR(255) PRIMARY KEY,
    member_name VARCHAR(250),
    member_address VARCHAR(250),
    reg_date VARCHAR(255)
);
```

---

### 📚 Books Table
```sql
CREATE TABLE Books (
    isbn VARCHAR(255) PRIMARY KEY,
    book_title VARCHAR(255),
    category VARCHAR(255),
    rental_price DECIMAL(6,2),
    `status` VARCHAR(255),
    author VARCHAR(255),
    publisher VARCHAR(255)
);
```

---

### 🔁 Return Table
```sql
CREATE TABLE return_status (
    return_id VARCHAR(20) PRIMARY KEY,
    issued_id VARCHAR(20),
    return_date VARCHAR(50)
);

-- Renaming the table
RENAME TABLE return_status TO `return`;

-- Removing unnecessary columns
ALTER TABLE `return` 
DROP COLUMN return_book_name,
DROP COLUMN return_book_isbn;
```

---

### 🏢 Branch Table
```sql
CREATE TABLE Branch (
    branch_id VARCHAR(50) PRIMARY KEY,
    manager_id VARCHAR(50),
    branch_address VARCHAR(255),
    contact_no INT
);

-- Changing column name and type
ALTER TABLE Branch 
CHANGE COLUMN contact_no contact_on VARCHAR(50);
```

---

### 👨‍💼 Employee Table
```sql
CREATE TABLE Employe (
    emp_id VARCHAR(50) PRIMARY KEY,
    emp_name VARCHAR(100),
    `position` VARCHAR(100),
    salary INT,
    branch_id VARCHAR(50)
);
```

---

### 📖 Issue Table
```sql
CREATE TABLE issue (
    issued_id VARCHAR(50) PRIMARY KEY,
    issued_member_id VARCHAR(50),
    issued_book_name VARCHAR(100),
    issued_date VARCHAR(50),
    issued_book_isbn VARCHAR(100),
    issued_emp_id VARCHAR(50)
);
```

---

## ✅ Notes

- All primary keys are defined to ensure uniqueness.
- Foreign key constraints can be added depending on further normalization and relational requirements.
- All date fields are stored as `VARCHAR` for simplicity, but can be converted to `DATE` type for stricter date handling.
- You can add sample data or additional constraints (e.g., `FOREIGN KEY`) as needed for your application logic.

---


## 📚 – Book Queries (MySQL)

This section contains SQL queries and corresponding answers related to **Books** in the Library Management System database.

---

## 📖 1. Which books are currently unavailable for rent?

```sql
SELECT * 
FROM books
WHERE `status` = 'No';
```

**Answer:**

| isbn              | book_title                                              | category | rental_price | status | author              | publisher         |
|------------------|----------------------------------------------------------|----------|---------------|--------|---------------------|-------------------|
| 978-0-307-58837-1 | Sapiens: A Brief History of Humankind                   | History  | 8.00          | no     | Yuval Noah Harari   | Harper Perennial  |
| 978-0-375-41398-8 | The Diary of a Young Girl                               | History  | 6.50          | no     | Anne Frank          | Bantam            |
| 978-0-7432-7357-1 | 1491: New Revelations of the Americas Before Columbus   | History  | 6.50          | no     | Charles C. Mann     | Vintage Books     |

---

## 💰 2. What is the most expensive book to rent in each category?

```sql
SELECT category, MAX(rental_price) AS max_price
FROM books
GROUP BY category;
```

**Answer:**

| Category         | Max Price |
|------------------|-----------|
| Children         | 4.00      |
| Classic          | 8.00      |
| Fiction          | 6.50      |
| Fantasy          | 7.50      |
| History          | 9.00      |
| Literary Fiction | 6.50      |
| Science Fiction  | 8.50      |
| Dystopian        | 7.00      |
| Horror           | 7.00      |
| Mystery          | 8.00      |

---

## 📚 3. How many books are there in the "Classic" category?

```sql
SELECT COUNT(*) AS books_count
FROM books
WHERE category = 'Classic';
```

**Answer:**

| books_count |
|-------------|
| 8           |

---

## 🔢 4. Which books have been issued the most?

```sql
SELECT issued_book_name AS book_name, COUNT(*) AS books_count
FROM issue
GROUP BY book_name
ORDER BY books_count DESC;
```

**Top Results:**

| book_name                              | books_count |
|----------------------------------------|-------------|
| Animal Farm                            | 2           |
| The Great Gatsby                       | 2           |
| Harry Potter and the Sorcerers Stone   | 2           |
| ...                                    | ...         |

---

## 🏷️ 5. List all books published by "Penguin Books"

```sql
SELECT book_title,
       ROW_NUMBER() OVER (ORDER BY book_title) AS serial
FROM books 
WHERE publisher = 'Penguin Books';
```

**Answer:**

| book_title                    | serial |
|------------------------------|--------|
| 1984                         | 1      |
| 1984                         | 2      |
| A Tale of Two Cities         | 3      |
| Animal Farm                  | 4      |
| Moby Dick                    | 5      |
| One Hundred Years of Solitude | 6    |

---

## 🔄 6. Which books have been issued more than once but never returned?

```sql
WITH book_count AS (
    SELECT *, COUNT(*) OVER(PARTITION BY issued_book_name) AS book_issued
    FROM issue 
)
SELECT issued_book_name AS book, issued_id
FROM book_count
LEFT JOIN `return` USING(issued_id)
WHERE book_issued > 1 AND return_id IS NULL;
```

**Answer:**

| book                                | issued_id |
|-------------------------------------|-----------|
| Animal Farm                         | IS140     |
| Harry Potter and the Sorcerers Stone | IS139    |
| The Great Gatsby                    | IS138     |

---

## ⌛ 7. Which books are currently overdue?

```sql
SELECT DISTINCT ROW_NUMBER() OVER() AS serial, issued_book_name AS books
FROM issue
LEFT JOIN `return` USING(issued_id)
WHERE return_id IS NULL;
```

**Answer:**

| serial | books                                 |
|--------|----------------------------------------|
| 1      | The Shining                            |
| 2      | Fahrenheit 451                         |
| 3      | Dune                                   |
| ...    | ...                                    |
| 20     | Animal Farm                            |

---

## 📦 8. Which books have never been issued?

```sql
SELECT book_title
FROM books
LEFT JOIN issue ON isbn = issued_book_isbn
WHERE issued_book_isbn IS NULL;
```

**Answer:**

| book_title         |
|--------------------|
| The Road           |
| 1984               |
| The Da Vinci Code  |

---

## 💵 9. What is the total revenue generated by each branch?

```sql
WITH revenue_table AS (
    SELECT isbn, book_title, rental_price,
           COUNT(issued_book_isbn) AS rent,
           rental_price * COUNT(issued_book_isbn) AS revenue
    FROM books 
    LEFT JOIN issue ON isbn = issued_book_isbn
    GROUP BY isbn, book_title
)
SELECT branch_id, SUM(revenue) AS total_revenue 
FROM revenue_table
LEFT JOIN issue ON isbn = issued_book_isbn
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY branch_id;
```

**Answer:**

| branch_id | total_revenue |
|-----------|----------------|
| B001      | 147.00         |
| B002      | 17.50          |
| B005      | 50.00          |
| B004      | 26.50          |
| B003      | 20.00          |
| NULL      | 0.00           |

---

## 📝 10. Which books were issued but not returned?

```sql
SELECT issued_id, issued_book_isbn, book_title
FROM issue
LEFT JOIN `return` USING(issued_id)
LEFT JOIN books ON isbn = issued_book_isbn
WHERE return_id IS NULL;
```

**Answer:**

| issued_id | issued_book_isbn       | book_title                             |
|-----------|-------------------------|----------------------------------------|
| IS121     | 978-0-385-33312-0       | The Shining                            |
| IS122     | 978-0-451-52993-5       | Fahrenheit 451                         |
| IS123     | 978-0-345-39180-3       | Dune                                   |
| IS124     | 978-0-06-025492-6       | Where the Wild Things Are              |
| IS125     | 978-0-06-112241-5       | The Kite Runner                        |
| ...       | ...                     | ...                                    |
| IS140     | 978-0-330-25864-8       | Animal Farm                            |

---

Here’s the **GitHub-ready Markdown** for your **Members-Related SQL Queries** section, including **formatted SQL, answers, and summaries**.

---

## 👥  Member Queries (MySQL)

This section includes SQL queries related to **members** in the Library Management System, such as registration trends, borrowing behaviors, and branch-based interactions.

---

## 📆 11. How many members registered in 2021?

Finds the number of members who registered in the year 2021.

```sql
SELECT COUNT(*) AS Member_num
FROM members
WHERE reg_date LIKE '2021%';
```

**Answer:**

| Member_num |
|------------|
| 8          |

---

## 📚 12. Which member has borrowed the most books?

Lists members by the total number of books they’ve borrowed, in descending order.

```sql
SELECT member_name, member_id, COUNT(*) AS books_borrowed
FROM issue
LEFT JOIN members ON member_id = issued_member_id 
GROUP BY member_id 
ORDER BY books_borrowed DESC;
```

**Answer (Top Members):**

| member_name   | member_id | books_borrowed |
|---------------|-----------|----------------|
| Ivy Martinez  | C109      | 7              |
| Grace Taylor  | C107      | 6              |
| Jack Wilson   | C110      | 6              |

---

## 🛑 13. List all members who have not borrowed any books.

Identifies members who have never issued any books.

```sql
SELECT member_name, member_id
FROM members
LEFT JOIN issue ON member_id = issued_member_id
WHERE issued_id IS NULL;
```

**Answer:**

| member_name | member_id |
|-------------|-----------|
| Sam         | C118      |
| John        | C119      |

---

## ⚠️ 14. Which member has the most overdue books (not returned)?

Counts the number of books each member has that are overdue (not returned yet).

```sql
WITH main AS (
    SELECT issued_member_id, COUNT(*) AS overdue
    FROM issue
    LEFT JOIN `return` USING(issued_id)
    WHERE return_id IS NULL 
    GROUP BY issued_member_id
    ORDER BY overdue DESC
)
SELECT main.*, members.member_name 
FROM main
LEFT JOIN members ON issued_member_id = member_id;
```

**Answer:**

| issued_member_id | overdue | member_name  |
|------------------|---------|--------------|
| C105             | 5       | Eve Brown    |
| C107             | 5       | Grace Taylor |
| C106             | 3       | Frank Thomas |

---

## 📊 15. What is the average number of books borrowed per member?

Calculates the average number of books borrowed per member.

```sql
SELECT ROUND(AVG(book_count), 2) AS Avg_Book 
FROM (
    SELECT COUNT(*) AS book_count, issued_member_id
    FROM issue
    GROUP BY issued_member_id
) AS count_table;
```

**Answer:**

| Avg_Book |
|----------|
| 3.50     |

---

## 🏢 16. Which members have borrowed books from multiple branches?

Finds members who have borrowed books from more than one branch.

```sql
SELECT issued_member_id, COUNT(DISTINCT branch_id) AS Total_branch
FROM issue 
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY issued_member_id
HAVING Total_branch > 1;
```

**Answer:**

| issued_member_id | Total_branch |
|------------------|--------------|
| C107             | 3            |
| C109             | 2            |
| C110             | 4            |

---

## 📘 17. Which members have borrowed books from the "Classic" category?

Lists members and the classic books they’ve borrowed.

```sql
SELECT member_id, member_name,
       GROUP_CONCAT(book_title SEPARATOR ', ') AS books_names
FROM books
LEFT JOIN issue ON book_title = issued_book_name
LEFT JOIN members ON member_id = issued_member_id
WHERE category = 'Classic'
GROUP BY member_name, member_id;
```

**Answer:**

| member_id | member_name     | books_names                                                  |
|-----------|------------------|--------------------------------------------------------------|
| C101      | Alice Johnson    | Pride and Prejudice                                          |
| C106      | Frank Thomas     | To Kill a Mockingbird, Animal Farm, Moby Dick               |
| C110      | Jack Wilson      | Animal Farm                                                 |

---

## 👤 18. What is the total number of unique members who have borrowed books?

Counts the number of distinct members who have issued at least one book.

```sql
SELECT COUNT(DISTINCT issued_member_id) AS total_unique_members
FROM issue;
```

**Answer:**

| total_unique_members |
|----------------------|
| 10                   |

---

## 🌍 19. Which members have borrowed books from the most branches?

Lists members who borrowed books from more than two distinct branches.

```sql
SELECT issued_member_id, member_name, COUNT(DISTINCT branch_id) AS borrowed_branch
FROM issue
LEFT JOIN members ON issued_member_id = member_id
LEFT JOIN employe ON issued_emp_id = emp_id 
GROUP BY issued_member_id, member_name
HAVING borrowed_branch > 2;
```

**Answer:**

| issued_member_id | member_name   | borrowed_branch |
|------------------|---------------|------------------|
| C107             | Grace Taylor  | 3                |
| C110             | Jack Wilson   | 4                |

---

## ➕ 20. List all members who have borrowed books from more than one branch.

Similar to the previous query but includes all who borrowed from more than one branch.

```sql
SELECT issued_member_id, member_name, COUNT(DISTINCT branch_id) AS borrowed_branch
FROM issue
LEFT JOIN members ON issued_member_id = member_id
LEFT JOIN employe ON issued_emp_id = emp_id 
GROUP BY issued_member_id, member_name
HAVING borrowed_branch > 1;
```

**Answer:**

| issued_member_id | member_name   | borrowed_branch |
|------------------|---------------|------------------|
| C107             | Grace Taylor  | 3                |
| C109             | Ivy Martinez  | 2                |
| C110             | Jack Wilson   | 4                |

---

Here’s the **GitHub-ready Markdown** for your **Employee-Related SQL Queries**, formatted with syntax highlighting, results, and brief summaries for each question.

---

## 🧑‍💼  Employee Queries (MySQL)

This section covers employee-related queries within the Library Management System. These include tracking book issues, salaries, roles, and identifying top-performing staff across branches.

---

## 📚 21. Which employee has issued the most books?

Returns a list of employees sorted by the number of books they issued.

```sql
SELECT emp_id, emp_name, COUNT(issued_emp_id) AS issued_num
FROM issue
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY emp_id, emp_name
ORDER BY issued_num DESC;
```

**Answer:**

| emp_id | emp_name           | issued_num |
|--------|--------------------|------------|
| E106   | Michelle Ramirez   | 6          |
| E110   | Laura Martinez     | 6          |
| E104   | Emily Davis        | 4          |

---

## 💰 22. What is the total salary expenditure for each branch?

Summarizes salary expenses branch-wise.

```sql
SELECT branch_id, SUM(salary) AS salary_expenditure 
FROM employe 
GROUP BY branch_id 
ORDER BY branch_id;
```

**Answer:**

| branch_id | salary_expenditure |
|-----------|--------------------|
| B001      | 240000             |
| B005      | 168000             |

---

## 👔 23. List all employees who are managers.

Retrieves all employees with the "manager" designation.

```sql
SELECT ROW_NUMBER() OVER(ORDER BY emp_name) AS serial, emp_name 
FROM employe
WHERE position = 'manager';
```

**Answer:**

| serial | emp_name         |
|--------|------------------|
| 1      | Daniel Anderson  |
| 2      | Laura Martinez   |

---

## 🏢 24. Which branch has the highest number of employees?

Counts employees per branch and sorts by count.

```sql
SELECT branch_id, COUNT(*) AS employe_num 
FROM employe
GROUP BY branch_id
ORDER BY employe_num DESC;
```

**Answer:**

| branch_id | employe_num |
|-----------|-------------|
| B001      | 5           |
| B005      | 3           |

---

## 📊 25. What is the average salary of employees by position?

Displays the average salary grouped by employee roles.

```sql
SELECT position, avg_salary
FROM (
    SELECT position, ROUND(AVG(salary), 2) AS avg_salary 
    FROM employe
    GROUP BY position
) AS avg_table;
```

**Answer:**

| position   | avg_salary |
|------------|------------|
| Clerk      | 53250.00   |
| Librarian  | 55000.00   |
| Assistant  | 47500.00   |
| Manager    | 49000.00   |

---

## 🏆 26. Which employee has the highest salary, and what is their branch?

Finds the highest-paid employee and their assigned branch.

```sql
SELECT emp_name, branch_id
FROM employe
WHERE salary = (SELECT MAX(salary) FROM employe);
```

**Answer:**

| emp_name         | branch_id |
|------------------|-----------|
| Christopher Lee  | B005      |

---

## 🗓️ 27. Which employee has the highest number of books issued in a single month?

Lists number of books issued per employee by month.

```sql
SELECT emp_id, emp_name, 
       COUNT(issue.issued_date) AS count_books,
       DATE_FORMAT(issued_date, '%Y %M') AS date_Month
FROM employe
LEFT JOIN issue ON emp_id = issued_emp_id
GROUP BY emp_id, emp_name, date_Month
ORDER BY emp_id;
```

**Partial Answer:**

| emp_id | emp_name           | count_books | date_Month   |
|--------|--------------------|-------------|--------------|
| E110   | Laura Martinez     | 4           | 2024 March   |
| E106   | Michelle Ramirez   | 3           | 2024 April   |
| E108   | Jessica Taylor     | 3           | 2024 March   |

---

## 📦 28. What is the total number of books issued by each manager?

Shows the total books issued by employees with the "manager" role.

```sql
SELECT emp_name, COUNT(issued_id) AS books_issue
FROM issue
LEFT JOIN employe ON issued_emp_id = emp_id
WHERE position = 'manager'
GROUP BY emp_name
ORDER BY books_issue DESC;
```

**Answer:**

| emp_name        | books_issue |
|-----------------|-------------|
| Laura Martinez  | 6           |
| Daniel Anderson | 3           |

---

## 🗃️ 29. List all employees who have issued books in 2024.

Returns distinct employees who have issued books in the year 2024.

```sql
SELECT DISTINCT emp_name 
FROM issue
LEFT JOIN employe ON emp_id = issued_emp_id
WHERE YEAR(issued_date) = '2024';
```

**Answer:**

| emp_name           |
|--------------------|
| Emily Davis        |
| Sarah Brown        |
| Michelle Ramirez   |
| John Doe           |
| Jane Smith         |

---

## 🧙 30. Which employees have issued books from the "Fantasy" category?

Identifies employees who issued books categorized under "Fantasy".

```sql
SELECT DISTINCT emp_name 
FROM issue
LEFT JOIN books ON issued_book_isbn = isbn
LEFT JOIN employe ON emp_id = issued_emp_id
WHERE category = 'Fantasy';
```

**Answer:**

| emp_name         |
|------------------|
| Sarah Brown      |
| Michelle Ramirez |

---

Absolutely! Here's the **GitHub-style Markdown** documentation for **Branch-Related and General Analytical Queries** in your Library Management System project.

---


## 🏢 Branch-Related Queries

---

### 🔢 31. How many branches are managed by each manager?

Shows how many and which branches each manager oversees.

```sql
SELECT emp_name, COUNT(manager_id) AS branch_count, 
       GROUP_CONCAT(b.branch_id) AS branch_ids
FROM employe e
JOIN branch b ON manager_id = emp_id
GROUP BY emp_name;
```

**Answer:**

| emp_name         | branch_count | branch_ids     |
|------------------|--------------|----------------|
| Daniel Anderson  | 3            | B001,B002,B003 |
| Laura Martinez   | 2            | B004,B005      |

---

### 📦 32. Which branch has issued the most books?

Calculates total issued books per branch.

```sql
SELECT branch_id, COUNT(issued_id) AS 'books issu'
FROM issue
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY branch_id;
```

**Answer:**

| branch_id | books issu |
|-----------|------------|
| B001      | 17         |
| B005      | 9          |

---

### ☎️ 33. List all branches and their contact numbers.

Retrieves branch contact details.

```sql
SELECT branch_id, contact_on
FROM branch;
```

**Answer:**

| branch_id | contact_on     |
|-----------|----------------|
| B001      | 919099988676   |
| B002      | 919099988677   |

---

### 📘 34. What is the total number of books issued by employees in each branch?

Summarizes book issues per branch with employee involvement.

```sql
SELECT branch_id, 
       GROUP_CONCAT(DISTINCT issued_emp_id) AS "emp id's", 
       COUNT(issued_id) AS books_issue
FROM issue
JOIN employe ON issued_emp_id = emp_id
GROUP BY branch_id;
```

**Answer:**

| branch_id | emp id's                 | books_issue |
|-----------|--------------------------|-------------|
| B001      | E101,E103,E104,E105,E106 | 17          |

---

### 💵 35. Which branch has the highest total rental income?

Calculates total rental revenue generated by each branch.

```sql
WITH books_rental AS (
    SELECT issued_book_isbn, issued_book_name, 
           rental_price, COUNT(issued_id) AS books_rent,
           rental_price * COUNT(issued_id) AS total_rent
    FROM issue
    LEFT JOIN books ON isbn = issued_book_isbn
    GROUP BY issued_book_isbn, issued_book_name
)

SELECT branch_id, SUM(total_rent) AS "Branch total rent"
FROM books_rental 
LEFT JOIN issue USING(issued_book_isbn)
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY branch_id;
```

**Answer:**

| branch_id | Branch total rent |
|-----------|-------------------|
| B001      | 147.00            |
| B005      | 50.00             |

---

## 📊 General Analytical Queries

---

### 💰 36. What is the total rental income generated from all issued books?

Gives cumulative rental revenue from all books.

```sql
WITH count_table AS (
    SELECT isbn, rental_price, COUNT(issued_id) AS book_count 
    FROM issue
    LEFT JOIN books ON isbn = issued_book_isbn
    GROUP BY isbn 
)

SELECT SUM(rental_price * book_count) AS "Total Rental Income"
FROM count_table;
```

**Answer:**  
💵 **Total Rental Income:** 220.00

---

### 📚 37. Which book category generates the highest rental income?

Ranks categories based on rental revenue.

```sql
WITH count_table AS (
    SELECT isbn, rental_price, COUNT(issued_id) AS book_count 
    FROM issue
    LEFT JOIN books ON isbn = issued_book_isbn
    GROUP BY isbn 
)

SELECT category, SUM(c.rental_price * book_count) AS Total_Rental_Income
FROM count_table c
LEFT JOIN books b USING(isbn)
GROUP BY category
ORDER BY Total_Rental_Income DESC;
```

**Answer:**

| category         | Total_Rental_Income |
|------------------|---------------------|
| Classic          | 59.00               |
| History          | 49.50               |
| Fantasy          | 28.50               |

---

### 🗓️ 38. How many books were issued in each month of 2024?

Monthly distribution of issued books for the year 2024.

```sql
SELECT MONTHNAME(issued_date) AS per_month, COUNT(*) AS books_issue
FROM issue
WHERE YEAR(issued_date) = 2024
GROUP BY per_month;
```

**Answer:**

| per_month | books_issue |
|-----------|-------------|
| March     | 22          |
| April     | 13          |

---

### 🏆 39. Which category of books is the most popular (most issued)?

Finds the category with the highest number of issued books.

```sql
SELECT category, COUNT(issued_id) AS issued
FROM issue 
LEFT JOIN books ON issued_book_isbn = isbn
GROUP BY category
ORDER BY issued DESC
LIMIT 1;
```

**Answer:**

| category | issued |
|----------|--------|
| Classic  | 10     |

---

### 📅 40. What is the total number of books returned in 2023?

Book return trends in 2023 by month.

```sql
SELECT DATE_FORMAT(return_date,'%Y %M') AS date_return, COUNT(*) AS book_return
FROM `return` 
WHERE YEAR(return_date) = 2023
GROUP BY date_return;
```

**Answer:**

| date_return   | book_return |
|---------------|-------------|
| 2023 June     | 2           |
| 2023 August   | 1           |

---

### ⏳ 41. What is the average time (in days) between book issuance and return?

Computes average return period for issued books.

```sql
WITH day_count AS (
    SELECT issued_id, DATEDIFF(return_date, issued_date) AS day_gap
    FROM `return`
    JOIN issue USING(issued_id)
)

SELECT ROUND(AVG(day_gap), 2) AS 'Avarage Day Gap'
FROM day_count;
```

**Answer:**  
📅 **Average Day Gap:** 59.00 days

---

### 👩‍💼 42. What is the total number of books issued by each employee?

Shows employee-wise issue count.

```sql
SELECT issued_emp_id, emp_name, COUNT(issued_id) AS Books_issued
FROM issue
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY issued_emp_id, emp_name;
```

**Answer:**

| emp_name         | Books_issued |
|------------------|--------------|
| Michelle Ramirez | 6            |
| Laura Martinez   | 6            |

---

### 🏢 43. What is the total number of books issued by each branch?

Branch-level breakdown of issued books.

```sql
SELECT branch_id, COUNT(issued_id) AS Books_issued
FROM issue
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY branch_id;
```

**Answer:**

| branch_id | Books_issued |
|-----------|--------------|
| B001      | 17           |
| B005      | 9            |

---

### 🗓️ 44. What is the total number of books issued in 2024?

Total issued books for the year 2024.

```sql
SELECT SUM(books_issued) AS "books issued in 2024"
FROM (
    SELECT YEAR(issued_date), COUNT(*) books_issued
    FROM issue
    WHERE YEAR(issued_date) = 2024
    GROUP BY issued_date
) AS table_1;
```

**Answer:**  
📚 **Books Issued in 2024:** 35

---

### 🔄 45. What is the total number of books returned in 2024?

Total returned books during 2024.

```sql
SELECT COUNT(*) AS "books returned in 2024"
FROM `return`
WHERE YEAR(return_date) = 2024;
```

**Answer:**  
📦 **Books Returned in 2024:** 15

---
Here’s your final section of **Advanced SQL Queries** formatted in clean GitHub-style **Markdown**, ready for a professional project README. This continues from previous sections and focuses on deeper insights like multi-branch usage, non-returned books, and role-based performance.

---

## 🚀 Advanced SQL Queries 

These queries go beyond basic reports, offering detailed operational insights — from unreturned books and revenue calculations to employee performance and cross-branch borrowing behavior.

---

### 🔁 46. Which books have been issued more than once but never returned?

Identifies popular books that have multiple issues but no return record — useful for tracking overdue/lost books.

```sql
WITH main AS (
    SELECT issued_book_isbn, book_title 
    FROM issue
    LEFT JOIN books ON issued_book_isbn = isbn
    GROUP BY issued_book_isbn, book_title 
    HAVING COUNT(issued_id) > 1
)

SELECT book_title 
FROM main
LEFT JOIN issue ON issued_book_name = book_title 
LEFT JOIN `return` USING(issued_id)
WHERE return_id IS NULL;
```

**Answer:**

| book_title                                   |
|---------------------------------------------|
| Animal Farm                                  |
| The Great Gatsby                             |
| Harry Potter and the Sorcerers Stone         |

---

### 💰 47. What is the total revenue generated by each branch?

Summarizes financial income by branch based on issued books and their rental rates.

```sql
SELECT branch_id, SUM(books_count * rental_price) AS "revenue generated"
FROM (
    SELECT COUNT(issued_id) AS books_count, rental_price, issued_book_isbn
    FROM issue
    LEFT JOIN books ON isbn = issued_book_isbn
    GROUP BY issued_book_isbn, rental_price
) AS main
LEFT JOIN issue USING(issued_book_isbn)
LEFT JOIN employe ON emp_id = issued_emp_id
GROUP BY branch_id;
```

**Answer:**

| branch_id | revenue generated |
|-----------|-------------------|
| B001      | 147.00            |
| B005      | 50.00             |
| B004      | 26.50             |

---

### 🌐 48. Which members have borrowed books from multiple branches?

Helps identify highly active members with cross-branch engagement — great for loyalty programs or fraud checks.

```sql
SELECT issued_member_id, COUNT(branch_id) AS branch_count
FROM issue 
LEFT JOIN employe ON issued_emp_id = emp_id
GROUP BY issued_member_id
HAVING COUNT(branch_id) > 1;
```

**Answer:**

| issued_member_id | branch_count |
|------------------|--------------|
| C106             | 4            |
| C107             | 6            |
| C108             | 2            |

---

### ⏱️ 49. What is the average time (in days) between book issuance and return?

Measures return behavior across all transactions — helpful for improving library policies or reminder systems.

```sql
SELECT ROUND(AVG(date_defferent)) AS "avg time of book return"
FROM (
    SELECT DATEDIFF(return_date, issued_date) AS date_defferent
    FROM issue
    JOIN `return` USING(issued_id)
) AS avg_table;
```

**Answer:**  
📅 **Average Time of Book Return:** 59 days

---

### 🧑‍💼 50. Which employee position issued more books?

Evaluates productivity by role, providing insights into staffing efficiency and workload distribution.

```sql
SELECT `position`, COUNT(issued_id) AS books_count
FROM issue
JOIN employe ON issued_emp_id = emp_id
GROUP BY `position`
ORDER BY books_count DESC;
```

**Answer:**

| position   | books_count |
|------------|-------------|
| Assistant  | 14          |
| Clerk      | 11          |
| Manager    | 9           |
| Librarian  | 1           |

---
