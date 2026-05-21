import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

const _urlStoreFile = 'edu_url.json';

/// 教务系统 URL 持久化存储。
class EduUrlStore {
  EduUrlStore._();

  /// 加载上次保存的 URL，若无则返回 null。
  static Future<String?> load() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_urlStoreFile');
      if (!await file.exists()) return null;
      final content = await file.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;
      final url = data['url'] as String?;
      return (url != null && url.isNotEmpty) ? url : null;
    } catch (_) {
      return null;
    }
  }

  /// 保存 URL 到本地文件。
  static Future<void> save(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_urlStoreFile');
      await file.writeAsString(jsonEncode({'url': url}));
    } catch (_) {}
  }
}
