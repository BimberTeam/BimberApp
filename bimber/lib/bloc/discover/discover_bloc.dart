import 'dart:async';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'discover_event.dart';

part 'discover_state.dart';

enum Swipe { LIKE, DISLIKE }

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GroupRepository groupRepository;

  DiscoverBloc({@required this.groupRepository}) : super(DiscoverInitial());

  @override
  Stream<DiscoverState> mapEventToState(
    DiscoverEvent event,
  ) async* {
    if (event is InitDiscover) {
      yield* _mapFetchSuggestions(5);
    }
    if (event is SwipeGroup) {
      yield* _mapSwipeGroup(event.swipeDirection, event.groupId);
    }
    if (event is SwipeButtonPressed) {
      yield* _mapButtonPressed(event.swipeDirection);
    }
  }

  Stream<DiscoverState> _mapButtonPressed(Swipe swipeDirection) async* {
    try {
      yield DiscoverAnimate(swipeAnimation: swipeDirection);
    } catch (exception) {
      if (exception is TimeoutException)
        yield DiscoverError(message: timeoutExceptionMessage);
      else
        yield DiscoverError(message: defaultErrorMessage);
    }
  }

  Stream<DiscoverState> _mapSwipeGroup(
      Swipe swipeDirection, String groupId) async* {
    try {
      yield DiscoverLoading();
      final message = await groupRepository.swipeGroup(swipeDirection, groupId);
      if (message.status == Status.OK) {
        if (message.message == "MATCH") yield DiscoverSwipeMatch();
        yield* _mapFetchSuggestions(1);
      } else {
        yield DiscoverError(message: message.message);
      }
    } catch (exception) {
      if (exception is TimeoutException)
        yield DiscoverError(message: timeoutExceptionMessage);
      else
        yield DiscoverError(message: defaultErrorMessage);
    }
  }

  Stream<DiscoverState> _mapFetchSuggestions(int limit) async* {
    try {
      final suggestions = await groupRepository.fetchGroupSuggestion(limit);
      yield DiscoverFetched(groupSuggestions: suggestions);
    } catch (exception) {
      if (exception is TimeoutException)
        yield DiscoverError(message: timeoutExceptionMessage);
      else
        yield DiscoverError(message: defaultErrorMessage);
    }
  }
}
