import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/ui_utils.dart';
import '../../core/utils/vibrate.dart';
import '../../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(themeSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          // Interaction settings
          _buildSection(
            context,
            title: l10n.interaction,
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.vibration),
                title: Text(l10n.vibration),
                subtitle: Text(l10n.vibrationSubtitle),
                value: settings.vibrationEnabled,
                onChanged: (v) {
                  ref.read(themeSettingsProvider.notifier).state =
                      settings.copyWith(vibrationEnabled: v);
                  saveThemeSettings(settings.copyWith(vibrationEnabled: v));
                  Vibrate.light();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Other settings
          _buildSection(
            context,
            title: l10n.others,
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.about),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Vibrate.light();
                  context.push('/about');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.cleaning_services_outlined,
                  color: theme.colorScheme.error,
                ),
                title: Text(
                  l10n.clearCache,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
                onTap: () {
                  Vibrate.light();
                  _showClearCacheDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.clearCache),
        content: Text(l10n.confirmClearCache),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              showAppSnackBar(context, l10n.cacheCleared);
            },
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }
}
