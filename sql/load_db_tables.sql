USE ams;

BULK INSERT dbo.country FROM '/home/data/countries.csv' WITH (
    FORMAT='CSV', ROWTERMINATOR='0x0a', FIRSTROW=2
);
BULK INSERT dbo.vessel FROM '/home/data/vessel.csv' WITH (
    FORMAT='CSV', ROWTERMINATOR='0x0a', FIRSTROW=2
);
BULK INSERT dbo.shipment FROM '/home/data/shipment.csv' WITH (
    FORMAT='CSV', ROWTERMINATOR='0x0a', FIRSTROW=2
);
BULK INSERT dbo.shipper FROM '/home/data/shipper.csv' WITH (
    FORMAT='CSV', ROWTERMINATOR='0x0a', FIRSTROW=2
);
BULK INSERT dbo.consignee FROM '/home/data/consignee.csv' WITH (
    FORMAT='CSV', ROWTERMINATOR='0x0a', FIRSTROW=2
);
BULK INSERT dbo.shipper_shipment FROM '/home/data/shipper_shipment.csv' WITH (
    FORMAT='CSV', ROWTERMINATOR='0x0a', FIRSTROW=2
);
BULK INSERT dbo.consignee_shipment FROM '/home/data/consignee_shipment.csv' WITH (
    FORMAT='CSV', ROWTERMINATOR='0x0a', FIRSTROW=2
);