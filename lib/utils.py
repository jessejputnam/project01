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


def get_id_nums(name_col):
    id_dict = {}
    id_count = 0

    for name in name_col.unique():
        id_dict[name] = id_count
        id_count += 1

    return id_dict
