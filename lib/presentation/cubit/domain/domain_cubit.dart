import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/dio.dart';
import '../../../data/models/domain_model.dart';

part 'domain_state.dart';

class DomainCubit extends Cubit<DomainState> {
  DomainCubit() : super(DomainInitial());

  Future<void> getDomains() async {
    try {
      final response = await DioInstance.dio.get('/domains');
      final List<dynamic> domainList = response.data['hydra:member'] ?? [];
      final List<DomainModel> domains =
          domainList.map((json) => DomainModel.fromJson(json)).toList();
      emit(DomainsLoaded(domains));
    } catch (e) {
      emit(DomainError(e.toString()));
    }
  }
}
