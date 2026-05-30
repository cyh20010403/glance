import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../domain/nearby_state.dart';
import 'nearby_viewmodel.dart';

final class NearbyPage extends ConsumerStatefulWidget {
  const NearbyPage({super.key});

  @override
  ConsumerState<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends ConsumerState<NearbyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nearbyViewModelProvider.notifier).loadStats();
    });
  }

  static const _moodLabels = {
    'expect': '期待', 'miss': '想念', 'happy': '开心',
    'quiet': '安静', 'bored': '无聊',
  };

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nearbyViewModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('附近'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: switch (state) {
        NearbyInitial() || NearbyLoading() => const Center(
            child: CircularProgressIndicator(color: AppTheme.primary)),
        NearbyLoaded(:final onlineCount, :final moodDistribution) =>
          _buildContent(onlineCount, moodDistribution),
        NearbyError(:final message) => Center(
            child: Text(message, style: const TextStyle(color: AppTheme.textSecondary))),
      },
    );
  }

  Widget _buildContent(int count, Map<String, int> distribution) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          const Text('📍', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text('附近 $count 人在线',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          const Text('基于蓝牙近场感知，不显示精确位置',
              style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(height: 32),
          if (distribution.isNotEmpty) ...[
            const Text('他们的心情',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 16),
            ...distribution.entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(_moodLabels[e.key] ?? e.key,
                      style: const TextStyle(fontSize: 15)),
                  const SizedBox(width: 12),
                  Expanded(child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: count > 0 ? e.value / count : 0,
                      minHeight: 8,
                      backgroundColor: AppTheme.border,
                      valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                    ),
                  )),
                  const SizedBox(width: 8),
                  Text('${e.value}人',
                      style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            )),
          ] else ...[
            const Text('😴', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            const Text('附近暂时安静',
                style: TextStyle(color: AppTheme.textSecondary)),
          ],
        ],
      ),
    );
  }
}
