// create_account_state.dart
part of 'create_account_cubit.dart';

abstract class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

class CreateAccountInitial extends CreateAccountState {}

class CreateAccountSuccess extends CreateAccountState {
  const CreateAccountSuccess();
}

class CreateAccountError extends CreateAccountState {
  final String error;

  const CreateAccountError(this.error);

  @override
  List<Object> get props => [error];
}
