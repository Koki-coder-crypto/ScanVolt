import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/core/constants/app_icons.dart';
import 'package:scanvolt/features/scan/domain/models/scan_result.dart';

/// 履歴リストの各アイテム。
class HistoryListItem extends StatelessWidget {
  /// [HistoryListItem] を生成する。
  const HistoryListItem({
    required this.result,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  /// スキャン結果。
  final ScanResult result;

  /// お気に入り切替コールバック。
  final VoidCallback onToggleFavorite;

  /// 削除コールバック。
  final VoidCallback onDelete;

  /// タップコールバック。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(result.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppTheme.warningRed,
        child: SvgPicture.asset(
          AppIcons.delete,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 24,
          height: 24,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              // タイプアイコン
              _TypeIcon(dataType: result.dataType),
              const SizedBox(width: 14),

              // テキスト情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.displayValue ?? result.rawValue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${result.dataType.label} · ${_relativeTime(result.scannedAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textTertiary,
                          ),
                    ),
                  ],
                ),
              ),

              // お気に入りスター
              IconButton(
                onPressed: onToggleFavorite,
                icon: SvgPicture.asset(
                  result.isFavorite ? AppIcons.star : AppIcons.starBorder,
                  colorFilter: ColorFilter.mode(
                    result.isFavorite ? Colors.amber : AppTheme.textTertiary,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _relativeTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }
}

class _TypeIcon extends StatelessWidget {
  const _TypeIcon({required this.dataType});

  final ScanDataType dataType;

  @override
  Widget build(BuildContext context) {
    final (iconPath, color) = switch (dataType) {
      ScanDataType.url => (AppIcons.language, AppTheme.primaryCyan),
      ScanDataType.wifi => (AppIcons.wifi, AppTheme.successGreen),
      ScanDataType.contact => (AppIcons.personOutline, Colors.orange),
      ScanDataType.text => (AppIcons.descriptionOutlined, Colors.white70),
      ScanDataType.email => (AppIcons.emailOutlined, Colors.amber),
      ScanDataType.phone => (AppIcons.phone, Colors.lightBlue),
      _ => (AppIcons.qrCode, Colors.grey),
    };

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(color, BlendMode.srcIn), width: 20, height: 20),
    );
  }
}

/// ScanDataType の表示ラベル拡張。
extension ScanDataTypeLabel on ScanDataType {
  /// 表示ラベルを返す。
  String get label => switch (this) {
        ScanDataType.url => 'URL',
        ScanDataType.wifi => 'Wi-Fi',
        ScanDataType.contact => 'Contact',
        ScanDataType.text => 'Text',
        ScanDataType.email => 'Email',
        ScanDataType.phone => 'Phone',
        ScanDataType.geo => 'Geo',
        ScanDataType.unknown => 'Unknown',
      };
}
