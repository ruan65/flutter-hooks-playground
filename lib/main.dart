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

const pictureUrl =
    'https://i.pinimg.com/originals/83/1a/7c/831a7cf39e76484168b529d4486f97db.jpg';

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;

    controller = useStreamController<double>(
      onListen: () {
        controller.sink.add(0.0);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: StreamBuilder<double>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final rotation = snapshot.data ?? 0.0;
          return GestureDetector(
            onTap: () {
              controller.sink.add(rotation + 10.0);
            },
            child: RotationTransition(
              turns: AlwaysStoppedAnimation<double>(rotation / 360),
              child: Center(
                child: Image.network(pictureUrl),
              ),
            ),
          );
        },
      ),
    );
  }
}
