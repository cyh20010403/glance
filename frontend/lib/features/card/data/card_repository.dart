import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../domain/heart_card.dart';

/// Card 数据层
final class CardRepository {
  final _dio = DioClient.instance;

  /// 获取附近的有效卡片
  Future<List<HeartCard>> fetchNearbyCards() async {
    final response = await _dio.get('/cards/nearby');
    final list = response.data['data'] as List<dynamic>;
    return list
        .map((j) => HeartCard.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// 获取自己发布的卡片
  Future<List<HeartCard>> fetchMyCards() async {
    final response = await _dio.get('/cards/mine');
    final list = response.data['data'] as List<dynamic>;
    return list
        .map((j) => HeartCard.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// 上传场景照片
  Future<Map<String, dynamic>?> uploadImage(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });
    final resp = await _dio.post('/v1/files/upload', data: formData);
    return resp.data['data'];
  }

  /// 创建心动卡片
  Future<HeartCard> createCard({
    required String scene,
    String sceneLabel = '',
    String location = '',
    required String occurredAt,
    String topColor = '',
    String pantsColor = '',
    int glasses = 0,
    String hairstyle = '',
    int hasBag = 0,
    String shoeColor = '',
    String description = '',
  }) async {
    final response = await _dio.post(
      '/cards',
      data: jsonEncode({
        'scene': scene,
        'sceneLabel': sceneLabel,
        'location': location,
        'occurredAt': occurredAt,
        'topColor': topColor,
        'pantsColor': pantsColor,
        'glasses': glasses,
        'hairstyle': hairstyle,
        'hasBag': hasBag,
        'shoeColor': shoeColor,
        'description': description,
      }),
    );
    return HeartCard.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}
