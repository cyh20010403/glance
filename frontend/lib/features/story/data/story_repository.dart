import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../domain/glance_story.dart';

class StoryRepository {
  final Dio _dio = DioClient.instance;

  Future<Map<String, dynamic>?> getTodayStory() async {
    final resp = await _dio.get('/v1/story/today');
    return resp.data['data'];
  }

  Future<List<GlanceStory>> getHistory({int page = 0, int size = 20}) async {
    final resp = await _dio.get('/v1/story/history', queryParameters: {
      'page': page,
      'size': size,
    });
    final list = resp.data['data'] as List;
    return list.map((j) => GlanceStory.fromJson(j)).toList();
  }
}
