# Database Seed Data - Airbnb Database

## Overview
This directory contains SQL scripts to populate the Airbnb database with realistic sample data for testing and development purposes.

## Files
- `seed.sql` - Complete sample data insertion script

## Sample Data Summary

### Users (10 total)
- **4 Hosts**: Sarah Johnson, Michael Chen, Emily Rodriguez, David Kim
- **5 Guests**: Jessica Williams, James Brown, Maria Garcia, Robert Taylor, Linda Martinez
- **1 Admin**: System administrator account

All users have:
- Unique UUIDs
- Hashed passwords (bcrypt format)
- Valid email addresses
- Phone numbers
- Appropriate roles
- Realistic creation timestamps

### Properties (8 total)
**Diverse Property Types:**
1. **Cozy Downtown Apartment** (New York) - $150/night
2. **Beachfront Villa** (Miami) - $350/night
3. **Mountain Cabin Retreat** (Denver) - $180/night
4. **Urban Loft Studio** (San Francisco) - $120/night
5. **Historic City Brownstone** (Boston) - $200/night
6. **Lakeside Cottage** (Seattle) - $140/night
7. **Desert Oasis Villa** (Phoenix) - $280/night
8. **Garden Studio Apartment** (Portland) - $95/night

Each property includes:
- Complete address information (street, city, state, country, postal code)
- Detailed descriptions
- Realistic pricing
- Host ownership

### Bookings (10 total)
**Booking Status Distribution:**
- **7 Confirmed bookings** (past and future)
- **2 Pending bookings** (awaiting confirmation)
- **1 Canceled booking** (realistic scenario)

Bookings include:
- Various date ranges (3-7 nights)
- Calculated total prices based on nightly rates
- Realistic timestamps
- Different statuses representing booking lifecycle

### Payments (9 total)
**Payment Methods Used:**
- Credit Card
- PayPal
- Stripe

Payment scenarios:
- Single full payments
- Split payments (deposit + final payment)
- Payments for pending bookings
- Historical payment records

All payments match booking amounts and include:
- Transaction timestamps
- Payment method types
- User associations

### Reviews (7 total)
**Rating Distribution:**
- 5 stars: 5 reviews
- 4 stars: 2 reviews
- 3 stars: 1 review

Reviews feature:
- Realistic guest feedback
- Detailed comments about stays
- Various rating levels
- Only for completed bookings
- Timestamps after checkout dates

### Messages (10 total)
**Conversation Types:**
- Booking inquiries
- Pre-arrival questions
- Amenity inquiries
- Post-stay thank you messages

Messages demonstrate:
- Real host-guest communication
- Multi-message conversations
- Various timestamps
- Natural dialogue flow

## Usage

### Prerequisites
- Database must exist with schema already created
- Run `schema.sql` from database-script-0x01 first

### Running the Seed Script

**Option 1: Command Line**
```bash
mysql -u your_username -p airbnb_db < database-script-0x02/seed.sql
```

**Option 2: MySQL Prompt**
```sql
USE airbnb_db;
SOURCE database-script-0x02/seed.sql;
```

**Option 3: Direct Copy-Paste**
Copy the SQL statements and execute them in your MySQL client.

### Verification

After running the script, verify data insertion:

```sql
-- Check record counts
SELECT COUNT(*) FROM USER;        -- Should return 10
SELECT COUNT(*) FROM PROPERTY;    -- Should return 8
SELECT COUNT(*) FROM BOOKING;     -- Should return 10
SELECT COUNT(*) FROM PAYMENT;     -- Should return 9
SELECT COUNT(*) FROM REVIEW;      -- Should return 7
SELECT COUNT(*) FROM MESSAGE;     -- Should return 10
```

## Sample Queries

### Find all properties in a specific city
```sql
SELECT name, city, price_per_night 
FROM PROPERTY 
WHERE city = 'New York';
```

### Get user's booking history
```sql
SELECT b.booking_id, p.name, b.start_date, b.end_date, b.status
FROM BOOKING b
JOIN PROPERTY p ON b.property_id = p.property_id
WHERE b.user_id = '550e8400-e29b-41d4-a716-446655440005'
ORDER BY b.start_date DESC;
```

### Calculate property average rating
```sql
SELECT p.name, AVG(r.rating) as avg_rating, COUNT(r.Review_id) as review_count
FROM PROPERTY p
LEFT JOIN REVIEW r ON p.property_id = r.Property_id
GROUP BY p.property_id, p.name
ORDER BY avg_rating DESC;
```

### View conversation between two users
```sql
SELECT m.Send_at, 
       CONCAT(u1.FirstName, ' ', u1.LastName) as Sender,
       CONCAT(u2.FirstName, ' ', u2.LastName) as Recipient,
       m.message_body
FROM MESSAGE m
JOIN USER u1 ON m.Sender_id = u1.user_id
JOIN USER u2 ON m.Receipt_id = u2.user_id
WHERE (m.Sender_id = '550e8400-e29b-41d4-a716-446655440005' 
   AND m.Receipt_id = '550e8400-e29b-41d4-a716-446655440001')
   OR (m.Sender_id = '550e8400-e29b-41d4-a716-446655440001' 
   AND m.Receipt_id = '550e8400-e29b-41d4-a716-446655440005')
ORDER BY m.Send_at;
```

### Find available properties for specific dates
```sql
SELECT p.name, p.city, p.price_per_night
FROM PROPERTY p
WHERE p.property_id NOT IN (
    SELECT property_id 
    FROM BOOKING 
    WHERE status IN ('pending', 'confirmed')
    AND start_date <= '2024-12-25'
    AND end_date >= '2024-12-20'
);
```

### Host's total earnings
```sql
SELECT 
    CONCAT(u.FirstName, ' ', u.LastName) as Host,
    COUNT(DISTINCT p.property_id) as Properties,
    COUNT(b.booking_id) as Total_Bookings,
    SUM(pay.Amount) as Total_Earnings
FROM USER u
JOIN PROPERTY p ON u.user_id = p.host_id
JOIN BOOKING b ON p.property_id = b.property_id
JOIN PAYMENT pay ON b.booking_id = pay.Booking_id
WHERE u.role = 'host'
GROUP BY u.user_id, u.FirstName, u.LastName;
```

## Data Characteristics

### Realistic Scenarios
- **Multiple bookings per property** - Shows property popularity
- **Repeat guests** - Same user booking different properties
- **Various booking statuses** - Pending, confirmed, and canceled
- **Split payments** - Demonstrates deposit + final payment flow
- **Conversation threads** - Multi-message exchanges between users
- **Date ranges** - Past bookings, current, and future reservations

### Business Logic Compliance
- No overlapping confirmed bookings for same property
- Reviews only for completed stays
- Payments match booking totals
- No self-messaging (sender ≠ recipient)
- One review per user per property
- Valid date ranges (end_date > start_date)

### Data Integrity
- All foreign keys properly referenced
- UUID format consistency
- Valid ENUM values
- Positive monetary amounts
- Realistic timestamps in chronological order

## Resetting Data

To clear all data and re-run the seed script:

```sql
-- The seed.sql script includes these commands at the beginning
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE MESSAGE;
TRUNCATE TABLE REVIEW;
TRUNCATE TABLE PAYMENT;
TRUNCATE TABLE BOOKING;
TRUNCATE TABLE PROPERTY;
TRUNCATE TABLE USER;
SET FOREIGN_KEY_CHECKS = 1;
```

**Warning**: This will delete all existing data. Use with caution in production environments.

## Testing Scenarios

### Test Case 1: User Registration and Property Listing
- New host signs up
- Creates property listing
- Property appears in search results

### Test Case 2: Booking Flow
- Guest searches for properties
- Makes booking request (pending status)
- Payment processed
- Booking confirmed

### Test Case 3: Review System
- Guest completes stay
- Leaves rating and review
- Review appears on property page
- Host responds to review (via messages)

### Test Case 4: Messaging
- Guest inquires about property
- Host responds with details
- Booking confirmed through conversation
- Follow-up messages exchanged

## Customization

To add more sample data:

1. **Generate new UUIDs** using:
   - Online UUID generators
   - SQL: `SELECT UUID();`
   - Programming language UUID libraries

2. **Follow existing patterns** for:
   - Date formats
   - Price calculations
   - Status values
   - Relationship references

3. **Maintain referential integrity**:
   - Users before properties
   - Properties before bookings
   - Bookings before payments
   - Completed bookings before reviews

## Troubleshooting

**Issue: Foreign key constraint fails**
- Ensure parent records exist before inserting child records
- Verify UUIDs match exactly between tables

**Issue: Duplicate entry error**
- Check for unique constraints (email, review uniqueness)
- Ensure UUIDs are unique

**Issue: Check constraint violation**
- Verify dates (end_date > start_date)
- Ensure prices are positive
- Confirm ratings are 1-5
- Check ENUM values match exactly

**Issue: Data appears but queries return empty**
- Check date ranges for bookings
- Verify property_id and user_id references
- Ensure status filters are correct

## Production Considerations

**Before using in production:**
- Replace sample passwords with real hashed passwords
- Use actual user data (with proper consent)
- Implement proper data privacy measures
- Add data validation layers
- Set up backup procedures
- Monitor for data anomalies

## License
This seed data is part of the ALX Airbnb Database Project and is intended for educational and development purposes only.