part of 'equipcharge_form_bloc.dart';

class EquipChargeFormState extends Equatable {
  const EquipChargeFormState({
    this.status = FormzStatus.pure,
    this.hours = const HoursInput.pure(),
    this.equipment = const EquipInput.pure(),
    this.pendingCharges,
    this.pendingChargesWorklog,
  });
  final FormzStatus status;
  final HoursInput hours;
  final EquipInput equipment;
  final List<EquipCharge> pendingCharges;
  final int pendingChargesWorklog;

  EquipChargeFormState copyWith({
    FormzStatus status,
    HoursInput hours,
    EquipInput equipment,
    List<EquipCharge> pendingCharges,
    int pendingChargesWorklog,
  }) {
    return EquipChargeFormState(
        status: status ?? this.status,
        hours: hours ?? this.hours,
        equipment: equipment ?? this.equipment,
        pendingCharges: pendingCharges ?? this.pendingCharges,
        pendingChargesWorklog:
            pendingChargesWorklog ?? this.pendingChargesWorklog);
  }

  @override
  List<Object> get props =>
      [status, hours, equipment, pendingCharges, pendingChargesWorklog];
}
