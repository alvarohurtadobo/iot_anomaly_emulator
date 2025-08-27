class ProcessType {
  ProcessType({
    required this.id,
    required this.name,
    required this.displayName,
  });

  int id;
  String name;
  String displayName;
}

ProcessType vibrationProcess = ProcessType(
  id: 1,
  name: 'vibrations',
  displayName: 'Vibrations',
);

ProcessType oilProcess = ProcessType(
  id: 2,
  name: 'oil_analysis',
  displayName: 'Oil Analysis',
);

ProcessType timeProcess = ProcessType(
  id: 3,
  name: 'hours_operated',
  displayName: 'Hours Operated',
);

List<ProcessType> processTypeWithId = [
  vibrationProcess,
  oilProcess,
  timeProcess,
];
