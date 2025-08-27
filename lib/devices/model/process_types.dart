enum ProcessType { vibrations, oilAnalysis, hoursOperated }

Map<ProcessType, String> map = {
  ProcessType.vibrations: 'Vibrations',
  ProcessType.oilAnalysis: 'Oil Analysis',
  ProcessType.hoursOperated: 'Hours Operated',
};

String processTypeToString(ProcessType type) {
  return map[type] ?? '';
}

class ProcessTypeWithId {
  ProcessTypeWithId({required this.id, required this.displayName});

  int id;
  String displayName;
}

List<ProcessTypeWithId> processTypeWithId = [
  ProcessTypeWithId(
    id: 1,
    displayName: map[ProcessType.vibrations] ?? '',
  ),
  ProcessTypeWithId(
    id: 2,
    displayName: map[ProcessType.oilAnalysis] ?? '',
  ),
  ProcessTypeWithId(
    id: 3,
    displayName: map[ProcessType.hoursOperated] ?? '',
  ),
];
