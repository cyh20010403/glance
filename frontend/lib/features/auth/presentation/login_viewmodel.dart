import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../domain/auth_state.dart';
import '../data/auth_repository.dart';

final class LoginViewModel extends Notifier<AuthState> {
  final _repository = AuthRepository();

  @override
  AuthState build() => const AuthState.idle();

  Future<void> sendCode(String phone) async {
    if (state is AuthLoading) return;

    if (phone.length != 11) {
      state = AuthState.error(message: '请输入正确的手机号');
      return;
    }

    try {
      await _repository.sendCode(phone);
      state = AuthState.codeSent(phone: phone);
    } on ApiException catch (e) {
      state = AuthState.error(message: e.message);
    } on DioException catch (e) {
      state = AuthState.error(message: dioErrorMsg(e));
    } catch (e) {
      state = const AuthState.error(message: '网络异常');
    }
  }

  Future<void> login(String code) async {
    final current = state;
    if (current is! AuthCodeSent || current is AuthLoading) return;

    state = const AuthState.loading();

    try {
      final phone = current.phone;
      final data = await _repository.login(phone, code);
      state = AuthState.success(
        token: data['token'] as String,
        userId: data['userId'] as int,
        nickname: (data['nickname'] as String?) ?? '',
        isNewUser: (data['isNewUser'] as bool?) ?? false,
      );
      ref.read(isLoggedInProvider.notifier).state = true;
    } on ApiException catch (e) {
      state = AuthState.error(message: e.message);
    } on DioException catch (e) {
      state = AuthState.error(message: dioErrorMsg(e));
    } catch (e) {
      state = const AuthState.error(message: '网络异常');
    }
  }

  void reset() {
    state = const AuthState.idle();
  }
}

final loginViewModelProvider = NotifierProvider<LoginViewModel, AuthState>(
  LoginViewModel.new,
);
