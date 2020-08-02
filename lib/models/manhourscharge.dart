import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manhourscharge.g.dart';

@JsonSerializable(nullable: false)
class ManHoursCharge extends Equatable {
  ManHoursCharge(
      this.hours, this.employee, this.position, this.worklog, this.dispute);

  double hours;
  int employee;
  String position;
  int worklog;
  int dispute;

  @override
  List<Object> get props => [hours, employee, position, worklog, dispute];

  factory ManHoursCharge.fromJson(Map<String, dynamic> json) =>
      _$ManHoursChargeFromJson(json);
  Map<String, dynamic> toJson() => _$ManHoursChargeToJson(this);
}

// 0.0.1a form data
//Map formData = {
//  hours: 0.0,
//  employee: 0,
//  position: "",
//  worklog: 0,
//  dispute: null,
//};
