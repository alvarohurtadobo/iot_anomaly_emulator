import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/devices/providers/sensor_stream_provider.dart';

void main() {
  test('sensorStreamProvider emits empty data', () async {
    final container = ProviderContainer();

    // listen to the stream every 100ms
    final stream = container.read(
      sensorStreamProvider(const Duration(milliseconds: 100)).stream,
    );

    // take the first emited data
    final data = await stream.first;

    expect(data, isA<SensorData>());
    expect(data.values, isNotEmpty);
    expect(data.timestamp, isA<DateTime>());
  });
}
