// app/locator.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/services/domain_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator(Dio dio) {
  locator.registerLazySingleton(() => dio);
  locator.registerLazySingleton(() => DomainService(locator<Dio>()));
  // Add more dependencies as needed
}
