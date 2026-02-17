// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ScanHistoryTableTable extends ScanHistoryTable
    with TableInfo<$ScanHistoryTableTable, ScanHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<String> rawValue = GeneratedColumn<String>(
    'raw_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataTypeMeta = const VerificationMeta(
    'dataType',
  );
  @override
  late final GeneratedColumn<String> dataType = GeneratedColumn<String>(
    'data_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayValueMeta = const VerificationMeta(
    'displayValue',
  );
  @override
  late final GeneratedColumn<String> displayValue = GeneratedColumn<String>(
    'display_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _scannedAtMeta = const VerificationMeta(
    'scannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> scannedAt = GeneratedColumn<DateTime>(
    'scanned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawValue,
    format,
    dataType,
    displayValue,
    isFavorite,
    scannedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    } else if (isInserting) {
      context.missing(_rawValueMeta);
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('data_type')) {
      context.handle(
        _dataTypeMeta,
        dataType.isAcceptableOrUnknown(data['data_type']!, _dataTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_dataTypeMeta);
    }
    if (data.containsKey('display_value')) {
      context.handle(
        _displayValueMeta,
        displayValue.isAcceptableOrUnknown(
          data['display_value']!,
          _displayValueMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('scanned_at')) {
      context.handle(
        _scannedAtMeta,
        scannedAt.isAcceptableOrUnknown(data['scanned_at']!, _scannedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_scannedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanHistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_value'],
      )!,
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      dataType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_type'],
      )!,
      displayValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_value'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      scannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scanned_at'],
      )!,
    );
  }

  @override
  $ScanHistoryTableTable createAlias(String alias) {
    return $ScanHistoryTableTable(attachedDatabase, alias);
  }
}

class ScanHistoryTableData extends DataClass
    implements Insertable<ScanHistoryTableData> {
  /// 一意の識別子。
  final String id;

  /// スキャンされた生データ。
  final String rawValue;

  /// バーコードフォーマット（例: qrCode, ean13）。
  final String format;

  /// データ種別（ScanDataType の name を文字列で保存）。
  final String dataType;

  /// 表示用の値。
  final String? displayValue;

  /// お気に入りフラグ。
  final bool isFavorite;

  /// スキャン日時。
  final DateTime scannedAt;
  const ScanHistoryTableData({
    required this.id,
    required this.rawValue,
    required this.format,
    required this.dataType,
    this.displayValue,
    required this.isFavorite,
    required this.scannedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['raw_value'] = Variable<String>(rawValue);
    map['format'] = Variable<String>(format);
    map['data_type'] = Variable<String>(dataType);
    if (!nullToAbsent || displayValue != null) {
      map['display_value'] = Variable<String>(displayValue);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['scanned_at'] = Variable<DateTime>(scannedAt);
    return map;
  }

  ScanHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return ScanHistoryTableCompanion(
      id: Value(id),
      rawValue: Value(rawValue),
      format: Value(format),
      dataType: Value(dataType),
      displayValue: displayValue == null && nullToAbsent
          ? const Value.absent()
          : Value(displayValue),
      isFavorite: Value(isFavorite),
      scannedAt: Value(scannedAt),
    );
  }

  factory ScanHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanHistoryTableData(
      id: serializer.fromJson<String>(json['id']),
      rawValue: serializer.fromJson<String>(json['rawValue']),
      format: serializer.fromJson<String>(json['format']),
      dataType: serializer.fromJson<String>(json['dataType']),
      displayValue: serializer.fromJson<String?>(json['displayValue']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      scannedAt: serializer.fromJson<DateTime>(json['scannedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'rawValue': serializer.toJson<String>(rawValue),
      'format': serializer.toJson<String>(format),
      'dataType': serializer.toJson<String>(dataType),
      'displayValue': serializer.toJson<String?>(displayValue),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'scannedAt': serializer.toJson<DateTime>(scannedAt),
    };
  }

  ScanHistoryTableData copyWith({
    String? id,
    String? rawValue,
    String? format,
    String? dataType,
    Value<String?> displayValue = const Value.absent(),
    bool? isFavorite,
    DateTime? scannedAt,
  }) => ScanHistoryTableData(
    id: id ?? this.id,
    rawValue: rawValue ?? this.rawValue,
    format: format ?? this.format,
    dataType: dataType ?? this.dataType,
    displayValue: displayValue.present ? displayValue.value : this.displayValue,
    isFavorite: isFavorite ?? this.isFavorite,
    scannedAt: scannedAt ?? this.scannedAt,
  );
  ScanHistoryTableData copyWithCompanion(ScanHistoryTableCompanion data) {
    return ScanHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      rawValue: data.rawValue.present ? data.rawValue.value : this.rawValue,
      format: data.format.present ? data.format.value : this.format,
      dataType: data.dataType.present ? data.dataType.value : this.dataType,
      displayValue: data.displayValue.present
          ? data.displayValue.value
          : this.displayValue,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      scannedAt: data.scannedAt.present ? data.scannedAt.value : this.scannedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryTableData(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('format: $format, ')
          ..write('dataType: $dataType, ')
          ..write('displayValue: $displayValue, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('scannedAt: $scannedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawValue,
    format,
    dataType,
    displayValue,
    isFavorite,
    scannedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanHistoryTableData &&
          other.id == this.id &&
          other.rawValue == this.rawValue &&
          other.format == this.format &&
          other.dataType == this.dataType &&
          other.displayValue == this.displayValue &&
          other.isFavorite == this.isFavorite &&
          other.scannedAt == this.scannedAt);
}

class ScanHistoryTableCompanion extends UpdateCompanion<ScanHistoryTableData> {
  final Value<String> id;
  final Value<String> rawValue;
  final Value<String> format;
  final Value<String> dataType;
  final Value<String?> displayValue;
  final Value<bool> isFavorite;
  final Value<DateTime> scannedAt;
  final Value<int> rowid;
  const ScanHistoryTableCompanion({
    this.id = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.format = const Value.absent(),
    this.dataType = const Value.absent(),
    this.displayValue = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.scannedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanHistoryTableCompanion.insert({
    required String id,
    required String rawValue,
    required String format,
    required String dataType,
    this.displayValue = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required DateTime scannedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       rawValue = Value(rawValue),
       format = Value(format),
       dataType = Value(dataType),
       scannedAt = Value(scannedAt);
  static Insertable<ScanHistoryTableData> custom({
    Expression<String>? id,
    Expression<String>? rawValue,
    Expression<String>? format,
    Expression<String>? dataType,
    Expression<String>? displayValue,
    Expression<bool>? isFavorite,
    Expression<DateTime>? scannedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawValue != null) 'raw_value': rawValue,
      if (format != null) 'format': format,
      if (dataType != null) 'data_type': dataType,
      if (displayValue != null) 'display_value': displayValue,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (scannedAt != null) 'scanned_at': scannedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanHistoryTableCompanion copyWith({
    Value<String>? id,
    Value<String>? rawValue,
    Value<String>? format,
    Value<String>? dataType,
    Value<String?>? displayValue,
    Value<bool>? isFavorite,
    Value<DateTime>? scannedAt,
    Value<int>? rowid,
  }) {
    return ScanHistoryTableCompanion(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      format: format ?? this.format,
      dataType: dataType ?? this.dataType,
      displayValue: displayValue ?? this.displayValue,
      isFavorite: isFavorite ?? this.isFavorite,
      scannedAt: scannedAt ?? this.scannedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<String>(rawValue.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (dataType.present) {
      map['data_type'] = Variable<String>(dataType.value);
    }
    if (displayValue.present) {
      map['display_value'] = Variable<String>(displayValue.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (scannedAt.present) {
      map['scanned_at'] = Variable<DateTime>(scannedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('format: $format, ')
          ..write('dataType: $dataType, ')
          ..write('displayValue: $displayValue, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScanHistoryTableTable scanHistoryTable = $ScanHistoryTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scanHistoryTable];
}

typedef $$ScanHistoryTableTableCreateCompanionBuilder =
    ScanHistoryTableCompanion Function({
      required String id,
      required String rawValue,
      required String format,
      required String dataType,
      Value<String?> displayValue,
      Value<bool> isFavorite,
      required DateTime scannedAt,
      Value<int> rowid,
    });
typedef $$ScanHistoryTableTableUpdateCompanionBuilder =
    ScanHistoryTableCompanion Function({
      Value<String> id,
      Value<String> rawValue,
      Value<String> format,
      Value<String> dataType,
      Value<String?> displayValue,
      Value<bool> isFavorite,
      Value<DateTime> scannedAt,
      Value<int> rowid,
    });

class $$ScanHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $ScanHistoryTableTable> {
  $$ScanHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataType => $composableBuilder(
    column: $table.dataType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScanHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanHistoryTableTable> {
  $$ScanHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataType => $composableBuilder(
    column: $table.dataType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScanHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanHistoryTableTable> {
  $$ScanHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get dataType =>
      $composableBuilder(column: $table.dataType, builder: (column) => column);

  GeneratedColumn<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scannedAt =>
      $composableBuilder(column: $table.scannedAt, builder: (column) => column);
}

class $$ScanHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanHistoryTableTable,
          ScanHistoryTableData,
          $$ScanHistoryTableTableFilterComposer,
          $$ScanHistoryTableTableOrderingComposer,
          $$ScanHistoryTableTableAnnotationComposer,
          $$ScanHistoryTableTableCreateCompanionBuilder,
          $$ScanHistoryTableTableUpdateCompanionBuilder,
          (
            ScanHistoryTableData,
            BaseReferences<
              _$AppDatabase,
              $ScanHistoryTableTable,
              ScanHistoryTableData
            >,
          ),
          ScanHistoryTableData,
          PrefetchHooks Function()
        > {
  $$ScanHistoryTableTableTableManager(
    _$AppDatabase db,
    $ScanHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanHistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanHistoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> rawValue = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<String> dataType = const Value.absent(),
                Value<String?> displayValue = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> scannedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanHistoryTableCompanion(
                id: id,
                rawValue: rawValue,
                format: format,
                dataType: dataType,
                displayValue: displayValue,
                isFavorite: isFavorite,
                scannedAt: scannedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String rawValue,
                required String format,
                required String dataType,
                Value<String?> displayValue = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                required DateTime scannedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScanHistoryTableCompanion.insert(
                id: id,
                rawValue: rawValue,
                format: format,
                dataType: dataType,
                displayValue: displayValue,
                isFavorite: isFavorite,
                scannedAt: scannedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScanHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanHistoryTableTable,
      ScanHistoryTableData,
      $$ScanHistoryTableTableFilterComposer,
      $$ScanHistoryTableTableOrderingComposer,
      $$ScanHistoryTableTableAnnotationComposer,
      $$ScanHistoryTableTableCreateCompanionBuilder,
      $$ScanHistoryTableTableUpdateCompanionBuilder,
      (
        ScanHistoryTableData,
        BaseReferences<
          _$AppDatabase,
          $ScanHistoryTableTable,
          ScanHistoryTableData
        >,
      ),
      ScanHistoryTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScanHistoryTableTableTableManager get scanHistoryTable =>
      $$ScanHistoryTableTableTableManager(_db, _db.scanHistoryTable);
}
