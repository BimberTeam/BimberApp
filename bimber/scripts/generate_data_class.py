

# This script generates dart data-like class with copyWith functionality based on input json file.
# The concept is simple. Declare json file with necessary fields, pipe it via this script and requested data class will be generated. 

# Format:
# __class__ - this field is a must, here you specify name of your output class
# pairs {key, value} should be of format: key <-> propery name, value <-> respective property type

# Dislaimer: if you use custom type for a property make sure is already exists, script will not generate anything besides the type name


import sys
import os
import json


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

 


filename = sys.argv[1]



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


        formatted = f"""
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class {classname} extends Equatable {{
{generate_properties(keys, spec)}

{generate_constructor(classname, keys, spec)}
{generate_copy_with(classname, keys, spec)}
{generate_props(keys, spec)}
}}"""

        print(formatted)
except Exception as e:
    print(e)



