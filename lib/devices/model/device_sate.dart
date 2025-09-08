class DeviceState {
  const DeviceState({
    required this.id,
    required this.name,
    required this.displayName,
  });

  final int id;
  final String name;
  final String displayName;
}

const vibrationProcess = DeviceState(
  id: 0,
  name: 'disabled',
  displayName: 'Out of work',
);

const oilProcess = DeviceState(
  id: 1,
  name: 'normal',
  displayName: 'Normal operation',
);

const timeProcess = DeviceState(
  id: 2,
  name: 'maintenance',
  displayName: 'Under Maintenance',
);

List<DeviceState> deviceStatesWithId = [
  vibrationProcess,
  oilProcess,
  timeProcess,
];
