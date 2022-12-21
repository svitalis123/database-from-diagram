CREATE DATABASE hospital;

CREATE TABLE patients(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(250),
    date_of_birth DATE
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(250),
    type VARCHAR(25)
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(10)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount NUMERIC,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price NUMERIC,
    quantity INT,
    total_price NUMERIC,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);

CREATE TABLE treatment_histories (
    treatment_id  INT REFERENCES treatments(id),
    medical_history_id INT REFERENCES medical_histories(id),
    PRIMARY KEY (treatment_id, medical_history_id)
);

--create indexes

CREATE INDEX medical_histories_patients_id_idx ON medical_histories(patient_id);
CREATE INDEX invoices_medical_history_idx ON invoices(medical_history_id);
CREATE INDEX invoice_items_invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX invoice_items_treatment_id_idx ON invoice_items(treatment_id);

-- foreign key indexes

CREATE INDEX treatment_histories_patients_on_medical_histories_id_idx ON treatment_histories (medical_histories_id);
CREATE INDEX treatment_histories_patients_id_idx ON treatment_histories (treatments_id);
