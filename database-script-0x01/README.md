# Database Schema - Airbnb Database

## Overview
This directory contains SQL scripts for creating the complete Airbnb database schema, including all tables, constraints, indexes, and relationships.

## Files
- `schema.sql` - Complete database schema definition with CREATE TABLE statements

## Database Schema

### Tables Created
1. **USER** - Stores user accounts (guests, hosts, admins)
2. **PROPERTY** - Contains property listings
3. **BOOKING** - Manages reservations
4. **PAYMENT** - Tracks payment transactions
5. **REVIEW** - Stores property reviews
6. **MESSAGE** - Enables user messaging

### Key Features

#### Data Types
- **CHAR(36)** - UUID primary keys for security and uniqueness
- **VARCHAR** - Variable-length strings with appropriate limits
- **TEXT** - Long-form content (descriptions, comments, messages)
- **DECIMAL(10,2)** - Monetary values with precision
- **ENUM** - Constrained categorical data
- **TIMESTAMP** - Automatic timestamp tracking
- **DATE** - Date fields for bookings

#### Primary Keys
All tables use UUID-based primary keys with automatic generation:
```sql
user_id CHAR(36) PRIMARY KEY DEFAULT (UUID())
```

#### Foreign Keys
All relationships enforced with foreign key constraints:
- **ON DELETE CASCADE** - Automatically delete dependent records (BOOKING→PAYMENT, USER→MESSAGE)
- **ON DELETE RESTRICT** - Prevent deletion of referenced records (USER→PROPERTY, PROPERTY→BOOKING)
- **ON UPDATE CASCADE** - Propagate updates to dependent records

#### Constraints
**Check Constraints:**
- Email format validation
- Price must be positive
- Date range validation (end_date > start_date)
- Rating between 1 and 5
- Users cannot message themselves

**Unique Constraints:**
- User email must be unique
- One review per user per property

#### Indexes
Performance optimized with strategic indexes:
- **Single-column indexes** - Foreign keys, search fields
- **Composite indexes** - Complex queries (booking date overlap, conversations)
- **Unique indexes** - Email lookup

### Relationships

```
USER (1) ──────< (N) PROPERTY [host_id]
USER (1) ──────< (N) BOOKING [user_id]
USER (1) ──────< (N) PAYMENT [user_id]
USER (1) ──────< (N) REVIEW [User_id]
USER (1) ──────< (N) MESSAGE [Sender_id, Receipt_id]

PROPERTY (1) ──< (N) BOOKING [property_id]
PROPERTY (1) ──< (N) REVIEW [Property_id]

BOOKING (1) ───< (N) PAYMENT [Booking_id]
```

## Usage

### Running the Schema

**Prerequisites:**
- MySQL 5.7+ or MariaDB 10.2+
- Database user with CREATE TABLE privileges

**Execute Schema:**
```bash
mysql -u your_username -p < schema.sql
```

Or from MySQL prompt:
```sql
SOURCE schema.sql;
```

**Verify Tables:**
```sql
SHOW TABLES;
DESCRIBE USER;
DESCRIBE PROPERTY;
```

### Testing the Schema

**Insert Test Data:**
```sql
-- Create a test user
INSERT INTO USER (user_id, FirstName, LastName, email, password_hashed, role)
VALUES (UUID(), 'John', 'Doe', 'john@example.com', 'hashed_password', 'host');

-- Verify insertion
SELECT * FROM USER;
```

**Test Constraints:**
```sql
-- This should fail (duplicate email)
INSERT INTO USER (user_id, FirstName, LastName, email, password_hashed, role)
VALUES (UUID(), 'Jane', 'Smith', 'john@example.com', 'hashed_password', 'guest');
```

## Schema Design Decisions

### Normalization
The schema is normalized to Third Normal Form (3NF):
- **PROPERTY.location** decomposed into atomic fields (street_address, city, state, country, postal_code)
- **BOOKING.total_price** retained for business reasons (price history, audit trail)
- All tables free from transitive dependencies

### Security Considerations
- UUID primary keys prevent enumeration attacks
- Password stored as hash only
- Email validation enforced at database level
- Foreign key constraints prevent orphaned records

### Performance Optimization
- Indexes on all foreign keys for fast JOIN operations
- Composite indexes for common query patterns
- Single indexes on frequently filtered columns
- Timestamp indexes for chronological queries

### Scalability
- UUID keys support distributed systems
- Normalized structure reduces redundancy
- Indexed queries optimize large datasets
- Clear separation of concerns for microservices

## Future Enhancements

Potential schema extensions:
- **Property Images** - One-to-many relationship for photos
- **Amenities** - Many-to-many for property features
- **Favorites** - User wishlist functionality
- **Notifications** - User notification system
- **Cancellation Policy** - Property-specific rules

## Common Queries

**Find all properties by a host:**
```sql
SELECT * FROM PROPERTY WHERE host_id = 'host-uuid';
```

**Check property availability:**
```sql
SELECT * FROM BOOKING 
WHERE property_id = 'property-uuid' 
  AND status IN ('pending', 'confirmed')
  AND start_date <= '2024-12-31' 
  AND end_date >= '2024-12-01';
```

**Get property average rating:**
```sql
SELECT Property_id, AVG(rating) as avg_rating, COUNT(*) as review_count
FROM REVIEW
GROUP BY Property_id;
```

## Troubleshooting

**Issue: Foreign key constraint fails**
- Ensure parent records exist before inserting child records
- Insert order: USER → PROPERTY → BOOKING → PAYMENT

**Issue: UUID() function not found**
- Check MySQL version (8.0+ required for UUID())
- Alternative: Use `UUID()` or generate UUIDs in application layer

**Issue: ENUM values case-sensitive**
- ENUM values must match exactly: 'guest' not 'Guest'
- Use lowercase for consistency

## Contact
For questions or issues, refer to the main project documentation or contact the development team.

## License
This schema is part of the ALX Airbnb Database Project.