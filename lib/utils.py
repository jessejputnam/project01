import numpy as np


def get_data_url(layer, table, year=None, part=None):
    """Get the URL for data file"""
    if year is None:
        return f"data/{layer}_layer/{table}.csv"

    return f"data/{layer}_layer/{table}_20{year}_part_{part}.csv"


####################################################################################


def clean_name(entity_name, address_1):
    # Handle the mr/mrs error
    if entity_name in ["MR. AND/OR MRS.", "MR.", "MRS."]:
        return address_1

    # Handle cases where quotations are erroneously used
    if entity_name[0] == '"':
        entity_name = entity_name.replace('"', "")
        if entity_name == "":
            return "N/A"

    return entity_name


def get_country_code(row, col_prefix, country_codes, country_dict):
    """Get valid country code if exists in any address, return NaN if not"""
    code = row["country_code"]

    if code is not np.nan:
        if code in country_codes:
            return code

    for i in range(3):
        val = row[f"{col_prefix}_address_{4 - i}"]

        if val in country_codes:
            return val
        if val in country_dict:
            return country_dict[val]

    return np.nan


def clean_row(row, col_prefix, country_codes, country_dict):
    """Cleans the row by fixing naming issues and adding correct country code if found"""
    entity_name = row[f"{col_prefix}_name"]
    address_1 = row[f"{col_prefix}_address_1"]

    # Clean name
    row[f"{col_prefix}_name"] = clean_name(entity_name, address_1)

    # Clean country code
    row["country_code"] = get_country_code(row, col_prefix, country_codes, country_dict)

    return row


####################################################################################


def remove_incorrect_codes(code, country_codes):
    """Remove country codes that are not found in alpha-2 list"""
    if code in country_codes:
        return code
    return np.nan


####################################################################################


def get_id_nums(name_col):
    """Return a dictionary of IDs for the entity table"""
    id_dict = {}
    id_count = 0

    for name in name_col.unique():
        id_dict[name] = id_count
        id_count += 1

    return id_dict
