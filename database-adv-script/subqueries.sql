giSELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    p.description,
    p.host_id
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    )
ORDER BY 
    p.property_id;

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    p.description,
    p.host_id,
    avg_ratings.average_rating
FROM 
    Property p
INNER JOIN (
    SELECT 
        property_id,
        AVG(rating) AS average_rating
    FROM 
        Review
    GROUP BY 
        property_id
    HAVING 
        AVG(rating) > 4.0
) AS avg_ratings ON p.property_id = avg_ratings.property_id
ORDER BY 
    avg_ratings.average_rating DESC, p.property_id;


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    u.user_id;


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) AS total_bookings
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    total_bookings DESC, u.user_id;


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role
FROM 
    User u
WHERE 
    EXISTS (
        SELECT 
            1
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
        GROUP BY 
            b.user_id
        HAVING 
            COUNT(*) > 3
    )
ORDER BY 
    u.user_id;

SELECT 
    p.property_id,
    p.name,
    (
        SELECT 
            AVG(r.rating)
        FROM 
            Review r
        WHERE 
            r.property_id = p.property_id
    ) AS average_rating
FROM 
    Property p
WHERE 
    (
        SELECT 
            AVG(r.rating)
        FROM 
            Review r
        WHERE 
            r.property_id = p.property_id
    ) > 4.0
ORDER BY 
    average_rating DESC;
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) AS user_bookings
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > (
        SELECT 
            AVG(booking_count)
        FROM (
            SELECT 
                COUNT(*) AS booking_count
            FROM 
                Booking
            GROUP BY 
                user_id
        ) AS avg_bookings
    )
ORDER BY 
    user_bookings DESC;

SELECT 
    p.property_id,
    p.name,
    p.location,
    (
        SELECT 
            AVG(r.rating)
        FROM 
            Review r
        WHERE 
            r.property_id = p.property_id
    ) AS property_avg_rating
FROM 
    Property p
WHERE 
    (
        SELECT 
            AVG(r.rating)
        FROM 
            Review r
        WHERE 
            r.property_id = p.property_id
    ) > (
        SELECT 
            AVG(rating)
        FROM 
            Review
    )
ORDER BY 
    property_avg_rating DESC;

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) AS total_bookings
FROM 
    User u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    ) > 3
    AND EXISTS (
        SELECT 
            1
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
            AND b.created_at >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    )
ORDER BY 
    total_bookings DESC;


EXPLAIN SELECT 
    p.property_id,
    p.name
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );

-- Method 2: Using JOIN
EXPLAIN SELECT 
    p.property_id,
    p.name
FROM 
    Property p
INNER JOIN (
    SELECT 
        property_id,
        AVG(rating) AS avg_rating
    FROM 
        Review
    GROUP BY 
        property_id
    HAVING 
        AVG(rating) > 4.0
) AS high_rated ON p.property_id = high_rated.property_id;