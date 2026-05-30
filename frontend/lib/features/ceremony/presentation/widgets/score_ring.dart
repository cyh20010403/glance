import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../theme/app_theme.dart';

/// 缘分百分比环形图 — 琥珀色调
final class ScoreRing extends StatelessWidget {
  final int percent;
  const ScoreRing({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130, height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.accent.withValues(alpha: 0.06),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120, height: 120,
            child: CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: 5,
              backgroundColor: AppTheme.border,
              valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$percent%',
                style: GoogleFonts.notoSerifSc(
                  fontSize: 32, fontWeight: FontWeight.bold,
                  color: AppTheme.accent,
                ),
              ),
              Text('缘分',
                style: GoogleFonts.notoSerifSc(
                  fontSize: 13, color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
