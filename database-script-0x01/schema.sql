
DROP TABLE IF EXISTS MESSAGE;
DROP TABLE IF EXISTS REVIEW;
DROP TABLE IF EXISTS PAYMENT;
DROP TABLE IF EXISTS BOOKING;
DROP TABLE IF EXISTS PROPERTY;
DROP TABLE IF EXISTS USER;


CREATE TABLE USER (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hashed VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    
    CONSTRAINT chk_email_format CHECK (email LIKE '%_@_%._%'),
    CONSTRAINT chk_role_valid CHECK (role IN ('guest', 'host', 'admin'))
);


CREATE INDEX idx_user_email ON USER(email);
CREATE INDEX idx_user_role ON USER(role);


CREATE TABLE PROPERTY (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) 
        REFERENCES USER(user_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
   
    CONSTRAINT chk_price_positive CHECK (price_per_night > 0)
);

CREATE INDEX idx_property_host ON PROPERTY(host_id);
CREATE INDEX idx_property_location ON PROPERTY(city, country);
CREATE INDEX idx_property_price ON PROPERTY(price_per_night);


CREATE TABLE BOOKING (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) 
        REFERENCES PROPERTY(property_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) 
        REFERENCES USER(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    
    CONSTRAINT chk_dates_valid CHECK (end_date > start_date),
    CONSTRAINT chk_total_price_positive CHECK (total_price > 0),
    CONSTRAINT chk_status_valid CHECK (status IN ('pending', 'confirmed', 'canceled'))
);


CREATE INDEX idx_booking_property ON BOOKING(property_id);
CREATE INDEX idx_booking_user ON BOOKING(user_id);
CREATE INDEX idx_booking_dates ON BOOKING(property_id, start_date, end_date);
CREATE INDEX idx_booking_status ON BOOKING(status);


CREATE TABLE PAYMENT (
    Payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    Booking_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Payment_Method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    
    CONSTRAINT fk_payment_booking FOREIGN KEY (Booking_id) 
        REFERENCES BOOKING(booking_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_payment_user FOREIGN KEY (user_id) 
        REFERENCES USER(user_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    
    CONSTRAINT chk_amount_positive CHECK (Amount > 0),
    CONSTRAINT chk_payment_method_valid CHECK (Payment_Method IN ('credit_card', 'paypal', 'stripe'))
);


CREATE INDEX idx_payment_booking ON PAYMENT(Booking_id);
CREATE INDEX idx_payment_user ON PAYMENT(user_id);
CREATE INDEX idx_payment_date ON PAYMENT(Payment_date);


CREATE TABLE REVIEW (
    Review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    Property_id CHAR(36) NOT NULL,
    User_id CHAR(36) NOT NULL,
    rating INTEGER NOT NULL,
    Coment TEXT NOT NULL,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    
    CONSTRAINT fk_review_property FOREIGN KEY (Property_id) 
        REFERENCES PROPERTY(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_review_user FOREIGN KEY (User_id) 
        REFERENCES USER(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    
    CONSTRAINT chk_rating_range CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT uq_user_property_review UNIQUE (Property_id, User_id)
);


CREATE INDEX idx_review_property ON REVIEW(Property_id);
CREATE INDEX idx_review_user ON REVIEW(User_id);
CREATE INDEX idx_review_rating ON REVIEW(rating);

CREATE TABLE MESSAGE (
    Message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    Sender_id CHAR(36) NOT NULL,
    Receipt_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    Send_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    
    CONSTRAINT fk_message_sender FOREIGN KEY (Sender_id) 
        REFERENCES USER(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_message_recipient FOREIGN KEY (Receipt_id) 
        REFERENCES USER(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
   
    CONSTRAINT chk_no_self_message CHECK (Sender_id != Receipt_id)
);


CREATE INDEX idx_message_sender ON MESSAGE(Sender_id);
CREATE INDEX idx_message_recipient ON MESSAGE(Receipt_id);
CREATE INDEX idx_message_conversation ON MESSAGE(Sender_id, Receipt_id);
CREATE INDEX idx_message_date ON MESSAGE(Send_at);

