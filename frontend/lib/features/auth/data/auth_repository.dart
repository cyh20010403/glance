import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/api_exception.dart';

/// Auth 数据层
///
/// 职责：调用 API、管理本地 Token 存储
final class AuthRepository {
  static const _tokenKey = 'token';
  static const _userIdKey = 'userId';
  static const _nicknameKey = 'nickname';

  /// 发送验证码（MVP: 模拟，始终成功）
  Future<void> sendCode(String phone) async {
    final dio = DioClient.instance;
    await dio.post('/auth/send-code', queryParameters: {'phone': phone});
  }

  /// 手机号 + 验证码登录
  ///
  /// 返回: {token, userId, nickname, isNewUser}
  /// 抛出: [ApiException] 子类
  Future<Map<String, dynamic>> login(String phone, String code) async {
    final dio = DioClient.instance;
    final response = await dio.post(
      '/auth/login',
      data: jsonEncode({'phone': phone, 'code': code}),
    );

    final data = response.data['data'] as Map<String, dynamic>;
    await _saveLoginInfo(data);
    return data;
  }

  /// 持久化登录信息
  Future<void> _saveLoginInfo(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, data['token'] as String);
    await prefs.setInt(_userIdKey, data['userId'] as int);
    await prefs.setString(_nicknameKey, (data['nickname'] as String?) ?? '');

    // 同步更新 DioClient 的 Token 缓存
    DioClient.clearTokenCache();
  }

  /// 检查是否已登录
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenKey);
  }

  /// 退出登录
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_nicknameKey);
    DioClient.clearTokenCache();
  }

  /// 读取已存储的 Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// 读取已存储的 userId
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }
}
