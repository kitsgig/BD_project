CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL CHECK (phone_number ~ '^\+7\d{10}$')
);

CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL CHECK (phone_number ~ '^\+7\d{10}$'),
    status_emp VARCHAR(10) NOT NULL CHECK(status_emp IN ('Занят','Свободен'))
);

CREATE TABLE supplier (
    supplier_id SERIAL PRIMARY KEY,
    supplier_address TEXT NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL CHECK (phone_number ~ '^\+7\d{10}$')
);

CREATE TABLE in_stock (
    product_id SERIAL PRIMARY KEY,
    supplier_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    cost INTEGER NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

CREATE TABLE cost_history (
    history_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    changed_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    new_cost INTEGER NOT NULL,
    old_cost INTEGER NOT NULL,
    FOREIGN KEY (product_id) REFERENCES in_stock(product_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (product_id) REFERENCES in_stock(product_id)
);