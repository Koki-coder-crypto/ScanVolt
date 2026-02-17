import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanvolt/core/utils/scan_data_classifier.dart';
import 'package:scanvolt/features/scan/domain/models/scan_result.dart';

part 'scan_view_model.freezed.dart';

/// スキャン画面の状態。
@freezed
abstract class ScanState with _$ScanState {
  /// [ScanState] を生成する。
  const factory ScanState({
    @Default(true) bool isScanning,
    ScanResult? lastResult,
    @Default(false) bool torchEnabled,
    String? error,
  }) = _ScanState;
}

/// スキャン状態を管理する ViewModel。
class ScanViewModel extends Notifier<ScanState> {
  @override
  ScanState build() => const ScanState();

  /// バーコード検出時のコールバック。
  void onBarcodeDetected(BarcodeCapture capture) {
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final rawValue = barcode.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    final dataType = ScanDataClassifier.classify(rawValue);
    final result = ScanResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      rawValue: rawValue,
      format: barcode.format.name,
      dataType: dataType,
      scannedAt: DateTime.now(),
      displayValue: barcode.displayValue,
    );

    state = state.copyWith(lastResult: result, isScanning: false);
  }

  /// トーチの ON/OFF を切り替える。
  void toggleTorch() {
    state = state.copyWith(torchEnabled: !state.torchEnabled);
  }

  /// スキャン状態をリセットする。
  void reset() {
    state = const ScanState();
  }
}

/// [ScanViewModel] の Riverpod プロバイダー。
final scanViewModelProvider =
    NotifierProvider<ScanViewModel, ScanState>(ScanViewModel.new);
