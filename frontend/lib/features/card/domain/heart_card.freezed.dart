// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'heart_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HeartCard _$HeartCardFromJson(Map<String, dynamic> json) {
  return _HeartCard.fromJson(json);
}

/// @nodoc
mixin _$HeartCard {
  String get imageUrl => throw _privateConstructorUsedError;
  double get matchScore => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get scene => throw _privateConstructorUsedError;
  String get sceneLabel => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get occurredAt => throw _privateConstructorUsedError;
  String get topColor => throw _privateConstructorUsedError;
  String get pantsColor => throw _privateConstructorUsedError;
  int get glasses => throw _privateConstructorUsedError; // 0-未知 1-有 2-无
  String get hairstyle => throw _privateConstructorUsedError;
  int get hasBag => throw _privateConstructorUsedError; // 0-未知 1-有 2-无
  String get shoeColor => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError; // 1-有效 2-已匹配 3-已过期
  String get expireAt => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this HeartCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HeartCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HeartCardCopyWith<HeartCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeartCardCopyWith<$Res> {
  factory $HeartCardCopyWith(HeartCard value, $Res Function(HeartCard) then) =
      _$HeartCardCopyWithImpl<$Res, HeartCard>;
  @useResult
  $Res call(
      {String imageUrl,
      double matchScore,
      int id,
      int userId,
      String scene,
      String sceneLabel,
      String location,
      String occurredAt,
      String topColor,
      String pantsColor,
      int glasses,
      String hairstyle,
      int hasBag,
      String shoeColor,
      String description,
      int status,
      String expireAt,
      String createdAt});
}

/// @nodoc
class _$HeartCardCopyWithImpl<$Res, $Val extends HeartCard>
    implements $HeartCardCopyWith<$Res> {
  _$HeartCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HeartCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? matchScore = null,
    Object? id = null,
    Object? userId = null,
    Object? scene = null,
    Object? sceneLabel = null,
    Object? location = null,
    Object? occurredAt = null,
    Object? topColor = null,
    Object? pantsColor = null,
    Object? glasses = null,
    Object? hairstyle = null,
    Object? hasBag = null,
    Object? shoeColor = null,
    Object? description = null,
    Object? status = null,
    Object? expireAt = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      scene: null == scene
          ? _value.scene
          : scene // ignore: cast_nullable_to_non_nullable
              as String,
      sceneLabel: null == sceneLabel
          ? _value.sceneLabel
          : sceneLabel // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as String,
      topColor: null == topColor
          ? _value.topColor
          : topColor // ignore: cast_nullable_to_non_nullable
              as String,
      pantsColor: null == pantsColor
          ? _value.pantsColor
          : pantsColor // ignore: cast_nullable_to_non_nullable
              as String,
      glasses: null == glasses
          ? _value.glasses
          : glasses // ignore: cast_nullable_to_non_nullable
              as int,
      hairstyle: null == hairstyle
          ? _value.hairstyle
          : hairstyle // ignore: cast_nullable_to_non_nullable
              as String,
      hasBag: null == hasBag
          ? _value.hasBag
          : hasBag // ignore: cast_nullable_to_non_nullable
              as int,
      shoeColor: null == shoeColor
          ? _value.shoeColor
          : shoeColor // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      expireAt: null == expireAt
          ? _value.expireAt
          : expireAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HeartCardImplCopyWith<$Res>
    implements $HeartCardCopyWith<$Res> {
  factory _$$HeartCardImplCopyWith(
          _$HeartCardImpl value, $Res Function(_$HeartCardImpl) then) =
      __$$HeartCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String imageUrl,
      double matchScore,
      int id,
      int userId,
      String scene,
      String sceneLabel,
      String location,
      String occurredAt,
      String topColor,
      String pantsColor,
      int glasses,
      String hairstyle,
      int hasBag,
      String shoeColor,
      String description,
      int status,
      String expireAt,
      String createdAt});
}

/// @nodoc
class __$$HeartCardImplCopyWithImpl<$Res>
    extends _$HeartCardCopyWithImpl<$Res, _$HeartCardImpl>
    implements _$$HeartCardImplCopyWith<$Res> {
  __$$HeartCardImplCopyWithImpl(
      _$HeartCardImpl _value, $Res Function(_$HeartCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of HeartCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? matchScore = null,
    Object? id = null,
    Object? userId = null,
    Object? scene = null,
    Object? sceneLabel = null,
    Object? location = null,
    Object? occurredAt = null,
    Object? topColor = null,
    Object? pantsColor = null,
    Object? glasses = null,
    Object? hairstyle = null,
    Object? hasBag = null,
    Object? shoeColor = null,
    Object? description = null,
    Object? status = null,
    Object? expireAt = null,
    Object? createdAt = null,
  }) {
    return _then(_$HeartCardImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      scene: null == scene
          ? _value.scene
          : scene // ignore: cast_nullable_to_non_nullable
              as String,
      sceneLabel: null == sceneLabel
          ? _value.sceneLabel
          : sceneLabel // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as String,
      topColor: null == topColor
          ? _value.topColor
          : topColor // ignore: cast_nullable_to_non_nullable
              as String,
      pantsColor: null == pantsColor
          ? _value.pantsColor
          : pantsColor // ignore: cast_nullable_to_non_nullable
              as String,
      glasses: null == glasses
          ? _value.glasses
          : glasses // ignore: cast_nullable_to_non_nullable
              as int,
      hairstyle: null == hairstyle
          ? _value.hairstyle
          : hairstyle // ignore: cast_nullable_to_non_nullable
              as String,
      hasBag: null == hasBag
          ? _value.hasBag
          : hasBag // ignore: cast_nullable_to_non_nullable
              as int,
      shoeColor: null == shoeColor
          ? _value.shoeColor
          : shoeColor // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      expireAt: null == expireAt
          ? _value.expireAt
          : expireAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HeartCardImpl extends _HeartCard {
  const _$HeartCardImpl(
      {this.imageUrl = '',
      this.matchScore = 0.0,
      required this.id,
      required this.userId,
      required this.scene,
      this.sceneLabel = '',
      this.location = '',
      required this.occurredAt,
      this.topColor = '',
      this.pantsColor = '',
      this.glasses = 0,
      this.hairstyle = '',
      this.hasBag = 0,
      this.shoeColor = '',
      this.description = '',
      this.status = 1,
      required this.expireAt,
      required this.createdAt})
      : super._();

  factory _$HeartCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeartCardImplFromJson(json);

  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final double matchScore;
  @override
  final int id;
  @override
  final int userId;
  @override
  final String scene;
  @override
  @JsonKey()
  final String sceneLabel;
  @override
  @JsonKey()
  final String location;
  @override
  final String occurredAt;
  @override
  @JsonKey()
  final String topColor;
  @override
  @JsonKey()
  final String pantsColor;
  @override
  @JsonKey()
  final int glasses;
// 0-未知 1-有 2-无
  @override
  @JsonKey()
  final String hairstyle;
  @override
  @JsonKey()
  final int hasBag;
// 0-未知 1-有 2-无
  @override
  @JsonKey()
  final String shoeColor;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int status;
// 1-有效 2-已匹配 3-已过期
  @override
  final String expireAt;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'HeartCard(imageUrl: $imageUrl, matchScore: $matchScore, id: $id, userId: $userId, scene: $scene, sceneLabel: $sceneLabel, location: $location, occurredAt: $occurredAt, topColor: $topColor, pantsColor: $pantsColor, glasses: $glasses, hairstyle: $hairstyle, hasBag: $hasBag, shoeColor: $shoeColor, description: $description, status: $status, expireAt: $expireAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeartCardImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.scene, scene) || other.scene == scene) &&
            (identical(other.sceneLabel, sceneLabel) ||
                other.sceneLabel == sceneLabel) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt) &&
            (identical(other.topColor, topColor) ||
                other.topColor == topColor) &&
            (identical(other.pantsColor, pantsColor) ||
                other.pantsColor == pantsColor) &&
            (identical(other.glasses, glasses) || other.glasses == glasses) &&
            (identical(other.hairstyle, hairstyle) ||
                other.hairstyle == hairstyle) &&
            (identical(other.hasBag, hasBag) || other.hasBag == hasBag) &&
            (identical(other.shoeColor, shoeColor) ||
                other.shoeColor == shoeColor) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expireAt, expireAt) ||
                other.expireAt == expireAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      imageUrl,
      matchScore,
      id,
      userId,
      scene,
      sceneLabel,
      location,
      occurredAt,
      topColor,
      pantsColor,
      glasses,
      hairstyle,
      hasBag,
      shoeColor,
      description,
      status,
      expireAt,
      createdAt);

  /// Create a copy of HeartCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeartCardImplCopyWith<_$HeartCardImpl> get copyWith =>
      __$$HeartCardImplCopyWithImpl<_$HeartCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HeartCardImplToJson(
      this,
    );
  }
}

abstract class _HeartCard extends HeartCard {
  const factory _HeartCard(
      {final String imageUrl,
      final double matchScore,
      required final int id,
      required final int userId,
      required final String scene,
      final String sceneLabel,
      final String location,
      required final String occurredAt,
      final String topColor,
      final String pantsColor,
      final int glasses,
      final String hairstyle,
      final int hasBag,
      final String shoeColor,
      final String description,
      final int status,
      required final String expireAt,
      required final String createdAt}) = _$HeartCardImpl;
  const _HeartCard._() : super._();

  factory _HeartCard.fromJson(Map<String, dynamic> json) =
      _$HeartCardImpl.fromJson;

  @override
  String get imageUrl;
  @override
  double get matchScore;
  @override
  int get id;
  @override
  int get userId;
  @override
  String get scene;
  @override
  String get sceneLabel;
  @override
  String get location;
  @override
  String get occurredAt;
  @override
  String get topColor;
  @override
  String get pantsColor;
  @override
  int get glasses; // 0-未知 1-有 2-无
  @override
  String get hairstyle;
  @override
  int get hasBag; // 0-未知 1-有 2-无
  @override
  String get shoeColor;
  @override
  String get description;
  @override
  int get status; // 1-有效 2-已匹配 3-已过期
  @override
  String get expireAt;
  @override
  String get createdAt;

  /// Create a copy of HeartCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeartCardImplCopyWith<_$HeartCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
