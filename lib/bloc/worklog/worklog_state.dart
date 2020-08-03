part of 'worklog_bloc.dart';

abstract class WorklogState {}

class WorklogListState extends WorklogState {}

class ViewingWorklogFormState extends WorklogState {}

class ViewingManHoursChargeFormState extends WorklogState {}

class ViewingEquipChargeFormState extends WorklogState {}

class ValidatingManHoursChargeState extends WorklogState {}

class ValidatingEquipChargeState extends WorklogState {}

class ValidatedManHoursChargeState extends WorklogState {}

class ValidatedEquipChargeState extends WorklogState {}
