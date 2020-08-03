part of 'equipcharge_form_bloc.dart';

class EquipChargeFormState extends Equatable {
  const EquipChargeFormState({
    this.status = FormzStatus.pure,
    this.hours = const HoursInput.pure(),
    this.equipment = const EquipInput.pure(),
  });
  final FormzStatus status;
  final HoursInput hours;
  final EquipInput equipment;

  EquipChargeFormState copyWith({
    FormzStatus status,
    HoursInput hours,
    EquipInput equipment,
  }) {
    return EquipChargeFormState(
        status: status ?? this.status,
        hours: hours ?? this.hours,
        equipment: equipment ?? this.equipment);
  }

  @override
  List<Object> get props => [status, hours, equipment];
}
