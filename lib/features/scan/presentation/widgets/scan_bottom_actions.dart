import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/core/constants/app_icons.dart';

/// スキャン画面下部のアクションバー。
///
/// フラッシュ切替・レンズ切替・画像選択の 3 つの円形ボタンを配置する。
class ScanBottomActions extends StatelessWidget {
  /// [ScanBottomActions] を生成する。
  const ScanBottomActions({
    required this.onFlashToggle,
    required this.onLensSwitch,
    required this.onImagePick,
    this.isFlashOn = false,
    super.key,
  });

  /// フラッシュ切替コールバック。
  final VoidCallback onFlashToggle;

  /// レンズ切替コールバック。
  final VoidCallback onLensSwitch;

  /// 画像選択コールバック。
  final VoidCallback onImagePick;

  /// フラッシュが ON かどうか。
  final bool isFlashOn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ActionButton(
            iconPath: isFlashOn ? AppIcons.flashOn : AppIcons.flashOff,
            onPressed: onFlashToggle,
            isActive: isFlashOn,
          ),
          const SizedBox(width: 24),
          _ActionButton(
            iconPath: AppIcons.cameraswitchOutlined,
            onPressed: onLensSwitch,
          ),
          const SizedBox(width: 24),
          _ActionButton(
            iconPath: AppIcons.photoLibraryOutlined,
            onPressed: onImagePick,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.iconPath,
    required this.onPressed,
    this.isActive = false,
  });

  final String iconPath;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.darkCard,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(
              isActive
                  ? AppTheme.primaryCyan
                  : AppTheme.textPrimary,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
