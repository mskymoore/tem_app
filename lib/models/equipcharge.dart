import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'equipcharge.g.dart';

@JsonSerializable(nullable: false)
class EquipCharge extends Equatable {
  EquipCharge(this.hours, this.equipment, this.worklog, this.dispute);
  final double hours;
  final int equipment;
  final int worklog;
  final int dispute;

  @override
  List<Object> get props => [hours, equipment, worklog, dispute];

  factory EquipCharge.fromJson(Map<String, dynamic> json) =>
      _$EquipChargeFromJson(json);
  Map<String, dynamic> toJson() => _$EquipChargeToJson(this);
}

// 0.0.1a form data
//Map formData = {
//  hours: 0.0,
//  equipment: 1,
//  worklog: 0,
//  dispute: null,
//};
