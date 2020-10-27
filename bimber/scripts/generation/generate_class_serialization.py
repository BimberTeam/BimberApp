import re

BASIC_TYPE_SERIALIZATIONS = {"String": "{}", "int": "{}",
                             "double": "{}", "bool": "{}", "DateTime": "{}?.toIso8601String()"}
BASIC_TYPE_DESERIALIZATIONS = {"String": "{}", "int": "{} as int", "double": "{} as double",
                               "bool": "{} as bool", "DateTime": "{0} != null ? DateTime.parse({0}) : null"}


def get_type_from_list(type):
    match = re.search("List<(.+)>", type)

    return match.group(1)


def serialize_method(key, spec):
    prop_type = spec[key]["type"]
    if prop_type in BASIC_TYPE_SERIALIZATIONS:
        return BASIC_TYPE_SERIALIZATIONS[prop_type].format(key)

    # we are not hitting deserializing list so just use 'toJson' method
    if not "List" in prop_type:
        return f"{key}?.toJson()"

    list_type = get_type_from_list(prop_type)

    map_function = BASIC_TYPE_SERIALIZATIONS[list_type].format(
        'e') if list_type in BASIC_TYPE_SERIALIZATIONS else 'e?.toJson()'
    return f"{key}.map((e) => {map_function})"


def get_property_serialization_line(key, spec):
    if spec[key]["type"] is None:
        raise AttributeError(
            "spec structure is expected to have 'type' property")

    return f'"{key}": {serialize_method(key, spec)}'


def deserialize_method(key, spec):
    prop_type = spec[key]["type"]
    if prop_type in BASIC_TYPE_DESERIALIZATIONS:
        key = f'"{key}"'
        json = f'json[{key}]'
        return f'{BASIC_TYPE_DESERIALIZATIONS[prop_type].format(json)}'

    # we are not hitting deserializing list so just use 'toJson' method
    if not "List" in prop_type:
        prop_type = f"{prop_type}Extension" if "enum" in spec[key] else prop_type
        return f'{prop_type}.fromJson(json["{key}"])'

    list_type = get_type_from_list(prop_type)

    list_type_static = f"{prop_type}Extension" if "enum" in spec[key] else list_type

    map_function = BASIC_TYPE_DESERIALIZATIONS[list_type].format(
        'e') if list_type in BASIC_TYPE_DESERIALIZATIONS else f'{list_type_static}.fromJson(e)'

    return f'List<{list_type_static}>.from(json["{key}"].map((e) => {map_function}))'


def get_property_deserialization_line(key, spec):
    if spec[key]["type"] is None:
        raise AttributeError(
            "spec structure is expected to have 'type' property")

    return f"{key}: {deserialize_method(key, spec)}"
