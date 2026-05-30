import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../auth/domain/auth_state.dart';
import '../data/profile_repository.dart';

/// 编辑个人资料页
final class ProfileEditPage extends ConsumerStatefulWidget {
  final String nickname;
  final String signature;
  const ProfileEditPage({super.key, required this.nickname, required this.signature});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  late final _nickCtrl = TextEditingController(text: widget.nickname);
  late final _sigCtrl = TextEditingController(text: widget.signature);
  bool _saving = false;

  @override
  void dispose() {
    _nickCtrl.dispose();
    _sigCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ProfileRepository().updateProfile(
        nickname: _nickCtrl.text,
        signature: _sigCtrl.text,
      );
      if (mounted) {
        // 更新全局昵称显示
        ref.read(isLoggedInProvider.notifier).state = true; // 触发刷新
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('编辑资料'),
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
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        children: [
          const Text('昵称', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
          const SizedBox(height: 8),
          TextField(
            controller: _nickCtrl,
            maxLength: 20,
            decoration: const InputDecoration(hintText: '你的昵称', counterText: ''),
          ),
          const SizedBox(height: AppTheme.spacing2xl),
          const Text('个性签名', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
          const SizedBox(height: 8),
          TextField(
            controller: _sigCtrl,
            maxLength: 100,
            maxLines: 3,
            decoration: const InputDecoration(hintText: '写一句话介绍自己...'),
          ),
        ],
      ),
    );
  }
}
