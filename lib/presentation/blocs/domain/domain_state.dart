// domain_state.dart

part of 'domain_cubit.dart';

abstract class DomainState extends Equatable {
  const DomainState();

  @override
  List<Object> get props => [];
}

class DomainInitial extends DomainState {}

class DomainsLoaded extends DomainState {
  final List<DomainModel> domains;

  DomainsLoaded(this.domains);

  @override
  List<Object> get props => [domains];
}

class DomainError extends DomainState {
  final String error;

  DomainError(this.error);

  @override
  List<Object> get props => [error];
}
