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
  final Swipe swipeDirection;
  final String groupId;

  SwipeGroup({this.swipeDirection, this.groupId});

  @override
  List<Object> get props => [this.swipeDirection];
}

class SwipeButtonPressed extends DiscoverEvent {
  final Swipe swipeDirection;

  SwipeButtonPressed({this.swipeDirection});

  @override
  List<Object> get props => [this.swipeDirection];
}
