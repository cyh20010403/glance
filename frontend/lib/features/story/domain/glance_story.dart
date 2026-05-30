import 'package:freezed_annotation/freezed_annotation.dart';

part 'glance_story.freezed.dart';
part 'glance_story.g.dart';

@freezed
sealed class GlanceStory with _$GlanceStory {
  const factory GlanceStory({
    required int id,
    required String content,
    required String storyDate,
    required String createdAt,
  }) = _GlanceStory;

  factory GlanceStory.fromJson(Map<String, dynamic> json) =>
      _$GlanceStoryFromJson(json);
}
