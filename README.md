# 🎵 Music Store Database Project

This project simulates a music store's operations using a normalized relational database schema in MySQL. The goal is to execute analytical SQL queries to derive business insights from customer, invoice, and music data.

---

## 🧩 Problem Statement

The music store is experiencing difficulty in understanding key business metrics such as:

- Who their most valuable customers are
- Which cities or countries generate the most revenue
- What music genres and artists are the most popular
- What tracks are outperforming others based on duration or demand
- How sales trends vary by region and genre

The business requires a data-driven approach to make decisions for promotions, event planning, artist outreach, and customer targeting.

---

## 📁 Database Initialization

- Database Name: `music_store`
- Tables:  
  - `Genre`
  - `MediaType`
  - `Employees`
  - `Customerss`
  - `Artist`
  - `Album`
  - `Track`
  - `Invoice`
  - `Invoice_Line`
  - `Playlist`
  - `PlaylistTrack`

> Note: `Customerss` is used instead of the conventional `Customers` due to reserved keyword handling or naming preference.

---

## 🧱 Schema Design Highlights

- **Track** table links to:
  - `Album` (Album details)
  - `Genre` (Genre type)
  - `MediaType` (MP3, CD, etc.)
- **Invoice** relates to:
  - `Customerss` and `Invoice_Line`
- **PlaylistTrack** represents many-to-many between `Track` and `Playlist`
- **Customerss** is linked to `Employees` via `support_rep_id`

---

## 📌 Key SQL Queries

### 1. Senior-most employee  
Find the employee with the highest role based on job level.

### 2. Most invoices by country  
Identify countries that generate the highest number of invoices.

### 3. Top 3 invoice totals  
Fetch the largest invoice totals to analyze big spenders.

### 4. Best customer city  
Return the city where the business made the most money from customers.

### 5. Best individual customer  
Identify the customer who has spent the most money overall.

### 6. Rock music listeners  
List customers who listen to Rock music (by genre) ordered by email.

### 7. Top 10 Rock bands  
Return artists with the most tracks that contain 'rock' in the album title.

### 8. Longest tracks  
List all tracks longer than the average song length.

### 9. Customer spending on artists  
Display how much each customer spent on each artist.

### 10. Most popular genre per country  
Use a CTE-based approach to return the top-selling music genre for each country.

### 11. Top customer per country  
Use window functions (`RANK() OVER()`) to return the highest-spending customer in every country.

---

## ⚠️ Notes

- `birthdate`, `hire_date` are stored as strings — should ideally be `DATE`
- `invoice_line` lacks foreign key constraints — these can be added to improve referential integrity
- `Playlisttrack` foreign keys and primary key are commented out — enable for full normalization

---

## 🔧 Technologies Used

- MySQL
- SQL Window Functions
- CTEs (Common Table Expressions)
- Aggregations and Joins

---

## 📈 Use Cases

- E-commerce or music store analytics
- SQL training for data analysts
- Performance benchmarking of queries
- CRM-like insights (top customers, genres, locations)

---

## 🚀 How to Use

1. Run the `drop database` and `create database` commands to start fresh.
2. Execute all `CREATE TABLE` statements.
3. Populate tables (not shown here – use CSVs or INSERT statements).
4. Run the SQL tasks section by section to analyze the store’s data.

---

## ✅ Conclusion

This SQL-based project enables comprehensive analysis of a music store’s business data. By using advanced SQL techniques such as joins, subqueries, and window functions, we can extract powerful insights regarding customer behavior, sales trends, artist popularity, and genre performance. These insights can drive strategic decisions for marketing, event planning, and customer relationship management.

---

## 🙌 Author

**Project By:**  
Drashti Bamharoliya  
📧 bamharoliyadrashti@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/drashtibamharoliya1225)

---
