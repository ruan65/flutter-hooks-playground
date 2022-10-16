import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

Stream<String> getTime() => Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now().toIso8601String(),
    );

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
    final dateTime = useStream(getTime());
    return Scaffold(
        appBar: AppBar(
          title: Text(dateTime.data ?? 'Home page'),
        ),
        body: Container());
  }
}
