// refを使ってriverpodと通信を行う
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = Provider<String>((ref) {
  return 'Riverpod Demo Home Page';
});