// create_account_state.dart
part of 'create_account_cubit.dart';

abstract class CreateAccountState extends Equatable {
  final String? address; // Add this line
  final String? password;
  const CreateAccountState({this.address, this.password});

  @override
  List<Object> get props => [];
}

class CreateAccountInitial extends CreateAccountState {
  const CreateAccountInitial({super.address, super.password});

  @override
  List<Object> get props => [address ?? '', password ?? ''];
}

class CreateAccountSuccess extends CreateAccountState {
  const CreateAccountSuccess({super.address, super.password});
}

class CreateAccountError extends CreateAccountState {
  final String error;

  const CreateAccountError(this.error);

  @override
  List<Object> get props => [error];
}
