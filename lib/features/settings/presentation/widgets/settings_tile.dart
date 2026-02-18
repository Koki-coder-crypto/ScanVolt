import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/core/constants/app_icons.dart';

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

  /// 左アイコンのSVGパス。
  final String icon;

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
      leading: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          iconColor ?? AppTheme.textPrimary,
          BlendMode.srcIn,
        ),
        width: 22,
        height: 22,
      ),
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
              ? SvgPicture.asset(
                  AppIcons.chevronRight,
                  colorFilter: const ColorFilter.mode(
                    AppTheme.textTertiary,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                )
              : null),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
