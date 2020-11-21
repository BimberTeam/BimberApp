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

enum SwipeType { LIKE, DISLIKE }

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GroupRepository groupRepository;

  DiscoverBloc({@required this.groupRepository}) : super(DiscoverInitial());

  @override
  Stream<DiscoverState> mapEventToState(
    DiscoverEvent event,
  ) async* {
    if (event is InitDiscover) {
      yield* _mapFetchSuggestions(3);
    }
    if (event is SwipeGroup) {
      yield* _mapSwipeGroup(event.swipeType, event.groupId);
    }
    if (event is SwipeButtonPressed) {
      yield* _mapButtonPressed(event.swipeType);
    }
  }

  Stream<DiscoverState> _mapButtonPressed(SwipeType swipeType) async* {
    try {
      yield DiscoverSwipeButtonPressed(swipeType: swipeType);
    } catch (exception) {
      if (exception is TimeoutException)
        yield DiscoverError(message: timeoutExceptionMessage);
      else
        yield DiscoverError(message: defaultErrorMessage);
    }
  }

  Stream<DiscoverState> _mapSwipeGroup(
      SwipeType swipeType, String groupId) async* {
    try {
      yield DiscoverLoading();
      final message = await groupRepository.swipeGroup(swipeType, groupId);
      if (message.status == Status.OK) {
        if (message.message == "MATCH") yield DiscoverSwipeMatched();
      } else {
        yield DiscoverError(message: message.message);
      }
      yield* _mapFetchSuggestions(1);
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
      print(exception);
      if (exception is TimeoutException)
        yield DiscoverError(message: timeoutExceptionMessage);
      else
        yield DiscoverError(message: defaultErrorMessage);
    }
  }
}
