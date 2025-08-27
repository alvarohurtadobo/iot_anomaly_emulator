class Parameter {
  const Parameter({
    required this.id,
    required this.name,
    required this.displayName,
  });
  final int id;
  final String name;
  final String displayName;
}

const vibrationParamenter = Parameter(
  id: 1,
  name: 'vibration',
  displayName: 'Vibration',
);

const temperatureParamenter = Parameter(
  id: 2,
  name: 'temperature',
  displayName: 'Temperature',
);

const pressureParamenter = Parameter(
  id: 3,
  name: 'pressure',
  displayName: 'Pressure',
);

const oilQualityParamenter = Parameter(
  id: 4,
  name: 'oil_quality',
  displayName: 'Oil Quality',
);

const contaminantLevelParamenter = Parameter(
  id: 5,
  name: 'contaminant_level',
  displayName: 'Contaminant Level',
);

const acidityParamenter = Parameter(
  id: 6,
  name: 'acidity',
  displayName: 'Acidity',
);

const hoursOperatedParamenter = Parameter(
  id: 7,
  name: 'hours_operated',
  displayName: 'Hours Operated',
);

const maintenanceHistoryParamenter = Parameter(
  id: 8,
  name: 'maintenance_history',
  displayName: 'Maintenance History',
);

const loadParamenter = Parameter(
  id: 9,
  name: 'load',
  displayName: 'Load',
);

List<Parameter> parameters = [
  vibrationParamenter,
  temperatureParamenter,
  pressureParamenter,
  oilQualityParamenter,
  contaminantLevelParamenter,
  acidityParamenter,
  hoursOperatedParamenter,
  maintenanceHistoryParamenter,
  loadParamenter,
];
