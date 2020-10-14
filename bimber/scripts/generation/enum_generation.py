def generate_enum_names(keys):
    return ",\n".join([name.upper() for name in keys])


def generate_to_json_enum_switch(classname, keys):
    cases = "\n".join(
        [f'case {classname}.{name.upper()}: return "{name.upper()}";' for name in keys])

    formatted = f"""
    switch(this) {{
        {cases}
        default:
            return null;

    }}
"""
    return formatted


def generate_from_json_enum_switch(classname, keys):
    cases = "\n".join(
        [f'case "{name.upper()}": return {classname}.{name.upper()};' for name in keys])

    formatted = f"""
    switch(name) {{
        {cases}
        default:
            return null;

    }}
"""
    return formatted


def generate_dart_enum(classname, keys, spec, meta):

    formatted = f"""
enum {classname} {{
    {generate_enum_names(keys)}
}}

extension {classname}Extension on {classname} {{
    String toJson() {{
        {generate_to_json_enum_switch(classname, keys)}
    }}

    static {classname} fromJson(String name) {{
        {generate_from_json_enum_switch(classname, keys)}
    }}
}}
"""
    return formatted
