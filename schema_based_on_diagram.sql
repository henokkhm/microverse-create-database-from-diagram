CREATE TABLE patients
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) not null,
	date_of_birth DATE not null
);

CREATE TABLE medical_histories (
	id SERIAL PRIMARY KEY,
    admitted_at timestamp,
	status VARCHAR(255) NOT NULL,
	patient_id int REFERENCES patients(id)
); 

CREATE TABLE treatments (
	id SERIAL PRIMARY KEY,
	type VARCHAR(255) NOT NULL, 
	name VARCHAR(255) NOT NULL
);

CREATE TABLE invoices (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount REAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    paid_at TIMESTAMP NOT NULL,
    medical_history_id INT UNIQUE,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
);

CREATE TABLE invoice_items (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    unit_price REAL NOT NULL,
    quantity INT NOT NULL,
    total_price REAL NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id),
);