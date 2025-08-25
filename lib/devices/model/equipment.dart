class EmulatedEquipment {
  const EmulatedEquipment({
    required this.id,
    required this.name,
  });
  
  factory EmulatedEquipment.fromJson(Map<String, dynamic> json) {
    return EmulatedEquipment(
      id: (json['id'] as int?) ?? 0,
      name: json['name'].toString(),
    );
  }

  final int id;
  final String name;

  EmulatedEquipment copyWith({int? id, String? name}) {
    return EmulatedEquipment(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
