import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_theme.dart';
import '../../../../routes/app_router.dart';
import '../domain/ceremony_data.dart';
import 'widgets/score_ring.dart';
import 'widgets/common_points_card.dart';
import 'widgets/icebreaker_card.dart';

/// 匹配仪式页 —「暮光手帖」风格
///
/// 暖黄渐变背景 + 弹性心跳动画 + 层层浮现的仪式内容。
/// "你们互相回眸了" —— 是这一刻最好的注脚。
final class MatchCeremonyPage extends StatefulWidget {
  final CeremonyData data;
  const MatchCeremonyPage({super.key, required this.data});

  @override
  State<MatchCeremonyPage> createState() => _MatchCeremonyPageState();
}

class _MatchCeremonyPageState extends State<MatchCeremonyPage>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 3000),
    vsync: this,
  )..forward();

  late final _overallFade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.35, curve: Curves.easeOut),
  );

  late final _heartScale = Tween<double>(begin: 0.3, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.05, 0.5, curve: Curves.elasticOut),
    ),
  );

  late final _contentSlide = Tween<Offset>(
    begin: const Offset(0, 0.25), end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.25, 0.7, curve: Curves.easeOutCubic),
  ));

  late final _contentFade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF8EE),
              AppTheme.background,
              Color(0xFFFFFBF6),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _overallFade,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // — 心跳动画 —
                  ScaleTransition(
                    scale: _heartScale,
                    child: Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.accent.withValues(alpha: 0.12),
                            AppTheme.accent.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text('💞', style: TextStyle(fontSize: 44)),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing2xl),

                  // — 标题区 —
                  FadeTransition(
                    opacity: _contentFade,
                    child: SlideTransition(
                      position: _contentSlide,
                      child: Column(
                        children: [
                          Text(
                            '你们互相回眸了',
                            style: GoogleFonts.notoSerifSc(
                              fontSize: 26, fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingMd),
                          Text(
                            '${d.partnerNickname} 也注意到了你',
                            style: const TextStyle(
                              fontSize: 16, color: AppTheme.textSecondary,
                            ),
                          ),
                          if (d.partnerMood.isNotEmpty) ...[
                            const SizedBox(height: AppTheme.spacingSm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.accent.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                              ),
                              child: Text(
                                '对方的心情：${d.partnerMood}',
                                style: const TextStyle(
                                  fontSize: 13, color: AppTheme.accent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing3xl),

                  // — 缘分百分比 —
                  ScoreRing(percent: d.scorePercent),

                  const SizedBox(height: AppTheme.spacing2xl),

                  // — 共同点 —
                  if (d.commonPoints.isNotEmpty)
                    CommonPointsCard(points: d.commonPoints),

                  // — TA 眼中的你 —
                  if (d.yourLookInTheirEyes.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.spacingXl),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppTheme.spacingXl),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                        border: Border.all(color: AppTheme.border, width: 0.5),
                      ),
                      child: Column(children: [
                        Text('💌  TA 眼中的你',
                          style: GoogleFonts.notoSerifSc(
                            fontSize: 13, color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        Text(
                          d.yourLookInTheirEyes,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.notoSerifSc(
                            fontSize: 16, height: 1.6,
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ]),
                    ),
                  ],

                  // — 破冰提示 —
                  const SizedBox(height: AppTheme.spacingXl),
                  IcebreakerCard(text: d.icebreaker),

                  // — 按钮区 —
                  const SizedBox(height: AppTheme.spacing3xl),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(
                          AppRouter.chat.replaceFirst(
                            ':matchId', d.matchId.toString(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                        ),
                        elevation: 0,
                      ),
                      child: Text('开始对话', style: GoogleFonts.notoSerifSc(
                        fontSize: 16, fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      )),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  TextButton(
                    onPressed: () => context.go(AppRouter.home),
                    child: const Text('返回首页', style: TextStyle(
                      color: AppTheme.textSecondary,
                    )),
                  ),
                  const SizedBox(height: AppTheme.spacing2xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
