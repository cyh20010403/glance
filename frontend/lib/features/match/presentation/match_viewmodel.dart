import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/match_state.dart';
import '../data/match_repository.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';

final class MatchViewModel extends Notifier<MatchState> {
  final _repository = MatchRepository();

  @override
  MatchState build() => const MatchState.idle();

  Future<void> tryMatch(int cardId) async {
    state = const MatchState.trying();
    try {
      final record = await _repository.tryMatch(cardId);
      if (record != null) {
        state = MatchState.matched(record: record);
      } else {
        state = const MatchState.pending(
          message: '心动卡片已发布，等待对方发现你 ✨',
        );
      }
    } on ApiException catch (e) {
      state = MatchState.error(message: e.message);
    } on DioException catch (e) {
      state = MatchState.error(message: dioErrorMsg(e));
    } catch (e) {
      state = MatchState.error(message: '未知错误');
    }
  }

  void reset() {
    state = const MatchState.idle();
  }
}

final matchViewModelProvider =
    NotifierProvider<MatchViewModel, MatchState>(MatchViewModel.new);
