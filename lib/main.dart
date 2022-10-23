import 'dart:math';

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

enum Action { rotateLeft, rotateRight, moreVisible, lessVisible }

@immutable
class State {
  final double rotationDeg;
  final double alpha;

  const State({required this.rotationDeg, required this.alpha});

  const State.initial()
      : rotationDeg = 0.0,
        alpha = 1.0;

  State rotateRight() => State(alpha: alpha, rotationDeg: rotationDeg + 10.0);

  State rotateLeft() => State(alpha: alpha, rotationDeg: rotationDeg - 10.0);

  State increaseAlpha() =>
      State(alpha: min(alpha + 0.1, 1.0), rotationDeg: rotationDeg);

  State decreaseAlpha() =>
      State(alpha: max(alpha - 0.1, 0.0), rotationDeg: rotationDeg);
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    default:
      return oldState;
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(
      reducer,
      initialState: const State.initial(),
      initialAction: null,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.rotateLeft);
                  },
                  child: const Text('Left')),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.rotateRight);
                  },
                  child: const Text('Right')),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.moreVisible);
                  },
                  child: const Text('+ alpha')),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.lessVisible);
                  },
                  child: const Text('- alpha')),
            ],
          ),
          const SizedBox(height: 100),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
                turns: AlwaysStoppedAnimation(store.state.rotationDeg / 360),
                child: Image.network(pictureUrl)),
          ),
        ],
      ),
    );
  }
}
