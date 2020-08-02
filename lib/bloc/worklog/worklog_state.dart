part of 'worklog_bloc.dart';

class WorklogState extends Equatable {
  const WorklogState._({this.status = WorklogViewStatus.viewingWorklogList});
  final WorklogViewStatus status;

  @override
  List<Object> get props => [];

  factory WorklogState.initial() {
    return WorklogState._();
  }

  const WorklogState.viewingWorklogList()
      : this._(status: WorklogViewStatus.viewingWorklogList);

  const WorklogState.creatingWorklog()
      : this._(status: WorklogViewStatus.creatingWorklog);

  const WorklogState.creatingManHoursCharge()
      : this._(status: WorklogViewStatus.creatingManHoursCharge);

  const WorklogState.creatingEquipCharge()
      : this._(status: WorklogViewStatus.creatingEquipCharge);
}
