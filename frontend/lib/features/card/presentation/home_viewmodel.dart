import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/card_state.dart';
import '../data/card_repository.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';

final class HomeViewModel extends Notifier<CardListState> {
  final _repository = CardRepository();

  @override
  CardListState build() => const CardListState.idle();

  Future<void> loadCards() async {
    state = const CardListState.loading();
    try {
      final cards = await _repository.fetchNearbyCards();
      state = CardListState.loaded(cards: cards);
    } on ApiException catch (e) {
      state = CardListState.error(message: e.message);
    } on DioException catch (e) {
      state = CardListState.error(message: dioErrorMsg(e));
    } catch (e) {
      state = const CardListState.error(message: '加载失败');
    }
  }
}

final homeViewModelProvider =
    NotifierProvider<HomeViewModel, CardListState>(HomeViewModel.new);
