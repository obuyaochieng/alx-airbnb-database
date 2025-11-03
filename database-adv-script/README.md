# Task 0: Complex Queries with Joins

## Objective
Master SQL joins by writing complex queries using different types of joins to retrieve related data from multiple tables in the Airbnb database.

## Overview
This task demonstrates proficiency in using three fundamental SQL join types:
- **INNER JOIN**: Returns only matching records from both tables
- **LEFT JOIN**: Returns all records from the left table and matching records from the right table
- **FULL OUTER JOIN**: Returns all records from both tables, including non-matching records

---

## Query Implementations

### Query 1: INNER JOIN - Bookings with Users
**Purpose**: Retrieve all bookings along with the user information for users who made those bookings.

**Use Case**: Display complete booking details with customer information for confirmed reservations.

**Key Features**:
- Returns only bookings that have a valid user association
- Includes comprehensive user details (name, email, phone, role)
- Ordered by booking creation date (most recent first)

**Expected Results**: All booking records with their corresponding user details. Orphaned bookings (without users) are excluded.

---

### Query 2: LEFT JOIN - Properties with Reviews
**Purpose**: Retrieve all properties and their associated reviews, including properties that haven't received any reviews yet.

**Use Case**: Display a complete property listing showing review information when available, helping identify properties that need more guest feedback.

**Key Features**:
- Returns ALL properties in the database
- Shows review details where they exist
- Properties without reviews will have NULL values in review columns
- Useful for property owners to see which listings need attention

**Expected Results**: Complete property list with review data. Properties without reviews will show NULL for review-related columns.

---

### Query 3: FULL OUTER JOIN - Users and Bookings
**Purpose**: Retrieve all users and all bookings, even if users have no bookings or bookings are not linked to users.

**Use Case**: Data integrity audit to identify:
- Users who have never made a booking
- Orphaned bookings not linked to any user
- Complete relationship mapping

**Key Features**:
- Returns ALL users (even those without bookings)
- Returns ALL bookings (even orphaned ones)
- NULL values indicate missing relationships
- Implemented using UNION of LEFT and RIGHT JOINs (MySQL compatible)

**Implementation Note**: 
- MySQL doesn't support FULL OUTER JOIN natively
- Achieved using `LEFT JOIN UNION RIGHT JOIN`
- PostgreSQL alternative syntax included as comment

**Expected Results**: Complete dataset showing all users and bookings with NULL values indicating missing relationships.

---

## Database Schema Reference

### Tables Used
1. **User**: Stores user account information
   - Primary Key: `user_id`
   - Key Columns: `first_name`, `last_name`, `email`, `role`

2. **Booking**: Stores reservation information
   - Primary Key: `booking_id`
   - Foreign Keys: `user_id`, `property_id`
   - Key Columns: `start_date`, `end_date`, `total_price`, `status`

3. **Property**: Stores property listings
   - Primary Key: `property_id`
   - Foreign Key: `host_id`
   - Key Columns: `name`, `location`, `pricepernight`

4. **Review**: Stores property reviews
   - Primary Key: `review_id`
   - Foreign Keys: `property_id`, `user_id`
   - Key Columns: `rating`, `comment`

---

## How to Run the Queries

### Prerequisites
```bash
# Ensure you have MySQL installed and running
mysql --version

# Access MySQL
mysql -u your_username -p
```

### Execute Queries
```sql
-- 1. Select the database
USE alx_airbnb;

-- 2. Run the queries from the file
SOURCE /path/to/database-adv-script/joins_queries.sql;

-- Or copy and paste individual queries
```

### Testing the Results
```bash
# Run each query separately and verify:
# - INNER JOIN returns only matched records
# - LEFT JOIN returns all left table records
# - FULL OUTER JOIN returns all records from both tables
```

---

## Analysis & Insights

### Performance Considerations
- **INNER JOIN**: Fastest as it only processes matching records
- **LEFT JOIN**: Slightly slower as it processes all left table records
- **FULL OUTER JOIN**: Slowest as it processes all records from both tables

### Data Integrity Checks
The queries help identify:
- ✅ Active bookings with valid users
- ⚠️ Properties without reviews (need marketing)
- ⚠️ Users without bookings (inactive accounts)
- 🚨 Orphaned bookings (data integrity issues)

---

## Additional Analysis Queries

The file includes three bonus queries for data analysis:

1. **Count Bookings Per User**: Verify INNER JOIN results by counting bookings
2. **Find Properties Without Reviews**: Identify listings needing attention
3. **Find Users Without Bookings**: Discover inactive user accounts

---

## Key Takeaways

### INNER JOIN
- ✅ Best for: Getting only complete, matched data
- ✅ Performance: Fast
- ❌ Excludes: Records without matches

### LEFT JOIN
- ✅ Best for: Keeping all primary records while fetching related data
- ✅ Useful for: Reports that need complete primary table data
- ⚠️ Watch for: NULL values in joined columns

### FULL OUTER JOIN
- ✅ Best for: Data auditing and integrity checks
- ✅ Useful for: Finding orphaned or unmatched records
- ⚠️ Performance: Can be slow on large datasets
- ⚠️ MySQL: Requires UNION workaround

---

## Files in This Task
- `joins_queries.sql`: Contains all three join queries plus analysis queries
- `README.md`: This documentation file

---

## Learning Outcomes
After completing this task, you should be able to:
- ✅ Write INNER JOIN queries to retrieve matched records
- ✅ Use LEFT JOIN to include all records from the primary table
- ✅ Implement FULL OUTER JOIN using UNION (MySQL) or native syntax (PostgreSQL)
- ✅ Choose the appropriate join type for different business requirements
- ✅ Analyze query results to identify data patterns and issues

---

## Next Steps
- Proceed to **Task 1**: Practice Subqueries
- Apply joins in combination with WHERE clauses for filtered results
- Explore multi-table joins (joining more than 2 tables)

---

**Author**: ALX Airbnb Database Project  
**Date**: November 2025  
**Task**: 0 - Complex Queries with Joins