part of 'worklog_form_bloc.dart';

class WorklogFormState extends Equatable {
  const WorklogFormState({
    this.status = FormzStatus.pure,
    this.summary = const SummaryInput.pure(),
    this.client = const ClientInput.pure(),
    this.site = const SiteInput.pure(),
    this.region = const RegionInput.pure(),
    this.created_by = const CreatedByInput.pure(),
    this.manhours_charges = const <FormzInput>[],
    this.equipment_charges = const <FormzInput>[],
    this.lastConfirmedWorklogId,
  });
  final FormzStatus status;
  final SummaryInput summary;
  final ClientInput client;
  final SiteInput site;
  final RegionInput region;
  final CreatedByInput created_by;
  final List<FormzInput> manhours_charges;
  final List<FormzInput> equipment_charges;
  final int lastConfirmedWorklogId;

  WorklogFormState copyWith({
    FormzStatus status,
    SummaryInput summary,
    ClientInput client,
    SiteInput site,
    RegionInput region,
    CreatedByInput created_by,
    List<FormzInput> manhours_charges,
    List<FormzInput> equipment_charges,
    int lastConfirmedWorklogId,
  }) {
    return WorklogFormState(
        status: status ?? this.status,
        summary: summary ?? this.summary,
        client: client ?? this.client,
        site: site ?? this.site,
        region: region ?? this.region,
        created_by: created_by ?? this.created_by,
        manhours_charges: manhours_charges ?? this.manhours_charges,
        equipment_charges: equipment_charges ?? this.equipment_charges,
        lastConfirmedWorklogId:
            lastConfirmedWorklogId ?? this.lastConfirmedWorklogId);
  }

  @override
  List<Object> get props => [
        status,
        summary,
        client,
        site,
        region,
        created_by,
        manhours_charges,
        equipment_charges,
        lastConfirmedWorklogId,
      ];
}
