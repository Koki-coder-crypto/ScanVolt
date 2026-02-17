import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/premium/presentation/screens/pro_upgrade_screen.dart';
import 'package:scanvolt/features/settings/presentation/widgets/settings_section.dart';
import 'package:scanvolt/features/settings/presentation/widgets/settings_tile.dart';

/// 設定画面。
class SettingsScreen extends ConsumerStatefulWidget {
  /// [SettingsScreen] を生成する。
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _vibrateOnScan = true;
  bool _soundOnScan = false;
  bool _autoOpenUrls = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),

            // General セクション
            SettingsSection(
              title: 'General',
              children: [
                SettingsTile(
                  icon: Icons.palette_outlined,
                  title: 'Appearance',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dark',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: AppTheme.textTertiary,
                      ),
                    ],
                  ),
                  onTap: () {
                    // TODO(scanvolt): show theme picker dialog
                  },
                ),
                SettingsTile(
                  icon: Icons.vibration,
                  title: 'Vibrate on scan',
                  trailing: Switch(
                    value: _vibrateOnScan,
                    onChanged: (v) => setState(() => _vibrateOnScan = v),
                    activeThumbColor: AppTheme.primaryCyan,
                  ),
                ),
                SettingsTile(
                  icon: Icons.volume_up_outlined,
                  title: 'Sound on scan',
                  trailing: Switch(
                    value: _soundOnScan,
                    onChanged: (v) => setState(() => _soundOnScan = v),
                    activeThumbColor: AppTheme.primaryCyan,
                  ),
                ),
                SettingsTile(
                  icon: Icons.open_in_new,
                  title: 'Auto-open URLs',
                  trailing: Switch(
                    value: _autoOpenUrls,
                    onChanged: (v) => setState(() => _autoOpenUrls = v),
                    activeThumbColor: AppTheme.primaryCyan,
                  ),
                ),
              ],
            ),

            // ScanVolt Pro セクション
            SettingsSection(
              title: 'ScanVolt Pro',
              children: [
                SettingsTile(
                  icon: Icons.bolt,
                  iconColor: Colors.amber,
                  title: 'Upgrade to Pro',
                  subtitle: 'Unlimited history, custom QR codes, and more',
                  onTap: () {
                    unawaited(
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          fullscreenDialog: true,
                          builder: (_) => const ProUpgradeScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            // Data セクション
            SettingsSection(
              title: 'Data',
              children: [
                SettingsTile(
                  icon: Icons.upload_outlined,
                  title: 'Export History',
                  onTap: () {
                    // TODO(scanvolt): export history
                  },
                ),
                SettingsTile(
                  icon: Icons.delete_outline,
                  iconColor: AppTheme.warningRed,
                  title: 'Clear History',
                  textColor: AppTheme.warningRed,
                  onTap: () {
                    // TODO(scanvolt): show clear history confirmation dialog
                  },
                ),
              ],
            ),

            // About セクション
            SettingsSection(
              title: 'About',
              children: [
                SettingsTile(
                  icon: Icons.star_border,
                  title: 'Rate ScanVolt',
                  onTap: () {
                    // TODO(scanvolt): open app store rating
                  },
                ),
                SettingsTile(
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    // TODO(scanvolt): open privacy policy URL
                  },
                ),
                SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () {
                    // TODO(scanvolt): open terms of service URL
                  },
                ),
                SettingsTile(
                  icon: Icons.source_outlined,
                  title: 'Open Source Licenses',
                  onTap: () {
                    showLicensePage(
                      context: context,
                      applicationName: 'ScanVolt',
                      applicationVersion: '1.0.0',
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.info_outline,
                  title: 'Version',
                  trailing: Text(
                    '1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textTertiary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
