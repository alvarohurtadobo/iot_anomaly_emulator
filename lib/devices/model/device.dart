import 'package:iot_anomaly_emulator/devices/model/types.dart';

class EmulatedDevice {
  const EmulatedDevice({
    required this.id,
    required this.name,
    required this.type,
  });

  factory EmulatedDevice.fromJson(Map<String, dynamic> json) {
    return EmulatedDevice(
      id: (json['id'] as int?) ?? 0,
      name: json['name'].toString(),
      type: json['type'] as DeviceTypes,
    );
  }

  final int id;
  final String name;
  final DeviceTypes type;

  EmulatedDevice copyWith({int? id, String? name, DeviceTypes? type}) {
    return EmulatedDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'type': type};
  }
}

List<EmulatedDevice> emulatedDevices = [
  const EmulatedDevice(id: 1, name: 'DeMag400', type: DeviceTypes.imm),
  const EmulatedDevice(id: 2, name: 'Arc Solder', type: DeviceTypes.arc),
  const EmulatedDevice(id: 3, name: 'DeMag100', type: DeviceTypes.imm),
];
