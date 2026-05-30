import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../theme/app_theme.dart';

/// 破冰提示卡片 — 暖黄底色，像便签纸
final class IcebreakerCard extends StatelessWidget {
  final String text;
  const IcebreakerCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingXl),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EE),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: AppTheme.accent.withValues(alpha: 0.15), width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wb_twilight_rounded,
                size: 17, color: AppTheme.accent,
              ),
              const SizedBox(width: 6),
              Text('破冰提示', style: GoogleFonts.notoSerifSc(
                fontSize: 13, fontWeight: FontWeight.w600,
                color: AppTheme.accent,
              )),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSerifSc(
              fontSize: 14, height: 1.7,
              color: AppTheme.textPrimary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
