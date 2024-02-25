import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_count_up/provider.dart';

import 'data/count_data.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('MyHomePage rebuild');

    // watchで監視しているProviderの値が変更されると再描画される
    // readに変更すると再描画されない
    final state = ref.watch(countDataProvider);

    // readでProviderの値を取得し、notifierでProviderの値を変更する
    // watchで監視しているProviderの値が変更されると再描画される
    // この場合は、countDataProviderの値が変更されると再描画される
    final stateNotifier = ref.read(countDataProvider.notifier);

    // selectで指定したstateのみ再描画を行う
    String selectToString({required Function(CountData) function}) =>
        ref.watch(countDataProvider.select(function)).toString();

    return Scaffold(
      appBar: AppBar(title: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Text(ref.watch(titleProvider));
        },
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref.watch(countUpDetail),
            ),
            Text(selectToString(function: (data) => data.count)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () => stateNotifier.state = state.copyWith(
                    count: state.count + 1,
                    countUp: state.countUp + 1,
                  ),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () => stateNotifier.state = state.copyWith(
                    count: state.count - 1,
                    countDown: state.countDown + 1,
                  ),
                  tooltip: 'Increment',
                  child: const Icon(Icons.remove),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(selectToString(function: (data) => data.countUp)),
                Text(selectToString(function: (data) => data.countDown)),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => stateNotifier.state = const CountData(
          count: 0,
          countUp: 0,
          countDown: 0,
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
