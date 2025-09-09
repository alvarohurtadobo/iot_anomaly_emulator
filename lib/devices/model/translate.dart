import 'dart:math';

class Translate {
  const Translate({
    required this.id,
    required this.source,
    required this.target,
  });

  factory Translate.fromJson(Map<String, dynamic> json) {
    return Translate(
      id: json['id'] as int,
      source: json['source'].toString(),
      target: json['target'] as String,
    );
  }

  final int id;
  final String source;
  final String? target;
}

Future<List<Translate>> getTranslations() async {
  await Future.delayed(const Duration(seconds: 1), () {});
  // const mockedList = [
  //   Translate(id: 1, source: 'name', target: 'nombre'),
  //   Translate(id: 2, source: 'hello', target: 'hola'),
  //   Translate(id: 3, source: 'bye', target: 'chau'),
  // ];

  final random = Random(DateTime.now().millisecondsSinceEpoch);
  final myRandomInt = random.nextInt(3);
  switch (myRandomInt) {
    case 0:
      return [];
    case 1:
      throw Exception('Unable to connect');
    default:
      final json = [
        {'id': 1, 'source': 'Hello', 'target': 'Hola'},
        {'id': 2, 'source': 'Good morning', 'target': 'Buenos días'},
        {'id': 3, 'source': 'Thank you', 'target': 'Gracias'},
      ];
      return json.map<Translate>(Translate.fromJson).toList();
  }
}
