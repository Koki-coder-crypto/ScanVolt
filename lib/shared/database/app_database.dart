import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// スキャン履歴テーブル定義。
class ScanHistoryTable extends Table {
  /// 一意の識別子。
  TextColumn get id => text()();

  /// スキャンされた生データ。
  TextColumn get rawValue => text()();

  /// バーコードフォーマット（例: qrCode, ean13）。
  TextColumn get format => text()();

  /// データ種別（ScanDataType の name を文字列で保存）。
  TextColumn get dataType => text()();

  /// 表示用の値。
  TextColumn get displayValue => text().nullable()();

  /// お気に入りフラグ。
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  /// スキャン日時。
  DateTimeColumn get scannedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// アプリケーションのローカルデータベース。
@DriftDatabase(tables: [ScanHistoryTable])
class AppDatabase extends _$AppDatabase {
  /// [AppDatabase] を生成する。
  AppDatabase() : super(_openConnection());

  /// テスト用コンストラクタ。
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'scanvolt.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
