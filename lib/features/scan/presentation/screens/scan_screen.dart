import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/scan/presentation/view_models/scan_view_model.dart';
import 'package:scanvolt/features/scan/presentation/widgets/scan_bottom_actions.dart';
import 'package:scanvolt/features/scan/presentation/widgets/scan_overlay.dart';
import 'package:scanvolt/features/scan/presentation/widgets/scan_result_sheet.dart';

/// QR・バーコードスキャン画面。
class ScanScreen extends ConsumerStatefulWidget {
  /// [ScanScreen] を生成する。
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  late final MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController();
  }

  @override
  void dispose() {
    unawaited(_controller.dispose());
    super.dispose();
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    final scanVm = ref.read(scanViewModelProvider.notifier);
    final currentState = ref.read(scanViewModelProvider);
    if (!currentState.isScanning) return;

    scanVm.onBarcodeDetected(capture);

    final result = ref.read(scanViewModelProvider).lastResult;
    if (result != null) {
      unawaited(HapticFeedback.mediumImpact());
      unawaited(_controller.stop());
      _showResultSheet();
    }
  }

  void _showResultSheet() {
    unawaited(
      showScanResultSheet(
        context: context,
        result: ref.read(scanViewModelProvider).lastResult!,
      ).then((_) {
        ref.read(scanViewModelProvider.notifier).reset();
        unawaited(_controller.start());
      }),
    );
  }

  Future<void> _onFlashToggle() async {
    await _controller.toggleTorch();
    ref.read(scanViewModelProvider.notifier).toggleTorch();
  }

  Future<void> _onLensSwitch() async {
    await _controller.switchCamera();
  }

  Future<void> _onImagePick() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final capture = await _controller.analyzeImage(image.path);
    if (capture == null || capture.barcodes.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No QR code found in image')),
        );
      }
    } else {
      _onBarcodeDetected(capture);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(scanViewModelProvider);

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: Stack(
        children: [
          // カメラプレビュー
          MobileScanner(
            controller: _controller,
            onDetect: _onBarcodeDetected,
          ),

          // スキャンオーバーレイ
          const ScanOverlay(),

          // アプリ名ラベル（右上）
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: Text(
              'ScanVolt',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryCyan,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          // ガイドテキスト
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.30,
            child: Text(
              'Point camera at a QR code',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ),

          // 下部アクションバー
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.14,
            child: ScanBottomActions(
              onFlashToggle: _onFlashToggle,
              onLensSwitch: _onLensSwitch,
              onImagePick: _onImagePick,
              isFlashOn: scanState.torchEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
