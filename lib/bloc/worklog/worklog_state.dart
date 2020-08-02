part of 'worklog_bloc.dart';

abstract class WorklogState {
  Map worklogFormData = {
    'summary': '',
    'client': '',
    'created_by': '',
    'approved': 'false',
    'disputed': 'false',
    'manhours_charges': [],
    'equipment_charges': [],
    'included_employees': []
  };

  Map equipmentChargeFormData = {
    'hours': 0.0,
    'equipment': 1,
    'worklog': 0,
    'dispute': null,
  };

  Map manHoursChargeFormData = {
    'hours': 0.0,
    'employee': 1,
    'position': "electrician",
    'worklog': 22,
    'dispute': null,
  };
}

class WorklogListState extends WorklogState {}

class WorklogFormState extends WorklogState {}

class ManHoursChargeFormState extends WorklogState {}

class EquipChargeFormState extends WorklogState {}

class ValidateManHoursChargeState extends WorklogState {}

class ValidateEquipChargeState extends WorklogState {}
