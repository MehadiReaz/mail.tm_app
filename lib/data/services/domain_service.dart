// domain_service.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/domain_model.dart';

class DomainService {
  final Dio dio;

  DomainService(this.dio);

  Future<List<DomainModel>> getDomains() async {
    try {
      final response = await dio.get('/domains');
      final List<dynamic> domainList = response.data['hydra:member'];
      return domainList.map((json) => DomainModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load domains");
    }
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String?> retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
