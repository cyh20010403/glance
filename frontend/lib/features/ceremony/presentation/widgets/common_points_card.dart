import 'package:flutter/material.dart';
import '../../../../../theme/app_theme.dart';

final class CommonPointsCard extends StatelessWidget {
  final List<String> points;
  const CommonPointsCard({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        children: [
          const Text('💫', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          const Text(
            '你们的共同点',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: points
                .map(
                  (p) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    ),
                    child: Text(
                      p,
                      style: const TextStyle(fontSize: 14, color: AppTheme.primary),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
