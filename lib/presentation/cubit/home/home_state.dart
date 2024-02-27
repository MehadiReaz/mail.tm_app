part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class MessagesLoaded extends HomeState {
  final List<MessageModel> messages;

  const MessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class HomeError extends HomeState {
  final String error;

  const HomeError(this.error);

  @override
  List<Object> get props => [error];
}
