-- Insert Chair into db --
INSERT INTO products (name, price, can_be_returned)
VALUES ('chair', 44.00,'false');

-- Insert Stool into db --
INSERT INTO products (name, price, can_be_returned)
 VALUES ('stool', 25.99,'true');

-- Insert Table into db --
 INSERT INTO products (name, price, can_be_returned)
 VALUES ('table', 124.00,'false');

-- Display rows and columns --
 SELECT * FROM products;

-- Display names --
SELECT name FROM products;

-- Add new product --
INSERT INTO products (name, price, can_be_returned)
 VALUES ('sofa', 679.00,'false');

-- Display can_be_returned products --
 SELECT * FROM products WHERE can_be_returned = 'true';

-- Display products under 44.00 --
SELECT * FROM products WHERE price <= 44.00;

-- Display products between 22.50 and 99.99 --
SELECT * FROM products WHERE price BETWEEN 22.50 AND 99.99;

-- Update price 20 less --
UPDATE products SET price = price - 20;

-- Delete products under 25 --
DELETE FROM products WHERE price < 25;

--Update price 20 more --
UPDATE products SET price = price + 20;

-- Set can_be_returned to true --
UPDATE products SET can_be_returned = true;



 