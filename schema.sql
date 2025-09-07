
CREATE DATABASE IF NOT EXISTS train_reservation;
USE train_reservation;

-- User accounts
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

-- Trains
CREATE TABLE trains (
    train_id INT AUTO_INCREMENT PRIMARY KEY,
    train_number VARCHAR(10),
    origin VARCHAR(50),
    destination VARCHAR(50)
);

-- Train schedules
CREATE TABLE schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    train_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    fare DECIMAL(8,2),
    FOREIGN KEY (train_id) REFERENCES trains(train_id)
);

-- Stops
CREATE TABLE stops (
    stop_id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT,
    station_name VARCHAR(50),
    stop_time DATETIME,
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
);

-- Reservations
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    schedule_id INT,
    reservation_date DATE,
    fare_paid DECIMAL(8,2),
    passenger_type VARCHAR(20), -- 'adult', 'child', 'senior', 'disabled'
    status VARCHAR(20), -- 'active', 'cancelled'
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
);

CREATE TABLE questions (
    q_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    question_text TEXT,
    answer_text TEXT,
    asked_at DATETIME,
    answered_by INT,
    answered_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (answered_by) REFERENCES users(id)
);
INSERT INTO users (username, password, role)
VALUES ('admin', 'adminpass', 'admin');
INSERT INTO users (username, password, role)
VALUES ('rep1', 'reppass', 'rep');
INSERT INTO users (username, password, role)
VALUES ('alice', 'alicepass', 'customer');
INSERT INTO trains (train_number, origin, destination)
VALUES
  ('A100', 'New York', 'Boston'),
  ('B200', 'Chicago', 'St. Louis'),
  ('C300', 'Los Angeles', 'San Diego');

INSERT INTO schedules (train_id, departure_time, arrival_time, fare)
VALUES
  (1, '2025-07-23 08:00:00', '2025-07-23 12:00:00', 50.00),
  (2, '2025-07-23 10:00:00', '2025-07-23 14:00:00', 40.00),
  (3, '2025-07-24 09:30:00', '2025-07-24 13:00:00', 35.00);

INSERT INTO stops (schedule_id, station_name, stop_time)
VALUES
  (1, 'Stamford', '2025-07-23 09:15:00'),
  (1, 'New Haven', '2025-07-23 10:30:00'),
  (2, 'Springfield', '2025-07-23 11:45:00'),
  (3, 'Anaheim', '2025-07-24 10:15:00');

INSERT INTO reservations (user_id, schedule_id, reservation_date, fare_paid, passenger_type, status)
VALUES
  (1, 1, '2025-07-20', 50.00, 'Regular', 'Active'),
  (2, 2, '2025-07-21', 36.00, 'Senior', 'Active'),
  (3, 3, '2025-07-21', 28.00, 'Child', 'Cancelled');

