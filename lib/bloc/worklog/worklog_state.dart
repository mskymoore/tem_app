part of 'worklog_bloc.dart';

abstract class WorklogState {}

class WorklogListState extends WorklogState {}

class WorklogFormState extends WorklogState {}

class ManHoursChargeFormState extends WorklogState {}

class EquipChargeFormState extends WorklogState {}

//class WorklogState extends Equatable {
//  const WorklogState._({this.status = WorklogViewStatus.viewingWorklogList});
//  final WorklogViewStatus status;
//
//  @override
//  List<Object> get props => [];
//
//  factory WorklogState.initial() {
//    return WorklogState._();
//  }
//
//  const WorklogState.viewingWorklogList()
//      : this._(status: WorklogViewStatus.viewingWorklogList);
//
//  const WorklogState.creatingWorklog()
//      : this._(status: WorklogViewStatus.creatingWorklog);
//
//  const WorklogState.creatingManHoursCharge()
//      : this._(status: WorklogViewStatus.creatingManHoursCharge);
//
//  const WorklogState.creatingEquipCharge()
//      : this._(status: WorklogViewStatus.creatingEquipCharge);
//}
