import 'package:flutter/material.dart';
import '../../../../theme/app_theme.dart';
import '../../domain/heart_card.dart';

/// 心动卡片组件
///
/// 展示：场景标签 + 剩余时间 + 描述文本 + 特征标签 + 匹配按钮
final class CardItem extends StatelessWidget {
  final HeartCard card;
  final VoidCallback? onMatchTap;

  const CardItem({super.key, required this.card, this.onMatchTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingLg),
      padding: const EdgeInsets.all(AppTheme.spacingXl),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: AppTheme.spacingLg),
          _buildDescription(),
          if (card.featureTags.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacingLg),
            _buildFeatureTags(),
          ],
          const SizedBox(height: AppTheme.spacing2xl),
          _buildMatchButton(context),
        ],
      ),
    );
  }

  // === 头部：场景 + 时间 ===
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.secondary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          ),
          child: Text(card.sceneText,
              style: const TextStyle(
                  fontSize: 13, color: AppTheme.primary,
                  fontWeight: FontWeight.w500)),
        ),
        const Spacer(),
        Icon(Icons.timer_outlined,
            size: 14,
            color: card.isExpiringSoon
                ? AppTheme.error
                : AppTheme.textSecondary),
        const SizedBox(width: 4),
        Text(
          '${card.remainingMinutes}分钟',
          style: TextStyle(
            fontSize: 13,
            color: card.isExpiringSoon
                ? AppTheme.error
                : AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  // === 描述 ===
  Widget _buildDescription() {
    return Text(
      card.description.isNotEmpty ? card.description : '在${card.sceneText}遇见了你...',
      style: const TextStyle(
          fontSize: 16, height: 1.6, color: AppTheme.textPrimary),
    );
  }

  // === 特征标签 ===
  Widget _buildFeatureTags() {
    return Wrap(
      spacing: AppTheme.spacingSm,
      runSpacing: AppTheme.spacingSm,
      children: card.featureTags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: Text(tag,
              style: const TextStyle(
                  fontSize: 12, color: AppTheme.textSecondary)),
        );
      }).toList(),
    );
  }

  // === 匹配按钮 ===
  Widget _buildMatchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onMatchTap,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 44),
          backgroundColor: AppTheme.accent,
        ),
        child: const Text('💌 我也看到了 TA'),
      ),
    );
  }
}
