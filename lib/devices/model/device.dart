import 'package:iot_anomaly_emulator/devices/model/process_types.dart';
import 'package:iot_anomaly_emulator/devices/model/types.dart';

class EmulatedDevice {
  const EmulatedDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.processType,
  });

  factory EmulatedDevice.fromJson(Map<String, dynamic> json) {
    return EmulatedDevice(
      id: (json['id'] as int?) ?? 0,
      name: json['name'].toString(),
      type: json['type'] as DeviceTypes,
      processType: json['process_type'] as ProcessType,
    );
  }

  final int id;
  final String name;
  final DeviceTypes type;
  final ProcessType processType;

  EmulatedDevice copyWith({
    int? id,
    String? name,
    DeviceTypes? type,
    ProcessType? processType,
  }) {
    return EmulatedDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      processType: processType ?? this.processType,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'type': type, 'process_type': processType};
  }
}

List<EmulatedDevice> emulatedDevices = [
  const EmulatedDevice(
    id: 1,
    name: 'DeMag400',
    type: DeviceTypes.imm,
    processType: ProcessType.hoursOperated,
  ),
  const EmulatedDevice(
    id: 2,
    name: 'Arc Solder',
    type: DeviceTypes.arc,
    processType: ProcessType.oilAnalysis,
  ),
  const EmulatedDevice(
    id: 3,
    name: 'DeMag100',
    type: DeviceTypes.other,
    processType: ProcessType.vibrations,
  ),
];
