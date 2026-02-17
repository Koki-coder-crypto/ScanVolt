/// 各種データを QR コード用の文字列にエンコードするユーティリティ。
class QrDataEncoder {
  QrDataEncoder._();

  /// URL をエンコードする（そのまま返す）。
  static String encodeUrl(String url) => url;

  /// テキストをエンコードする（そのまま返す）。
  static String encodeText(String text) => text;

  /// Wi-Fi 接続情報を QR コード用文字列にエンコードする。
  static String encodeWifi({
    required String ssid,
    required String password,
    String encryption = 'WPA',
  }) {
    return 'WIFI:T:$encryption;S:$ssid;P:$password;;';
  }

  /// 連絡先情報を vCard 形式にエンコードする。
  static String encodeContact({
    required String name,
    String? phone,
    String? email,
  }) {
    final buffer = StringBuffer()
      ..writeln('BEGIN:VCARD')
      ..writeln('VERSION:3.0')
      ..writeln('FN:$name');

    if (phone != null && phone.isNotEmpty) {
      buffer.writeln('TEL:$phone');
    }
    if (email != null && email.isNotEmpty) {
      buffer.writeln('EMAIL:$email');
    }

    buffer.writeln('END:VCARD');
    return buffer.toString();
  }
}
