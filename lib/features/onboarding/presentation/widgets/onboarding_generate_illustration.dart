// ignore_for_file: cascade_invocations, CustomPainterのCanvas連続呼び出しは可読性優先

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';

/// 「Generate & Share」ページ用のアニメーションイラスト。
///
/// 中央のQRコード、周囲のアイコンバブル（URL, Wi-Fi, Contact）、
/// 接続線を CustomPainter + AnimationController で描画する。
class OnboardingGenerateIllustration extends StatefulWidget {
  /// [OnboardingGenerateIllustration] を生成する。
  const OnboardingGenerateIllustration({super.key});

  @override
  State<OnboardingGenerateIllustration> createState() =>
      _OnboardingGenerateIllustrationState();
}

class _OnboardingGenerateIllustrationState
    extends State<OnboardingGenerateIllustration>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _floatController;

  late final Animation<double> _qrScale;
  late final Animation<double> _bubblesAppear;
  late final Animation<double> _connectionLines;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _qrScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _bubblesAppear = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _connectionLines = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );

    // 浮遊ループ
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    unawaited(_floatController.repeat());

    unawaited(_entryController.forward());
  }

  @override
  void dispose() {
    _entryController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: AnimatedBuilder(
        animation: Listenable.merge([_entryController, _floatController]),
        builder: (context, _) {
          return CustomPaint(
            size: const Size(280, 280),
            painter: _GenerateIllustrationPainter(
              qrScale: _qrScale.value,
              bubblesAppear: _bubblesAppear.value,
              connectionLines: _connectionLines.value,
              floatProgress: _floatController.value,
            ),
          );
        },
      ),
    );
  }
}

class _GenerateIllustrationPainter extends CustomPainter {
  _GenerateIllustrationPainter({
    required this.qrScale,
    required this.bubblesAppear,
    required this.connectionLines,
    required this.floatProgress,
  });

  final double qrScale;
  final double bubblesAppear;
  final double connectionLines;
  final double floatProgress;

  static const Color _cyan = AppTheme.primaryCyan;
  static const _cyanBright = Color(0xFF00E5FF);
  static const _darkSurface = Color(0xFF1E1E1E);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    _drawBackgroundCircles(canvas, center);
    _drawOrbitalLines(canvas, center);
    _drawConnectionLines(canvas, center);
    _drawQrCode(canvas, center);
    _drawBubble(canvas, center, 0, const Offset(-76, -61), _drawLinkIcon);
    _drawBubble(canvas, center, 1, const Offset(74, -51), _drawWifiIcon);
    _drawBubble(canvas, center, 2, const Offset(-11, 84), _drawContactIcon);
    _drawSparkles(canvas, center);
  }

  void _drawBackgroundCircles(Canvas canvas, Offset center) {
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _cyan.withValues(alpha: 0.18),
          _cyanBright.withValues(alpha: 0.08),
          _cyan.withValues(alpha: 0.03),
        ],
        stops: const [0, 0.5, 1],
      ).createShader(Rect.fromCircle(center: center, radius: 140));
    canvas.drawCircle(center, 140, bgPaint);

    for (final r in [125.0, 110.0, 95.0]) {
      final opacity = 0.15 - (125 - r) * 0.003;
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = _cyan.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5,
      );
    }
  }

  void _drawOrbitalLines(Canvas canvas, Offset center) {
    final rotation = floatProgress * 2 * math.pi;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation / 50 * 2 * math.pi);

    final orbPaint1 = Paint()
      ..color = _cyan.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 200, height: 120),
      orbPaint1,
    );

    final orbPaint2 = Paint()
      ..color = _cyanBright.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 120, height: 200),
      orbPaint2,
    );

    canvas.restore();
  }

  void _drawConnectionLines(Canvas canvas, Offset center) {
    if (connectionLines <= 0) return;

    final dashPhase = floatProgress * 20;
    final connectPaint = Paint()
      ..color = _cyan.withValues(alpha: 0.2 * connectionLines)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // リンクバブル → QRコード
    _drawDashedLine(
      canvas,
      center + const Offset(-52, -37),
      center + const Offset(-25, -25),
      connectPaint,
      dashPhase,
    );

    // Wi-Fiバブル → QRコード
    _drawDashedLine(
      canvas,
      center + const Offset(50, -27),
      center + const Offset(25, -25),
      connectPaint,
      dashPhase,
    );

    // コンタクトバブル → QRコード
    _drawDashedLine(
      canvas,
      center + const Offset(-11, 60),
      center + const Offset(-5, 25),
      connectPaint,
      dashPhase,
    );
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
    double phase,
  ) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final length = math.sqrt(dx * dx + dy * dy);
    final ux = dx / length;
    final uy = dy / length;

    const dashLen = 3.0;
    const gapLen = 3.0;
    var d = phase % (dashLen + gapLen);

    while (d < length) {
      final s = d;
      final e = math.min(d + dashLen, length);
      canvas.drawLine(
        Offset(start.dx + ux * s, start.dy + uy * s),
        Offset(start.dx + ux * e, start.dy + uy * e),
        paint,
      );
      d += dashLen + gapLen;
    }
  }

  void _drawQrCode(Canvas canvas, Offset center) {
    if (qrScale <= 0) return;

    // 中央グロー
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _cyanBright.withValues(alpha: 0.4),
          _cyan.withValues(alpha: 0.15),
          _cyan.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 75));
    canvas.drawCircle(center, 75, glowPaint);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(qrScale);
    canvas.translate(-50, -50);

    // QRコードのグロー
    final qrGlowPaint = Paint()
      ..color = _cyanBright.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 100, 100),
        const Radius.circular(6),
      ),
      qrGlowPaint,
    );

    // 白背景
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 100, 100),
        const Radius.circular(6),
      ),
      Paint()..color = Colors.white,
    );

    // ボーダー
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0.5, 0.5, 99, 99),
        const Radius.circular(5.5),
      ),
      Paint()
        ..color = const Color(0xFFE0E0E0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final black = Paint()..color = Colors.black;
    final cyanPaint = Paint()..color = _cyan;

    // コーナーマーカー（左上）
    _drawCornerMarker(canvas, 6, 6, black, cyanPaint);
    // コーナーマーカー（右上）
    _drawCornerMarker(canvas, 74, 6, black, cyanPaint);
    // コーナーマーカー（左下）
    _drawCornerMarker(canvas, 6, 74, black, cyanPaint);

    // データモジュール
    _drawDataModules(canvas, black, cyanPaint);

    // 中央アクセント
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(42, 42, 16, 16),
        const Radius.circular(2),
      ),
      Paint()
        ..shader = const LinearGradient(
          colors: [_cyanBright, _cyan],
        ).createShader(const Rect.fromLTWH(42, 42, 16, 16))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(45, 45, 10, 10),
        const Radius.circular(1),
      ),
      Paint()..color = _cyan.withValues(alpha: 0.2),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(47, 47, 6, 6),
        const Radius.circular(0.5),
      ),
      Paint()..color = _cyan.withValues(alpha: 0.5),
    );

    canvas.restore();
  }

  void _drawCornerMarker(Canvas canvas, double x, double y, Paint b, Paint c) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, 20, 20),
        const Radius.circular(2),
      ),
      b,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 2, y + 2, 16, 16),
        const Radius.circular(1.5),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 5, y + 5, 10, 10),
        const Radius.circular(1),
      ),
      b,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 7, y + 7, 6, 6),
        const Radius.circular(0.5),
      ),
      Paint()..color = _cyan.withValues(alpha: 0.3),
    );
  }

  void _drawDataModules(Canvas canvas, Paint black, Paint cyan) {
    // 上部データ
    canvas.drawRect(const Rect.fromLTWH(30, 6, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(36, 6, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(41, 6, 4, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(47, 6, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(52, 6, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(58, 6, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(63, 6, 4, 4), black);

    // 中部データ
    canvas.drawRect(const Rect.fromLTWH(6, 30, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(12, 30, 4, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(18, 30, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(30, 30, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(36, 30, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(42, 30, 3, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(30, 36, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(36, 36, 4, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(42, 36, 4, 4), black);

    canvas.drawRect(const Rect.fromLTWH(52, 30, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(58, 30, 3, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(63, 30, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(69, 30, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(75, 30, 3, 4), black);

    // 下部データ
    canvas.drawRect(const Rect.fromLTWH(30, 52, 4, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(36, 52, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(42, 52, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(52, 52, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(58, 52, 4, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(64, 52, 3, 4), black);

    canvas.drawRect(const Rect.fromLTWH(30, 74, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(36, 74, 3, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(41, 74, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(47, 74, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(53, 74, 3, 4), black);

    canvas.drawRect(const Rect.fromLTWH(30, 80, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(35, 80, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(41, 80, 4, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(47, 80, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(52, 80, 4, 4), black);

    canvas.drawRect(const Rect.fromLTWH(30, 86, 4, 4), cyan);
    canvas.drawRect(const Rect.fromLTWH(36, 86, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(42, 86, 3, 4), black);
    canvas.drawRect(const Rect.fromLTWH(47, 86, 4, 4), black);
    canvas.drawRect(const Rect.fromLTWH(53, 86, 4, 4), black);
  }

  void _drawBubble(
    Canvas canvas,
    Offset center,
    int index,
    Offset baseOffset,
    void Function(Canvas, Offset) drawIcon,
  ) {
    if (bubblesAppear <= 0) return;

    // staggered登場
    final stagger = (index * 0.15).clamp(0.0, 0.3);
    final progress = ((bubblesAppear - stagger) / (1 - stagger)).clamp(0.0, 1.0);
    if (progress <= 0) return;

    // 浮遊オフセット
    final floatPhase = floatProgress + index * 0.33;
    final floatY = math.sin(floatPhase * 2 * math.pi) * 12;
    final floatRotation = math.sin(floatPhase * 2 * math.pi) * 0.14;

    final bubbleCenter = center + baseOffset + Offset(0, floatY);

    canvas.save();
    canvas.translate(bubbleCenter.dx, bubbleCenter.dy);
    canvas.rotate(floatRotation);
    canvas.scale(progress);

    // バブルシャドウ
    canvas.drawCircle(
      const Offset(0, 6),
      24,
      Paint()
        ..color = _cyan.withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // バブルの環（放射グラデーション背景）
    canvas.drawCircle(
      Offset.zero,
      26,
      Paint()
        ..shader = RadialGradient(
          colors: [
            _cyanBright.withValues(alpha: 0.25),
            _cyan.withValues(alpha: 0.1),
          ],
        ).createShader(const Rect.fromLTWH(-26, -26, 52, 52)),
    );

    // ダークサーフェス背景
    canvas.drawCircle(Offset.zero, 24, Paint()..color = _darkSurface);

    // 内部グラデーション
    canvas.drawCircle(
      Offset.zero,
      22,
      Paint()
        ..shader = RadialGradient(
          colors: [
            _cyanBright.withValues(alpha: 0.25),
            _cyan.withValues(alpha: 0.1),
          ],
        ).createShader(const Rect.fromLTWH(-22, -22, 44, 44)),
    );

    // シアンボーダー
    canvas.drawCircle(
      Offset.zero,
      20,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..shader = const LinearGradient(
          colors: [_cyanBright, _cyan],
        ).createShader(const Rect.fromLTWH(-20, -20, 40, 40)),
    );

    // アイコン描画
    drawIcon(canvas, Offset.zero);

    // デコレーションドット
    canvas.drawCircle(
      const Offset(0, -12),
      1.5,
      Paint()..color = _cyanBright.withValues(alpha: 0.6),
    );
    canvas.drawCircle(
      const Offset(12, 0),
      1.5,
      Paint()..color = _cyan.withValues(alpha: 0.6),
    );

    canvas.restore();

    // パルスリング
    final pulsePhase = (floatProgress + index * 0.27) % 1.0;
    final pulseScale = 1.0 + pulsePhase * 0.4;
    final pulseOpacity = 0.6 * (1 - pulsePhase) * progress;

    canvas.drawCircle(
      bubbleCenter,
      20 * pulseScale,
      Paint()
        ..color = (index.isEven ? _cyanBright : _cyan)
            .withValues(alpha: pulseOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  void _drawLinkIcon(Canvas canvas, Offset center) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..shader = const LinearGradient(
        colors: [_cyanBright, _cyan],
      ).createShader(const Rect.fromLTWH(-12, -12, 24, 24));

    // グロー
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = _cyanBright.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);

    final path = Path()
      ..moveTo(-8, -3)
      ..lineTo(-4, -7)
      ..moveTo(4, 5)
      ..lineTo(8, 1);

    final arc1 = Path()
      ..moveTo(-4, -7)
      ..cubicTo(-2.5, -8.5, 0, -8.5, 1.5, -7)
      ..cubicTo(3, -5.5, 3, -3, 1.5, -1.5)
      ..lineTo(-1, 1);

    final arc2 = Path()
      ..moveTo(1, -1)
      ..lineTo(-1.5, 1.5)
      ..cubicTo(-3, 3, -3, 5.5, -1.5, 7)
      ..cubicTo(0, 8.5, 2.5, 8.5, 4, 7)
      ..lineTo(8, 1);

    for (final p in [path, arc1, arc2]) {
      canvas.drawPath(p, glowPaint);
      canvas.drawPath(p, paint);
    }
  }

  void _drawWifiIcon(Canvas canvas, Offset center) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [_cyanBright, _cyan],
      ).createShader(const Rect.fromLTWH(-12, -12, 24, 24));

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = _cyanBright.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);

    // 外側アーク
    final arc1 = Path()
      ..addArc(
        const Rect.fromLTWH(-11, -10, 22, 22),
        math.pi + math.pi * 0.25,
        math.pi * 0.5,
      );
    paint.strokeWidth = 3;
    glowPaint.strokeWidth = 3;
    canvas.drawPath(arc1, glowPaint);
    canvas.drawPath(arc1, paint);

    // 中間アーク
    final arc2 = Path()
      ..addArc(
        const Rect.fromLTWH(-8, -6, 16, 16),
        math.pi + math.pi * 0.25,
        math.pi * 0.5,
      );
    paint.strokeWidth = 2.8;
    glowPaint.strokeWidth = 2.8;
    canvas.drawPath(arc2, glowPaint);
    canvas.drawPath(arc2, paint);

    // 内側アーク
    final arc3 = Path()
      ..addArc(
        const Rect.fromLTWH(-5, -2, 10, 10),
        math.pi + math.pi * 0.25,
        math.pi * 0.5,
      );
    paint.strokeWidth = 2.5;
    glowPaint.strokeWidth = 2.5;
    canvas.drawPath(arc3, glowPaint);
    canvas.drawPath(arc3, paint);

    // 中央ドット
    canvas.drawCircle(
      const Offset(0, 6),
      2,
      Paint()
        ..shader = const LinearGradient(
          colors: [_cyanBright, _cyan],
        ).createShader(const Rect.fromLTWH(-2, 4, 4, 4)),
    );
  }

  void _drawContactIcon(Canvas canvas, Offset center) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [_cyanBright, _cyan],
      ).createShader(const Rect.fromLTWH(-12, -12, 24, 24));

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..color = _cyanBright.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);

    // 頭部（円）
    canvas.drawCircle(const Offset(0, -6), 5, glowPaint);
    canvas.drawCircle(const Offset(0, -6), 5, paint);

    // 胴体（弧）
    final bodyPath = Path()
      ..moveTo(-9, 9)
      ..cubicTo(-9, 4, -4.5, 1, 0, 1)
      ..cubicTo(4.5, 1, 9, 4, 9, 9);
    paint.strokeWidth = 2.8;
    glowPaint.strokeWidth = 2.8;
    canvas.drawPath(bodyPath, glowPaint);
    canvas.drawPath(bodyPath, paint);
  }

  void _drawSparkles(Canvas canvas, Offset center) {
    final sparkles = [
      const Offset(-65, 0),
      const Offset(65, 0),
    ];

    for (var i = 0; i < sparkles.length; i++) {
      final phase = (floatProgress + i * 0.5) % 1.0;
      final opacity = math.sin(phase * math.pi);
      final pos = center + sparkles[i];
      canvas.drawCircle(
        pos,
        1.5,
        Paint()
          ..color =
              (i.isEven ? _cyanBright : _cyan).withValues(alpha: opacity * 0.7),
      );
      canvas.drawCircle(
        pos,
        3,
        Paint()
          ..color =
              (i.isEven ? _cyanBright : _cyan).withValues(alpha: opacity * 0.2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GenerateIllustrationPainter oldDelegate) {
    return oldDelegate.qrScale != qrScale ||
        oldDelegate.bubblesAppear != bubblesAppear ||
        oldDelegate.connectionLines != connectionLines ||
        oldDelegate.floatProgress != floatProgress;
  }
}
