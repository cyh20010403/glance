import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../core/network/dio_client.dart';
import 'dart:convert';

/// 我的形象设置页 — 设置自己的穿着特征
/// 用于匹配时比对：别人描述你的时候，和你的实际形象比对
final class MyLookPage extends ConsumerStatefulWidget {
  const MyLookPage({super.key});

  @override
  ConsumerState<MyLookPage> createState() => _MyLookPageState();
}

class _MyLookPageState extends ConsumerState<MyLookPage> {
  String _topColor = '', _pantsColor = '', _shoeColor = '', _hairstyle = '';
  bool _glasses = false, _hasBag = false;
  bool _loading = true, _saving = false;

  static const _colors = ['黑色', '白色', '灰色', '蓝色', '红色', '粉色', '黄色', '绿色', '棕色', '紫色'];
  static const _hairstyles = ['短发', '长发', '卷发', '马尾', '丸子头'];

  @override
  void initState() {
    super.initState();
    _loadLook();
  }

  Future<void> _loadLook() async {
    try {
      final resp = await DioClient.instance.get('/user/my-look');
      final d = resp.data['data'] as Map<String, dynamic>?;
      if (d != null && mounted) {
        setState(() {
          _topColor = d['myTopColor'] ?? '';
          _pantsColor = d['myPantsColor'] ?? '';
          _shoeColor = d['myShoeColor'] ?? '';
          _hairstyle = d['myHairstyle'] ?? '';
          _glasses = d['myGlasses'] == 1;
          _hasBag = d['myHasBag'] == 1;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await DioClient.instance.put('/user/my-look', data: jsonEncode({
        'myTopColor': _topColor, 'myPantsColor': _pantsColor,
        'myShoeColor': _shoeColor, 'myHairstyle': _hairstyle,
        'myGlasses': _glasses ? 1 : 2, 'myHasBag': _hasBag ? 1 : 2,
      }));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('形象已更新')),
        );
        context.pop();
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存失败')),
        );
      }
    }
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(child: CircularProgressIndicator(color: AppTheme.primary)),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('我的形象'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primary))
                : const Text('保存', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('设置你今天的样子，别人描述你的时候系统会进行比对',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
          const SizedBox(height: AppTheme.spacing2xl),
          _section('👔 上衣颜色'), const SizedBox(height: 8),
          _chipRow(_colors, _topColor, (v) => setState(() => _topColor = v), AppTheme.primary),
          const SizedBox(height: AppTheme.spacingXl),
          _section('👖 裤子颜色'), const SizedBox(height: 8),
          _chipRow(_colors, _pantsColor, (v) => setState(() => _pantsColor = v), AppTheme.primary),
          const SizedBox(height: AppTheme.spacingXl),
          _section('👟 鞋子颜色'), const SizedBox(height: 8),
          _chipRow(_colors, _shoeColor, (v) => setState(() => _shoeColor = v), AppTheme.primary),
          const SizedBox(height: AppTheme.spacingXl),
          _section('💇 发型'), const SizedBox(height: 8),
          _chipRow(_hairstyles, _hairstyle, (v) => setState(() => _hairstyle = v), AppTheme.accent),
          const SizedBox(height: AppTheme.spacingXl),
          Row(children: [
            _toggle('👓 我戴眼镜', _glasses, (v) => setState(() => _glasses = v)),
            const SizedBox(width: 24),
            _toggle('🎒 我背包', _hasBag, (v) => setState(() => _hasBag = v)),
          ]),
          const SizedBox(height: AppTheme.spacing3xl),
          const Text('💡 提示：匹配时，别人描述的特征会和你的实际形象比对，相符才能匹配成功',
              style: TextStyle(fontSize: 12, color: AppTheme.textHint)),
        ]),
      ),
    );
  }

  Widget _section(String t) => Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500));
  Widget _chipRow(List<String> opts, String cur, Function(String) sel, Color c) => Wrap(
    spacing: 8, runSpacing: 8,
    children: opts.map((o) => GestureDetector(
      onTap: () => sel(cur == o ? '' : o),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: cur == o ? c.withValues(alpha: 0.1) : AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(color: cur == o ? c : AppTheme.border, width: cur == o ? 1.5 : 1),
        ),
        child: Text(o, style: TextStyle(fontSize: 13, color: cur == o ? c : AppTheme.textPrimary,
            fontWeight: cur == o ? FontWeight.w600 : FontWeight.normal)),
      ),
    )).toList(),
  );
  Widget _toggle(String l, bool v, Function(bool) c) => Row(mainAxisSize: MainAxisSize.min, children: [
    SizedBox(width: 22, height: 22, child: Checkbox(
      value: v, onChanged: (x) => c(x ?? false),
      activeColor: AppTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    )),
    const SizedBox(width: 6),
    Text(l, style: const TextStyle(fontSize: 14)),
  ]);
}
