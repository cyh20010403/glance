import 'package:freezed_annotation/freezed_annotation.dart';
import 'heart_card.dart';

part 'card_state.freezed.dart';

/// 卡片列表状态
@freezed
sealed class CardListState with _$CardListState {
  const factory CardListState.idle() = CardListIdle;
  const factory CardListState.loading() = CardListLoading;
  const factory CardListState.loaded({required List<HeartCard> cards}) = CardListLoaded;
  const factory CardListState.error({required String message}) = CardListError;
}

/// 创建卡片状态
@freezed
sealed class CreateCardState with _$CreateCardState {
  const factory CreateCardState.idle() = CreateCardIdle;
  const factory CreateCardState.submitting() = CreateCardSubmitting;
  const factory CreateCardState.success({required HeartCard card}) = CreateCardSuccess;
  const factory CreateCardState.error({required String message}) = CreateCardError;
}
