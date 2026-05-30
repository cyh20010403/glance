import 'package:flutter_test/flutter_test.dart';
import 'package:glance/features/card/domain/heart_card.dart';

void main() {
  group('HeartCard Model', () {
    final sampleJson = {
      'id': 1,
      'userId': 10,
      'scene': 'campus',
      'sceneLabel': '',
      'location': '',
      'occurredAt': '2026-05-30T18:00:00',
      'topColor': '白色',
      'pantsColor': '蓝色',
      'glasses': 1,
      'hairstyle': '短发',
      'hasBag': 0,
      'shoeColor': '白色',
      'description': '你在窗边看书',
      'status': 1,
      'expireAt': '2026-05-30T18:30:00',
      'createdAt': '2026-05-30T18:00:00',
    };

    test('fromJson parses correctly', () {
      final card = HeartCard.fromJson(sampleJson);
      expect(card.id, 1);
      expect(card.scene, 'campus');
      expect(card.topColor, '白色');
      expect(card.glasses, 1);
      expect(card.description, '你在窗边看书');
    });

    test('sceneText returns correct emoji label', () {
      final card = HeartCard.fromJson(sampleJson);
      expect(card.sceneText, contains('校园'));
    });

    test('featureTags lists only non-empty features', () {
      final card = HeartCard.fromJson(sampleJson);
      final tags = card.featureTags;
      expect(tags.any((t) => t.contains('白色')), true);
      expect(tags.any((t) => t.contains('蓝色')), true);
      expect(tags.any((t) => t.contains('眼镜')), true);
      expect(tags.any((t) => t.contains('短发')), true);
      expect(tags.any((t) => t.contains('背包')), false); // hasBag=0
    });

    test('fromJson handles empty fields', () {
      final empty = HeartCard.fromJson({
        'id': 1, 'userId': 1, 'scene': 'cafe',
        'occurredAt': '2026-05-30T18:00:00',
        'expireAt': '2026-05-30T18:30:00',
        'createdAt': '2026-05-30T18:00:00',
      });
      expect(empty.topColor, '');
      expect(empty.description, '');
      expect(empty.featureTags, isEmpty);
    });
  });
}
