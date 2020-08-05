# TODO: generating enum class with all extension method

# This script generates dart data-like class with copyWith and serialization/deserialization functionality based on input json file.
# The concept is simple. Declare json file with necessary fields, pipe it via this script and requested data class will be generated.

# Format:
# __class__ - this field is a must, here you specify name of your output class
# paris {key, value} should be of format: key <-> property name, value <-> map containing property metadata
# currently supported metadata is of format: [type: "type name", "enum": true]
# "enum": true indicates that requested type is an enum and different name should be used for 'fromJson" method (see dart static method extensions)

# Scripts supports list types which must be of format 'List<YourType>'
# if 'YourType' is one of default types, default serialization/deserialization will be applied
# otherwise 'toJson' and 'fromJson' are applied as the type is assumed to be a custom one

# DEFAULT TYPES
# - bool
# - int
# - double
# - String
# - DateTime

# Dislaimer: if you use custom type for a property make sure is already exists, script will not generate anything besides the type name
# Another disclaimer: if you want well formatted output class please use `flutter format <your_class_file.dart>` as it is easier than doing it by hand in python

# Example

# age_preference.json
# {
#     "__class__": "AgePreference",
#     "from": {"type": "int"},
#     "to": {"type": "int"}
# }

# age_preference.dart
#
# import 'package:equatable/equatable.dart';
# import 'package:meta/meta.dart';
#
# class AgePreference extends Equatable {
#   final int from;
#   final int to;
#
#   AgePreference({@required this.from, @required this.to});
#
#   AgePreference copyWith({int from, int to}) {
#     return AgePreference(from: from ?? this.from, to: to ?? this.to);
#   }
#
#   @override
#   List get props => [from, to];
#
#   Map<String, dynamic> toJson() {
#     return {"from": from, "to": to};
#   }
#
#   factory AgePreference.fromJson(dynamic json) {
#     return AgePreference(from: json["from"] as int, to: json["to"] as int);
#   }
# }

import sys
import os
import json
import argparse
import re

from data_class_generation import generate_dart_data_class
from enum_generation import generate_dart_enum

META = ["__class__", "__enum__"]


def load_file_information(filename):
    if ".json" not in filename:
        print("expected first argument to be a json format file")
        sys.exit(1)

    if not os.path.isfile(filename):
        print("given file does not exist, make sure you pass the right path")
        sys.exit(1)

    try:
        with open(filename) as fp:
            spec = json.load(fp)
            if spec["__class__"] == None:
                print("expected '__class__' key, make sure to include one")
                sys.exit(1)

            classname = spec["__class__"]
            keys = list(filter(lambda x: x not in META, spec.keys()))
            meta = list(filter(lambda x: x in META, spec.keys()))

            return classname, keys, spec, meta
    except Exception as e:
        print(e)


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

    classname, keys, spec, meta = load_file_information(args.input_file)

    generated = ""
    if "__enum__" in meta:
        generated = generate_dart_enum(classname, keys, spec, meta)
    else:
        generated = generate_dart_data_class(classname, keys, spec, meta)

    if classname != None:
        name = args.output_file if not args.discover_output else re.sub(
            r'(?<!^)(?=[A-Z])', '_', classname).lower() + ".dart"
        if name is None:
            print(
                "you have to either specify output file path or use path discovery option")
            sys.exit(1)
        with open(name, "w") as fp:
            fp.write(generated)
