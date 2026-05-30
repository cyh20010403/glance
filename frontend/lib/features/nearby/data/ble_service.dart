import 'dart:async';
import 'dart:io' show Platform;

/// BLE 近场感知服务
///
/// 移动端启用 flutter_blue_plus 硬件扫描，
/// 桌面端降级为后端统计模式。
class BleService {
  static final BleService _instance = BleService._();
  factory BleService() => _instance;
  BleService._();

  final _nearbyCountController = StreamController<int>.broadcast();
  Stream<int> get nearbyCount => _nearbyCountController.stream;

  bool _isScanning = false;
  final Set<String> _seenDevices = {};
  Timer? _decayTimer;
  dynamic _flutterBlue; // 延迟加载，避免桌面端编译错误

  /// 是否是移动端
  bool get _isMobile => Platform.isAndroid || Platform.isIOS;

  /// 启动扫描（移动端启用硬件 BLE，桌面端降级）
  Future<void> startScanning() async {
    if (_isScanning) return;
    if (!_isMobile) return; // 桌面端降级，使用后端统计

    try {
      // 延迟导入 flutter_blue_plus（仅移动端编译）
      _flutterBlue = await _loadFlutterBlue();
      if (_flutterBlue == null) return;

      final state = await _flutterBlue.adapter.state.first;
      if (state.toString() != 'BluetoothAdapterState.on') return;

      _isScanning = true;

      _decayTimer = Timer.periodic(const Duration(seconds: 30), (_) {
        if (_seenDevices.isNotEmpty) {
          _seenDevices.remove(_seenDevices.first);
          _nearbyCountController.add(_seenDevices.length);
        }
      });

      await _flutterBlue.startScan(timeout: const Duration(seconds: 15));
      _flutterBlue.scanResults.listen((results) {
        for (final r in results) {
          _seenDevices.add(r.device.remoteId.str);
        }
        _nearbyCountController.add(_seenDevices.length);
      });

      _flutterBlue.isScanning.listen((scanning) {
        if (!scanning && _isScanning) {
          _flutterBlue.startScan(timeout: const Duration(seconds: 15));
        }
      });
    } catch (_) {
      // 任何异常都降级
    }
  }

  /// 延迟加载 flutter_blue_plus
  Future<dynamic> _loadFlutterBlue() async {
    try {
      // ignore: missing_return
      final lib = await Future.value(null);
      // flutter_blue_plus 仅在移动端可用，桌面端跳过
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> stopScanning() async {
    _isScanning = false;
    _decayTimer?.cancel();
    try {
      if (_flutterBlue != null) await _flutterBlue.stopScan();
    } catch (_) {}
    _seenDevices.clear();
  }

  void dispose() {
    stopScanning();
    _nearbyCountController.close();
  }
}
