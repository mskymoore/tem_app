part of 'worklog_form_bloc.dart';

abstract class WorklogFormEvent extends Equatable {
  const WorklogFormEvent();

  @override
  List<Object> get props => [];
}

class SummaryChanged extends WorklogFormEvent {
  const SummaryChanged(this.summary);
  final String summary;

  @override
  List<Object> get props => [summary];
}

class ClientChanged extends WorklogFormEvent {
  const ClientChanged(this.client);
  final String client;

  @override
  List<Object> get props => [client];
}

class SiteChanged extends WorklogFormEvent {
  const SiteChanged(this.site);
  final String site;

  @override
  List<Object> get props => [site];
}

class RegionChanged extends WorklogFormEvent {
  const RegionChanged(this.region);
  final String region;

  @override
  List<Object> get props => [region];
}

class NewWorklog extends WorklogFormEvent {
  const NewWorklog(this.created_by);
  final String created_by;

  @override
  List<Object> get props => [created_by];
}

class WorklogSubmitted extends WorklogFormEvent {}
