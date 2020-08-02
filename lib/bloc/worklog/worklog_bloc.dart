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
    print(event);
    switch (event) {
      case WorklogEvent.CreateWorklogButtonTapped:
      case WorklogEvent.ManHoursChargeCreated:
      case WorklogEvent.EquipChargeCreated:
        print('WorklogFormState');
        yield WorklogFormState();
        break;
      case WorklogEvent.WorklogCreated:
      case WorklogEvent.WorklogCardTapped:
        print('WorklogListState');
        yield WorklogListState();
        break;
      case WorklogEvent.CreateEquipChargeButtonTapped:
        print('EquipChargeState');
        yield EquipChargeFormState();
        break;
      case WorklogEvent.AddEquipChargeButtonTapped:
        print('ValidatEquipChargeState');
        yield ValidateEquipChargeState();
        break;
      case WorklogEvent.CreateManHoursChargeButtonTapped:
        print('ManHoursChargeFormState');
        yield ManHoursChargeFormState();
        break;
      case WorklogEvent.AddManHoursChargeButtonTapped:
        print('ValidateManHoursChargeState');
        yield ValidateManHoursChargeState();
        break;
    }
  }
}
