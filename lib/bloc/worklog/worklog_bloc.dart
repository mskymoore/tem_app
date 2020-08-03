import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tem_app/bloc/worklog/worklog.dart';
import 'package:tem_app/models/equipcharge.dart';
import 'package:tem_app/models/models.dart';

part 'worklog_event.dart';
part 'worklog_state.dart';

class WorklogBloc extends Bloc<WorklogEvent, WorklogState> {
  WorklogBloc() : super(WorklogListState());

  @override
  Stream<WorklogState> mapEventToState(WorklogEvent event) async* {
    print(event);
    switch (event) {
      case WorklogEvent.CreateWorklogButtonTapped:
        print('WorklogFormState');
        yield ViewingWorklogFormState();
        break;
      case WorklogEvent.ManHoursChargeCreated:
        print('ValidatedManHoursChargeState');
        yield ValidatedManHoursChargeState();
        break;
      case WorklogEvent.EquipChargeCreated:
        print('ValidatedEquipChargeState');
        yield ValidatedEquipChargeState();
        break;
      case WorklogEvent.WorklogCreated:
      case WorklogEvent.WorklogCardTapped:
        print('WorklogListState');
        yield WorklogListState();
        break;
      case WorklogEvent.CreateEquipChargeButtonTapped:
        print('EquipChargeState');
        yield ViewingEquipChargeFormState();
        break;
      case WorklogEvent.AddEquipChargeButtonTapped:
        print('ValidatEquipChargeState');
        yield ValidatingEquipChargeState();
        break;
      case WorklogEvent.CreateManHoursChargeButtonTapped:
        print('ManHoursChargeFormState');
        yield ViewingManHoursChargeFormState();
        break;
      case WorklogEvent.AddManHoursChargeButtonTapped:
        print('ValidateManHoursChargeState');
        yield ValidatingManHoursChargeState();
        break;
    }
  }
}
