enum ProcessType { hoursOperated, oilAnalysis, vibrations }

Map<ProcessType, String> map = {
  ProcessType.hoursOperated: 'Hours Operated',
  ProcessType.oilAnalysis: 'Oil Analysis',
  ProcessType.vibrations: 'Vibrations',
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
    displayName: map[ProcessType.hoursOperated] ?? '',
  ),
  ProcessTypeWithId(
    id: 2,
    displayName: map[ProcessType.oilAnalysis] ?? '',
  ),
  ProcessTypeWithId(
    id: 3,
    displayName: map[ProcessType.vibrations] ?? '',
  ),
];
