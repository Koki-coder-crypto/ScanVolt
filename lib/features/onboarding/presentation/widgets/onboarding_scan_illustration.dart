// ignore_for_file: cascade_invocations, CustomPainterのCanvas連続呼び出しは可読性優先

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';

/// 「Instant Scan」ページ用のアニメーションイラスト。
///
/// スマートフォンフレーム、QRコード、スキャン枠、スキャンライン、
/// 浮遊パーティクルを CustomPainter + AnimationController で描画する。
class OnboardingScanIllustration extends StatefulWidget {
  /// [OnboardingScanIllustration] を生成する。
  const OnboardingScanIllustration({super.key});

  @override
  State<OnboardingScanIllustration> createState() =>
      _OnboardingScanIllustrationState();
}

class _OnboardingScanIllustrationState
    extends State<OnboardingScanIllustration>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _loopController;

  late final Animation<double> _phoneFade;
  late final Animation<double> _qrScale;
  late final Animation<double> _cornerSlide;

  @override
  void initState() {
    super.initState();

    // エントリーアニメーション（0→1.2秒）
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _phoneFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0, 0.33, curve: Curves.easeOut),
      ),
    );

    _qrScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.17, 0.5, curve: Curves.elasticOut),
      ),
    );

    _cornerSlide = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.33, 0.67, curve: Curves.easeOutCubic),
      ),
    );

    // ループアニメーション（スキャンライン + パーティクル + グロー）
    _loopController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    unawaited(_loopController.repeat());

    unawaited(_entryController.forward());
  }

  @override
  void dispose() {
    _entryController.dispose();
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: AnimatedBuilder(
        animation: Listenable.merge([_entryController, _loopController]),
        builder: (context, _) {
          return CustomPaint(
            size: const Size(280, 280),
            painter: _ScanIllustrationPainter(
              phoneFade: _phoneFade.value,
              qrScale: _qrScale.value,
              cornerSlide: _cornerSlide.value,
              scanProgress: _loopController.value,
              particleRotation: _loopController.value * 2 * math.pi,
            ),
          );
        },
      ),
    );
  }
}

class _ScanIllustrationPainter extends CustomPainter {
  _ScanIllustrationPainter({
    required this.phoneFade,
    required this.qrScale,
    required this.cornerSlide,
    required this.scanProgress,
    required this.particleRotation,
  });

  final double phoneFade;
  final double qrScale;
  final double cornerSlide;
  final double scanProgress;
  final double particleRotation;

  static const Color _cyan = AppTheme.primaryCyan;
  static const _cyanBright = Color(0xFF00E5FF);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    _drawBackgroundCircles(canvas, center);
    _drawParticles(canvas, center);
    _drawPhoneFrame(canvas, center);
    _drawQrCode(canvas, center);
    _drawCornerBrackets(canvas, center);
    _drawScanLine(canvas, center);
    _drawCornerDots(canvas, center);
  }

  void _drawBackgroundCircles(Canvas canvas, Offset center) {
    // メインの放射グラデーション背景
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _cyan.withValues(alpha: 0.18 * phoneFade),
          _cyanBright.withValues(alpha: 0.08 * phoneFade),
          _cyan.withValues(alpha: 0.03 * phoneFade),
        ],
        stops: const [0, 0.5, 1],
      ).createShader(Rect.fromCircle(center: center, radius: 140));
    canvas.drawCircle(center, 140, bgPaint);

    // 同心円リング
    for (final r in [125.0, 110.0, 95.0]) {
      final opacity = (0.15 - (125 - r) * 0.003) * phoneFade;
      final ringPaint = Paint()
        ..color = _cyan.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;
      canvas.drawCircle(center, r, ringPaint);
    }
  }

  void _drawParticles(Canvas canvas, Offset center) {
    final particles = [
      const Offset(-70, -50),
      const Offset(70, -30),
      const Offset(60, 50),
      const Offset(-60, 40),
    ];

    final cosR = math.cos(particleRotation);
    final sinR = math.sin(particleRotation);

    for (var i = 0; i < particles.length; i++) {
      final p = particles[i];
      final rotated = Offset(
        p.dx * cosR - p.dy * sinR,
        p.dx * sinR + p.dy * cosR,
      );
      final pos = center + rotated;
      final opacity = (0.35 + 0.15 * (i % 2)) * phoneFade;
      final paint = Paint()
        ..color = (i.isEven ? _cyan : _cyanBright).withValues(alpha: opacity);
      canvas.drawCircle(pos, 2 + (i % 2) * 0.5, paint);
    }

    // きらめきエフェクト
    final sparkles = [
      const Offset(-80, -60),
      const Offset(80, -40),
      const Offset(60, 60),
    ];
    for (var i = 0; i < sparkles.length; i++) {
      final phase = (scanProgress + i * 0.33) % 1.0;
      final sparkleOpacity = math.sin(phase * math.pi) * phoneFade;
      final sparkleScale = 0.5 + math.sin(phase * math.pi);
      final paint = Paint()
        ..color = (i.isEven ? _cyanBright : _cyan)
            .withValues(alpha: sparkleOpacity);
      canvas.drawCircle(
        center + sparkles[i],
        1.5 * sparkleScale,
        paint,
      );
    }
  }

  void _drawPhoneFrame(Canvas canvas, Offset center) {
    if (phoneFade <= 0) return;

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center.translate(0, 5), width: 114, height: 204),
      const Radius.circular(14),
    );
    final innerRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center.translate(0, 5), width: 110, height: 200),
      const Radius.circular(13),
    );

    // シャドウ
    final shadowPaint = Paint()
      ..color = _cyan.withValues(alpha: 0.35 * phoneFade)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawRRect(phoneRect, shadowPaint);

    // 外側フレーム
    final outerPaint = Paint()
      ..color = const Color(0xFF1A1A1A).withValues(alpha: phoneFade);
    canvas.drawRRect(phoneRect, outerPaint);

    // 内側フレームグラデーション
    final framePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF424242).withValues(alpha: phoneFade),
          const Color(0xFF2E2E2E).withValues(alpha: phoneFade),
          const Color(0xFF1A1A1A).withValues(alpha: phoneFade),
        ],
      ).createShader(innerRect.outerRect);
    canvas.drawRRect(innerRect, framePaint);

    // エッジハイライト
    final highlightPaint = Paint()
      ..color = const Color(0xFF555555).withValues(alpha: 0.5 * phoneFade);
    canvas.drawRect(
      Rect.fromLTWH(
        center.dx - 55,
        center.dy - 95,
        110,
        2,
      ),
      highlightPaint,
    );

    // シアンボーダー
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..shader = LinearGradient(
        colors: [
          _cyanBright.withValues(alpha: phoneFade),
          _cyan.withValues(alpha: phoneFade),
        ],
      ).createShader(innerRect.outerRect);
    canvas.drawRRect(innerRect, borderPaint);

    // スクリーンエリア
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center.translate(0, 6), width: 96, height: 176),
      const Radius.circular(2),
    );
    final screenPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF2A2A2A).withValues(alpha: phoneFade),
          const Color(0xFF161616).withValues(alpha: phoneFade),
        ],
      ).createShader(screenRect.outerRect);
    canvas.drawRRect(screenRect, screenPaint);

    // カメラノッチ
    final notchRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center.translate(0, -82),
        width: 40,
        height: 6,
      ),
      const Radius.circular(3),
    );
    canvas.drawRRect(
      notchRect,
      Paint()..color = const Color(0xFF1C1C1C).withValues(alpha: phoneFade),
    );

    // カメラレンズ
    canvas.drawCircle(
      center.translate(22, -82),
      1.5,
      Paint()..color = const Color(0xFF1A3A3A).withValues(alpha: phoneFade),
    );
    canvas.drawCircle(
      center.translate(22, -82),
      0.8,
      Paint()..color = _cyan.withValues(alpha: 0.3 * phoneFade),
    );
  }

  void _drawQrCode(Canvas canvas, Offset center) {
    if (qrScale <= 0) return;

    canvas.save();
    canvas.translate(center.dx, center.dy + 5);
    canvas.scale(qrScale);
    canvas.translate(-25, -25);

    // QRコード下のグロー
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _cyanBright.withValues(alpha: 0.4),
          _cyan.withValues(alpha: 0.2),
          _cyan.withValues(alpha: 0),
        ],
      ).createShader(const Rect.fromLTWH(-25, -25, 100, 100));
    canvas.drawCircle(const Offset(25, 25), 50, glowPaint);

    // QRコード白背景
    final qrBg = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, 50, 50),
      const Radius.circular(2.5),
    );

    // グローフィルター
    final qrGlowPaint = Paint()
      ..color = _cyanBright.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawRRect(qrBg, qrGlowPaint);

    canvas.drawRRect(qrBg, Paint()..color = Colors.white);

    final black = Paint()..color = Colors.black;
    final cyanPaint = Paint()..color = _cyan;

    // コーナーマーカー（左上）
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(3, 3, 13, 13),
        const Radius.circular(1),
      ),
      black,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(5, 5, 9, 9),
        const Radius.circular(0.5),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(7, 7, 5, 5),
        const Radius.circular(0.5),
      ),
      black,
    );

    // コーナーマーカー（右上）
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(34, 3, 13, 13),
        const Radius.circular(1),
      ),
      black,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(36, 5, 9, 9),
        const Radius.circular(0.5),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(38, 7, 5, 5),
        const Radius.circular(0.5),
      ),
      black,
    );

    // コーナーマーカー（左下）
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(3, 34, 13, 13),
        const Radius.circular(1),
      ),
      black,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(5, 36, 9, 9),
        const Radius.circular(0.5),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(7, 38, 5, 5),
        const Radius.circular(0.5),
      ),
      black,
    );

    // データパターン（シアンアクセント付き）
    canvas.drawRect(const Rect.fromLTWH(20, 3, 3, 3), cyanPaint);
    canvas.drawRect(const Rect.fromLTWH(24, 3, 2, 3), black);
    canvas.drawRect(const Rect.fromLTWH(27, 3, 2, 3), black);
    canvas.drawRect(const Rect.fromLTWH(30, 3, 2, 3), black);

    canvas.drawRect(const Rect.fromLTWH(3, 18, 3, 3), black);
    canvas.drawRect(const Rect.fromLTWH(7, 18, 3, 3), cyanPaint);
    canvas.drawRect(const Rect.fromLTWH(11, 18, 2, 3), black);

    // 中央のシアンアクセント
    final centerBorder = Paint()
      ..color = _cyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(18, 18, 14, 14),
        const Radius.circular(1),
      ),
      centerBorder,
    );
    canvas.drawRect(
      const Rect.fromLTWH(21, 21, 8, 8),
      Paint()..color = _cyan.withValues(alpha: 0.3),
    );
    canvas.drawRect(const Rect.fromLTWH(23, 23, 4, 4), cyanPaint);

    canvas.drawRect(const Rect.fromLTWH(34, 18, 3, 3), black);
    canvas.drawRect(const Rect.fromLTWH(38, 18, 3, 3), black);
    canvas.drawRect(const Rect.fromLTWH(42, 18, 3, 3), cyanPaint);

    canvas.drawRect(const Rect.fromLTWH(18, 34, 3, 3), black);
    canvas.drawRect(const Rect.fromLTWH(22, 34, 2, 3), black);
    canvas.drawRect(const Rect.fromLTWH(25, 34, 3, 3), cyanPaint);
    canvas.drawRect(const Rect.fromLTWH(29, 34, 2, 3), black);

    canvas.drawRect(const Rect.fromLTWH(34, 38, 3, 3), black);
    canvas.drawRect(const Rect.fromLTWH(38, 38, 3, 3), cyanPaint);
    canvas.drawRect(const Rect.fromLTWH(42, 38, 3, 3), black);

    canvas.drawRect(const Rect.fromLTWH(18, 42, 3, 3), cyanPaint);
    canvas.drawRect(const Rect.fromLTWH(22, 42, 3, 3), black);
    canvas.drawRect(const Rect.fromLTWH(26, 42, 2, 3), black);
    canvas.drawRect(const Rect.fromLTWH(29, 42, 3, 3), black);

    canvas.restore();
  }

  void _drawCornerBrackets(Canvas canvas, Offset center) {
    if (cornerSlide <= 0) return;

    final offset = 20 * (1 - cornerSlide);
    final opacity = cornerSlide;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = _cyanBright.withValues(alpha: opacity);

    // グローエフェクト
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = _cyanBright.withValues(alpha: opacity * 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // パルスアニメーション
    final pulse = 0.8 + 0.2 * math.sin(scanProgress * 2 * math.pi);
    paint.color = _cyanBright.withValues(alpha: opacity * pulse);

    // スキャンエリアの座標
    const left = 100.0;
    const top = 90.0;
    const right = 180.0;
    const bottom = 180.0;

    // 左上コーナー
    final tl = Path()
      ..moveTo(left - offset, top + 10 - offset)
      ..lineTo(left - offset, top - offset)
      ..lineTo(left + 10 - offset, top - offset);

    // 右上コーナー
    final tr = Path()
      ..moveTo(right + offset, top + 10 - offset)
      ..lineTo(right + offset, top - offset)
      ..lineTo(right - 10 + offset, top - offset);

    // 左下コーナー
    final bl = Path()
      ..moveTo(left - offset, bottom - 10 + offset)
      ..lineTo(left - offset, bottom + offset)
      ..lineTo(left + 10 - offset, bottom + offset);

    // 右下コーナー
    final br = Path()
      ..moveTo(right + offset, bottom - 10 + offset)
      ..lineTo(right + offset, bottom + offset)
      ..lineTo(right - 10 + offset, bottom + offset);

    for (final path in [tl, tr, bl, br]) {
      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, paint);
    }
  }

  void _drawScanLine(Canvas canvas, Offset center) {
    if (cornerSlide < 0.5) return;

    final lineOpacity = (cornerSlide - 0.5) * 2;
    // スキャンラインの往復
    final y = 90.0 + scanProgress * 90.0;

    canvas.save();
    canvas.clipRect(const Rect.fromLTRB(100, 90, 180, 180));

    final linePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0x0000BCD4),
          Color(0x4D00E5FF),
          Color(0xE600E5FF),
          Color(0x4D00E5FF),
          Color(0x0000BCD4),
        ],
        stops: [0, 0.2, 0.5, 0.8, 1],
      ).createShader(Rect.fromLTWH(100, y - 1.5, 80, 3))
      ..strokeWidth = 3;

    // メインラインのグロー
    final glowLinePaint = Paint()
      ..color = _cyanBright.withValues(alpha: 0.3 * lineOpacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      ..strokeWidth = 3;

    canvas.drawLine(Offset(100, y), Offset(180, y), glowLinePaint);
    canvas.drawLine(Offset(100, y), Offset(180, y), linePaint);

    // サブライン
    final subLinePaint = Paint()
      ..color = _cyan.withValues(alpha: 0.15 * lineOpacity)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(100, y + 2), Offset(180, y + 2), subLinePaint);

    canvas.restore();
  }

  void _drawCornerDots(Canvas canvas, Offset center) {
    if (cornerSlide <= 0) return;
    final opacity = 0.8 * cornerSlide;
    final paint = Paint()
      ..color = _cyanBright.withValues(alpha: opacity);

    const dots = [
      Offset(103, 93),
      Offset(177, 93),
      Offset(103, 177),
      Offset(177, 177),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScanIllustrationPainter oldDelegate) {
    return oldDelegate.phoneFade != phoneFade ||
        oldDelegate.qrScale != qrScale ||
        oldDelegate.cornerSlide != cornerSlide ||
        oldDelegate.scanProgress != scanProgress ||
        oldDelegate.particleRotation != particleRotation;
  }
}
