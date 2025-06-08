import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_app/cubit/counter_cubit.dart';
import 'package:bloc_app/cubit/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubitPage extends StatelessWidget {
  const CounterCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter BLOC",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          bloc: counterCubit,
          builder: (context, counter) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Counter",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "$counter",
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _playClickSound();
              counterCubit.increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              _playClickSound();
              counterCubit.decrement();
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SecondPage()));
            },
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  void _playClickSound() {
    final player = AudioPlayer();
    player.play(AssetSource('sounds/click_sound.mp3'));
  }
}
