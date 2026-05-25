import 'package:flutter/material.dart';

/// 可自定义遮罩透明度的 PopupRoute。
///
/// 通过 [dragNotifier] 监听拖动状态，当值为 `true` 时遮罩变为透明，
/// 使得 slider 拖拽时能看到底层内容。
/// 同时保留了 `showDialog` 的所有特性：正确宽度、返回键关闭、入场动画、安全区适配。
class MutableBarrierRoute<T> extends PopupRoute<T> {
  MutableBarrierRoute({
    required this.dragNotifier,
    required this.builder,
  });

  final ValueNotifier<bool> dragNotifier;
  final WidgetBuilder builder;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Close';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Stack(
      children: [
        // 自定义遮罩：FadeTransition 负责出入场动画，AnimatedOpacity 负责拖拽态切换
        Positioned.fill(
          child: FadeTransition(
            opacity: animation,
            child: ListenableBuilder(
              listenable: dragNotifier,
              builder: (context, _) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: AnimatedOpacity(
                    duration: transitionDuration,
                    opacity: dragNotifier.value ? 0.0 : 1.0,
                    child: Container(color: Colors.black54),
                  ),
                );
              },
            ),
          ),
        ),
        // 对话框内容（居中 + 上边距 + 淡入动画）
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.linearToEaseOut,
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
