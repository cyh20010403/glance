import 'package:flutter_test/flutter_test.dart';
import 'package:glance/core/network/api_exception.dart';
import 'package:glance/core/network/dio_client.dart';
import 'package:dio/dio.dart';

void main() {
  group('dioErrorMsg', () {
    test('returns ApiException message directly', () {
      final ex = BusinessException('卡片不存在', code: 400);
      expect(dioErrorMsg(ex), '卡片不存在');
    });

    test('extracts message from DioException with ApiException', () {
      final apiEx = BusinessException('Token 过期', code: 401);
      final dioEx = DioException(
        requestOptions: RequestOptions(path: '/test'),
        error: apiEx,
      );
      expect(dioErrorMsg(dioEx), 'Token 过期');
    });

    test('returns fallback for unknown errors', () {
      expect(dioErrorMsg('random string'), '未知错误');
      final dioEx = DioException(
        requestOptions: RequestOptions(path: '/test'),
        error: 'some error',
      );
      expect(dioErrorMsg(dioEx), '网络异常，请稍后重试');
    });
  });

  group('ApiException subtypes', () {
    test('BusinessException has code', () {
      final ex = BusinessException('错误', code: 400);
      expect(ex.code, 400);
      expect(ex.message, '错误');
    });

    test('NetworkException has default message', () {
      const ex = NetworkException();
      expect(ex.message, contains('网络'));
    });

    test('TimeoutException has default message', () {
      const ex = TimeoutException();
      expect(ex.message, contains('超时'));
    });

    test('UnauthorizedException has default message', () {
      const ex = UnauthorizedException();
      expect(ex.message, contains('登录'));
    });
  });
}
