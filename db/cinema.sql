DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  price INT
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id SERIAL4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id SERIAL4 REFERENCES films(id) ON DELETE CASCADE
);
