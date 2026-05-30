import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../domain/mood_state.dart';
import 'mood_viewmodel.dart';

/// 情绪选择器 —「暮光手帖」风格
///
/// 圆形 emoji 选择器，选中态带琥珀微光。
final class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key});

  static const _moods = [
    ('expect', '🌟', '期待'),
    ('miss', '💭', '想念'),
    ('happy', '😊', '开心'),
    ('quiet', '🌙', '安静'),
    ('bored', '🫠', '无聊'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodState = ref.watch(moodViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text('今日心情', style: GoogleFonts.notoSerifSc(
              fontSize: 13, color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            )),
            const SizedBox(width: 6),
            Container(
              width: 4, height: 4,
              decoration: const BoxDecoration(
                color: AppTheme.accent, shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _moods.map((m) {
            final (key, emoji, label) = m;
            final isSelected = moodState is MoodLoaded && moodState.mood == key;
            return GestureDetector(
              onTap: () => ref.read(moodViewModelProvider.notifier).setMood(key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                width: 52, height: 72,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.accent.withValues(alpha: 0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  border: isSelected
                      ? Border.all(color: AppTheme.accent.withValues(alpha: 0.25), width: 0.5)
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(emoji, style: TextStyle(
                      fontSize: isSelected ? 26 : 22,
                    )),
                    const SizedBox(height: 4),
                    Text(label, style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? AppTheme.accent : AppTheme.textSecondary,
                    )),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
