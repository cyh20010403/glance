import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_router.dart';
import '../../../theme/app_theme.dart';
import '../domain/auth_state.dart';
import 'login_viewmodel.dart';

/// 登录页面 —「暮光手帖」风格
///
/// 暖黄纸底上的简约登录，品牌标题 + 衬线字体。
final class LoginPage extends ConsumerStatefulWidget {
  final bool isFullScreen;
  const LoginPage({super.key, this.isFullScreen = false});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  late final _fadeIn = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 800),
  )..forward();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _fadeIn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);

    ref.listen(loginViewModelProvider, (prev, next) {
      if (next is AuthSuccess) context.go(AppRouter.home);
    });

    final body = FadeTransition(
      opacity: _fadeIn,
      child: _buildBody(state),
    );

    if (widget.isFullScreen) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(child: body),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(
        28, 28, 28,
        28 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusXl),
        ),
        border: const Border(
          top: BorderSide(color: AppTheme.border, width: 0.5),
        ),
      ),
      child: body,
    );
  }

  Widget _buildBody(AuthState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isFullScreen) ...[
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],

        Text('欢迎回眸',
          style: GoogleFonts.notoSerifSc(
            fontSize: 26, fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary, letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 6),
        Text('首次登录将自动注册账号',
          style: GoogleFonts.notoSerifSc(
            fontSize: 13, color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 32),

        // 手机号
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          enabled: state is! AuthCodeSent && state is! AuthLoading,
          style: const TextStyle(fontSize: 16, letterSpacing: 2),
          decoration: const InputDecoration(
            hintText: '请输入手机号',
            prefixIcon: Icon(Icons.phone_iphone, color: AppTheme.textSecondary, size: 20),
            counterText: '',
          ),
        ),
        const SizedBox(height: AppTheme.spacingLg),

        // 验证码
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                enabled: state is AuthCodeSent || state is AuthLoading,
                style: const TextStyle(fontSize: 16, letterSpacing: 4),
                decoration: const InputDecoration(
                  hintText: '验证码', counterText: '',
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingMd),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: (state is AuthIdle || state is AuthError)
                    ? () => ref.read(loginViewModelProvider.notifier).sendCode(_phoneController.text)
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 52),
                  backgroundColor: state is AuthCodeSent ? AppTheme.border : AppTheme.accent,
                  elevation: 0,
                ),
                child: Text(
                  state is AuthCodeSent ? '已发送' : '获取验证码',
                  style: TextStyle(
                    fontSize: 14,
                    color: state is AuthCodeSent ? AppTheme.textSecondary : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingMd),

        if (state is AuthError)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(state.message,
              style: const TextStyle(color: AppTheme.error, fontSize: 14)),
          ),

        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: (state is AuthCodeSent && state is! AuthLoading)
                ? () => ref.read(loginViewModelProvider.notifier).login(_codeController.text)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              disabledBackgroundColor: AppTheme.primary.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              ),
              elevation: 0,
            ),
            child: state is AuthLoading
                ? const SizedBox(
                    width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text('登录 / 注册',
                    style: GoogleFonts.notoSerifSc(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 2)),
          ),
        ),
        const SizedBox(height: AppTheme.spacingLg),

        Center(
          child: Text(
            'MVP 阶段：任意 6 位数字即为有效验证码',
            style: GoogleFonts.notoSerifSc(
              fontSize: 11, color: AppTheme.textSecondary.withValues(alpha: 0.5),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),
      ],
    );
  }
}
