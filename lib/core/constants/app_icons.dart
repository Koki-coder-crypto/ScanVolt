/// SVG icon asset path constants for the app.
///
/// Usage:
/// ```dart
/// SvgPicture.asset(
///   AppIcons.scan,
///   colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
///   width: 24,
///   height: 24,
/// )
/// ```
class AppIcons {
  const AppIcons._();

  static const String _basePath = 'assets/icons';

  // Navigation
  static const String qrCodeScanner = '$_basePath/icon_qr_code_scanner.svg';
  static const String accessTime = '$_basePath/icon_access_time.svg';
  static const String addBoxOutlined = '$_basePath/icon_add_box_outlined.svg';
  static const String settingsOutlined =
      '$_basePath/icon_settings_outlined.svg';

  // Scan actions
  static const String flashOn = '$_basePath/icon_flash_on.svg';
  static const String flashOff = '$_basePath/icon_flash_off.svg';
  static const String cameraswitchOutlined =
      '$_basePath/icon_cameraswitch_outlined.svg';
  static const String photoLibraryOutlined =
      '$_basePath/icon_photo_library_outlined.svg';

  // Scan result actions
  static const String openInNew = '$_basePath/icon_open_in_new.svg';
  static const String copyOutlined = '$_basePath/icon_copy_outlined.svg';
  static const String iosShare = '$_basePath/icon_ios_share.svg';
  static const String search = '$_basePath/icon_search.svg';
  static const String bookmarkBorder = '$_basePath/icon_bookmark_border.svg';

  // Content type icons
  static const String language = '$_basePath/icon_language.svg';
  static const String wifi = '$_basePath/icon_wifi.svg';
  static const String personOutline = '$_basePath/icon_person_outline.svg';
  static const String descriptionOutlined =
      '$_basePath/icon_description_outlined.svg';
  static const String emailOutlined = '$_basePath/icon_email_outlined.svg';
  static const String phone = '$_basePath/icon_phone.svg';
  static const String qrCode = '$_basePath/icon_qr_code.svg';
  static const String link = '$_basePath/icon_link.svg';

  // Security
  static const String shieldOutlined = '$_basePath/icon_shield_outlined.svg';
  static const String warningAmber = '$_basePath/icon_warning_amber.svg';

  // Settings
  static const String paletteOutlined = '$_basePath/icon_palette_outlined.svg';
  static const String chevronRight = '$_basePath/icon_chevron_right.svg';
  static const String vibration = '$_basePath/icon_vibration.svg';
  static const String volumeUpOutlined =
      '$_basePath/icon_volume_up_outlined.svg';
  static const String bolt = '$_basePath/icon_bolt.svg';
  static const String uploadOutlined = '$_basePath/icon_upload_outlined.svg';
  static const String deleteOutline = '$_basePath/icon_delete_outline.svg';
  static const String starBorder = '$_basePath/icon_star_border.svg';
  static const String sourceOutlined = '$_basePath/icon_source_outlined.svg';
  static const String infoOutline = '$_basePath/icon_info_outline.svg';

  // History
  static const String tune = '$_basePath/icon_tune.svg';
  static const String delete = '$_basePath/icon_delete.svg';
  static const String star = '$_basePath/icon_star.svg';

  // Generate
  static const String download = '$_basePath/icon_download.svg';

  // Premium
  static const String close = '$_basePath/icon_close.svg';
  static const String checkCircleOutline =
      '$_basePath/icon_check_circle_outline.svg';

  // ---------------------------------------------------------------------------
  // Onboarding illustrations
  // ---------------------------------------------------------------------------
  static const String _onboardingPath = 'assets/onboarding';

  /// Page 1 — Instant Scan: Phone with camera viewfinder & QR code.
  static const String onboardingScan =
      '$_onboardingPath/onboarding_scan.svg';

  /// Page 2 — Generate & Share: Phone with QR code & floating type icons.
  static const String onboardingGenerate =
      '$_onboardingPath/onboarding_generate.svg';

  /// Page 3 — History at a Glance: Phone with history list & search bar.
  static const String onboardingHistory =
      '$_onboardingPath/onboarding_history.svg';
}
