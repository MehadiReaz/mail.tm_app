// login_state.dart

part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String? address; // Add this line
  final String? password;

  const LoginState({this.address, this.password}); // Add this constructor

  @override
  List<Object> get props => [address ?? '', password ?? ''];
}

class LoginInitial extends LoginState {
  const LoginInitial({super.address, super.password});

  @override
  List<Object> get props => [address ?? '', password ?? ''];
}

class LoginSuccess extends LoginState {
  final String token;

  const LoginSuccess(this.token);

  @override
  List<Object> get props => [token];
}

class LoginError extends LoginState {
  final String error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}
