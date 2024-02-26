part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class MessagesLoaded extends HomeState {
  final dynamic data;

  MessagesLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);

  @override
  List<Object> get props => [error];
}
