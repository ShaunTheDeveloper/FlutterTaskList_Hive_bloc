part of 'bloc_home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState{}
class HomeDataSuccess extends HomeState{
  List<Task> data;
  HomeDataSuccess({required this.data});
}
class HomeEmptyState extends HomeState{}
class HomeError extends HomeState{
  String message;
  HomeError({required this.message});
}
