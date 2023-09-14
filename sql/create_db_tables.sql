USE master;

CREATE DATABASE ams;

USE ams;

CREATE TABLE country(
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    region VARCHAR(20),
    sub_region VARCHAR(50)
);

CREATE TABLE shipment(
    shipment_id BIGINT PRIMARY KEY,
    carrier_code VARCHAR(4),
    vessel_country_code CHAR(2) FOREIGN KEY REFERENCES country(country_id),
    vessel_name VARCHAR(50),
    estimated_arrival_date DATE,
    actual_arrival_date DATE
);

CREATE TABLE shipper(
    shipper_id INT PRIMARY KEY,
    shipper_name VARCHAR(75),
    shipper_country_code CHAR(2) FOREIGN KEY REFERENCES country(country_id)
);

CREATE TABLE consignee(
    consignee_id INT PRIMARY KEY,
    consignee_name VARCHAR(75),
    consignee_country_code CHAR(2) FOREIGN KEY REFERENCES country(country_id)
);

CREATE TABLE shipper_shipment(
    shipper_shipment_id INT PRIMARY KEY,
    shipment_id BIGINT FOREIGN KEY REFERENCES shipment(shipment_id),
    shipper_id INT FOREIGN KEY REFERENCES shipper(shipper_id)
);

CREATE TABLE consignee_shipment(
    consignee_shipment_id INT PRIMARY KEY,
    shipment_id BIGINT FOREIGN KEY REFERENCES shipment(shipment_id),
    consignee_id INT FOREIGN KEY REFERENCES consignee(consignee_id)
);