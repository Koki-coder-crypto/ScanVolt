import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_content.freezed.dart';

/// QR コンテンツの種別。
enum QrContentType { url, text, wifi, contact }

/// QR コード生成用のコンテンツモデル。
@freezed
abstract class QrContent with _$QrContent {
  /// [QrContent] を生成する。
  const factory QrContent({
    required QrContentType type,
    required String data,
    required String label,
    required DateTime createdAt,
  }) = _QrContent;
}
