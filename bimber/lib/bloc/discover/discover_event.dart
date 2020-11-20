part of 'discover_bloc.dart';

@immutable
abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitDiscover extends DiscoverEvent {}

class SwipeGroup extends DiscoverEvent {
  final SwipeType swipeType;
  final String groupId;

  SwipeGroup({this.swipeType, this.groupId});

  @override
  List<Object> get props => [this.swipeType];
}

class SwipeButtonPressed extends DiscoverEvent {
  final SwipeType swipeType;

  SwipeButtonPressed({this.swipeType});

  @override
  List<Object> get props => [this.swipeType];
}
