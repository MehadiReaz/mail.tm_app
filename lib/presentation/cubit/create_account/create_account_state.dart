part of 'create_account_cubit.dart';

abstract class CreateAccountState extends Equatable {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //CreateAccountState({addressController, passwordController});

  @override
  List<Object> get props => [addressController.text, passwordController.text];
}

class CreateAccountInitial extends CreateAccountState {
  CreateAccountInitial({addressController, passwordController});

  @override
  List<Object> get props => [addressController.text, passwordController.text];
}

class CreateAccountSuccess extends CreateAccountState {
  CreateAccountSuccess({addressController, passwordController});
}

class CreateAccountError extends CreateAccountState {
  final String error;

  CreateAccountError(this.error);

  @override
  List<Object> get props => [error];
}
