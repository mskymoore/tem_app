import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:tem_app/bloc/worklog/worklog.dart';

part 'worklog_event.dart';
part 'worklog_state.dart';

class WorklogBloc extends Bloc<WorklogEvent, WorklogState> {
  WorklogBloc() : super(WorklogListState());

  @override
  Stream<WorklogState> mapEventToState(WorklogEvent event) async* {
    switch (event) {
      case WorklogEvent.CreateWorklogButtonTapped:
      case WorklogEvent.ManHoursChargeCreated:
      case WorklogEvent.EquipChargeCreated:
        yield WorklogFormState();
        break;
      case WorklogEvent.WorklogCreated:
      case WorklogEvent.WorklogCardTapped:
        yield WorklogListState();
        break;
      case WorklogEvent.CreateEquipChargeButtonTapped:
        yield EquipChargeFormState();
        break;
      case WorklogEvent.CreateManHoursChargeButtonTapped:
        yield ManHoursChargeFormState();
        break;
    }
  }
}
