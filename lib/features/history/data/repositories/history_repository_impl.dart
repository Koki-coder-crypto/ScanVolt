import 'package:drift/drift.dart';
import 'package:scanvolt/features/history/domain/repositories/history_repository.dart';
import 'package:scanvolt/features/scan/domain/models/scan_result.dart';
import 'package:scanvolt/shared/database/app_database.dart';
import 'package:scanvolt/shared/database/daos/scan_history_dao.dart';

/// [HistoryRepository] の実装。
class HistoryRepositoryImpl implements HistoryRepository {
  /// [HistoryRepositoryImpl] を生成する。
  HistoryRepositoryImpl(this._dao);

  final ScanHistoryDao _dao;

  @override
  Future<List<ScanResult>> getAllScans() async {
    final rows = await _dao.getAllScans();
    return rows.map(_toScanResult).toList();
  }

  @override
  Future<List<ScanResult>> getRecentScans(int limit) async {
    final rows = await _dao.getRecentScans(limit);
    return rows.map(_toScanResult).toList();
  }

  @override
  Future<void> saveScan(ScanResult result) async {
    await _dao.insertScan(
      ScanHistoryTableCompanion.insert(
        id: result.id,
        rawValue: result.rawValue,
        format: result.format,
        dataType: result.dataType.name,
        displayValue: Value(result.displayValue),
        isFavorite: Value(result.isFavorite),
        scannedAt: result.scannedAt,
      ),
    );
  }

  @override
  Future<void> deleteScan(String id) async {
    await _dao.deleteScan(id);
  }

  @override
  Future<void> toggleFavorite(String id, {required bool isFavorite}) async {
    await _dao.toggleFavorite(id, isFavorite: isFavorite);
  }

  @override
  Stream<List<ScanResult>> watchAllScans() {
    return _dao.watchAllScans().map(
          (rows) => rows.map(_toScanResult).toList(),
        );
  }

  ScanResult _toScanResult(ScanHistoryTableData row) {
    return ScanResult(
      id: row.id,
      rawValue: row.rawValue,
      format: row.format,
      dataType: ScanDataType.values.byName(row.dataType),
      scannedAt: row.scannedAt,
      displayValue: row.displayValue,
      isFavorite: row.isFavorite,
    );
  }
}
