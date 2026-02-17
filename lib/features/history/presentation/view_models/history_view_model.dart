import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scanvolt/features/history/data/repositories/providers.dart';
import 'package:scanvolt/features/history/domain/repositories/history_repository.dart';
import 'package:scanvolt/features/scan/domain/models/scan_result.dart';

part 'history_view_model.freezed.dart';

/// 履歴画面の状態。
@freezed
abstract class HistoryState with _$HistoryState {
  /// [HistoryState] を生成する。
  const factory HistoryState({
    @Default([]) List<ScanResult> scans,
    @Default(false) bool isLoading,
    String? error,
  }) = _HistoryState;
}

/// 履歴画面の ViewModel。
class HistoryViewModel extends Notifier<HistoryState> {
  @override
  HistoryState build() {
    unawaited(_loadScans());
    return const HistoryState();
  }

  HistoryRepository get _repository => ref.read(historyRepositoryProvider);

  /// スキャン履歴を読み込む。
  Future<void> _loadScans() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final scans = await _repository.getAllScans();
      state = state.copyWith(scans: scans, isLoading: false);
    } on Exception catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// スキャン履歴を再読み込みする。
  Future<void> loadScans() => _loadScans();

  /// 指定 [id] のスキャン履歴を削除する。
  Future<void> deleteScan(String id) async {
    try {
      await _repository.deleteScan(id);
      await _loadScans();
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 指定 [id] のお気に入りフラグを切り替える。
  Future<void> toggleFavorite(String id, {required bool isFavorite}) async {
    try {
      await _repository.toggleFavorite(id, isFavorite: isFavorite);
      await _loadScans();
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

/// [HistoryViewModel] の Riverpod プロバイダー。
final historyViewModelProvider =
    NotifierProvider<HistoryViewModel, HistoryState>(HistoryViewModel.new);
