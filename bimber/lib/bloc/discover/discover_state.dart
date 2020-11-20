part of 'discover_bloc.dart';

@immutable
abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class DiscoverInitial extends DiscoverState {}

class DiscoverError extends DiscoverState {
  final String message;

  DiscoverError({@required this.message});

  @override
  List<Object> get props => [message];
}

class DiscoverFetched extends DiscoverState {
  final List<Group> groupSuggestions;

  DiscoverFetched({this.groupSuggestions});

  @override
  List<Object> get props => [this.groupSuggestions];
}

class DiscoverLoading extends DiscoverState {}

class DiscoverSwipeMatched extends DiscoverState {}

class DiscoverSwipeButtonPressed extends DiscoverState {
  final SwipeType swipeType;

  DiscoverSwipeButtonPressed({@required this.swipeType});

  @override
  List<Object> get props => [this.swipeType];
}
