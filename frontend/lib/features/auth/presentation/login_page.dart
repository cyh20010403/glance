import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_router.dart';
import '../../../theme/app_theme.dart';
import '../domain/auth_state.dart';
import 'login_viewmodel.dart';

/// 登录页面
///
/// 支持两种模式：
/// - 底部弹出（`isFullScreen: false`，默认）
/// - 全屏（`isFullScreen: true`，用于返回重新登录）
///
/// 流程：
/// 1. 输入手机号 → 获取验证码（MVP: 任意 6 位数字）
/// 2. 输入验证码 → 登录
/// 3. 成功 → 跳转首页
final class LoginPage extends ConsumerStatefulWidget {
  final bool isFullScreen;
  const LoginPage({super.key, this.isFullScreen = false});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);

    // 登录成功 → 跳转首页
    ref.listen(loginViewModelProvider, (prev, next) {
      if (next is AuthSuccess) {
        context.go(AppRouter.home);
      }
    });

    final body = _buildBody(state);
    if (widget.isFullScreen) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(child: body),
      );
    }

    // 底部弹出模式
    return Container(
      padding: EdgeInsets.fromLTRB(
        28, 28, 28,
        28 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: body,
    );
  }

  Widget _buildBody(AuthState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 拖拽指示条（底部弹出模式）
        if (!widget.isFullScreen) ...[
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],

        const Text('手机号登录',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('首次登录将自动注册账号',
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
        const SizedBox(height: 28),

        // 手机号
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          enabled: state is! AuthCodeSent && state is! AuthLoading,
          decoration: const InputDecoration(
            hintText: '请输入手机号',
            prefixIcon:
                Icon(Icons.phone_iphone, color: AppTheme.textSecondary, size: 20),
            counterText: '',
          ),
        ),
        const SizedBox(height: AppTheme.spacingLg),

        // 验证码 + 获取验证码按钮
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                enabled: state is AuthCodeSent || state is AuthLoading,
                decoration: const InputDecoration(
                    hintText: '验证码', counterText: ''),
              ),
            ),
            const SizedBox(width: AppTheme.spacingMd),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: (state is AuthIdle || state is AuthError)
                    ? () => ref
                        .read(loginViewModelProvider.notifier)
                        .sendCode(_phoneController.text)
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 52),
                  backgroundColor: state is AuthCodeSent
                      ? AppTheme.border
                      : AppTheme.secondary,
                ),
                child: Text(
                  state is AuthCodeSent ? '已发送' : '获取验证码',
                  style: TextStyle(
                    fontSize: 14,
                    color: state is AuthCodeSent
                        ? AppTheme.textSecondary
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingMd),

        // 错误提示
        if (state is AuthError)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(state.message,
                style: const TextStyle(color: AppTheme.error, fontSize: 14)),
          ),

        // 登录按钮
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (state is AuthCodeSent && state is! AuthLoading)
                ? () => ref
                    .read(loginViewModelProvider.notifier)
                    .login(_codeController.text)
                : null,
            child: state is AuthLoading
                ? const SizedBox(
                    width: 20, height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text('登录 / 注册'),
          ),
        ),
        const SizedBox(height: AppTheme.spacingLg),

        // MVP 提示
        Center(
          child: Text(
            'MVP 阶段：任意 6 位数字即为有效验证码',
            style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary.withValues(alpha: 0.6)),
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),
      ],
    );
  }
}
