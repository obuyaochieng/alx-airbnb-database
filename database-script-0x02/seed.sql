
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE MESSAGE;
TRUNCATE TABLE REVIEW;
TRUNCATE TABLE PAYMENT;
TRUNCATE TABLE BOOKING;
TRUNCATE TABLE PROPERTY;
TRUNCATE TABLE USER;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- INSERT USERS
-- =====================================================
INSERT INTO USER (user_id, FirstName, LastName, email, password_hashed, PhoneNumber, role, Created_at) VALUES
-- Hosts
('550e8400-e29b-41d4-a716-446655440001', 'Sarah', 'Johnson', 'sarah.johnson@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0101', 'host', '2023-01-15 10:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Michael', 'Chen', 'michael.chen@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0102', 'host', '2023-02-20 14:20:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Emily', 'Rodriguez', 'emily.rodriguez@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0103', 'host', '2023-03-10 09:15:00'),
('550e8400-e29b-41d4-a716-446655440004', 'David', 'Kim', 'david.kim@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0104', 'host', '2023-04-05 16:45:00'),

-- Guests
('550e8400-e29b-41d4-a716-446655440005', 'Jessica', 'Williams', 'jessica.williams@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0105', 'guest', '2023-05-12 11:20:00'),
('550e8400-e29b-41d4-a716-446655440006', 'James', 'Brown', 'james.brown@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0106', 'guest', '2023-06-18 13:30:00'),
('550e8400-e29b-41d4-a716-446655440007', 'Maria', 'Garcia', 'maria.garcia@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0107', 'guest', '2023-07-22 15:10:00'),
('550e8400-e29b-41d4-a716-446655440008', 'Robert', 'Taylor', 'robert.taylor@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0108', 'guest', '2023-08-30 10:00:00'),
('550e8400-e29b-41d4-a716-446655440009', 'Linda', 'Martinez', 'linda.martinez@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0109', 'guest', '2023-09-14 12:45:00'),


('550e8400-e29b-41d4-a716-446655440010', 'Admin', 'User', 'admin@airbnb.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIq.5XOPF6', '+1-555-0100', 'admin', '2023-01-01 08:00:00');


INSERT INTO PROPERTY (property_id, host_id, name, description, street_address, city, state, country, postal_code, price_per_night, created_at) VALUES

('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Apartment', 'Modern 2-bedroom apartment in the heart of downtown. Perfect for business travelers and tourists. Walking distance to restaurants and attractions.', '123 Main Street', 'New York', 'New York', 'United States', '10001', 150.00, '2023-01-20 10:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Beachfront Villa', 'Luxurious 4-bedroom villa with stunning ocean views. Private beach access, infinity pool, and modern amenities.', '456 Ocean Drive', 'Miami', 'Florida', 'United States', '33139', 350.00, '2023-02-10 14:30:00'),


('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Mountain Cabin Retreat', 'Rustic 3-bedroom cabin nestled in the mountains. Perfect for nature lovers and hikers. Fireplace and hot tub included.', '789 Mountain Road', 'Denver', 'Colorado', 'United States', '80202', 180.00, '2023-03-15 09:00:00'),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Urban Loft Studio', 'Stylish studio loft in trendy neighborhood. Exposed brick, high ceilings, and modern kitchen.', '321 Industrial Blvd', 'San Francisco', 'California', 'United States', '94102', 120.00, '2023-04-01 11:20:00'),


('650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 'Historic City Brownstone', 'Charming 3-bedroom brownstone in historic district. Original hardwood floors and modern updates.', '567 Heritage Lane', 'Boston', 'Massachusetts', 'United States', '02108', 200.00, '2023-04-20 13:45:00'),
('650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Lakeside Cottage', 'Peaceful 2-bedroom cottage on private lake. Kayaks, fishing equipment, and dock included.', '890 Lakeview Drive', 'Seattle', 'Washington', 'United States', '98101', 140.00, '2023-05-05 15:30:00'),


('650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 'Desert Oasis Villa', 'Modern 5-bedroom villa with pool and mountain views. Perfect for large groups and families.', '234 Desert Vista', 'Phoenix', 'Arizona', 'United States', '85001', 280.00, '2023-05-20 10:15:00'),
('650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Garden Studio Apartment', 'Cozy studio with private garden entrance. Quiet neighborhood, perfect for solo travelers.', '678 Garden Way', 'Portland', 'Oregon', 'United States', '97201', 95.00, '2023-06-10 12:00:00');


INSERT INTO BOOKING (booking_id, property_id, user_id, start_date, end_date, total_price, status, Created_at) VALUES

('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', '2024-01-15', '2024-01-20', 750.00, 'confirmed', '2023-12-01 09:00:00'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440006', '2024-02-10', '2024-02-17', 2450.00, 'confirmed', '2023-12-15 14:30:00'),
('750e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', '2024-03-05', '2024-03-10', 900.00, 'confirmed', '2024-01-10 11:20:00'),
('750e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', '2024-04-01', '2024-04-05', 800.00, 'confirmed', '2024-02-20 10:45:00'),
('750e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', '2024-05-20', '2024-05-27', 1960.00, 'confirmed', '2024-03-15 15:30:00'),


('750e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440005', '2024-12-15', '2024-12-20', 600.00, 'pending', '2024-11-01 09:15:00'),
('750e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440006', '2024-12-20', '2024-12-27', 980.00, 'pending', '2024-11-05 13:20:00'),


('750e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440007', '2024-01-10', '2024-01-15', 475.00, 'canceled', '2023-12-20 16:00:00'),

('750e8400-e29b-41d4-a716-446655440009', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '2023-11-10', '2023-11-15', 750.00, 'confirmed', '2023-10-15 10:30:00'),
('750e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', '2023-10-05', '2023-10-12', 1260.00, 'confirmed', '2023-09-10 14:20:00');


INSERT INTO PAYMENT (Payment_id, Booking_id, user_id, Amount, Payment_date, Payment_Method) VALUES

('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', 750.00, '2023-12-01 09:15:00', 'credit_card'),

('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440006', 2450.00, '2023-12-15 14:45:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', 900.00, '2024-01-10 11:35:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440008', 800.00, '2024-02-20 11:00:00', 'credit_card'),


('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440009', 980.00, '2024-03-15 15:45:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440009', 980.00, '2024-05-15 10:00:00', 'credit_card'),

('850e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440005', 600.00, '2024-11-01 09:30:00', 'stripe'),


('850e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440006', 750.00, '2023-10-15 10:45:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440008', 1260.00, '2023-09-10 14:35:00', 'credit_card');


INSERT INTO REVIEW (Review_id, Property_id, User_id, rating, Coment, Created_at) VALUES


('950e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 5, 'Amazing apartment! Perfect location and very clean. Sarah was a wonderful host and very responsive. Would definitely stay here again!', '2023-11-20 15:30:00'),

('950e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 4, 'Beautiful mountain cabin with stunning views. The hot tub was a great touch. Only minor issue was the WiFi signal, but overall excellent stay.', '2023-10-18 14:20:00'),

('950e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005', 5, 'Absolutely incredible beachfront villa! The private beach access and infinity pool exceeded our expectations. Perfect for a family vacation.', '2024-02-25 10:45:00'),

('950e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440007', 4, 'Lovely historic brownstone in great neighborhood. Everything was as described. Would have given 5 stars but the heating system was a bit noisy.', '2024-04-10 16:30:00'),

('950e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', 5, 'Second time staying here and it was just as perfect as the first! Great location and amenities.', '2024-01-25 12:15:00'),

('950e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', 5, 'Desert oasis is the perfect description! The pool area was spectacular and David was very helpful with local recommendations.', '2024-06-05 11:00:00'),

('950e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440006', 3, 'Nice studio but smaller than expected. Location was good but parking was difficult. Overall decent stay for the price.', '2024-01-15 09:30:00');



INSERT INTO MESSAGE (Message_id, Sender_id, Receipt_id, message_body, Send_at) VALUES


('a50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440001', 'Hi Sarah! I am interested in booking your downtown apartment for January 15-20. Is it available?', '2023-11-28 10:30:00'),
('a50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', 'Hi Jessica! Yes, the apartment is available for those dates. Would you like to proceed with the booking?', '2023-11-28 11:15:00'),
('a50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440001', 'Perfect! Yes, I would like to book it. One quick question - is parking included?', '2023-11-28 11:45:00'),
('a50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005', 'Great! Yes, there is one parking spot included. I will send you the details after booking confirmation.', '2023-11-28 12:00:00'),


('a50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Hi Sarah, we are excited for our stay at the beachfront villa! What time is check-in?', '2024-02-08 14:20:00'),
('a50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Hi James! Check-in is at 3 PM. I will meet you there to give you the keys and show you around. Looking forward to hosting you!', '2024-02-08 15:30:00'),


('a50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'Hi Michael, does the mountain cabin have WiFi? I need to do some remote work during my stay.', '2024-01-05 09:45:00'),
('a50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Hi Maria! Yes, there is WiFi available. The signal is good enough for video calls and work. Let me know if you need anything else!', '2024-01-05 10:30:00'),


('a50e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Hi David! Thank you so much for the wonderful stay at the desert villa. We had an amazing time. Left a review for you!', '2024-06-01 16:45:00'),
('a50e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', 'Thank you Linda! So glad you enjoyed your stay. Hope to host you again in the future!', '2024-06-02 09:15:00');


SELECT 'Data insertion completed successfully!' AS Status;
SELECT 'Users inserted:' AS Info, COUNT(*) AS Count FROM USER;
SELECT 'Properties inserted:' AS Info, COUNT(*) AS Count FROM PROPERTY;
SELECT 'Bookings inserted:' AS Info, COUNT(*) AS Count FROM BOOKING;
SELECT 'Payments inserted:' AS Info, COUNT(*) AS Count FROM PAYMENT;
SELECT 'Reviews inserted:' AS Info, COUNT(*) AS Count FROM REVIEW;
SELECT 'Messages inserted:' AS Info, COUNT(*) AS Count FROM MESSAGE;