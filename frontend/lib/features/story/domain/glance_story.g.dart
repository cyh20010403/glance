// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glance_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GlanceStoryImpl _$$GlanceStoryImplFromJson(Map<String, dynamic> json) =>
    _$GlanceStoryImpl(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      storyDate: json['storyDate'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$GlanceStoryImplToJson(_$GlanceStoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'storyDate': instance.storyDate,
      'createdAt': instance.createdAt,
    };
