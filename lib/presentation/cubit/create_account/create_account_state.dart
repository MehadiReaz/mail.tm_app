part of 'create_account_cubit.dart';

class CreateAccountState extends Equatable {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  List<Object> get props => [addressController.text, passwordController.text];
}

class CreateAccountInitial extends CreateAccountState {
  CreateAccountInitial({addressController, passwordController});

  @override
  List<Object> get props => [addressController.text, passwordController.text];
}

class CreateAccountSuccess extends CreateAccountState {
  final String success;
  CreateAccountSuccess(this.success);

  @override
  List<Object> get props => [success];
}

class CreateAccountError extends CreateAccountState {
  final String error;

  CreateAccountError(this.error);

  @override
  List<Object> get props => [error];
}
