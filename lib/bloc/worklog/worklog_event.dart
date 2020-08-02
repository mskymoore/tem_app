part of 'worklog_bloc.dart';

abstract class WorklogEvent extends Equatable {
  const WorklogEvent();

  @override
  List<Object> get props => [];
}

class CreateWorklogButtonTapped extends WorklogEvent {
  const CreateWorklogButtonTapped();

  @override
  List<Object> get props => [];
}

class WorklogCreated extends WorklogEvent {
  const WorklogCreated();

  @override
  List<Object> get props => [];
}

class WorklogCardTapped extends WorklogEvent {}

class CreateManHoursChargeButtonTapped extends WorklogEvent {
  const CreateManHoursChargeButtonTapped();

  @override
  List<Object> get props => [];
}

class ManHoursChargeCreated extends WorklogEvent {
  const ManHoursChargeCreated();

  @override
  List<Object> get props => [];
}

class CreateEquipChargeButtonTapped extends WorklogEvent {
  const CreateEquipChargeButtonTapped();

  @override
  List<Object> get props => [];
}

class EquipChargeCreated extends WorklogEvent {
  const EquipChargeCreated();

  @override
  List<Object> get props => [];
}
