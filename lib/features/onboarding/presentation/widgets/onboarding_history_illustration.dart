// ignore_for_file: cascade_invocations, CustomPainterのCanvas連続呼び出しは可読性優先

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:scanvolt/app/theme.dart';

/// 「History at a Glance」ページ用のアニメーションイラスト。
///
/// 検索バー、フィルターチップ、履歴カード3枚、シマーエフェクトを
/// CustomPainter + AnimationController で描画する。
class OnboardingHistoryIllustration extends StatefulWidget {
  /// [OnboardingHistoryIllustration] を生成する。
  const OnboardingHistoryIllustration({super.key});

  @override
  State<OnboardingHistoryIllustration> createState() =>
      _OnboardingHistoryIllustrationState();
}

class _OnboardingHistoryIllustrationState
    extends State<OnboardingHistoryIllustration>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _shimmerController;

  late final Animation<double> _searchSlide;
  late final Animation<double> _chipsSlide;
  late final Animation<double> _card1Slide;
  late final Animation<double> _card2Slide;
  late final Animation<double> _card3Slide;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _searchSlide = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    _chipsSlide = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _card1Slide = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _card2Slide = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _card3Slide = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.6, 1, curve: Curves.easeOutCubic),
      ),
    );

    // シマーループ
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    unawaited(_shimmerController.repeat());

    unawaited(_entryController.forward());
  }

  @override
  void dispose() {
    _entryController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: AnimatedBuilder(
        animation: Listenable.merge([_entryController, _shimmerController]),
        builder: (context, _) {
          return CustomPaint(
            size: const Size(280, 280),
            painter: _HistoryIllustrationPainter(
              searchSlide: _searchSlide.value,
              chipsSlide: _chipsSlide.value,
              card1Slide: _card1Slide.value,
              card2Slide: _card2Slide.value,
              card3Slide: _card3Slide.value,
              shimmerProgress: _shimmerController.value,
            ),
          );
        },
      ),
    );
  }
}

class _HistoryIllustrationPainter extends CustomPainter {
  _HistoryIllustrationPainter({
    required this.searchSlide,
    required this.chipsSlide,
    required this.card1Slide,
    required this.card2Slide,
    required this.card3Slide,
    required this.shimmerProgress,
  });

  final double searchSlide;
  final double chipsSlide;
  final double card1Slide;
  final double card2Slide;
  final double card3Slide;
  final double shimmerProgress;

  static const Color _cyan = AppTheme.primaryCyan;
  static const _cyanBright = Color(0xFF00E5FF);

  // キャンバスのレイアウト原点
  static const _originX = 50.0;
  static const _originY = 55.0;
  static const _contentWidth = 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    _drawBackgroundCircles(canvas, center);
    _drawGridLines(canvas);
    _drawSearchBar(canvas);
    _drawFilterChips(canvas);
    _drawCard1(canvas);
    _drawCard2(canvas);
    _drawCard3(canvas);
    _drawSparkles(canvas, center);
    _drawFlowLines(canvas);
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

  void _drawGridLines(Canvas canvas) {
    final gridPaint = Paint()
      ..color = _cyan.withValues(alpha: 0.04)
      ..strokeWidth = 0.5;

    // 縦線
    canvas.drawLine(
      const Offset(50, 60),
      const Offset(50, 220),
      gridPaint,
    );
    canvas.drawLine(
      const Offset(230, 60),
      const Offset(230, 220),
      gridPaint,
    );

    // 横線
    for (final y in [80.0, 140.0, 200.0]) {
      canvas.drawLine(Offset(50, y), Offset(230, y), gridPaint);
    }
  }

  void _drawSearchBar(Canvas canvas) {
    if (searchSlide <= 0) return;

    final slideOffset = (1 - searchSlide) * -30;
    final opacity = searchSlide;

    canvas.save();
    canvas.translate(0, slideOffset);

    // シャドウ
    final shadowPaint = Paint()
      ..color = _cyan.withValues(alpha: 0.5 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(_originX, _originY, _contentWidth, 40),
        const Radius.circular(20),
      ),
      shadowPaint,
    );

    // 背景
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF404040).withValues(alpha: opacity),
          const Color(0xFF2E2E2E).withValues(alpha: opacity),
        ],
      ).createShader(
        const Rect.fromLTWH(_originX, _originY, _contentWidth, 40),
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(_originX, _originY, _contentWidth, 40),
        const Radius.circular(20),
      ),
      bgPaint,
    );

    // ボーダー
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(_originX + 1, _originY + 1, 178, 38),
        const Radius.circular(19),
      ),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..shader = LinearGradient(
          colors: [
            _cyanBright.withValues(alpha: opacity),
            _cyan.withValues(alpha: opacity),
          ],
        ).createShader(
          const Rect.fromLTWH(_originX, _originY, _contentWidth, 40),
        ),
    );

    // 虫眼鏡アイコン
    final searchIconPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [
          _cyanBright.withValues(alpha: opacity),
          _cyan.withValues(alpha: opacity),
        ],
      ).createShader(
        const Rect.fromLTWH(_originX + 10, _originY + 10, 20, 20),
      );

    // グロー
    final searchGlowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..color = _cyanBright.withValues(alpha: 0.3 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawCircle(
      const Offset(_originX + 18, _originY + 20),
      7,
      searchGlowPaint,
    );
    canvas.drawCircle(
      const Offset(_originX + 18, _originY + 20),
      7,
      searchIconPaint,
    );

    canvas.drawLine(
      const Offset(_originX + 23, _originY + 25),
      const Offset(_originX + 28, _originY + 30),
      searchGlowPaint,
    );
    canvas.drawLine(
      const Offset(_originX + 23, _originY + 25),
      const Offset(_originX + 28, _originY + 30),
      searchIconPaint,
    );

    // プレースホルダーテキスト
    _drawText(
      canvas,
      'Search history...',
      const Offset(_originX + 36, _originY + 12),
      13,
      const Color(0xFF909090).withValues(alpha: opacity),
      FontWeight.w500,
    );

    canvas.restore();
  }

  void _drawFilterChips(Canvas canvas) {
    if (chipsSlide <= 0) return;

    const chipY = _originY + 52;
    final opacity = chipsSlide;

    // 「All」チップ（アクティブ）
    final chipSlide0 = ((chipsSlide - 0) / 0.5).clamp(0.0, 1.0);
    if (chipSlide0 > 0) {
      final slideX = (1 - chipSlide0) * -30;

      canvas.save();
      canvas.translate(slideX, 0);

      // グロー
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX, chipY, 48, 28),
          const Radius.circular(14),
        ),
        Paint()
          ..color = _cyanBright.withValues(alpha: 0.3 * opacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );

      // 背景
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX, chipY, 48, 28),
          const Radius.circular(14),
        ),
        Paint()
          ..shader = LinearGradient(
            colors: [
              _cyanBright.withValues(alpha: 0.3 * opacity),
              _cyan.withValues(alpha: 0.3 * opacity),
            ],
          ).createShader(const Rect.fromLTWH(_originX, chipY, 48, 28)),
      );

      // ボーダー
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX + 1, chipY + 1, 46, 26),
          const Radius.circular(13),
        ),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..shader = LinearGradient(
            colors: [
              _cyanBright.withValues(alpha: opacity),
              _cyan.withValues(alpha: opacity),
            ],
          ).createShader(const Rect.fromLTWH(_originX, chipY, 48, 28)),
      );

      // ハイライト
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX + 3, chipY + 3, 42, 10),
          const Radius.circular(10),
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.1 * opacity),
      );

      _drawText(
        canvas,
        'All',
        const Offset(_originX + 17, chipY + 4),
        12,
        _cyanBright.withValues(alpha: opacity),
        FontWeight.w700,
      );

      canvas.restore();
    }

    // 「Links」チップ
    final chipSlide1 = ((chipsSlide - 0.15) / 0.5).clamp(0.0, 1.0);
    if (chipSlide1 > 0) {
      final slideX = (1 - chipSlide1) * -30;

      canvas.save();
      canvas.translate(slideX, 0);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX + 56, chipY, 56, 28),
          const Radius.circular(14),
        ),
        Paint()..color = const Color(0xFF2C2C2C).withValues(alpha: opacity),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX + 57, chipY + 1, 54, 26),
          const Radius.circular(13),
        ),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = const Color(0xFF3C3C3C).withValues(alpha: opacity),
      );
      _drawText(
        canvas,
        'Links',
        const Offset(_originX + 69, chipY + 4),
        12,
        const Color(0xFFA0A0A0).withValues(alpha: opacity),
        FontWeight.w600,
      );

      canvas.restore();
    }

    // 「QR」チップ
    final chipSlide2 = ((chipsSlide - 0.3) / 0.5).clamp(0.0, 1.0);
    if (chipSlide2 > 0) {
      final slideX = (1 - chipSlide2) * -30;

      canvas.save();
      canvas.translate(slideX, 0);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX + 120, chipY, 48, 28),
          const Radius.circular(14),
        ),
        Paint()..color = const Color(0xFF2C2C2C).withValues(alpha: opacity),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(_originX + 121, chipY + 1, 46, 26),
          const Radius.circular(13),
        ),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = const Color(0xFF3C3C3C).withValues(alpha: opacity),
      );
      _drawText(
        canvas,
        'QR',
        const Offset(_originX + 136, chipY + 4),
        12,
        const Color(0xFFA0A0A0).withValues(alpha: opacity),
        FontWeight.w600,
      );

      canvas.restore();
    }
  }

  void _drawCard1(Canvas canvas) {
    _drawHistoryCard(
      canvas,
      progress: card1Slide,
      yOffset: _originY + 95,
      title: 'Product Page',
      subtitle: '2 hours ago',
      iconType: 0,
      showPulse: true,
      cardOpacity: 1,
    );
  }

  void _drawCard2(Canvas canvas) {
    _drawHistoryCard(
      canvas,
      progress: card2Slide,
      yOffset: _originY + 160,
      title: 'Restaurant Menu',
      subtitle: 'Yesterday',
      iconType: 1,
      showPulse: false,
      cardOpacity: 1,
    );
  }

  void _drawCard3(Canvas canvas) {
    _drawHistoryCard(
      canvas,
      progress: card3Slide,
      yOffset: _originY + 225,
      title: 'WiFi Network',
      subtitle: '',
      iconType: 2,
      showPulse: false,
      cardOpacity: 0.5,
      isPartial: true,
    );
  }

  void _drawHistoryCard(
    Canvas canvas, {
    required double progress,
    required double yOffset,
    required String title,
    required String subtitle,
    required int iconType,
    required bool showPulse,
    required double cardOpacity,
    bool isPartial = false,
  }) {
    if (progress <= 0) return;

    final slideY = (1 - progress) * 30;
    final opacity = progress * cardOpacity;
    final cardHeight = isPartial ? 30.0 : 56.0;

    canvas.save();
    canvas.translate(0, slideY);

    // カードシャドウ
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(_originX, yOffset, _contentWidth, cardHeight),
        const Radius.circular(12),
      ),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.4 * opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // カード背景グラデーション
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(_originX, yOffset, _contentWidth, cardHeight),
        const Radius.circular(12),
      ),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF383838).withValues(alpha: opacity),
            const Color(0xFF2E2E2E).withValues(alpha: opacity),
            const Color(0xFF282828).withValues(alpha: opacity),
          ],
        ).createShader(
          Rect.fromLTWH(_originX, yOffset, _contentWidth, cardHeight),
        ),
    );

    // ボーダー
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          _originX + 1,
          yOffset + 1,
          _contentWidth - 2,
          cardHeight - 2,
        ),
        const Radius.circular(11),
      ),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = const Color(0xFF404040).withValues(alpha: opacity),
    );

    // カード上部ハイライト
    if (!isPartial) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(_originX + 2, yOffset + 2, _contentWidth - 4, 20),
          const Radius.circular(10),
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.02 * opacity),
      );
    }

    // シマーエフェクト
    if (!isPartial) {
      _drawShimmer(canvas, _originX, yOffset, _contentWidth, cardHeight,
          opacity);
    }

    // アイコンコンテナ
    const iconX = _originX + 12;
    final iconY = isPartial ? yOffset + 7 : yOffset + 12;
    final iconSize = isPartial ? 16.0 : 32.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(iconX, iconY, iconSize, iconSize),
        Radius.circular(isPartial ? 4 : 8),
      ),
      Paint()
        ..shader = RadialGradient(
          colors: [
            _cyanBright.withValues(alpha: 0.3 * opacity),
            _cyan.withValues(alpha: 0.15 * opacity),
          ],
        ).createShader(Rect.fromLTWH(iconX, iconY, iconSize, iconSize)),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(iconX + 0.5, iconY + 0.5, iconSize - 1, iconSize - 1),
        Radius.circular(isPartial ? 3.5 : 7.5),
      ),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = _cyan.withValues(alpha: 0.4 * opacity),
    );

    // ミニアイコン描画
    if (iconType == 0) {
      _drawMiniLinkIcon(canvas, iconX, iconY, iconSize, opacity);
    } else if (iconType == 1) {
      _drawMiniQrIcon(canvas, iconX, iconY, iconSize, opacity);
    } else {
      _drawMiniWifiIcon(canvas, iconX, iconY, iconSize, opacity);
    }

    // テキスト
    final textX = isPartial ? _originX + 36 : _originX + 52;
    _drawText(
      canvas,
      title,
      Offset(textX, isPartial ? yOffset + 7 : yOffset + 13),
      isPartial ? 11.0 : 13.0,
      Colors.white.withValues(alpha: opacity * (isPartial ? 0.9 : 1)),
      FontWeight.w700,
    );

    if (subtitle.isNotEmpty && !isPartial) {
      _drawText(
        canvas,
        subtitle,
        Offset(textX, yOffset + 28),
        10,
        const Color(0xFF808080).withValues(alpha: opacity),
        FontWeight.w500,
      );
    }

    // ステータスインジケーター
    if (showPulse) {
      const indicatorX = _originX + 155;
      final indicatorY = yOffset + 22;

      canvas.drawCircle(
        Offset(indicatorX, indicatorY),
        6,
        Paint()..color = _cyan.withValues(alpha: 0.2 * opacity),
      );
      canvas.drawCircle(
        Offset(indicatorX, indicatorY),
        3,
        Paint()
          ..shader = LinearGradient(
            colors: [
              _cyanBright.withValues(alpha: opacity),
              _cyan.withValues(alpha: opacity),
            ],
          ).createShader(
            Rect.fromLTWH(indicatorX - 3, indicatorY - 3, 6, 6),
          ),
      );

      // パルスアニメーション
      final pulsePhase = shimmerProgress;
      final pulseScale = 1.0 + pulsePhase * 0.6;
      final pulseOpacity = 0.5 * (1 - pulsePhase) * opacity;
      canvas.drawCircle(
        Offset(indicatorX, indicatorY),
        6 * pulseScale,
        Paint()
          ..color = _cyan.withValues(alpha: pulseOpacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    } else if (!isPartial) {
      const indicatorX = _originX + 155;
      final indicatorY = yOffset + 22;
      canvas.drawCircle(
        Offset(indicatorX, indicatorY),
        6,
        Paint()..color = _cyan.withValues(alpha: 0.15 * opacity),
      );
      canvas.drawCircle(
        Offset(indicatorX, indicatorY),
        3,
        Paint()..color = _cyan.withValues(alpha: 0.5 * opacity),
      );
    }

    // アクセントライン
    if (!isPartial) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(_originX + 177, yOffset + 22, 3, 12),
          const Radius.circular(1.5),
        ),
        Paint()
          ..shader = LinearGradient(
            colors: [
              _cyanBright.withValues(
                alpha: (showPulse ? 0.6 : 0.3) * opacity,
              ),
              _cyan.withValues(alpha: (showPulse ? 0.6 : 0.3) * opacity),
            ],
          ).createShader(
            Rect.fromLTWH(_originX + 177, yOffset + 22, 3, 12),
          ),
      );
    }

    canvas.restore();
  }

  void _drawShimmer(
    Canvas canvas,
    double x,
    double y,
    double width,
    double height,
    double opacity,
  ) {
    final shimmerX = x + (shimmerProgress * (width + 60)) - 30;

    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, width, height),
        const Radius.circular(12),
      ),
    );

    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.04 * opacity),
          Colors.white.withValues(alpha: 0),
        ],
        stops: const [0, 0.5, 1],
      ).createShader(Rect.fromLTWH(shimmerX - 15, y, 30, height));
    canvas.drawRect(
      Rect.fromLTWH(shimmerX - 15, y, 30, height),
      shimmerPaint,
    );

    canvas.restore();
  }

  void _drawMiniLinkIcon(
    Canvas canvas,
    double x,
    double y,
    double size,
    double opacity,
  ) {
    final cx = x + size / 2;
    final cy = y + size / 2;
    final scale = size / 32;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..shader = LinearGradient(
        colors: [
          _cyanBright.withValues(alpha: opacity),
          _cyan.withValues(alpha: opacity),
        ],
      ).createShader(Rect.fromLTWH(cx - 10, cy - 10, 20, 20));

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = _cyanBright.withValues(alpha: 0.3 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    final path = Path()
      ..moveTo(cx - 6 * scale, cy - 2 * scale)
      ..lineTo(cx - 2 * scale, cy - 6 * scale);

    final path2 = Path()
      ..moveTo(cx + 2 * scale, cy + 6 * scale)
      ..lineTo(cx + 6 * scale, cy + 2 * scale);

    for (final p in [path, path2]) {
      canvas.drawPath(p, glowPaint);
      canvas.drawPath(p, paint);
    }
  }

  void _drawMiniQrIcon(
    Canvas canvas,
    double x,
    double y,
    double size,
    double opacity,
  ) {
    final cx = x + size / 2;
    final cy = y + size / 2;
    final s = size * 0.5;

    // 白背景
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy), width: s, height: s),
        const Radius.circular(2),
      ),
      Paint()..color = Colors.white.withValues(alpha: opacity),
    );

    final black = Paint()..color = Colors.black.withValues(alpha: opacity);
    final cyanP = Paint()..color = _cyan.withValues(alpha: opacity);
    final half = s / 2;
    final qx = cx - half;
    final qy = cy - half;
    final cellW = s / 6;

    // コーナーマーカー簡易版
    // 左上
    canvas.drawRect(Rect.fromLTWH(qx + cellW * 0.2, qy + cellW * 0.2,
        cellW * 2, cellW * 2), black);
    canvas.drawRect(Rect.fromLTWH(qx + cellW * 0.4, qy + cellW * 0.4,
        cellW * 1.6, cellW * 1.6), Paint()..color = Colors.white.withValues(alpha: opacity));
    canvas.drawRect(Rect.fromLTWH(qx + cellW * 0.7, qy + cellW * 0.7,
        cellW, cellW), black);

    // 右上
    canvas.drawRect(Rect.fromLTWH(qx + s - cellW * 2.2, qy + cellW * 0.2,
        cellW * 2, cellW * 2), black);

    // 左下
    canvas.drawRect(Rect.fromLTWH(qx + cellW * 0.2, qy + s - cellW * 2.2,
        cellW * 2, cellW * 2), black);

    // データモジュール
    canvas.drawRect(
      Rect.fromLTWH(qx + cellW * 3, qy + cellW * 0.5, cellW * 0.8, cellW * 0.8),
      cyanP,
    );
    canvas.drawRect(
      Rect.fromLTWH(qx + cellW * 3, qy + cellW * 3, cellW * 0.8, cellW * 0.8),
      cyanP,
    );
  }

  void _drawMiniWifiIcon(
    Canvas canvas,
    double x,
    double y,
    double size,
    double opacity,
  ) {
    final cx = x + size / 2;
    final cy = y + size / 2;
    final scale = size / 32;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5 * scale
      ..shader = LinearGradient(
        colors: [
          _cyanBright.withValues(alpha: opacity),
          _cyan.withValues(alpha: opacity),
        ],
      ).createShader(Rect.fromLTWH(cx - 8, cy - 8, 16, 16));

    // 外側アーク
    final arc1 = Path()
      ..addArc(
        Rect.fromCenter(
          center: Offset(cx, cy),
          width: 12 * scale,
          height: 12 * scale,
        ),
        math.pi + math.pi * 0.25,
        math.pi * 0.5,
      );
    canvas.drawPath(arc1, paint);

    // 内側アーク
    final arc2 = Path()
      ..addArc(
        Rect.fromCenter(
          center: Offset(cx, cy + 1 * scale),
          width: 7 * scale,
          height: 7 * scale,
        ),
        math.pi + math.pi * 0.25,
        math.pi * 0.5,
      );
    paint.strokeWidth = 1.3 * scale;
    canvas.drawPath(arc2, paint);

    // 中央ドット
    canvas.drawCircle(
      Offset(cx, cy + 3.5 * scale),
      0.8 * scale,
      Paint()
        ..shader = LinearGradient(
          colors: [
            _cyanBright.withValues(alpha: opacity),
            _cyan.withValues(alpha: opacity),
          ],
        ).createShader(Rect.fromLTWH(cx - 1, cy + 2, 2, 2)),
    );
  }

  void _drawSparkles(Canvas canvas, Offset center) {
    final sparkles = [
      const Offset(95, -50),
      const Offset(-98, 65),
      const Offset(98, 35),
    ];

    for (var i = 0; i < sparkles.length; i++) {
      final phase = (shimmerProgress + i * 0.4) % 1.0;
      final opacity = math.sin(phase * math.pi);
      final pos = center + sparkles[i];
      canvas.drawCircle(
        pos,
        2,
        Paint()
          ..color =
              (i.isEven ? _cyanBright : _cyan).withValues(alpha: opacity * 0.7),
      );
      canvas.drawCircle(
        pos,
        4,
        Paint()
          ..color =
              (i.isEven ? _cyanBright : _cyan).withValues(alpha: opacity * 0.2),
      );
    }
  }

  void _drawFlowLines(Canvas canvas) {
    // 点線の流れエフェクト
    for (var i = 0; i < 2; i++) {
      final phase = (shimmerProgress + i * 0.33) % 1.0;
      final opacity = math.sin(phase * math.pi) * 0.15;
      final y = i == 0 ? 130.0 : 195.0;
      _drawDashedLine(
        canvas,
        Offset(50, y),
        Offset(230, y),
        Paint()
          ..color = (i == 0 ? _cyan : _cyanBright).withValues(alpha: opacity)
          ..strokeWidth = 0.5,
      );
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final length = math.sqrt(dx * dx + dy * dy);
    final ux = dx / length;
    final uy = dy / length;

    var d = 0.0;
    while (d < length) {
      final e = math.min(d + 4, length);
      canvas.drawLine(
        Offset(start.dx + ux * d, start.dy + uy * d),
        Offset(start.dx + ux * e, start.dy + uy * e),
        paint,
      );
      d += 8;
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset position,
    double fontSize,
    Color color,
    FontWeight fontWeight,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: 'Inter',
          letterSpacing: 0.01 * fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant _HistoryIllustrationPainter oldDelegate) {
    return oldDelegate.searchSlide != searchSlide ||
        oldDelegate.chipsSlide != chipsSlide ||
        oldDelegate.card1Slide != card1Slide ||
        oldDelegate.card2Slide != card2Slide ||
        oldDelegate.card3Slide != card3Slide ||
        oldDelegate.shimmerProgress != shimmerProgress;
  }
}
