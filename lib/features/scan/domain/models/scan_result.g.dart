// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScanResult _$ScanResultFromJson(Map<String, dynamic> json) => _ScanResult(
  id: json['id'] as String,
  rawValue: json['rawValue'] as String,
  format: json['format'] as String,
  dataType: $enumDecode(_$ScanDataTypeEnumMap, json['dataType']),
  scannedAt: DateTime.parse(json['scannedAt'] as String),
  displayValue: json['displayValue'] as String?,
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$ScanResultToJson(_ScanResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rawValue': instance.rawValue,
      'format': instance.format,
      'dataType': _$ScanDataTypeEnumMap[instance.dataType]!,
      'scannedAt': instance.scannedAt.toIso8601String(),
      'displayValue': instance.displayValue,
      'isFavorite': instance.isFavorite,
    };

const _$ScanDataTypeEnumMap = {
  ScanDataType.url: 'url',
  ScanDataType.wifi: 'wifi',
  ScanDataType.contact: 'contact',
  ScanDataType.phone: 'phone',
  ScanDataType.email: 'email',
  ScanDataType.geo: 'geo',
  ScanDataType.text: 'text',
  ScanDataType.unknown: 'unknown',
};
