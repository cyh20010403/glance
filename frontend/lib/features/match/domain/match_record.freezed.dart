// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchRecord _$MatchRecordFromJson(Map<String, dynamic> json) {
  return _MatchRecord.fromJson(json);
}

/// @nodoc
mixin _$MatchRecord {
  int get id => throw _privateConstructorUsedError;
  int get cardAId => throw _privateConstructorUsedError;
  int get cardBId => throw _privateConstructorUsedError;
  int get userAId => throw _privateConstructorUsedError;
  int get userBId => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError; // 1-已匹配 2-已解除
  String get matchedAt => throw _privateConstructorUsedError;

  /// Serializes this MatchRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchRecordCopyWith<MatchRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchRecordCopyWith<$Res> {
  factory $MatchRecordCopyWith(
          MatchRecord value, $Res Function(MatchRecord) then) =
      _$MatchRecordCopyWithImpl<$Res, MatchRecord>;
  @useResult
  $Res call(
      {int id,
      int cardAId,
      int cardBId,
      int userAId,
      int userBId,
      int status,
      String matchedAt});
}

/// @nodoc
class _$MatchRecordCopyWithImpl<$Res, $Val extends MatchRecord>
    implements $MatchRecordCopyWith<$Res> {
  _$MatchRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cardAId = null,
    Object? cardBId = null,
    Object? userAId = null,
    Object? userBId = null,
    Object? status = null,
    Object? matchedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cardAId: null == cardAId
          ? _value.cardAId
          : cardAId // ignore: cast_nullable_to_non_nullable
              as int,
      cardBId: null == cardBId
          ? _value.cardBId
          : cardBId // ignore: cast_nullable_to_non_nullable
              as int,
      userAId: null == userAId
          ? _value.userAId
          : userAId // ignore: cast_nullable_to_non_nullable
              as int,
      userBId: null == userBId
          ? _value.userBId
          : userBId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      matchedAt: null == matchedAt
          ? _value.matchedAt
          : matchedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchRecordImplCopyWith<$Res>
    implements $MatchRecordCopyWith<$Res> {
  factory _$$MatchRecordImplCopyWith(
          _$MatchRecordImpl value, $Res Function(_$MatchRecordImpl) then) =
      __$$MatchRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int cardAId,
      int cardBId,
      int userAId,
      int userBId,
      int status,
      String matchedAt});
}

/// @nodoc
class __$$MatchRecordImplCopyWithImpl<$Res>
    extends _$MatchRecordCopyWithImpl<$Res, _$MatchRecordImpl>
    implements _$$MatchRecordImplCopyWith<$Res> {
  __$$MatchRecordImplCopyWithImpl(
      _$MatchRecordImpl _value, $Res Function(_$MatchRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cardAId = null,
    Object? cardBId = null,
    Object? userAId = null,
    Object? userBId = null,
    Object? status = null,
    Object? matchedAt = null,
  }) {
    return _then(_$MatchRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cardAId: null == cardAId
          ? _value.cardAId
          : cardAId // ignore: cast_nullable_to_non_nullable
              as int,
      cardBId: null == cardBId
          ? _value.cardBId
          : cardBId // ignore: cast_nullable_to_non_nullable
              as int,
      userAId: null == userAId
          ? _value.userAId
          : userAId // ignore: cast_nullable_to_non_nullable
              as int,
      userBId: null == userBId
          ? _value.userBId
          : userBId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      matchedAt: null == matchedAt
          ? _value.matchedAt
          : matchedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchRecordImpl extends _MatchRecord {
  const _$MatchRecordImpl(
      {required this.id,
      required this.cardAId,
      required this.cardBId,
      required this.userAId,
      required this.userBId,
      this.status = 1,
      required this.matchedAt})
      : super._();

  factory _$MatchRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchRecordImplFromJson(json);

  @override
  final int id;
  @override
  final int cardAId;
  @override
  final int cardBId;
  @override
  final int userAId;
  @override
  final int userBId;
  @override
  @JsonKey()
  final int status;
// 1-已匹配 2-已解除
  @override
  final String matchedAt;

  @override
  String toString() {
    return 'MatchRecord(id: $id, cardAId: $cardAId, cardBId: $cardBId, userAId: $userAId, userBId: $userBId, status: $status, matchedAt: $matchedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cardAId, cardAId) || other.cardAId == cardAId) &&
            (identical(other.cardBId, cardBId) || other.cardBId == cardBId) &&
            (identical(other.userAId, userAId) || other.userAId == userAId) &&
            (identical(other.userBId, userBId) || other.userBId == userBId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.matchedAt, matchedAt) ||
                other.matchedAt == matchedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, cardAId, cardBId, userAId, userBId, status, matchedAt);

  /// Create a copy of MatchRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchRecordImplCopyWith<_$MatchRecordImpl> get copyWith =>
      __$$MatchRecordImplCopyWithImpl<_$MatchRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchRecordImplToJson(
      this,
    );
  }
}

abstract class _MatchRecord extends MatchRecord {
  const factory _MatchRecord(
      {required final int id,
      required final int cardAId,
      required final int cardBId,
      required final int userAId,
      required final int userBId,
      final int status,
      required final String matchedAt}) = _$MatchRecordImpl;
  const _MatchRecord._() : super._();

  factory _MatchRecord.fromJson(Map<String, dynamic> json) =
      _$MatchRecordImpl.fromJson;

  @override
  int get id;
  @override
  int get cardAId;
  @override
  int get cardBId;
  @override
  int get userAId;
  @override
  int get userBId;
  @override
  int get status; // 1-已匹配 2-已解除
  @override
  String get matchedAt;

  /// Create a copy of MatchRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchRecordImplCopyWith<_$MatchRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
