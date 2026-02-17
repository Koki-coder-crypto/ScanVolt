import 'package:scanvolt/features/scan/domain/models/scan_result.dart';

/// 履歴データの抽象リポジトリ。
abstract class HistoryRepository {
  /// 全スキャン履歴を取得する。
  Future<List<ScanResult>> getAllScans();

  /// 直近 [limit] 件のスキャン履歴を取得する。
  Future<List<ScanResult>> getRecentScans(int limit);

  /// スキャン結果を保存する。
  Future<void> saveScan(ScanResult result);

  /// 指定 [id] のスキャン履歴を削除する。
  Future<void> deleteScan(String id);

  /// 指定 [id] のお気に入りフラグを切り替える。
  Future<void> toggleFavorite(String id, {required bool isFavorite});

  /// 全スキャン履歴をリアルタイムで監視する。
  Stream<List<ScanResult>> watchAllScans();
}
