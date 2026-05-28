import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

/// Reusable helper for detecting and extracting schedule HTML from
/// a WebView. Used by multiple edu-system parsers in the import flow.
class ScheduleWebViewHelper {
  final WebViewController controller;
  bool _redirecting = false;

  ScheduleWebViewHelper(this.controller);

  bool get isRedirecting => _redirecting;

  /// Auto-detect schedule iframe and navigate to it.
  /// Call this from WebView's onPageFinished callback.
  Future<String?> detectAndRedirect() async {
    if (_redirecting) return null;

    final currentUrl = (await controller.currentUrl()) ?? '';
    // Already on the schedule page — nothing to do
    if (currentUrl.contains('xskb_list') || currentUrl.contains('kbtable')) {
      return currentUrl;
    }

    // kbtable already in main document — nothing to do
    try {
      final hasTable = await controller.runJavaScriptReturningResult(
        'document.querySelector("#kbtable") != null',
      );
      if (hasTable == true) return currentUrl;
    } catch (_) {}

    // 1. Search iframes for schedule-related src
    final frameUrl = await _searchIframes();
    if (frameUrl != null) {
      final target = _resolveUrl(frameUrl, currentUrl);
      if (target != null) {
        _redirecting = true;
        await controller.loadRequest(Uri.parse(target));
        Future.delayed(const Duration(seconds: 3), () => _redirecting = false);
        return target;
      }
    }

    // 2. Fallback: extract from page HTML
    final pageHtml = await _getPageHtml();
    if (pageHtml != null && pageHtml.isNotEmpty) {
      final scheduleUrl = extractScheduleUrl(pageHtml);
      if (scheduleUrl != null) {
        final target = _resolveUrl(scheduleUrl, currentUrl);
        if (target != null) {
          _redirecting = true;
          await controller.loadRequest(Uri.parse(target));
          Future.delayed(const Duration(seconds: 3), () => _redirecting = false);
          return target;
        }
      }
    }

    return null;
  }

  /// Poll for the schedule table (#kbtable) to appear, then extract HTML.
  /// Returns the decoded HTML string, or null if not found.
  Future<String?> extractScheduleHtml({
    int maxAttempts = 15,
    Duration interval = const Duration(milliseconds: 600),
  }) async {
    // Wait for kbtable to appear (in main doc or iframes)
    bool tableReady = false;
    for (int i = 0; i < maxAttempts && !tableReady; i++) {
      final hasTable = await controller.runJavaScriptReturningResult(
        "(function(){var f1=document.getElementById('Frame1');"
        "if(f1&&f1.contentDocument&&f1.contentDocument.querySelector('#kbtable'))return true;"
        "var f0=document.getElementById('Frame0');"
        "if(f0&&f0.contentDocument&&f0.contentDocument.querySelector('#kbtable'))return true;"
        "return document.querySelector('#kbtable')!=null;})()",
      );
      if (hasTable == true) {
        tableReady = true;
        break;
      }
      await Future.delayed(interval);
    }

    // Extract HTML, preferring iframe content when available
    final rawResult = await controller.runJavaScriptReturningResult(
      "encodeURIComponent((function(){"
      "var f1=document.getElementById('Frame1');"
      "if(f1&&f1.contentDocument)return f1.contentDocument.documentElement.outerHTML;"
      "var f0=document.getElementById('Frame0');"
      "if(f0&&f0.contentDocument)return f0.contentDocument.documentElement.outerHTML;"
      "return document.documentElement.outerHTML;"
      "})())",
    );

    if (rawResult is String) {
      try {
        return Uri.decodeComponent(rawResult);
      } catch (_) {
        final plain = await controller.runJavaScriptReturningResult(
          'document.documentElement.outerHTML',
        );
        return plain is String ? plain : null;
      }
    }

    final plain = await controller.runJavaScriptReturningResult(
      'document.documentElement.outerHTML',
    );
    return plain is String ? plain : null;
  }

  /// Search all iframes/frames for a src attribute matching schedule keywords
  Future<String?> _searchIframes() async {
    try {
      final result = await controller.runJavaScriptReturningResult(
        "(function(){"
        "var frames=document.querySelectorAll('iframe,frame');"
        "var keywords=['xskb_list','xskb','kbtable'];"
        "for(var i=0;i<frames.length;i++){"
        "var src=frames[i].getAttribute('src')||'';"
        "for(var k=0;k<keywords.length;k++){"
        "if(src.indexOf(keywords[k])!==-1)return'src:'+src;"
        "}"
        "}"
        "for(var i=0;i<frames.length;i++){"
        "var src=frames[i].getAttribute('src')||'';"
        "if(src)return'src:'+src;"
        "}"
        "return'';"
        "})()",
      );
      if (result is String && result.startsWith('src:')) {
        return result.substring(4).trim();
      }
    } catch (_) {}
    return null;
  }

  /// Get the full page HTML
  Future<String?> _getPageHtml() async {
    try {
      final raw = await controller.runJavaScriptReturningResult(
        'document.documentElement.outerHTML',
      );
      return raw is String ? raw : null;
    } catch (_) {
      return null;
    }
  }

  /// Resolve a relative URL against the current page URL
  String? _resolveUrl(String url, String base) {
    if (url.isEmpty) return null;
    if (url.startsWith('http')) return url;
    if (base.startsWith('http')) {
      return Uri.parse(base).resolve(url).toString();
    }
    return null;
  }

  /// Extract a schedule page URL from raw HTML text
  static String? extractScheduleUrl(String html) {
    const keywords = ['xskb_list', 'xskb', 'kbtable'];

    // Search iframe/frame src attributes
    final srcRegex = RegExp(
      r'''(?:frame|iframe)\s+[^>]*?src\s*=\s*["']([^"']+)["']''',
      caseSensitive: false,
    );
    for (final m in srcRegex.allMatches(html)) {
      for (final kw in keywords) {
        if (m.group(1)!.contains(kw)) return m.group(1);
      }
    }

    // Search <a> href attributes
    final hrefRegex = RegExp(
      r'''href\s*=\s*["']([^"']+)["']''',
      caseSensitive: false,
    );
    for (final m in hrefRegex.allMatches(html)) {
      for (final kw in keywords) {
        if (m.group(1)!.contains(kw)) return m.group(1);
      }
    }

    return null;
  }
}
