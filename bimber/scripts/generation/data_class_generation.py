import re
from generate_class_serialization import get_property_serialization_line, get_property_deserialization_line, BASIC_TYPE_SERIALIZATIONS as basic_types


def generate_properties(keys, spec):
    properties = []
    for key in keys:
        properties.append(f"  final {spec[key]['type']} {key};")
    return "\n".join(properties)

def parse_type_import(type):
    if not "List" in type:
        return type
    match = re.search("List<(.+)>", type)
    return match.group(1)


def generate_custom_type_imports(keys, spec, package_dir="bimber/models/"):
    types = [parse_type_import(spec[key]["type"]) for key in keys]
    types = list(
        set(list(filter(lambda x: x not in basic_types.keys(), types))))

    def to_snake_case(x): return re.sub(r'(?<!^)(?=[A-Z])', '_', x).lower()
    imports = "\n".join(
        [f'import "package:{package_dir}{to_snake_case(type)}.dart";' for type in types])
    return imports


def generate_constructor(classname, keys, spec):
    properties = []
    for key in keys:
        properties.append(f"@required this.{key}")

    props = ", ".join(properties)

    return f"  {classname}({{{props}}});\n"


def generate_copy_with(classname, keys, spec):
    properties = []
    for key in keys:
        properties.append(f"{spec[key]['type']} {key}")

    props = ", ".join(properties)

    replace = []

    for key in keys:
        replace.append(f"{key}: {key} ?? this.{key}")

    reps = f",\n{8 * ' '}".join(replace)

    return f"""
  {classname} copyWith({{{props}}}) {{
      return {classname}(
        {reps}
      );
  }}"""


def generate_props(keys, spec):

    return f"""
  @override
  List get props => [{", ".join(keys)}];
"""


def generate_serialization(classname, keys, spec):
    serialization_lines = ",\n".join(
        [get_property_serialization_line(key, spec) for key in keys])
    deserialization_lines = ",\n".join(
        [get_property_deserialization_line(key, spec) for key in keys])
    serialize = f"""
Map<String, dynamic> toJson() {{
    return {{
    {serialization_lines}
    }};
}}
"""
    deserialize = f"""
factory {classname}.fromJson(dynamic json) {{
    if (json == null) return null;
    return {classname}(
    {deserialization_lines}
    );
}}
"""
    return serialize + deserialize


def generate_dart_data_class(classname, keys, spec, meta):
    formatted = f"""import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
{generate_custom_type_imports(keys, spec)}

class {classname} extends Equatable {{

    bool get stringify => true;
    
{generate_properties(keys, spec)}

{generate_constructor(classname, keys, spec)}
{generate_copy_with(classname, keys, spec)}
{generate_props(keys, spec)}
{generate_serialization(classname, keys, spec)}
}}"""

    return formatted
