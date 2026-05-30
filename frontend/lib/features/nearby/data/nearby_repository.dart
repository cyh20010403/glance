import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class NearbyRepository {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>?> getStats() async {
    final resp = await _dio.get('/v1/nearby/stats');
    if (resp.data['code'] == 200) return resp.data['data'];
    return null;
  }
}
