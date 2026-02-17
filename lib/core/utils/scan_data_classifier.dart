import 'package:scanvolt/features/scan/domain/models/scan_result.dart';

/// スキャンデータの種別を自動判別するユーティリティ。
class ScanDataClassifier {
  ScanDataClassifier._();

  /// [rawValue] の内容から [ScanDataType] を判別する。
  static ScanDataType classify(String rawValue) {
    final trimmed = rawValue.trim();

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return ScanDataType.url;
    }
    if (trimmed.startsWith('WIFI:')) {
      return ScanDataType.wifi;
    }
    if (trimmed.contains('BEGIN:VCARD')) {
      return ScanDataType.contact;
    }
    if (trimmed.startsWith('tel:')) {
      return ScanDataType.phone;
    }
    if (trimmed.startsWith('mailto:')) {
      return ScanDataType.email;
    }
    if (trimmed.startsWith('geo:')) {
      return ScanDataType.geo;
    }

    return ScanDataType.text;
  }
}
