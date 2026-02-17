import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';

/// スキャン領域を示すオーバーレイ。
///
/// 中央に透明なスキャンウィンドウを配置し、四隅にコーナーブラケットを描画する。
class ScanOverlay extends StatelessWidget {
  /// [ScanOverlay] を生成する。
  const ScanOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScanOverlayPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scanSize = size.width * 0.65;
    final left = (size.width - scanSize) / 2;
    final top = (size.height - scanSize) / 2 - 40;
    final scanRect = Rect.fromLTWH(left, top, scanSize, scanSize);

    // 半透明の暗いオーバーレイ
    final overlayPaint = Paint()..color = AppTheme.scanOverlay;
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // スキャン窓をくり抜く
    canvas
      ..saveLayer(fullRect, Paint())
      ..drawRect(fullRect, overlayPaint)
      ..drawRect(scanRect, Paint()..blendMode = BlendMode.clear)
      ..restore();

    // コーナーブラケット
    final cornerPaint = Paint()
      ..color = AppTheme.scanCorner
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 30.0;

    // 左上
    canvas
      ..drawLine(
        scanRect.topLeft,
        scanRect.topLeft + const Offset(cornerLength, 0),
        cornerPaint,
      )
      ..drawLine(
        scanRect.topLeft,
        scanRect.topLeft + const Offset(0, cornerLength),
        cornerPaint,
      )

      // 右上
      ..drawLine(
        scanRect.topRight,
        scanRect.topRight + const Offset(-cornerLength, 0),
        cornerPaint,
      )
      ..drawLine(
        scanRect.topRight,
        scanRect.topRight + const Offset(0, cornerLength),
        cornerPaint,
      )

      // 左下
      ..drawLine(
        scanRect.bottomLeft,
        scanRect.bottomLeft + const Offset(cornerLength, 0),
        cornerPaint,
      )
      ..drawLine(
        scanRect.bottomLeft,
        scanRect.bottomLeft + const Offset(0, -cornerLength),
        cornerPaint,
      )

      // 右下
      ..drawLine(
        scanRect.bottomRight,
        scanRect.bottomRight + const Offset(-cornerLength, 0),
        cornerPaint,
      )
      ..drawLine(
        scanRect.bottomRight,
        scanRect.bottomRight + const Offset(0, -cornerLength),
        cornerPaint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
