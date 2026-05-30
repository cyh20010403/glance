import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';
import '../../../../theme/app_theme.dart';
import '../../auth/domain/auth_state.dart';
import '../../auth/presentation/login_page.dart';
import '../../match/data/match_repository.dart';
import '../domain/heart_card.dart';
import '../data/card_repository.dart';
import '../../mood/presentation/mood_selector.dart';
import '../../mood/presentation/mood_viewmodel.dart';

/// 首页 — 场景入口
///
/// PRD 7.1：附近在线人数 + 当前场景 + 创建心动卡片按钮
/// 不展示他人卡片，匹配发生在后台。
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadActiveCard();
      _startPolling();
      ref.read(moodViewModelProvider.notifier).loadMood();
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadActiveCard() async {
    try {
      final cards = await _cardRepo.fetchMyCards();
      if (mounted) {
        setState(() {
          _activeCard = cards.isNotEmpty ? cards.first : null;
          _onlineCount = cards.length + 5; // MVP: 模拟附近人数
        });
      }
    } catch (_) {}
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (!mounted) return;
      final result = await _matchRepo.checkMatch();
      if (result != null && mounted) {
        _pollTimer?.cancel();
        final match = result['match'];
        final partnerCard = result['partnerCard'];
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            context.push(AppRouter.match, extra: {
              'matchId': match['id'],
              'partnerCard': partnerCard,
            });
          }
        });
      }
    });
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
      appBar: AppBar(
        title: const Text('回眸'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_stories_outlined),
            tooltip: '回眸故事',
            onPressed: () => context.push(AppRouter.story),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRouter.profile),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 场景标识
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
                child: Text(
                  sceneLabel,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.primary),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '附近 $_onlineCount 人在线',
                style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: MoodSelector(),
              ),
              const SizedBox(height: 48),

              // 活跃卡片状态 或 引导
              if (_activeCard != null) ...[
                _buildActiveCard(),
              ] else ...[
                const Text('💫', style: TextStyle(fontSize: 56)),
                const SizedBox(height: 20),
                const Text(
                  '在人群中看到了让你心动的人？',
                  style: TextStyle(fontSize: 16, color: AppTheme.textPrimary),
                ),
                const SizedBox(height: 8),
                const Text(
                  '悄悄描述 TA，如果 TA 也在找你，你们会相遇',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 36),
                _buildCreateButton('💌 创建心动卡片'),
              ],
              const SizedBox(height: 24),

              // 如果已创建卡片，仍可再创建
              if (_activeCard != null) _buildCreateButton('+ 创建新的心动卡片'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveCard() {
    final card = _activeCard!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: [
          const Text('💌', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          const Text('你的心动卡片',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer_outlined, size: 16, color: AppTheme.textSecondary),
              const SizedBox(width: 4),
              Text(
                '剩余 ${card.remainingMinutes} 分钟',
                style: TextStyle(
                  fontSize: 14,
                  color: card.isExpiringSoon ? AppTheme.error : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '等待 TA 发现你…',
            style: TextStyle(
              fontSize: 15,
              color: AppTheme.primary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '如果 TA 也在描述你，你们将自动匹配',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.push(AppRouter.createCard),
        child: Text(text),
      ),
    );
  }
}
