import '../../../core/network/dio_client.dart';
import '../domain/match_record.dart';

final class MatchRepository {
  final _dio = DioClient.instance;

  /// 检查匹配（轮询用），返回 {match, partnerCard, similarityScore?}
  Future<Map<String, dynamic>?> checkMatch() async {
    final response = await _dio.get('/matches/check');
    final data = response.data['data'];
    if (data == null) return null;
    if (data is Map<String, dynamic>) return data;
    return null;
  }

  /// 尝试匹配
  Future<MatchRecord?> tryMatch(int cardId) async {
    final response = await _dio.post('/matches/try/$cardId');
    final data = response.data;
    if (data['data'] != null) {
      return MatchRecord.fromJson(data['data'] as Map<String, dynamic>);
    }
    return null;
  }

  /// 获取我的所有匹配
  Future<List<MatchRecord>> fetchMyMatches() async {
    final response = await _dio.get('/matches');
    final list = response.data['data'] as List<dynamic>;
    return list
        .map((j) => MatchRecord.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// 解除匹配
  Future<void> unmatch(int matchId) async {
    await _dio.delete('/matches/$matchId');
  }
}
