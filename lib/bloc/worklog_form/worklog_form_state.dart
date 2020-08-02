part of 'worklog_form_bloc.dart';

class WorklogFormState extends Equatable {
  const WorklogFormState({
    this.status = FormzStatus.pure,
    this.summary = const SummaryInput.pure(),
    this.client = const ClientInput.pure(),
    this.site = const SiteInput.pure(),
    this.region = const RegionInput.pure(),
    this.manhours_charges = const <FormzInput>[],
    this.equipment_charges = const <FormzInput>[],
  });
  final FormzStatus status;
  final SummaryInput summary;
  final ClientInput client;
  final SiteInput site;
  final RegionInput region;
  final List<FormzInput> manhours_charges;
  final List<FormzInput> equipment_charges;

  WorklogFormState copyWith({
    FormzStatus status,
    SummaryInput summary,
    ClientInput client,
    SiteInput site,
    RegionInput region,
    List<FormzInput> manhours_charges,
    List<FormzInput> equipment_charges,
  }) {
    return WorklogFormState(
        status: status ?? this.status,
        summary: summary ?? this.summary,
        client: client ?? this.client,
        site: site ?? this.site,
        region: region ?? this.region,
        manhours_charges: manhours_charges ?? this.manhours_charges,
        equipment_charges: equipment_charges ?? this.equipment_charges);
  }

  @override
  List<Object> get props =>
      [status, summary, client, site, manhours_charges, equipment_charges];
}
