import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/app_theme.dart';
import '../domain/mood_state.dart';
import 'mood_viewmodel.dart';

/// 情绪选择器组件 — 可复用于首页和 Profile 页
final class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key});

  static const _moods = [
    ('expect', '🌟', '期待遇见'),
    ('miss', '💭', '有点想你'),
    ('happy', '😊', '今天心情不错'),
    ('quiet', '🌙', '享受独处'),
    ('bored', '🫠', '谁来聊聊天'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodState = ref.watch(moodViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('今日心情', style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textSecondary)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _moods.map((m) {
            final (key, emoji, label) = m;
            final isSelected = moodState is MoodLoaded && moodState.mood == key;
            return GestureDetector(
              onTap: () => ref.read(moodViewModelProvider.notifier).setMood(key),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primary.withValues(alpha: 0.12)
                      : AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  border: Border.all(
                    color: isSelected ? AppTheme.primary : AppTheme.border,
                    width: isSelected ? 1.5 : 0.5,
                  ),
                ),
                child: Text('$emoji $label', style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                )),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
