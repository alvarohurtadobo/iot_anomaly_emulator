class RealTimeParameters {
  const RealTimeParameters({
    required this.vibration,
    required this.temperature,
    required this.pressure,
    required this.oilQuality,
    required this.contaminantLevel,
    required this.acidity,
    required this.hoursOperated,
    required this.maintenanceHistory,
    required this.load,
    required this.failure,
    required this.anomaly,
    required this.timestamp,
  });

  factory RealTimeParameters.fromJson(Map<String, dynamic> json) {
    return RealTimeParameters(
      vibration: double.tryParse(json['vibration'].toString()),
      temperature: double.tryParse(json['temperature'].toString()),
      pressure: double.tryParse(json['pressure'].toString()),
      oilQuality: double.tryParse(json['oil_quality'].toString()),
      contaminantLevel: double.tryParse(json['contaminant_level'].toString()),
      acidity: double.tryParse(json['acidity'].toString()) ?? 0,
      hoursOperated: double.tryParse(json['hours_operated'].toString()),
      maintenanceHistory: double.tryParse(
        json['maintenance_history'].toString(),
      ),
      load: double.tryParse(json['load'].toString()),
      failure: (json['failure'] as bool?) ?? false,
      anomaly: (json['anomaly'] as bool?) ?? false,
      timestamp:
          DateTime.tryParse(json['timestamp'].toString()) ?? DateTime.now(),
    );
  }

  final double? vibration;
  final double? temperature;
  final double? pressure;
  final double? oilQuality;
  final double? contaminantLevel;
  final double? acidity;
  final double? hoursOperated;
  final double? maintenanceHistory;
  final double? load;
  final bool failure;
  final bool anomaly;
  final DateTime timestamp;

  RealTimeParameters copyWith({
    double? vibration,
    double? temperature,
    double? pressure,
    double? oilQuality,
    double? contaminantLevel,
    double? acidity,
    double? hoursOperated,
    double? maintenanceHistory,
    double? load,
    bool? failure,
    bool? anomaly,
    DateTime? timestamp,
  }) {
    return RealTimeParameters(
      vibration: vibration ?? this.vibration,
      temperature: temperature ?? this.temperature,
      pressure: pressure ?? this.pressure,
      oilQuality: oilQuality ?? this.oilQuality,
      contaminantLevel: contaminantLevel ?? this.contaminantLevel,
      acidity: acidity ?? this.acidity,
      hoursOperated: hoursOperated ?? this.hoursOperated,
      maintenanceHistory: maintenanceHistory ?? this.maintenanceHistory,
      load: load ?? this.load,
      failure: failure ?? this.failure,
      anomaly: anomaly ?? this.anomaly,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Para convertir a JSON (ej. si viene de Firestore o API)
  Map<String, dynamic> toJson() {
    return {
      'vibration': vibration,
      'temperature': temperature,
      'pressure': pressure,
      'oil_quality': oilQuality,
      'contaminant_level': contaminantLevel,
      'acidity': acidity,
      'hours_operated': hoursOperated,
      'maintenance_history': maintenanceHistory,
      'load': load,
      'failure': failure,
      'anomaly': anomaly,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
