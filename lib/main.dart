import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cachedCountdown = useMemoized(() => CountDown(from: 20));
    final listenable = useListenable(cachedCountdown);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page: ${listenable.value}'),
      ),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(seconds: 1), (value) => from - value)
        .takeWhile((value) => value >= 0)
        .listen((value) {
      this.value = value;
    });
  }

  late StreamSubscription sub;

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
