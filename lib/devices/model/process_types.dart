class ProcessType {
  const ProcessType({
    required this.id,
    required this.name,
    required this.displayName,
  });

  final int id;
  final String name;
  final String displayName;
}

const vibrationProcess = ProcessType(
  id: 1,
  name: 'vibrations',
  displayName: 'Vibrations',
);

const oilProcess = ProcessType(
  id: 2,
  name: 'oil_analysis',
  displayName: 'Oil Analysis',
);

const timeProcess = ProcessType(
  id: 3,
  name: 'hours_operated',
  displayName: 'Hours Operated',
);

List<ProcessType> processTypesWithId = [
  vibrationProcess,
  oilProcess,
  timeProcess,
];
