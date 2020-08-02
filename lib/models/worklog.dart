import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tem_app/config/constants.dart';

part 'worklog.g.dart';

@JsonSerializable(nullable: false)
class Worklog extends Equatable {
  Worklog(
      this.summary,
      this.client,
      this.site,
      this.created_by,
      this.approved,
      this.disputed,
      this.manhours_charges,
      this.equipment_charges,
      this.included_employees);
  final String summary;
  final String client;
  final String site;
  final String created_by;
  final bool approved;
  final bool disputed;
  final List<int> manhours_charges;
  final List<int> equipment_charges;
  final List<int> included_employees;

  @override
  List<Object> get props => [
        summary,
        client,
        site,
        created_by,
        approved,
        disputed,
        manhours_charges,
        equipment_charges,
        included_employees
      ];

  factory Worklog.fromJson(Map<String, dynamic> json) =>
      _$WorklogFromJson(json);
  Map<String, dynamic> toJson() => _$WorklogToJson(this);
}

// 0.0.1a form data
//Map formData = {
//  'summary': '',
//  'client': '',
//  'created_by': '',
//  'approved': 'false',
//  'disputed': 'false',
//  'manhours_charges': [],
//  'equipment_charges': [],
//  'included_employees': []
//};
