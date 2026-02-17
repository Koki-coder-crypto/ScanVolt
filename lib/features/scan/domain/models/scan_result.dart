import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_result.freezed.dart';
part 'scan_result.g.dart';

/// スキャンデータの種別。
enum ScanDataType { url, wifi, contact, phone, email, geo, text, unknown }

/// スキャン結果のイミュータブルデータモデル。
@freezed
abstract class ScanResult with _$ScanResult {
  /// [ScanResult] を生成する。
  const factory ScanResult({
    required String id,
    required String rawValue,
    required String format,
    required ScanDataType dataType,
    required DateTime scannedAt,
    String? displayValue,
    @Default(false) bool isFavorite,
  }) = _ScanResult;

  /// JSON から [ScanResult] を生成する。
  factory ScanResult.fromJson(Map<String, dynamic> json) =>
      _$ScanResultFromJson(json);
}
