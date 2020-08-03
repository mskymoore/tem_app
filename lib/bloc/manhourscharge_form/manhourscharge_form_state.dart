part of 'manhourscharge_form_bloc.dart';

class ManHoursChargeFormState extends Equatable {
  const ManHoursChargeFormState({
    this.status = FormzStatus.pure,
    this.hours = const HoursInput.pure(),
    this.employee = const EmployeeInput.pure(),
    this.position = const PositionInput.pure(),
    this.pendingCharges,
    this.pendingChargesWorklog,
  });
  final FormzStatus status;
  final HoursInput hours;
  final EmployeeInput employee;
  final PositionInput position;
  final List<ManHoursCharge> pendingCharges;
  final int pendingChargesWorklog;

  ManHoursChargeFormState copyWith({
    FormzStatus status,
    HoursInput hours,
    EmployeeInput employee,
    PositionInput position,
    List<ManHoursCharge> pendingCharges,
    int pendingChargesWorklog,
  }) {
    return ManHoursChargeFormState(
        status: status ?? this.status,
        hours: hours ?? this.hours,
        employee: employee ?? this.employee,
        position: position ?? this.position,
        pendingCharges: pendingCharges ?? this.pendingCharges,
        pendingChargesWorklog:
            pendingChargesWorklog ?? this.pendingChargesWorklog);
  }

  @override
  List<Object> get props =>
      [status, hours, employee, pendingCharges, pendingChargesWorklog];
}
