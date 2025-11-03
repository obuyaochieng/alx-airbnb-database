-- Total bookings made by each user
SELECT u.id, u.name, COUNT(b.id) AS total_bookings
FROM User u
JOIN Booking b ON b.user_id = u.id
GROUP BY u.id, u.name;

-- Rank properties based on total bookings
SELECT 
  p.id, p.name, 
  COUNT(b.id) AS total_bookings,
  RANK() OVER (ORDER BY COUNT(b.id) DESC) AS rank_position
FROM Property p
LEFT JOIN Booking b ON b.property_id = p.id
GROUP BY p.id, p.name;
