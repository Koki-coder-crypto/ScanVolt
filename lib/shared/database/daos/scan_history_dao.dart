import 'package:drift/drift.dart';
import 'package:scanvolt/shared/database/app_database.dart';

part 'scan_history_dao.g.dart';

/// スキャン履歴テーブルへのデータアクセスオブジェクト。
@DriftAccessor(tables: [ScanHistoryTable])
class ScanHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$ScanHistoryDaoMixin {
  /// [ScanHistoryDao] を生成する。
  ScanHistoryDao(super.attachedDatabase);

  /// 全スキャン履歴を日付降順で取得する。
  Future<List<ScanHistoryTableData>> getAllScans() {
    return (select(scanHistoryTable)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.scannedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  /// 直近 [limit] 件のスキャン履歴を取得する。
  Future<List<ScanHistoryTableData>> getRecentScans(int limit) {
    return (select(scanHistoryTable)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.scannedAt,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(limit))
        .get();
  }

  /// スキャン履歴を挿入する。
  Future<int> insertScan(ScanHistoryTableCompanion entry) {
    return into(scanHistoryTable).insert(entry);
  }

  /// 指定 [id] のスキャン履歴を削除する。
  Future<bool> deleteScan(String id) async {
    final rows = await (delete(scanHistoryTable)
          ..where((t) => t.id.equals(id)))
        .go();
    return rows > 0;
  }

  /// 指定 [id] のお気に入りフラグを切り替える。
  Future<int> toggleFavorite(String id, {required bool isFavorite}) {
    return (update(scanHistoryTable)..where((t) => t.id.equals(id))).write(
      ScanHistoryTableCompanion(isFavorite: Value(isFavorite)),
    );
  }

  /// 全スキャン履歴をリアルタイムで監視する。
  Stream<List<ScanHistoryTableData>> watchAllScans() {
    return (select(scanHistoryTable)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.scannedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }
}
