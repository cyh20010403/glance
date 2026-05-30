import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_theme.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/widgets/cartoon_avatar.dart';
import 'dart:convert';

/// 我的形象设置页 —「暮光手帖」风格
///
/// 顶部实时卡通预览 + 底部标签选择器。
/// 选择不同特征时，卡通形象即时变化。
final class MyLookPage extends ConsumerStatefulWidget {
  const MyLookPage({super.key});

  @override
  ConsumerState<MyLookPage> createState() => _MyLookPageState();
}

class _MyLookPageState extends ConsumerState<MyLookPage>
    with SingleTickerProviderStateMixin {
  String _topColor = '', _pantsColor = '', _shoeColor = '', _hairstyle = '';
  bool _glasses = false, _hasBag = false;
  bool _loading = true, _saving = false;
  late final _fadeIn = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 600),
  )..forward();

  static const _colors = [
    '黑色', '白色', '灰色', '蓝色', '红色', '粉色', '黄色', '绿色', '棕色', '紫色',
  ];
  static const _hairstyles = ['短发', '长发', '卷发', '马尾', '丸子头'];

  @override
  void initState() {
    super.initState();
    _loadLook();
  }

  @override
  void dispose() {
    _fadeIn.dispose();
    super.dispose();
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

  /// 是否设置了任何特征
  bool get _hasAnyFeature =>
      _topColor.isNotEmpty || _pantsColor.isNotEmpty || _shoeColor.isNotEmpty ||
      _hairstyle.isNotEmpty || _glasses || _hasBag;

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
        title: Text('我的形象', style: GoogleFonts.notoSerifSc(
          fontSize: 18, fontWeight: FontWeight.w600,
        )),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(width: 16, height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppTheme.primary))
                : Text('保存', style: GoogleFonts.notoSerifSc(
                    fontSize: 15, color: AppTheme.primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeIn,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingXl),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── 卡通形象实时预览 ──
            Center(
              child: Column(children: [
                Container(
                  width: 220,
                  padding: const EdgeInsets.all(AppTheme.spacingXl),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFF8EE), AppTheme.background],
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    border: Border.all(color: AppTheme.border, width: 0.5),
                    boxShadow: AppTheme.shadowSm,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOutBack,
                    child: CartoonAvatar(
                      key: ValueKey('$_topColor-$_pantsColor-$_shoeColor-$_hairstyle-$_glasses-$_hasBag'),
                      topColor: _topColor,
                      pantsColor: _pantsColor,
                      shoeColor: _shoeColor,
                      hairstyle: _hairstyle,
                      hasGlasses: _glasses,
                      hasBag: _hasBag,
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Text(
                  _hasAnyFeature ? '这就是你' : '设置你的形象',
                  style: GoogleFonts.notoSerifSc(
                    fontSize: 15, color: AppTheme.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ]),
            ),

            const SizedBox(height: AppTheme.spacing2xl),
            Text('设置你今天的样子\n别人描述你的时候，系统会和你的实际形象比对',
              style: GoogleFonts.notoSerifSc(
                fontSize: 13, color: AppTheme.textSecondary, height: 1.6,
              ),
            ),
            const SizedBox(height: AppTheme.spacing2xl),

            // ── 标签选择区 ──
            _section('👔 上衣颜色'),
            const SizedBox(height: 8),
            _chipRow(_colors, _topColor, (v) => setState(() => _topColor = v)),

            const SizedBox(height: AppTheme.spacingXl),
            _section('👖 裤子颜色'),
            const SizedBox(height: 8),
            _chipRow(_colors, _pantsColor, (v) => setState(() => _pantsColor = v)),

            const SizedBox(height: AppTheme.spacingXl),
            _section('👟 鞋子颜色'),
            const SizedBox(height: 8),
            _chipRow(_colors, _shoeColor, (v) => setState(() => _shoeColor = v)),

            const SizedBox(height: AppTheme.spacingXl),
            _section('💇 发型'),
            const SizedBox(height: 8),
            _chipRow(_hairstyles, _hairstyle, (v) => setState(() => _hairstyle = v)),

            const SizedBox(height: AppTheme.spacingXl),
            Row(children: [
              _toggle('👓 我戴眼镜', _glasses, (v) => setState(() => _glasses = v)),
              const SizedBox(width: 24),
              _toggle('🎒 我背包', _hasBag, (v) => setState(() => _hasBag = v)),
            ]),

            const SizedBox(height: AppTheme.spacing3xl),
            Text('💡 匹配时，别人描述的特征会和你的实际形象比对，相符才能匹配成功',
              style: GoogleFonts.notoSerifSc(
                fontSize: 12, color: AppTheme.textHint, height: 1.5,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _section(String t) => Text(t, style: GoogleFonts.notoSerifSc(
    fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.textPrimary,
  ));

  Widget _chipRow(List<String> opts, String cur, Function(String) sel) => Wrap(
    spacing: 8, runSpacing: 8,
    children: opts.map((o) => GestureDetector(
      onTap: () => sel(cur == o ? '' : o),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: cur == o
              ? CartoonAvatar.colorFromName(o).withValues(alpha: 0.18)
              : AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(
            color: cur == o ? CartoonAvatar.colorFromName(o) : AppTheme.border,
            width: cur == o ? 1.5 : 0.5,
          ),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 14, height: 14,
            decoration: BoxDecoration(
              color: CartoonAvatar.colorFromName(o),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black.withValues(alpha: 0.1), width: 0.5),
            ),
          ),
          const SizedBox(width: 6),
          Text(o, style: TextStyle(fontSize: 13,
            color: cur == o ? AppTheme.textPrimary : AppTheme.textPrimary,
            fontWeight: cur == o ? FontWeight.w600 : FontWeight.normal)),
        ]),
      ),
    )).toList(),
  );

  Widget _toggle(String l, bool v, Function(bool) c) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: 22, height: 22, child: Checkbox(
        value: v, onChanged: (x) => c(x ?? false),
        activeColor: AppTheme.primary,
        side: const BorderSide(color: AppTheme.border, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      )),
      const SizedBox(width: 6),
      Text(l, style: GoogleFonts.notoSerifSc(fontSize: 14, color: AppTheme.textPrimary)),
    ],
  );
}
