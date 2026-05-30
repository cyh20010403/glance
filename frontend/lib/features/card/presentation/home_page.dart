import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_router.dart';
import '../../../../theme/app_theme.dart';
import '../../auth/domain/auth_state.dart';
import '../../auth/presentation/login_page.dart';
import '../../match/data/match_repository.dart';
import '../domain/heart_card.dart';
import '../data/card_repository.dart';
import '../../mood/presentation/mood_selector.dart';
import '../../mood/presentation/mood_viewmodel.dart';
import '../../ceremony/domain/ceremony_data.dart';
import '../../match/data/match_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 首页 —「暮光手帖」风格
///
/// 暖黄纸页上记录每一次回眸。
/// 无 AppBar，用留白和字体层级构建呼吸感。
final class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _matchRepo = MatchRepository();
  final _cardRepo = CardRepository();
  Timer? _pollTimer;
  HeartCard? _activeCard;
  int _onlineCount = 0;
  final _notificationService = MatchNotificationService();
  StreamSubscription? _wsSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadActiveCard();
      _loadUserIdAndConnect();
      ref.read(moodViewModelProvider.notifier).loadMood();
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _wsSub?.cancel();
    _notificationService.disconnect();
    super.dispose();
  }

  Future<void> _loadActiveCard() async {
    try {
      final cards = await _cardRepo.fetchMyCards();
      if (mounted) {
        setState(() {
          _activeCard = cards.isNotEmpty ? cards.first : null;
          _onlineCount = cards.length + 5;
        });
      }
    } catch (_) {}
  }

  void _startPolling() { /* 降级保留 */ }

  Future<void> _loadUserIdAndConnect() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId != null) {
      _notificationService.connect(userId);
      _wsSub = _notificationService.notifications.listen((data) {
        if (!mounted) return;
        final matchId = data['matchId'] as int;
        _matchRepo.getCeremonyDetail(matchId).then((detail) {
          if (detail != null && mounted) {
            context.push(
              AppRouter.ceremony.replaceFirst(':matchId', matchId.toString()),
              extra: CeremonyData.fromJson(detail),
            );
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    if (!isLoggedIn) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(child: LoginPage(isFullScreen: true)),
      );
    }

    const sceneLabels = {
      'subway': '🚇 地铁', 'library': '📚 图书馆',
      'cafe': '☕ 咖啡店', 'campus': '🏫 校园', 'other': '📍 其他',
    };
    final scene = _activeCard?.scene ?? 'campus';
    final sceneLabel = sceneLabels[scene] ?? '🏫 校园';

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            // === 主内容滚动区 ===
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 48, 28, 120),
                child: Column(
                  children: [
                    // — 顶部品牌区 —
                    _buildHeader(),
                    const SizedBox(height: AppTheme.spacing3xl),

                    // — 场景 + 在线 —
                    _buildSceneChip(sceneLabel),
                    const SizedBox(height: AppTheme.spacingSm),
                    Text(
                      '此刻附近 $_onlineCount 人在线',
                      style: const TextStyle(
                        fontSize: 13, color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing2xl),

                    // — 情绪选择 —
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: MoodSelector(),
                    ),
                    const SizedBox(height: AppTheme.spacing4xl),

                    // — 核心区域：活跃卡片 或 空状态 —
                    if (_activeCard != null) ...[
                      _buildActiveCard(),
                    ] else ...[
                      _buildEmptyState(),
                    ],
                    const SizedBox(height: AppTheme.spacing2xl),

                    // — 创建按钮 —
                    if (_activeCard != null)
                      _buildTextAction('+ 创建新的心动卡片')
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ),

            // === 底部导航浮层 ===
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: _buildBottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  // ─── 顶部品牌区 ───

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          '回眸',
          style: GoogleFonts.notoSerifSc(
            fontSize: 32, fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          '所有故事，都始于一次回眸',
          style: GoogleFonts.notoSerifSc(
            fontSize: 13, color: AppTheme.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // ─── 场景指示 ───

  Widget _buildSceneChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.12), width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.notoSerifSc(
          fontSize: 16, fontWeight: FontWeight.w600,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  // ─── 空状态（无活跃卡片）───

  Widget _buildEmptyState() {
    return Column(
      children: [
        const SizedBox(height: AppTheme.spacing2xl),
        // 琥珀光晕装饰
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppTheme.accent.withValues(alpha: 0.15),
                AppTheme.accent.withValues(alpha: 0.02),
              ],
            ),
          ),
          child: const Center(
            child: Text('✨', style: TextStyle(fontSize: 32)),
          ),
        ),
        const SizedBox(height: AppTheme.spacing2xl),
        Text(
          '在人群中看到了\n让你心动的人？',
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSerifSc(
            fontSize: 20, fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary, height: 1.5,
          ),
        ),
        const SizedBox(height: AppTheme.spacingMd),
        const Text(
          '悄悄描述 TA，如果 TA 也在找你，你们会相遇',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14, color: AppTheme.textSecondary, height: 1.6,
          ),
        ),
        const SizedBox(height: AppTheme.spacing3xl),
        _buildCreateButton('写下一张心动卡片'),
      ],
    );
  }

  // ─── 活跃卡片 ───

  Widget _buildActiveCard() {
    final card = _activeCard!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppTheme.border, width: 0.5),
        boxShadow: AppTheme.shadowGlow,
      ),
      child: Column(
        children: [
          // 信封图标
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('💌', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          Text(
            '你的心动卡片',
            style: GoogleFonts.notoSerifSc(
              fontSize: 18, fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // 倒计时
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hourglass_bottom_rounded,
                size: 15,
                color: card.isExpiringSoon ? AppTheme.error : AppTheme.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                '剩余 ${card.remainingMinutes} 分钟',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: card.isExpiringSoon ? AppTheme.error : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingXl),

          // 卡片场景信息
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingXl),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: card.featureTags.take(4).map((tag) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Text(tag, style: const TextStyle(
                        fontSize: 11, color: AppTheme.textSecondary,
                      )),
                    ),
                  )).toList(),
                ),
                if (card.description.isNotEmpty) ...[
                  const SizedBox(height: AppTheme.spacingMd),
                  const Divider(color: AppTheme.border),
                  const SizedBox(height: AppTheme.spacingMd),
                  Text(
                    card.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerifSc(
                      fontSize: 15, height: 1.7,
                      color: AppTheme.textPrimary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: AppTheme.spacingMd),
          Text(
            '等待 TA 发现你…',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.accent.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ─── 主要按钮 ───

  Widget _buildCreateButton(String text) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () => context.push(AppRouter.createCard),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(text, style: GoogleFonts.notoSerifSc(
          fontSize: 16, fontWeight: FontWeight.w600,
          letterSpacing: 1,
        )),
      ),
    );
  }

  // ─── 文字操作 ───

  Widget _buildTextAction(String text) {
    return TextButton(
      onPressed: () => context.push(AppRouter.createCard),
      child: Text(text, style: GoogleFonts.notoSerifSc(
        fontSize: 14, color: AppTheme.textSecondary,
      )),
    );
  }

  // ─── 底部导航浮层 ───

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(28, 0, 28, 20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(color: AppTheme.border, width: 0.5),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.radar_rounded, '附近', () => context.push(AppRouter.nearby)),
          _navItem(Icons.auto_stories_rounded, '故事', () => context.push(AppRouter.story)),
          _navItem(Icons.edit_note_rounded, '卡片', () => context.push(AppRouter.createCard)),
          _navItem(Icons.person_outline_rounded, '我', () => context.push(AppRouter.profile)),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: AppTheme.textPrimary),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(
              fontSize: 10, color: AppTheme.textSecondary,
            )),
          ],
        ),
      ),
    );
  }
}
