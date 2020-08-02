// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worklog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Worklog _$WorklogFromJson(Map<String, dynamic> json) {
  return Worklog(
    json['summary'] as String,
    json['client'] as String,
    json['site'] as String,
    json['created_by'] as String,
    json['approved'] as bool,
    json['disputed'] as bool,
    (json['manhours_charges'] as List).map((e) => e as int).toList(),
    (json['equipment_charges'] as List).map((e) => e as int).toList(),
    (json['included_employees'] as List).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$WorklogToJson(Worklog instance) => <String, dynamic>{
      'summary': instance.summary,
      'client': instance.client,
      'site': instance.site,
      'created_by': instance.created_by,
      'approved': instance.approved,
      'disputed': instance.disputed,
      'manhours_charges': instance.manhours_charges,
      'equipment_charges': instance.equipment_charges,
      'included_employees': instance.included_employees,
    };
