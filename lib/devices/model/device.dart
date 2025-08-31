import 'package:iot_anomaly_emulator/devices/model/process_types.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';

class EmulatedDevice {
  const EmulatedDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.processType,
    required this.state,
  });

  factory EmulatedDevice.fromJson(Map<String, dynamic> json) {
    return EmulatedDevice(
      id: (json['id'] as int?) ?? 0,
      name: json['name'].toString(),
      type: json['type'] as DeviceTypes,
      processType: json['process_type'] as ProcessType,
      state: json['state'] == true,
    );
  }

  final int id;
  final String name;
  final DeviceTypes type;
  final ProcessType processType;
  final bool state;

  EmulatedDevice copyWith({
    int? id,
    String? name,
    DeviceTypes? type,
    ProcessType? processType,
    bool? state,
  }) {
    return EmulatedDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      processType: processType ?? this.processType,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'process_type': processType,
      'state': state,
    };
  }
}

List<EmulatedDevice> emulatedDevices = [
  const EmulatedDevice(
    id: 1,
    name: 'DeMag400',
    type: DeviceTypes.imm,
    processType: timeProcess,
    state: true,
  ),
  const EmulatedDevice(
    id: 2,
    name: 'Arc Solder',
    type: DeviceTypes.arc,
    processType: oilProcess,
    state: true,
  ),
  const EmulatedDevice(
    id: 3,
    name: 'DeMag300',
    type: DeviceTypes.other,
    processType: vibrationProcess,
    state: true,
  ),
  const EmulatedDevice(
    id: 4,
    name: 'DeMag400',
    type: DeviceTypes.imm,
    processType: timeProcess,
    state: true,
  ),
  const EmulatedDevice(
    id: 5,
    name: 'Industrial Oven',
    type: DeviceTypes.imm,
    processType: oilProcess,
    state: true,
  ),
  const EmulatedDevice(
    id: 6,
    name: 'Industrial fridge',
    type: DeviceTypes.other,
    processType: vibrationProcess,
    state: true,
  ),
];
