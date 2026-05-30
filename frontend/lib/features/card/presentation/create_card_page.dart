import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';
import '../../../../theme/app_theme.dart';
import '../../match/data/match_repository.dart';
import '../domain/card_state.dart';
import '../domain/heart_card.dart';
import 'create_card_viewmodel.dart';

/// 创建心动卡片页
///
/// 提交后进入等待状态，轮询检查匹配结果。
final class CreateCardPage extends ConsumerStatefulWidget {
  const CreateCardPage({super.key});

  @override
  ConsumerState<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends ConsumerState<CreateCardPage> {
  String _scene = 'campus';
  String _topColor = '';
  String _pantsColor = '';
  String _shoeColor = '';
  String _hairstyle = '';
  bool _hasGlasses = false;
  bool _hasBag = false;
  final _descController = TextEditingController();
  HeartCard? _createdCard;
  Timer? _pollTimer;
  final _matchRepo = MatchRepository();

  static const _scenes = [
    ('campus', '🏫', '校园'),
    ('subway', '🚇', '地铁'),
    ('library', '📚', '图书馆'),
    ('cafe', '☕', '咖啡店'),
    ('other', '📍', '其他'),
  ];
  static const _colors = ['黑色', '白色', '灰色', '蓝色', '红色', '粉色', '黄色', '绿色', '棕色', '紫色'];
  static const _hairstyles = ['短发', '长发', '卷发', '马尾', '丸子头'];

  @override
  void dispose() {
    _descController.dispose();
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    await ref.read(createCardViewModelProvider.notifier).submit(
      scene: _scene,
      topColor: _topColor,
      pantsColor: _pantsColor,
      shoeColor: _shoeColor,
      glasses: _hasGlasses ? 1 : 2,
      hairstyle: _hairstyle,
      hasBag: _hasBag ? 1 : 2,
      description: _descController.text,
    );
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 8), (_) async {
      if (!mounted) return;
      final result = await _matchRepo.checkMatch();
      if (result != null && mounted) {
        _pollTimer?.cancel();
        final match = result['match'];
        final partnerCard = result['partnerCard'];
        context.pushReplacement(AppRouter.match, extra: {
          'matchId': match['id'],
          'partnerCard': partnerCard,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createCardViewModelProvider);

    ref.listen(createCardViewModelProvider, (prev, next) {
      if (next is CreateCardSuccess) {
        setState(() => _createdCard = next.card);
        _startPolling();
      }
    });

    // 等待匹配页面
    if (_createdCard != null) return _buildWaiting();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('创建心动卡片'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _sectionTitle('📍 你在哪里遇见了 TA？'),
          const SizedBox(height: AppTheme.spacingMd),
          _chipRow(_scenes.map((s) => (
            selected: _scene == s.$1,
            label: '${s.$2} ${s.$3}',
            onTap: () => setState(() => _scene = s.$1),
          )).toList()),
          const SizedBox(height: AppTheme.spacing3xl),

          _sectionTitle('👔 TA 的穿着特征'),
          const SizedBox(height: AppTheme.spacingMd),
          _picker('上衣颜色', _topColor, _colors, (v) => setState(() => _topColor = v), AppTheme.primary),
          const SizedBox(height: AppTheme.spacingLg),
          _picker('裤子颜色', _pantsColor, _colors, (v) => setState(() => _pantsColor = v), AppTheme.primary),
          const SizedBox(height: AppTheme.spacingLg),
          _picker('鞋子颜色', _shoeColor, _colors, (v) => setState(() => _shoeColor = v), AppTheme.primary),
          const SizedBox(height: AppTheme.spacingLg),
          _picker('发型', _hairstyle, _hairstyles, (v) => setState(() => _hairstyle = v), AppTheme.accent),
          const SizedBox(height: AppTheme.spacingXl),
          Row(children: [
            _toggle('👓 戴眼镜', _hasGlasses, (v) => setState(() => _hasGlasses = v)),
            const SizedBox(width: AppTheme.spacing2xl),
            _toggle('🎒 背包', _hasBag, (v) => setState(() => _hasBag = v)),
          ]),
          const SizedBox(height: AppTheme.spacing3xl),

          _sectionTitle('💭 想对 TA 说点什么'),
          const SizedBox(height: AppTheme.spacingMd),
          TextField(
            controller: _descController,
            maxLength: 300,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: '比如："你刚刚一直在看窗外。"\n"你戴着黑框眼镜。"\n"你笑起来很好看。"',
            ),
          ),
          const SizedBox(height: AppTheme.spacing3xl),

          if (state is CreateCardError)
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingLg),
              child: Text(state.message, style: const TextStyle(color: AppTheme.error, fontSize: 14)),
            ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state is CreateCardSubmitting ? null : _submit,
              child: state is CreateCardSubmitting
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('💌 发布心动卡片'),
            ),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }

  Widget _buildWaiting() {
    final card = _createdCard!;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('💌', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 24),
              const Text('心动卡片已发布',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.timer_outlined, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text('有效期 ${card.remainingMinutes} 分钟',
                    style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              ]),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  boxShadow: AppTheme.shadowSm,
                ),
                child: Column(children: [
                  const SizedBox(width: 32, height: 32, child: CircularProgressIndicator(color: AppTheme.primary, strokeWidth: 2.5)),
                  const SizedBox(height: 20),
                  const Text('正在寻找彼此的频率…',
                      style: TextStyle(fontSize: 16, color: AppTheme.textPrimary)),
                  const SizedBox(height: 8),
                  Text(
                    '如果 TA 也在描述你，\n你们将自动匹配',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppTheme.textSecondary.withValues(alpha: 0.8)),
                  ),
                ]),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  _pollTimer?.cancel();
                  context.go(AppRouter.home);
                },
                child: const Text('回到首页', style: TextStyle(color: AppTheme.textSecondary)),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // === 组件 ===
  Widget _sectionTitle(String text) => Text(text,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.textPrimary));

  Widget _chipRow(List<({bool selected, String label, VoidCallback onTap})> chips) {
    return Wrap(spacing: 10, runSpacing: 10,
      children: chips.map((c) => _chip(c.label, c.selected, c.onTap, AppTheme.primary)).toList());
  }

  Widget _chip(String label, bool selected, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.1) : AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(color: selected ? color : AppTheme.border, width: selected ? 1.5 : 1),
        ),
        child: Text(label, style: TextStyle(fontSize: 14,
            color: selected ? color : AppTheme.textPrimary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      ),
    );
  }

  Widget _picker(String label, String current, List<String> options, Function(String) onSelect, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
      const SizedBox(height: AppTheme.spacingSm),
      Wrap(spacing: AppTheme.spacingSm, runSpacing: AppTheme.spacingSm,
        children: options.map((o) => _chip(o, current == o, () => onSelect(current == o ? '' : o), color)).toList()),
    ]);
  }

  Widget _toggle(String label, bool value, Function(bool) onChanged) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(width: 24, height: 24,
        child: Checkbox(
          value: value, onChanged: (v) => onChanged(v ?? false),
          activeColor: AppTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      const SizedBox(width: AppTheme.spacingSm),
      Text(label, style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary)),
    ]);
  }
}
