import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
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
    final state = useAppLifecycleState();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Opacity(
          opacity: state == AppLifecycleState.resumed ? 1 : 0,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 10,
                  color: Colors.black.withAlpha(100),
                ),
              ],
            ),
            child: Image.asset('assets/card.jpeg'),
          ),
        ),
      ),
    );
  }
}
