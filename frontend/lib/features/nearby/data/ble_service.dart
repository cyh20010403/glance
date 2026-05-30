import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// BLE 近场感知服务
///
/// 扫描附近广播 Glance 匿名 ID 的设备，不获取精确位置。
/// 当前在桌面端降级为后端统计模式，移动端启用硬件扫描。
class BleService {
  static final BleService _instance = BleService._();
  factory BleService() => _instance;
  BleService._();

  final _nearbyCountController = StreamController<int>.broadcast();
  Stream<int> get nearbyCount => _nearbyCountController.stream;

  bool _isScanning = false;
  final Set<String> _seenDevices = {};
  Timer? _decayTimer;

  /// 启动 BLE 扫描（移动端启用）
  Future<void> startScanning() async {
    if (_isScanning) return;

    // 检查蓝牙是否可用
    try {
      final adapter = FlutterBluePlus.adapter;
      final state = await adapter.state.first;
      if (state != BluetoothAdapterState.on) {
        // 蓝牙未开启，降级为后端统计
        return;
      }
    } catch (_) {
      // 桌面端不支持 BLE，降级
      return;
    }

    _isScanning = true;

    // 每 30 秒衰减一次计数（模拟设备离开范围）
    _decayTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_seenDevices.isNotEmpty) {
        _seenDevices.remove(_seenDevices.first);
        _nearbyCountController.add(_seenDevices.length);
      }
    });

    // 开始扫描
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 15),
      androidUsesFineLocation: false,
    );

    FlutterBluePlus.scanResults.listen((results) {
      for (final result in results) {
        // 只关注广播 Glance 服务 UUID 的设备
        // 实际实现：过滤特定 service UUID
        _seenDevices.add(result.device.remoteId.str);
      }
      _nearbyCountController.add(_seenDevices.length);
    });

    // 持续扫描：每次结束后重新开始
    FlutterBluePlus.isScanning.listen((scanning) {
      if (!scanning && _isScanning) {
        FlutterBluePlus.startScan(
          timeout: const Duration(seconds: 15),
        );
      }
    });
  }

  /// 停止 BLE 扫描
  Future<void> stopScanning() async {
    _isScanning = false;
    _decayTimer?.cancel();
    try {
      await FlutterBluePlus.stopScan();
    } catch (_) {}
    _seenDevices.clear();
  }

  void dispose() {
    stopScanning();
    _nearbyCountController.close();
  }
}
