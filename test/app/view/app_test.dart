import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/app/app.dart';
import 'package:iot_anomaly_emulator/home/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
