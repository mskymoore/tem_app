part of 'equipcharge_form_bloc.dart';

abstract class EquipChargeFormEvent extends Equatable {
  const EquipChargeFormEvent();

  @override
  List<Object> get props => [];
}

class HoursChanged extends EquipChargeFormEvent {
  const HoursChanged(this.hours);
  final String hours;

  @override
  List<Object> get props => [hours];
}

class EquipChanged extends EquipChargeFormEvent {
  const EquipChanged(this.equipment);
  final String equipment;

  @override
  List<Object> get props => [equipment];
}

class EquipChargeSubmitted extends EquipChargeFormEvent {}

class EquipRequiredWorklogSuccessfullySubmitted extends EquipChargeFormEvent {}
