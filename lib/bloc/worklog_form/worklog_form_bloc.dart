import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tem_app/models/models.dart';

part 'worklog_form_event.dart';
part 'worklog_form_state.dart';

class WorklogFormBloc extends Bloc<WorklogFormEvent, WorklogFormState> {
  WorklogFormBloc() : super(const WorklogFormState());

  @override
  Stream<WorklogFormState> mapEventToState(
    WorklogFormEvent event,
  ) async* {
    print(event.toString());
    if (event is SummaryChanged) {
      final summary = SummaryInput.dirty(event.summary);
      yield state.copyWith(summary: summary, status: Formz.validate([summary]));
    } else if (event is ClientChanged) {
      final client = ClientInput.dirty(event.client);
      yield state.copyWith(client: client, status: Formz.validate([client]));
    } else if (event is SiteChanged) {
      final site = SiteInput.dirty(event.site);
      yield state.copyWith(site: site, status: Formz.validate([site]));
    } else if (event is RegionChanged) {
      final region = RegionInput.dirty(event.region);
      yield state.copyWith(region: region, status: Formz.validate([region]));
    }
  }
}

Stream<WorklogFormState> _mapWorklogSubmittedToState(
    WorklogSubmitted event, WorklogFormState state) async* {
  if (state.status.isValidated) {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    // TODO: call worklog repository to submit worklog
  } else {
    // TODO: display message to let user know it's invalid
  }
}
