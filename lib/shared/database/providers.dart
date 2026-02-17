import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanvolt/shared/database/app_database.dart';
import 'package:scanvolt/shared/database/daos/scan_history_dao.dart';

/// [AppDatabase] の Riverpod プロバイダー。
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// [ScanHistoryDao] の Riverpod プロバイダー。
final scanHistoryDaoProvider = Provider<ScanHistoryDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ScanHistoryDao(db);
});
