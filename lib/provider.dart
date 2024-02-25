import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_count_up/data/count_data.dart';

// refを使ってriverpodと通信を行う
final titleProvider = Provider<String>((ref) => 'Riverpod Demo Home Page');

final countUpDetail = Provider<String>((ref) {
  return 'You have pushed the button this many times:';
});

final countProvider = StateProvider<int>((ref) => 0);
final countDataProvider = StateProvider<CountData>(
    (ref) => const CountData(count: 0, countUp: 0, countDown: 0));
