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
      type: json['type'].toString(),
    );
  }

  final int id;
  final String name;
  final String type;

  EmulatedDevice copyWith({int? id, String? name, String? type}) {
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
