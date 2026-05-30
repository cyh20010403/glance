import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class MoodRepository {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>?> getMyMood() async {
    final resp = await _dio.get('/v1/mood');
    return resp.data['data'];
  }

  Future<void> updateMood(String mood) async {
    await _dio.post('/v1/mood', data: {'mood': mood});
  }
}
