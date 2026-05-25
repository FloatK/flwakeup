import 'package:flutter/services.dart';

/// 全局振动工具。
///
/// 通过静态 [_enabled] 开关控制是否实际触发振动，
/// 避免每个按钮都要读取 provider。
///
/// 使用方式：在任意地方直接调用 `Vibrate.light()`。
class Vibrate {
  static bool _enabled = true;

  /// 更新振动开关状态。
  static void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  /// 如果振动开关已开启，触发轻触振动。
  static void light() {
    if (_enabled) {
      HapticFeedback.lightImpact();
    }
  }
}
