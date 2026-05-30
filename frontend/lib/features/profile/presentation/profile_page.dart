import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';
import '../../../../theme/app_theme.dart';
import '../../auth/domain/auth_state.dart';
import '../domain/profile_state.dart';
import 'profile_viewmodel.dart';

/// 个人页面
///
/// 展示用户信息、菜单入口、退出登录
final class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).loadProfile();
    });
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('退出', style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(profileViewModelProvider.notifier).logout();
      ref.read(isLoggedInProvider.notifier).state = false;
      if (mounted) context.go(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('我的')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        children: [
          // 头像 + 昵称
          _buildProfileHeader(state),
          const SizedBox(height: AppTheme.spacing3xl),

          // 互动
          _MenuSection(title: '我的互动', items: [
            _MenuItem(
              icon: Icons.favorite_border,
              label: '我的心动卡片',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.chat_bubble_outline,
              label: '聊天记录',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: AppTheme.spacingXl),

          // 设置
          _MenuSection(title: '我的形象', items: [
            _MenuItem(icon: Icons.face, label: '设置我的穿着形象', onTap: () => context.push(AppRouter.myLook)),
          ]),
          const SizedBox(height: AppTheme.spacingXl),
          _MenuSection(title: '设置', items: [
            _MenuItem(
              icon: Icons.security_outlined,
              label: '隐私设置',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.help_outline,
              label: '帮助与反馈',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.info_outline,
              label: '关于回眸',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: AppTheme.spacing3xl),

          // 退出登录
          Center(
            child: TextButton(
              onPressed: _logout,
              child: const Text('退出登录',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 15)),
            ),
          ),
          const SizedBox(height: AppTheme.spacingLg),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ProfileState state) {
    return Center(
      child: Column(
        children: switch (state) {
          ProfileIdle() || ProfileLoading() => [
              const SizedBox(height: 20),
              const CircularProgressIndicator(color: AppTheme.primary),
            ],
          ProfileLoaded(:final nickname, :final signature) => [
              Container(
                width: 80, height: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, AppTheme.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    nickname.isNotEmpty ? nickname.substring(0, 1) : '?',
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLg),
              Text(nickname,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: AppTheme.spacingXs),
              GestureDetector(
                onTap: () {
                  context.push(AppRouter.profileEdit, extra: {
                    'nickname': nickname,
                    'signature': signature,
                  });
                },
                child: const Text('点击编辑个人资料',
                    style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              ),
            ],
          _ => [const Text('加载失败')],
        },
      ),
    );
  }
}

/// 菜单分组
class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
            child: Text(title,
                style: const TextStyle(
                    fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
          ),
          ...items,
        ],
      ),
    );
  }
}

/// 菜单项
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary, size: 22),
      title: Text(label, style: const TextStyle(fontSize: 15, color: AppTheme.textPrimary)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: AppTheme.textHint),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18),
    );
  }
}
