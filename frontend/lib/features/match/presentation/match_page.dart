import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';
import '../../../../theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/dio_client.dart';

/// 匹配成功页面 — 展示对方匿名资料 + TA 对你的描述 + 开始聊天
final class MatchPage extends ConsumerStatefulWidget {
  final int? matchId;
  final Map<String, dynamic>? partnerCard;
  const MatchPage({super.key, this.matchId, this.partnerCard});

  @override
  ConsumerState<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends ConsumerState<MatchPage>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 1200),
    vsync: this,
  )..forward();

  late final _fadeIn = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.6, curve: Curves.easeOut),
  );

  late final _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ),
  );

  Map<String, dynamic>? _partner;
  Map<String, dynamic>? _partnerCard;

  @override
  void initState() {
    super.initState();
    _partnerCard = widget.partnerCard;
    if (widget.matchId != null) _loadMatchInfo();
  }

  Future<void> _loadMatchInfo() async {
    try {
      final dio = DioClient.instance;
      final matchResp = await dio.get('/matches');
      final matches = (matchResp.data['data'] as List)
          .map((m) => m as Map<String, dynamic>).toList();
      final match = matches.firstWhere(
        (m) => m['id'] == widget.matchId,
        orElse: () => <String, dynamic>{},
      );
      final myUserId = await _getMyUserId();
      final partnerId = match['userAId'] == myUserId
          ? match['userBId'] : match['userAId'];
      if (partnerId != null) {
        final userResp = await dio.get('/user/$partnerId/profile');
        if (userResp.data['data'] != null && mounted) {
          setState(() => _partner = userResp.data['data'] as Map<String, dynamic>);
        }
      }
    } catch (_) {}
  }

  Future<int?> _getMyUserId() async {
    final prefs = await SharedPreferencesHelper.instance();
    return prefs.getInt('userId');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 生成特征描述文案
  String _buildFeatureText(Map<String, dynamic> card) {
    final parts = <String>[];
    if (card['topColor']?.toString().isNotEmpty == true) parts.add('${card['topColor']}上衣');
    if (card['pantsColor']?.toString().isNotEmpty == true) parts.add('${card['pantsColor']}裤子');
    if (card['hairstyle']?.toString().isNotEmpty == true) parts.add(card['hairstyle']);
    if (card['glasses'] == 1) parts.add('戴眼镜');
    if (card['hasBag'] == 1) parts.add('背书包');
    if (card['shoeColor']?.toString().isNotEmpty == true) parts.add('${card['shoeColor']}鞋');
    if (parts.isEmpty) return '';
    return parts.join('、');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: ScaleTransition(
            scale: _scale,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('💞', style: TextStyle(fontSize: 72)),
                    const SizedBox(height: 28),
                    const Text('匹配成功！',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary)),
                    const SizedBox(height: 8),
                    Text(
                      _partner != null
                          ? '${_partner!['nickname']} 也注意到了你'
                          : 'TA 也刚刚注意到了你',
                      style: const TextStyle(fontSize: 16, color: AppTheme.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    const Text('缘分就此开始',
                        style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),

                    // TA 是如何描述你的（情绪核心）
                    if (_partnerCard != null) ...[
                      const SizedBox(height: 28),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                          boxShadow: AppTheme.shadowMd,
                        ),
                        child: Column(children: [
                          const Text('💌', style: TextStyle(fontSize: 24)),
                          const SizedBox(height: 8),
                          const Text('TA 眼中的你',
                              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                          const SizedBox(height: 12),

                          // 特征标签
                          if (_buildFeatureText(_partnerCard!).isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                _buildFeatureText(_partnerCard!),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 15, color: AppTheme.primary,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                          // 文本描述
                          if (_partnerCard!['description']?.toString().isNotEmpty == true)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.background,
                                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                              ),
                              child: Text(
                                '${_partnerCard!['description']}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, height: 1.6,
                                    color: AppTheme.textPrimary,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                        ]),
                      ),
                    ],

                    // 对方资料
                    if (_partner != null) ...[
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.secondary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.person, size: 16, color: AppTheme.textSecondary),
                          const SizedBox(width: 6),
                          Text(_partner!['nickname'] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                          if (_partner!['tags']?.toString().isNotEmpty == true) ...[
                            const SizedBox(width: 8),
                            ...(_partner!['tags'].toString().split(','))
                                .where((t) => t.trim().isNotEmpty)
                                .take(3)
                                .map((tag) => Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: Text('#$tag', style: const TextStyle(
                                          fontSize: 11, color: AppTheme.primary)),
                                    )),
                          ],
                        ]),
                      ),
                    ],

                    const SizedBox(height: 36),
                    if (widget.matchId != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(AppRouter.chat
                                .replaceFirst(':matchId', widget.matchId.toString()));
                          },
                          child: const Text('💬 开始聊天'),
                        ),
                      ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => context.go(AppRouter.home),
                      child: const Text('返回首页',
                          style: TextStyle(color: AppTheme.textSecondary)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SharedPreferencesHelper {
  static SharedPreferences? _prefs;
  static Future<SharedPreferences> instance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }
}
