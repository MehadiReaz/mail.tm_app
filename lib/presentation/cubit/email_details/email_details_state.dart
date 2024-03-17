part of 'email_details_cubit.dart';

class EmailDetailsState extends Equatable {
  const EmailDetailsState();

  @override
  List<Object> get props => [];
}

class EmailDetailsInitial extends EmailDetailsState {}

class EmailDetailsLoading extends EmailDetailsState {}

class EmailDetailsLoaded extends EmailDetailsState {
  final EmailDetails emailDetails;

  const EmailDetailsLoaded(this.emailDetails);

  @override
  List<Object> get props => [emailDetails];
}

class EmailDeleted extends EmailDetailsState {}

class EmailDetailsError extends EmailDetailsState {
  final String errorMessage;

  const EmailDetailsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
