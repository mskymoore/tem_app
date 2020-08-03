import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tem_app/models/models.dart';
import 'package:tem_app/rest/api.dart';
part 'worklog_form_event.dart';
part 'worklog_form_state.dart';

class WorklogFormBloc extends Bloc<WorklogFormEvent, WorklogFormState> {
  WorklogFormBloc() : super(const WorklogFormState());

  @override
  Stream<WorklogFormState> mapEventToState(
    WorklogFormEvent event,
  ) async* {
    print(event.toString());
    if (event is NewWorklog) {
      final created_by = CreatedByInput.dirty(event.created_by);
      yield WorklogFormState();
      yield state.copyWith(created_by: created_by);
    } else if (event is WorklogSubmitted) {
      yield* _mapWorklogSubmittedToState(event, state);
    } else if (event is SummaryChanged) {
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

  Stream<WorklogFormState> _mapWorklogSubmittedToState(
      WorklogSubmitted event, WorklogFormState state) async* {
    if (state.status.isValidated) {
      print("validated");
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      final response = await postWorklog(Worklog(
          state.summary.value,
          state.client.value,
          state.site.value,
          state.created_by.value,
          false,
          false,
          [],
          [],
          [1]).toJson());
      if (response != null) {
        yield state.copyWith(status: FormzStatus.submissionSuccess);
        await Future.delayed(Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.pure);
        add(WorklogConfirmed(response['id']));
      } else {
        yield state.copyWith(status: FormzStatus.submissionFailure);
        await Future.delayed(Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.pure);
        // TODO: display message to let user know it's invalid
      }

      // TODO: call worklog repository to submit worklog
    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
      await Future.delayed(Duration(seconds: 1));
      yield state.copyWith(status: FormzStatus.pure);
      // TODO: display message to let user know it's invalid
    }
  }
}
