part of 'group_info_bloc.dart';

@immutable
abstract class GroupInfoState extends Equatable {
  const GroupInfoState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupInfoInitial extends GroupInfoState {}

class GroupInfoError extends GroupInfoState {
  final String message;

  GroupInfoError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GroupInfoFetched extends GroupInfoState {
  final List<String> friendCandidates;
  final String meId;
  final Group group;

  GroupInfoFetched({this.friendCandidates, this.meId, this.group});

  @override
  List<Object> get props => [this.friendCandidates, this.meId, this.group];
}

class GroupInfoLoading extends GroupInfoState {}

class GroupInfoAddSuccess extends GroupInfoState {}

class GroupInfoAddFailure extends GroupInfoState {}
