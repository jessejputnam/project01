import numpy as np
from lib.utils import clean_name


def get_country_code(row, country_codes):
    """Get valid country code if exists in any address, return NaN if not"""
    if row["country_code"] in country_codes:
        return row["country_code"]
    return np.nan


def clean_consignee(row, country_codes):
    """Cleans the row by fixing naming issues and adding correct country code if found"""
    consignee_name = row["consignee_name"]
    code = row["country_code"]
    address_1 = row["consignee_address_1"]

    # Clean name
    row["consignee_name"] = clean_name(consignee_name, address_1)

    # Clean country code
    if code is not np.nan:
        if code in country_codes:
            return row
    row["country_code"] = get_country_code(row, country_codes)

    return row
