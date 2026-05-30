import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../../routes/app_router.dart';
import '../domain/ceremony_data.dart';
import 'widgets/score_ring.dart';
import 'widgets/common_points_card.dart';
import 'widgets/icebreaker_card.dart';

/// 匹配仪式页面 — 粒子动画 + 共同点 + 缘分百分比 + 破冰提示
final class MatchCeremonyPage extends StatefulWidget {
  final CeremonyData data;
  const MatchCeremonyPage({super.key, required this.data});

  @override
  State<MatchCeremonyPage> createState() => _MatchCeremonyPageState();
}

class _MatchCeremonyPageState extends State<MatchCeremonyPage>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 2500),
    vsync: this,
  )..forward();

  late final _fadeIn = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.5, curve: Curves.easeOut),
  );

  late final _slideUp = Tween<Offset>(
    begin: const Offset(0, 0.3),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slideUp,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // 粒子动画占位（用 emoji + 缩放动画替代）
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.5, end: 1.0),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.elasticOut,
                    builder: (ctx, scale, _) => Transform.scale(
                      scale: scale,
                      child: const Text('💞', style: TextStyle(fontSize: 80)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '匹配成功！',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${d.partnerNickname} 也注意到了你',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  if (d.partnerMood.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      '对方的心情: ${d.partnerMood}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),
                  ScoreRing(percent: d.scorePercent),

                  const SizedBox(height: 24),
                  CommonPointsCard(points: d.commonPoints),

                  if (d.yourLookInTheirEyes.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '💌 TA 眼中的你',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            d.yourLookInTheirEyes,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  IcebreakerCard(text: d.icebreaker),

                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(
                          AppRouter.chat
                              .replaceFirst(':matchId', d.matchId.toString()),
                        );
                      },
                      child: const Text('💬 开始聊天'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go(AppRouter.home),
                    child: const Text(
                      '返回首页',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
