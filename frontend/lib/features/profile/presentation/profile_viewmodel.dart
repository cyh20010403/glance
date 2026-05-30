import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/profile_state.dart';
import '../data/profile_repository.dart';
import '../../../core/network/api_exception.dart';

/// 个人页 ViewModel
final class ProfileViewModel extends Notifier<ProfileState> {
  final _repository = ProfileRepository();

  @override
  ProfileState build() => const ProfileState.idle();

  /// 加载本地用户信息
  Future<void> loadProfile() async {
    state = const ProfileState.loading();
    try {
      final profile = await _repository.getLocalProfile();
      state = ProfileState.loaded(
        nickname: profile.nickname,
        signature: profile.signature,
      );
    } catch (e) {
      state = const ProfileState.error(message: '加载失败');
    }
  }

  /// 举报用户
  Future<void> report(int targetId, String reason, String detail) async {
    try {
      await _repository.reportUser(
          targetId: targetId, reason: reason, detail: detail);
      state = const ProfileState.actionSuccess(message: '举报已提交');
    } on ApiException catch (e) {
      state = ProfileState.error(message: e.message);
    }
  }

  /// 拉黑用户
  Future<void> block(int targetId) async {
    try {
      await _repository.blockUser(targetId);
      state = const ProfileState.actionSuccess(message: '已拉黑');
    } on ApiException catch (e) {
      state = ProfileState.error(message: e.message);
    }
  }

  /// 退出登录
  Future<void> logout() async {
    await _repository.logout();
  }

  void reset() => state = const ProfileState.idle();
}

/// ProfileViewModel Provider
final profileViewModelProvider =
    NotifierProvider<ProfileViewModel, ProfileState>(ProfileViewModel.new);
