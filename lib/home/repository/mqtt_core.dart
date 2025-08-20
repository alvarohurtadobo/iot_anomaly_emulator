import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


MqttServerClient myClient = MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);
myClient.keepAlivePeriod = 60;
final MqttConnectMessage connMessage = MqttConnectMessage()
    .authenticateAs('username', 'password')
    .withWillTopic('willtopic')
    .withWillMessage('Will message')
    .startClean()
    .withWillQos(MqttQos.atLeastOnce);
myClient.connectionMessage = connMessage;
