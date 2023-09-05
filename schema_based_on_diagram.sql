CREATE TABLE patients (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP NOT NULL,
    status VARCHAR(255) NOT NULL,
    patient_id INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE invoices (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount REAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    paid_at TIMESTAMP NOT NULL,
    medical_history_id INT UNIQUE,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    unit_price REAL NOT NULL,
    quantity INT NOT NULL,
    total_price REAL NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE medical_history_treatments (
    medical_history_id INT,
    treatment_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX medical_histories_patient_id_idx ON medical_histories(patient_id);

CREATE INDEX treatments_medical_history_id_idx ON invoices(medical_history_id);

CREATE INDEX invoice_items_invoice_id_idx ON invoice_items(invoice_id);

CREATE INDEX invoice_items_treatment_id_idx ON invoice_items(treatment_id);

CREATE INDEX medical_history_treatments_medical_history_id_idx ON medical_history_treatments(medical_history_id);

CREATE INDEX medical_history_treatments_treatment_id_idx ON medical_history_treatments(treatment_id);