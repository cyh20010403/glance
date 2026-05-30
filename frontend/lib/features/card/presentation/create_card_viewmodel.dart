import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/card_state.dart';
import '../data/card_repository.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';

final class CreateCardViewModel extends Notifier<CreateCardState> {
  final _repository = CardRepository();

  @override
  CreateCardState build() => const CreateCardState.idle();

  Future<void> submit({
    required String scene,
    String sceneLabel = '',
    String location = '',
    String topColor = '',
    String pantsColor = '',
    int glasses = 0,
    String hairstyle = '',
    int hasBag = 0,
    String shoeColor = '',
    String description = '',
  }) async {
    state = const CreateCardState.submitting();
    try {
      final card = await _repository.createCard(
        scene: scene,
        sceneLabel: sceneLabel,
        location: location,
        occurredAt: DateTime.now().toIso8601String(),
        topColor: topColor,
        pantsColor: pantsColor,
        glasses: glasses,
        hairstyle: hairstyle,
        hasBag: hasBag,
        shoeColor: shoeColor,
        description: description,
      );
      state = CreateCardState.success(card: card);
    } on ApiException catch (e) {
      state = CreateCardState.error(message: e.message);
    } on DioException catch (e) {
      state = CreateCardState.error(message: dioErrorMsg(e));
    } catch (e) {
      state = const CreateCardState.error(message: '未知错误');
    }
  }

  void reset() {
    state = const CreateCardState.idle();
  }
}

final createCardViewModelProvider =
    NotifierProvider<CreateCardViewModel, CreateCardState>(
        CreateCardViewModel.new);
