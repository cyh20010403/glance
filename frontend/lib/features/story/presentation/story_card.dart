import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../domain/glance_story.dart';

/// 回眸故事卡片 —「手帖日记」风格
///
/// 暖白纸底 + 靛蓝文字，像一页私人手记。
final class StoryCard extends StatelessWidget {
  final GlanceStory story;
  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppTheme.border, width: 0.5),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: [
          // 日期标签
          Text(
            story.storyDate,
            style: GoogleFonts.notoSerifSc(
              fontSize: 13, color: AppTheme.textSecondary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: AppTheme.spacing3xl),

          // 故事正文
          Text(
            story.content,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSerifSc(
              fontSize: 15, height: 2.0,
              color: AppTheme.textPrimary,
            ),
          ),

          const SizedBox(height: AppTheme.spacing3xl),

          // 底部品牌线
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24, height: 0.5,
                color: AppTheme.textHint,
              ),
              const SizedBox(width: 12),
              Text(
                '回眸',
                style: GoogleFonts.notoSerifSc(
                  fontSize: 12, color: AppTheme.textHint,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 24, height: 0.5,
                color: AppTheme.textHint,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
