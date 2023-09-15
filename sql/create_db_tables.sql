USE master;

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ams') 
BEGIN
    CREATE DATABASE ams 
END;

USE ams;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'country') 
BEGIN
    CREATE TABLE country(
        country_id CHAR(2) PRIMARY KEY,
        country_name VARCHAR(100) NOT NULL,
        region VARCHAR(20),
        sub_region VARCHAR(50)
    ) 
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'vessel') 
BEGIN
    CREATE TABLE vessel(
        vessel_id INT PRIMARY KEY,
        vessel_name VARCHAR(50),
        vessel_country_id CHAR(2) FOREIGN KEY REFERENCES country(country_id),
        carrier_code VARCHAR(4)
    ) 
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'shipment') 
BEGIN
    CREATE TABLE shipment(
        shipment_id BIGINT PRIMARY KEY,
        vessel_id INT,
        estimated_arrival_date DATE,
        actual_arrival_date DATE
    ) 
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'shipper') 
BEGIN
    CREATE TABLE shipper(
        shipper_id INT PRIMARY KEY,
        shipper_name VARCHAR(75),
        shipper_country_code CHAR(2) FOREIGN KEY REFERENCES country(country_id)
    ) 
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'consignee') 
BEGIN
    CREATE TABLE consignee(
        consignee_id INT PRIMARY KEY,
        consignee_name VARCHAR(75),
        consignee_country_code CHAR(2) FOREIGN KEY REFERENCES country(country_id)
    ) 
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'shipper_shipment') 
BEGIN 
    CREATE TABLE shipper_shipment(
        shipper_shipment_id INT PRIMARY KEY,
        shipment_id BIGINT FOREIGN KEY REFERENCES shipment(shipment_id),
        shipper_id INT FOREIGN KEY REFERENCES shipper(shipper_id)
    ) 
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'consignee_shipment') 
BEGIN
    CREATE TABLE consignee_shipment(
        consignee_shipment_id INT PRIMARY KEY,
        shipment_id BIGINT FOREIGN KEY REFERENCES shipment(shipment_id),
        consignee_id INT FOREIGN KEY REFERENCES consignee(consignee_id)
    ) 
END;