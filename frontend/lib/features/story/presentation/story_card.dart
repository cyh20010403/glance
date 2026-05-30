import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../domain/glance_story.dart';

/// 回眸故事卡片 — 可配合 RepaintBoundary 做截图分享
final class StoryCard extends StatelessWidget {
  final GlanceStory story;
  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8F0FF), Color(0xFFFFF5F5)],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: [
          const Text('📖', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 12),
          const Text('今日回眸',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 4),
          Text(story.storyDate,
              style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(height: 20),
          Text(story.content,
              style: const TextStyle(fontSize: 15, height: 1.8,
                  color: AppTheme.textPrimary),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          const Text('—— 来自《回眸》',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}
