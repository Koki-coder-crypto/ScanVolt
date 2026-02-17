import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';

/// 設定画面の個別タイル。
class SettingsTile extends StatelessWidget {
  /// [SettingsTile] を生成する。
  const SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.subtitle,
    this.onTap,
    this.iconColor,
    this.textColor,
    super.key,
  });

  /// 左アイコン。
  final IconData icon;

  /// タイトル。
  final String title;

  /// サブタイトル。
  final String? subtitle;

  /// 右側ウィジェット（スイッチ、矢印、テキストなど）。
  final Widget? trailing;

  /// タップコールバック。
  final VoidCallback? onTap;

  /// アイコン色。
  final Color? iconColor;

  /// テキスト色。
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppTheme.textPrimary, size: 22),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor ?? AppTheme.textPrimary,
            ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textTertiary,
                  ),
            )
          : null,
      trailing: trailing ??
          (onTap != null
              ? const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textTertiary,
                )
              : null),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
