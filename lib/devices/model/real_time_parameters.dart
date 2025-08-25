class RealTimeParameters {
  final double vibration;
  final double temperature;
  final double pressure;
  final double oilQuality;
  final double contaminantLevel;
  final double acidity;
  final double hoursOperated;
  final double maintenanceHistory;
  final double load;
  final bool failure;
  final bool anomaly;
  final DateTime timestamp;

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

  /// Crea una copia modificada del objeto (útil para Riverpod/StateNotifier)
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

  /// Para crear la clase desde JSON
  factory RealTimeParameters.fromJson(Map<String, dynamic> json) {
    return RealTimeParameters(
      vibration: double.tryParse(json['vibration'].toString()) ?? 0.0,
      temperature: double.tryParse(json['temperature'].toString()) ?? 0,
      pressure: double.tryParse(json['pressure'].toString()) ?? 0,
      oilQuality: double.tryParse(json['oil_quality'].toString()) ?? 0,
      contaminantLevel:
          double.tryParse(json['contaminant_level'].toString()) ?? 0,
      acidity: double.tryParse(json['acidity'].toString()) ?? 0,
      hoursOperated: double.tryParse(json['hours_operated'].toString()) ?? 0,
      maintenanceHistory:
          double.tryParse(json['maintenance_history'].toString()) ?? 0,
      load: double.tryParse(json['load'].toString()) ?? 0,
      failure: (json['failure'] as bool?) ?? false,
      anomaly: (json['anomaly'] as bool?) ?? false,
      timestamp:
          DateTime.tryParse(json['timestamp'].toString()) ?? DateTime.now(),
    );
  }
}
