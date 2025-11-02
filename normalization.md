# Database Normalization - Airbnb Database

## Objective
This document applies normalization principles to the Airbnb database design, ensuring the schema achieves Third Normal Form (3NF) to eliminate redundancy and maintain data integrity.

## Normalization Overview

Normalization is a database design process that organizes tables to reduce redundancy and dependency. The three normal forms are:

- **First Normal Form (1NF)**: Eliminate repeating groups and ensure all attributes contain atomic (indivisible) values.
- **Second Normal Form (2NF)**: Achieve 1NF and remove partial dependencies (applies to composite keys).
- **Third Normal Form (3NF)**: Achieve 2NF and remove transitive dependencies (non-key attributes depending on other non-key attributes).

## Schema Review and Analysis

### 1. USER Table
**Current Structure**: user_id (PK), FirstName, LastName, email (UK), password_hashed, PhoneNumber, role, Created_at, Update_at

**1NF Analysis**: ✅ PASS - All attributes are atomic. FirstName and LastName are separate fields.

**2NF Analysis**: ✅ PASS - Single primary key (user_id), so no partial dependencies exist.

**3NF Analysis**: ✅ PASS - No transitive dependencies. All attributes directly depend on user_id.

**Conclusion**: USER table is already in 3NF. No changes needed.

---

### 2. PROPERTY Table
**Current Structure**: property_id (PK), host_id (FK), name, description, location, price_per_night, created_at, update_at

**1NF Analysis**: ⚠️ ISSUE - The `location` attribute is not atomic. It contains multiple pieces of information (street address, city, state, country, postal code) stored as a single value.

**Solution**: Decompose location into atomic attributes to achieve 1NF.

**Revised Structure**:
```
PROPERTY (
    property_id (PK),
    host_id (FK),
    name,
    description,
    street_address,
    city,
    state,
    country,
    postal_code,
    price_per_night,
    created_at,
    update_at
)
```

**2NF Analysis**: ✅ PASS - Single primary key, no partial dependencies.

**3NF Analysis**: ✅ PASS - All attributes depend directly on property_id.

**Conclusion**: After decomposing location, PROPERTY table achieves 3NF.

---

### 3. BOOKING Table
**Current Structure**: booking_id (PK), property_id (FK), user_id (FK), start_date, end_date, total_price, status, Created_at, Update_at

**1NF Analysis**: ✅ PASS - All attributes are atomic.

**2NF Analysis**: ✅ PASS - Single primary key.

**3NF Analysis**: ⚠️ DISCUSSION - The `total_price` attribute can be calculated from (end_date - start_date) × price_per_night. This creates a transitive dependency: total_price → property_id → price_per_night.

**Discussion**: Technically, total_price violates 3NF because it's a calculated value. However, we retain it for business reasons:
- **Price History**: Property prices change over time. Storing total_price preserves the exact booking amount.
- **Additional Fees**: The total may include cleaning fees, service charges, or discounts not reflected in the base nightly rate.
- **Performance**: Eliminates need for complex calculations in financial reports.
- **Audit Trail**: Essential for accounting and dispute resolution.

**Decision**: Keep total_price as a controlled denormalization for business purposes.

**Conclusion**: BOOKING table is in 3NF with justified denormalization.

---

### 4. PAYMENT Table
**Current Structure**: Payment_id (PK), Booking_id (FK), Amount, Payment_date, Payment_Method, user_id (FK)

**1NF Analysis**: ✅ PASS - All attributes are atomic.

**2NF Analysis**: ✅ PASS - Single primary key.

**3NF Analysis**: ⚠️ DISCUSSION - The user_id could be considered redundant since it can be derived through Booking_id → user_id. However, this creates a valuable business relationship.

**Discussion**: Including user_id provides:
- **Direct Access**: Quick retrieval of all payments by a user without joining through BOOKING.
- **Flexibility**: Supports future scenarios like guest paying for another guest's booking.
- **Performance**: Reduces join operations for user payment history queries.

**Decision**: Keep user_id as it represents a direct relationship between USER and PAYMENT.

**Conclusion**: PAYMENT table is in 3NF.

---

### 5. REVIEW Table
**Current Structure**: Review_id (PK), Property_id (FK), User_id (FK), rating, Coment, Created_at, Update_at

**1NF Analysis**: ✅ PASS - All attributes are atomic.

**2NF Analysis**: ✅ PASS - Single primary key.

**3NF Analysis**: ✅ PASS - rating and Coment depend directly on Review_id.

**Additional Constraint**: Composite UNIQUE (Property_id, User_id) prevents duplicate reviews - this is a business rule, not normalization.

**Conclusion**: REVIEW table is in 3NF. No changes needed.

---

### 6. MESSAGE Table
**Current Structure**: Message_id (PK), Sender_id (FK), Receipt_id (FK), Send_at, Update_at

**1NF Analysis**: ✅ PASS - All attributes are atomic.

**2NF Analysis**: ✅ PASS - Single primary key.

**3NF Analysis**: ✅ PASS - All attributes depend directly on Message_id.

**Conclusion**: MESSAGE table is in 3NF. No changes needed.

---

## Summary of Changes

### Required Changes for 3NF:

**PROPERTY Table - Location Decomposition**
- **Before**: location (VARCHAR) - contained composite address data
- **After**: Decomposed into:
  - street_address
  - city
  - state
  - country
  - postal_code

This change ensures atomicity and achieves 1NF, which is required for 3NF.

### Retained for Business Reasons:

**BOOKING.total_price** - Calculated field kept for price history and audit purposes.

**PAYMENT.user_id** - Redundant but retained for performance and flexibility.

## Final Normalized Schema

```
USER (user_id, FirstName, LastName, email, password_hashed, PhoneNumber, role, Created_at, Update_at)

PROPERTY (property_id, host_id, name, description, street_address, city, state, country, postal_code, price_per_night, created_at, update_at)

BOOKING (booking_id, property_id, user_id, start_date, end_date, total_price, status, Created_at, Update_at)

PAYMENT (Payment_id, Booking_id, Amount, Payment_date, Payment_Method, user_id)

REVIEW (Review_id, Property_id, User_id, rating, Coment, Created_at, Update_at)

MESSAGE (Message_id, Sender_id, Receipt_id, Send_at, Update_at)
```

## Benefits of Normalization

**Data Integrity**: Decomposing location prevents inconsistent address formats and improves data quality.

**Reduced Redundancy**: Each piece of address information is stored once, reducing storage and update anomalies.

**Query Flexibility**: Individual address components can be queried independently (e.g., find all properties in a specific city).

**Maintainability**: Changes to address components don't require parsing and updating composite strings.

**Scalability**: Normalized structure supports future features like location-based search and filtering.

## Conclusion

The Airbnb database schema has been reviewed and normalized to 3NF. One table (PROPERTY) required modification to decompose the location field into atomic attributes. All other tables were already compliant with 3NF. Two calculated/redundant fields (BOOKING.total_price and PAYMENT.user_id) are retained for valid business reasons. The schema now maintains data integrity while supporting efficient queries and future scalability.