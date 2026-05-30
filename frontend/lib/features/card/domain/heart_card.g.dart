// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeartCardImpl _$$HeartCardImplFromJson(Map<String, dynamic> json) =>
    _$HeartCardImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      scene: json['scene'] as String,
      sceneLabel: json['sceneLabel'] as String? ?? '',
      location: json['location'] as String? ?? '',
      occurredAt: json['occurredAt'] as String,
      topColor: json['topColor'] as String? ?? '',
      pantsColor: json['pantsColor'] as String? ?? '',
      glasses: (json['glasses'] as num?)?.toInt() ?? 0,
      hairstyle: json['hairstyle'] as String? ?? '',
      hasBag: (json['hasBag'] as num?)?.toInt() ?? 0,
      shoeColor: json['shoeColor'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 1,
      expireAt: json['expireAt'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$HeartCardImplToJson(_$HeartCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'scene': instance.scene,
      'sceneLabel': instance.sceneLabel,
      'location': instance.location,
      'occurredAt': instance.occurredAt,
      'topColor': instance.topColor,
      'pantsColor': instance.pantsColor,
      'glasses': instance.glasses,
      'hairstyle': instance.hairstyle,
      'hasBag': instance.hasBag,
      'shoeColor': instance.shoeColor,
      'description': instance.description,
      'status': instance.status,
      'expireAt': instance.expireAt,
      'createdAt': instance.createdAt,
    };
