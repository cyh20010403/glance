// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchRecordImpl _$$MatchRecordImplFromJson(Map<String, dynamic> json) =>
    _$MatchRecordImpl(
      id: (json['id'] as num).toInt(),
      cardAId: (json['cardAId'] as num).toInt(),
      cardBId: (json['cardBId'] as num).toInt(),
      userAId: (json['userAId'] as num).toInt(),
      userBId: (json['userBId'] as num).toInt(),
      status: (json['status'] as num?)?.toInt() ?? 1,
      matchedAt: json['matchedAt'] as String,
    );

Map<String, dynamic> _$$MatchRecordImplToJson(_$MatchRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardAId': instance.cardAId,
      'cardBId': instance.cardBId,
      'userAId': instance.userAId,
      'userBId': instance.userBId,
      'status': instance.status,
      'matchedAt': instance.matchedAt,
    };
