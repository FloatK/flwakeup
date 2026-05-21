import 'package:flutter/material.dart';

/// 显示应用统一风格的 SnackBar。
void showAppSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor:
          isError ? Theme.of(context).colorScheme.error : null,
    ),
  );
}
