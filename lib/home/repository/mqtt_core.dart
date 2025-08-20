import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTConttoller {
  init() async {
    final myClient =
        MqttServerClient.withPort(
            'broker.emqx.io',
            'flutter_client',
            1883,
          )
          ..keepAlivePeriod = 60
          ..logging(on: true)
          ..onConnected = () {
            print("Successfully connected");
          }
          ..onDisconnected = () {
            print("Successfully disconnected");
          }
          ..onSubscribed = (topic) {
            print("Successfully subscribed to $topic");
          };

    try {
      await myClient.connect();
    } catch (e) {
      print('Error: $e');
      myClient.disconnect();
    }
  }
}
