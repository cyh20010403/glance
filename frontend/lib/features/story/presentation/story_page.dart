import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../domain/glance_story.dart';
import '../domain/story_state.dart';
import 'story_viewmodel.dart';
import 'story_card.dart';

/// 回眸故事页面 — 展示今日故事 + 历史列表
final class StoryPage extends ConsumerStatefulWidget {
  const StoryPage({super.key});

  @override
  ConsumerState<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends ConsumerState<StoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(storyViewModelProvider.notifier).loadTodayStory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyViewModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('回眸故事'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => ref.read(storyViewModelProvider.notifier).loadHistory(),
            child: const Text('历史', style: TextStyle(color: AppTheme.primary)),
          ),
        ],
      ),
      body: switch (state) {
        StoryInitial() || StoryLoading() => const Center(
            child: CircularProgressIndicator(color: AppTheme.primary)),
        StoryTodayLoaded(:final story) => _buildToday(story),
        StoryHistoryLoaded(:final stories) => _buildHistory(stories),
        StoryError(:final message) => Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('😔', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(message, style: const TextStyle(color: AppTheme.textSecondary)),
            ]),
          ),
      },
    );
  }

  Widget _buildToday(GlanceStory? story) {
    if (story == null) {
      return const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('📭', style: TextStyle(fontSize: 56)),
          SizedBox(height: 16),
          Text('今天还没有回眸故事',
              style: TextStyle(fontSize: 16, color: AppTheme.textSecondary)),
          SizedBox(height: 8),
          Text('去创建一张心动卡片吧',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
        ]),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: StoryCard(story: story),
    );
  }

  Widget _buildHistory(List<GlanceStory> stories) {
    if (stories.isEmpty) {
      return const Center(child: Text('暂无历史故事',
          style: TextStyle(color: AppTheme.textSecondary)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stories.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: StoryCard(story: stories[i]),
      ),
    );
  }
}
