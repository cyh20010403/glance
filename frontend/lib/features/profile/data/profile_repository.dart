import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/dio_client.dart';
import '../../auth/data/auth_repository.dart';

/// Profile 数据层
final class ProfileRepository {
  final _dio = DioClient.instance;

  /// 更新用户资料
  Future<void> updateProfile({
    String? nickname,
    String? avatar,
    String? signature,
    List<String>? tags,
  }) async {
    final body = <String, dynamic>{};
    if (nickname != null) body['nickname'] = nickname;
    if (avatar != null) body['avatar'] = avatar;
    if (signature != null) body['signature'] = signature;
    if (tags != null) body['tags'] = tags;

    await _dio.put('/user/profile', data: jsonEncode(body));

    // 同步更新本地缓存
    if (nickname != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('nickname', nickname);
    }
  }

  /// 举报用户
  Future<void> reportUser({
    required int targetId,
    required String reason,
    String detail = '',
  }) async {
    await _dio.post(
      '/user/report/$targetId',
      queryParameters: {'reason': reason, 'detail': detail},
    );
  }

  /// 拉黑用户
  Future<void> blockUser(int targetId) async {
    await _dio.post('/user/block/$targetId');
  }

  /// 获取本地缓存的用户信息
  Future<({String nickname, String signature})> getLocalProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return (
      nickname: prefs.getString('nickname') ?? '未设置',
      signature: '',
    );
  }

  /// 退出登录
  Future<void> logout() async {
    await AuthRepository.logout();
  }
}
