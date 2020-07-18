

# This script generates dart data-like class with copyWith functionality based on input json file.
# The concept is simple. Declare json file with necessary fields, pipe it via this script and requested data class will be generated.

# Format:
# __class__ - this field is a must, here you specify name of your output class
# pairs {key, value} should be of format: key <-> propery name, value <-> respective property type

# Dislaimer: if you use custom type for a property make sure is already exists, script will not generate anything besides the type name


import sys
import os
import json
import argparse
import re


def generate_properties(keys, spec):
    properties = []
    for key in keys:
        properties.append(f"  final {spec[key]} {key};")
    return "\n".join(properties)


def generate_constructor(classname, keys, spec):
    properties = []
    for key in keys:
        properties.append(f"@required this.{key}")

    props = ", ".join(properties)

    return f"  {classname}({{{props}}});\n"


def generate_copy_with(classname, keys, spec):
    properties = []
    for key in keys:
        properties.append(f"{spec[key]} {key}")

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


def generate_dart_data_class(filename):
    if ".json" not in filename:
        print("expected first argument to be a json format file")
        sys.exit(1)

    if not os.path.isfile(filename):
        print("given file does not exist, make sure you pass the right path")
        sys.exit(1)

    try:
        with open(filename) as fp:
            spec = json.load(fp)
            if spec["__class__"] is None:
                print("expected '__class__' key, make sure to include one")
                sys.exit(1)

            classname = spec["__class__"]
            keys = list(filter(lambda x: x != "__class__", spec.keys()))

            formatted = f"""import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class {classname} extends Equatable {{
{generate_properties(keys, spec)}

{generate_constructor(classname, keys, spec)}
{generate_copy_with(classname, keys, spec)}
{generate_props(keys, spec)}
}}"""

            return classname, formatted
    except Exception as e:
        print(e)
        return None, None


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Generate dart data class based on provided json spec file.')
    parser.add_argument("-i", "--input", type=str, required=True,
                        dest="input_file", help="json data class specification input file path")
    parser.add_argument("-o", "--output", type=str,
                        dest="output_file", help="dart data class output file path")
    parser.add_argument("--discover-output", type=bool, dest="discover_output",
                        help="discover output file path by inspecting class name", default=False)

    args = parser.parse_args(sys.argv[1:])

    classname, src = generate_dart_data_class(args.input_file)
    if classname != None:
        name = args.output_file if not args.discover_output else re.sub(
            r'(?<!^)(?=[A-Z])', '_', classname).lower() + ".dart"
        if name is None:
            print(
                "you have to either specify output file path or use path discovery option")
            sys.exit(1)
        with open(name, "w") as fp:
            fp.write(src)
