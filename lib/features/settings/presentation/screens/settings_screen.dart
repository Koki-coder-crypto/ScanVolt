import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/core/constants/app_icons.dart';
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
                  icon: AppIcons.paletteOutlined,
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
                      SvgPicture.asset(
                        AppIcons.chevronRight,
                        colorFilter: const ColorFilter.mode(
                          AppTheme.textTertiary,
                          BlendMode.srcIn,
                        ),
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  onTap: () {
                    // TODO(scanvolt): show theme picker dialog
                  },
                ),
                SettingsTile(
                  icon: AppIcons.vibration,
                  title: 'Vibrate on scan',
                  trailing: Switch(
                    value: _vibrateOnScan,
                    onChanged: (v) => setState(() => _vibrateOnScan = v),
                    activeThumbColor: AppTheme.primaryCyan,
                  ),
                ),
                SettingsTile(
                  icon: AppIcons.volumeUpOutlined,
                  title: 'Sound on scan',
                  trailing: Switch(
                    value: _soundOnScan,
                    onChanged: (v) => setState(() => _soundOnScan = v),
                    activeThumbColor: AppTheme.primaryCyan,
                  ),
                ),
                SettingsTile(
                  icon: AppIcons.openInNew,
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
                  icon: AppIcons.bolt,
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
                  icon: AppIcons.uploadOutlined,
                  title: 'Export History',
                  onTap: () {
                    // TODO(scanvolt): export history
                  },
                ),
                SettingsTile(
                  icon: AppIcons.deleteOutline,
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
                  icon: AppIcons.starBorder,
                  title: 'Rate ScanVolt',
                  onTap: () {
                    // TODO(scanvolt): open app store rating
                  },
                ),
                SettingsTile(
                  icon: AppIcons.shieldOutlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    // TODO(scanvolt): open privacy policy URL
                  },
                ),
                SettingsTile(
                  icon: AppIcons.descriptionOutlined,
                  title: 'Terms of Service',
                  onTap: () {
                    // TODO(scanvolt): open terms of service URL
                  },
                ),
                SettingsTile(
                  icon: AppIcons.sourceOutlined,
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
                  icon: AppIcons.infoOutline,
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
