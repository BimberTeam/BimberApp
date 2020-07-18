import 'package:bimber/models/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Alcohol extends Equatable {
  final String name;
  final AlcoholType type;

  Alcohol({@required this.name, @required this.type});

  Alcohol copyWith({String name, AlcoholType type}) {
    return Alcohol(name: name ?? this.name, type: type ?? this.type);
  }

  @override
  List get props => [name, type];
}
