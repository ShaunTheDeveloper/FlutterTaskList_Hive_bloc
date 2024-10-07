part of 'bloc_home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeStarted extends HomeEvent{}
class HomeDeleteAll extends HomeEvent{}
class HomeSearch extends HomeEvent{
  String searchKey;
  HomeSearch({required this.searchKey});
}



