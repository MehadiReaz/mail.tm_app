part of 'login_cubit.dart';

class LoginState extends Equatable {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  List<Object> get props => [addressController.text, passwordController.text];
}

class LoginInitial extends LoginState {
  LoginInitial({addressController, passwordController});

  @override
  List<Object> get props => [addressController.text, passwordController.text];
}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess(this.token);

  @override
  List<Object> get props => [token];
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);

  @override
  List<Object> get props => [error];
}
