DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;


CREATE TABLE customers (
  id SERIAL2 PRIMARY KEY,
  name VARCHAR(255),
  funds INT2
);


CREATE TABLE films (
  id SERIAL2 PRIMARY KEY,
  title VARCHAR(255),
  price INT2
);


CREATE TABLE tickets (
  id SERIAL2 PRIMARY KEY,
  customer_id INT2 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT2 REFERENCES films(id) ON DELETE CASCADE
);


CREATE TABLE screenings (
  id SERIAL2 PRIMARY KEY,
  film_id INT2 REFERENCES films(id) ON DELETE CASCADE,
  film_time INT2
)
