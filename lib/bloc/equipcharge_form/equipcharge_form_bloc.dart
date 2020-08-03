import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tem_app/models/models.dart';

part 'equipcharge_form_event.dart';
part 'equipcharge_form_state.dart';

class EquipChargeFormBloc
    extends Bloc<EquipChargeFormEvent, EquipChargeFormState> {
  EquipChargeFormBloc() : super(const EquipChargeFormState());

  @override
  Stream<EquipChargeFormState> mapEventToState(
    EquipChargeFormEvent event,
  ) async* {
    print(event.toString());
    if (event is EquipChargeSubmitted) {
      yield* _mapEquipChargeSubmittedToState(event, state);
    } else if (event is HoursChanged) {
      final hours = HoursInput.dirty(event.hours);
      print(Formz.validate([hours]).toString());
      yield state.copyWith(hours: hours, status: Formz.validate([hours]));
    } else if (event is EquipChanged) {
      final equipment = EquipInput.dirty(event.equipment);
      yield state.copyWith(
          equipment: equipment, status: Formz.validate([equipment]));
    }
  }

  Stream<EquipChargeFormState> _mapEquipChargeSubmittedToState(
      EquipChargeSubmitted event, EquipChargeFormState state) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      List<EquipCharge> currentPendingCharges =
          state.pendingCharges ?? List<EquipCharge>();
      List<EquipCharge> pendingCharges = currentPendingCharges +
          <EquipCharge>[
            EquipCharge(
                double.parse(state.hours.value),
                int.parse(state.equipment.value),
                int.parse(state.equipment.value),
                null)
          ];
      yield state.copyWith(
          pendingCharges: pendingCharges,
          status: FormzStatus.submissionSuccess);
    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
