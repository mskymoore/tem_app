import 'package:equatable/equatable.dart';
import 'package:tem_app/rest/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tem_app/models/models.dart';

part 'manhourscharge_form_event.dart';
part 'manhourscharge_form_state.dart';

class ManHoursChargeFormBloc
    extends Bloc<ManHoursChargeFormEvent, ManHoursChargeFormState> {
  ManHoursChargeFormBloc() : super(const ManHoursChargeFormState());

  @override
  Stream<ManHoursChargeFormState> mapEventToState(
    ManHoursChargeFormEvent event,
  ) async* {
    print(event.toString());
    if (event is ManHoursChargeSubmitted) {
      yield* _mapManHoursChargeSubmittedToState(event, state);
    } else if (event is ManHoursRequiredWorklogConfirmedSubmitted) {
      yield state.copyWith(pendingChargesWorklog: event.worklog);
      state.pendingCharges.forEach((manHoursCharge) {
        final charge = manHoursCharge.toJson();
        charge['worklog'] = event.worklog;
        postManHoursCharge(charge);
      });
      yield ManHoursChargeFormState();
    } else if (event is HoursChanged) {
      final hours = HoursInput.dirty(event.hours);
      yield state.copyWith(hours: hours, status: Formz.validate([hours]));
    } else if (event is PositionChanged) {
      final position = PositionInput.dirty(event.position);
      yield state.copyWith(
          position: position, status: Formz.validate([position]));
    } else if (event is EmployeeChanged) {
      final employee = EmployeeInput.dirty(event.employee);
      yield state.copyWith(
          employee: employee, status: Formz.validate([employee]));
    }
  }

  Stream<ManHoursChargeFormState> _mapManHoursChargeSubmittedToState(
      ManHoursChargeSubmitted event, ManHoursChargeFormState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      // TODO: call manhourscharge repository to submit manhourscharge
      List<ManHoursCharge> currentPendingCharges =
          state.pendingCharges ?? List<ManHoursCharge>();
      List<ManHoursCharge> pendingCharges = currentPendingCharges +
          <ManHoursCharge>[
            ManHoursCharge(
                double.parse(state.hours.value),
                int.parse(state.employee.value),
                state.position.value,
                int.parse(state.employee.value),
                null)
          ];
      yield state.copyWith(
          pendingCharges: pendingCharges,
          status: FormzStatus.submissionSuccess);
    } else {
      // TODO: display message to let user know it's invalid
    }
  }
}
