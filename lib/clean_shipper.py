import numpy as np
from lib.utils import clean_name


def get_country_code(row, country_codes, country_dict):
    """Get valid country code if exists in any address, return NaN if not"""

    for i in range(3):
        val = row[f"shipper_party_address_{4 - i}"]

        if val in country_codes:
            return val
        if val in country_dict:
            return country_dict[val]

    return np.nan


def clean_shipper(row, country_codes, country_dict):
    """Cleans the row by fixing naming issues  and adding correct country code if found"""
    shipper_name = row["shipper_party_name"]
    address_1 = row["shipper_party_address_1"]
    code = row["country_code"]

    # Clean name
    row["shipper_party_name"] = clean_name(shipper_name, address_1)

    # Clean country code
    row["country_code"] = get_country_code(row, country_codes, country_dict)

    return row
