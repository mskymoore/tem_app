// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipcharge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipCharge _$EquipChargeFromJson(Map<String, dynamic> json) {
  return EquipCharge(
    (json['hours'] as num).toDouble(),
    json['equipment'] as int,
    json['worklog'] as int,
    json['dispute'] as int,
  );
}

Map<String, dynamic> _$EquipChargeToJson(EquipCharge instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'equipment': instance.equipment,
      'worklog': instance.worklog,
      'dispute': instance.dispute,
    };
