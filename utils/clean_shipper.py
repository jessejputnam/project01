import pandas as pd
import numpy as np


def get_country_code(row, country_codes, country_dict):
    """Get valid country code if exists in any address, return NaN if not"""
    for i in range(3):
        val = row[f"shipper_party_address_{4 - i}"]

        if val in country_codes:
            return val
        if val in country_dict:
            return country_dict[val]

    return np.nan


def clean_row(row, country_codes, country_dict):
    """Cleans the row by fixing naming issues  and adding correct country code if found"""

    # Handle the mr/mrs error
    if "MR. AND/OR" in row["shipper_party_name"]:
        row["shipper_party_name"] = row["shipper_party_address_1"]

    if row["country_code"] is not np.nan:
        if row["country_code"] in country_codes:
            return row
    row["country_code"] = get_country_code(row, country_codes, country_dict)

    return row
