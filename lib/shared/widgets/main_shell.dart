import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scanvolt/app/theme.dart';

/// アプリのメインシェル（ボトムナビゲーション付き）。
///
/// Figma NavBar デザインに準拠: アクティブタブにシアン色のピル型ハイライト。
class MainShell extends StatelessWidget {
  /// [MainShell] を生成する。
  const MainShell({required this.navigationShell, super.key});

  /// go_router のナビゲーションシェル。
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppTheme.darkSurface,
          border: Border(
            top: BorderSide(color: AppTheme.darkCard, width: 0.5),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.qr_code_scanner,
                  label: 'Scan',
                  isActive: navigationShell.currentIndex == 0,
                  onTap: () => _onTap(0),
                ),
                _NavItem(
                  icon: Icons.access_time,
                  label: 'History',
                  isActive: navigationShell.currentIndex == 1,
                  onTap: () => _onTap(1),
                ),
                _NavItem(
                  icon: Icons.add_box_outlined,
                  label: 'Generate',
                  isActive: navigationShell.currentIndex == 2,
                  onTap: () => _onTap(2),
                ),
                _NavItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  isActive: navigationShell.currentIndex == 3,
                  onTap: () => _onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppTheme.primaryCyan : AppTheme.textTertiary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ピル型ハイライト付きアイコン
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: isActive
                  ? BoxDecoration(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    )
                  : null,
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
