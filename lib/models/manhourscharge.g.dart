// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manhourscharge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManHoursCharge _$ManHoursChargeFromJson(Map<String, dynamic> json) {
  return ManHoursCharge(
    (json['hours'] as num).toDouble(),
    json['employee'] as int,
    json['position'] as String,
    json['worklog'] as int,
    json['dispute'] as int,
  );
}

Map<String, dynamic> _$ManHoursChargeToJson(ManHoursCharge instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'employee': instance.employee,
      'position': instance.position,
      'worklog': instance.worklog,
      'dispute': instance.dispute,
    };
