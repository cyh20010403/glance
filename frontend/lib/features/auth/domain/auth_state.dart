import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/auth_repository.dart';

part 'auth_state.freezed.dart';

/// 全局登录状态 Provider — HomePage 和 LoginPage 共享
final isLoggedInProvider = StateProvider<bool>((ref) => false);

/// 登录流程状态
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.idle() = AuthIdle;
  const factory AuthState.codeSent({required String phone}) = AuthCodeSent;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success({
    required String token,
    required int userId,
    required String nickname,
    required bool isNewUser,
  }) = AuthSuccess;
  const factory AuthState.error({required String message}) = AuthError;
}

/// 启动时检查是否已登录
final authInitProvider = FutureProvider<bool>((ref) async {
  final loggedIn = await AuthRepository.isLoggedIn();
  if (loggedIn) {
    ref.read(isLoggedInProvider.notifier).state = true;
  }
  return loggedIn;
});
