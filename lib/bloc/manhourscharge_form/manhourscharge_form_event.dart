part of 'manhourscharge_form_bloc.dart';

abstract class ManHoursChargeFormEvent extends Equatable {
  const ManHoursChargeFormEvent();

  @override
  List<Object> get props => [];
}

class HoursChanged extends ManHoursChargeFormEvent {
  const HoursChanged(this.hours);
  final String hours;

  @override
  List<Object> get props => [hours];
}

class EmployeeChanged extends ManHoursChargeFormEvent {
  const EmployeeChanged(this.employee);
  final String employee;

  @override
  List<Object> get props => [employee];
}

class PositionChanged extends ManHoursChargeFormEvent {
  const PositionChanged(this.position);
  final String position;

  @override
  List<Object> get props => [position];
}

class ManHoursChargeSubmitted extends ManHoursChargeFormEvent {}

class ManHoursRequiredWorklogConfirmedSubmitted
    extends ManHoursChargeFormEvent {
  const ManHoursRequiredWorklogConfirmedSubmitted(this.worklog);
  final int worklog;

  @override
  List<Object> get props => [worklog];
}
