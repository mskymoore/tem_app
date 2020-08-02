import 'dart:async';

enum WorklogViewStatus {
  viewingWorklogList,
  creatingWorklog,
  creatingManHoursCharge,
  creatingEquipCharge
}

class WorklogRepo {
  final _controller = StreamController<WorklogViewStatus>();

  Stream<WorklogViewStatus> get status async* {
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}
