import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scanvolt/core/utils/qr_data_encoder.dart';
import 'package:scanvolt/features/generate/domain/models/qr_content.dart';

part 'generate_view_model.freezed.dart';

/// QR コード生成画面の状態。
@freezed
abstract class GenerateState with _$GenerateState {
  /// [GenerateState] を生成する。
  const factory GenerateState({
    @Default(QrContentType.url) QrContentType selectedType,
    @Default('') String inputData,
    String? generatedData,
  }) = _GenerateState;
}

/// QR コード生成画面の ViewModel。
class GenerateViewModel extends Notifier<GenerateState> {
  @override
  GenerateState build() => const GenerateState();

  /// コンテンツ種別を選択する。
  void selectType(QrContentType type) {
    state = state.copyWith(selectedType: type, generatedData: null);
  }

  /// 入力データを更新する。
  void updateInput(String input) {
    state = state.copyWith(inputData: input);
  }

  /// 入力データから QR コード用文字列を生成する。
  void generate() {
    final data = state.inputData;
    if (data.isEmpty) return;

    final String encoded;
    switch (state.selectedType) {
      case QrContentType.url:
        encoded = QrDataEncoder.encodeUrl(data);
      case QrContentType.text:
        encoded = QrDataEncoder.encodeText(data);
      case QrContentType.wifi:
        encoded = QrDataEncoder.encodeWifi(ssid: data, password: '');
      case QrContentType.contact:
        encoded = QrDataEncoder.encodeContact(name: data);
    }

    state = state.copyWith(generatedData: encoded);
  }
}

/// [GenerateViewModel] の Riverpod プロバイダー。
final generateViewModelProvider =
    NotifierProvider<GenerateViewModel, GenerateState>(
  GenerateViewModel.new,
);
