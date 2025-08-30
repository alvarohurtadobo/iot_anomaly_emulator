import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_anomaly_emulator/devices/model/translate.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CounterView();
  }
}

class CounterView extends ConsumerWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Translate>>(
          future: getTranslations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error loading');
            } else if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.isEmpty) {
              return const Text('Empty data');
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(data[index].id.toString()),
                      Text(data[index].source),
                      Text(data[index].target!),
                    ],
                  );
                },
              );
            }else{
              return const Text('Unknown error');
            }
          },
        ),
      ),
    );
  }
}
