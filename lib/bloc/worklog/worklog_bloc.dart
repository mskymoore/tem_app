import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:tem_app/bloc/worklog/worklog.dart';

part 'worklog_event.dart';
part 'worklog_state.dart';

class WorklogBloc extends Bloc<WorklogEvent, WorklogState> {
  WorklogBloc() : super(WorklogState.initial());

  WorklogState get initialState => WorklogState.initial();

  @override
  Stream<WorklogState> mapEventToState(WorklogEvent event) async* {
    if (event is CreateWorklogButtonTapped ||
        event is ManHoursChargeCreated ||
        event is EquipChargeCreated) {
      yield WorklogState.creatingWorklog();
    } else if (event is WorklogCreated) {
      yield WorklogState.viewingWorklogList();
    } else if (event is CreateEquipChargeButtonTapped) {
      yield WorklogState.creatingEquipCharge();
    } else if (event is CreateManHoursChargeButtonTapped) {
      yield WorklogState.creatingManHoursCharge();
    } else
      yield WorklogState.viewingWorklogList();
  }
}
