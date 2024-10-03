import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  TimerViewState createState() => TimerViewState();
}

class TimerViewState extends State<TimerView> {
  int maxMinutes = 25;
  int minutes = 25;
  int seconds = 0;
  Timer? timer;

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = minutes == maxMinutes && seconds == 0;
    final timeController = TextEditingController();

    return isRunning || !isCompleted
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              onPressed: () {
                if (isRunning) {
                  stopTimer(reset: true);
                } else {
                  resetTimer();
                }
              },
              child: isRunning ? const Text("初めから") : const Text("再開"),
            ),
            const SizedBox(width: 12),
            TextButton(onPressed: resetTimer, child: const Text("初めから")),
          ])
        : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: '分数を入力してください'),
              keyboardType: TextInputType.number,
              autofocus: true,
              controller: timeController,
            ),
            ElevatedButton(
              onPressed: () {
                maxMinutes = int.parse(timeController.text);
                startTimer();
              },
              child: const Text(
                "スタート",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ]);
  }

  Widget buildTimer() => SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - (minutes * 60 + seconds) / (maxMinutes * 60),
            valueColor: const AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 12,
            backgroundColor: Colors.greenAccent,
          ),
          Center(
            child: buildTime(),
          )
        ],
      ));

  Widget buildTime() {
    return Text(
      '$minutes:${seconds.toString().padLeft(2, '0')}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 60,
      ),
    );
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    // seconds: 1
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else if (minutes > 0) {
        setState(() {
          minutes--;
          seconds = 59;
        });
      } else {
        stopTimer(reset: false);
        minutes = maxMinutes;
        seconds = 0;
      }
    });
  }

  void resetTimer() => setState(() {
        minutes = maxMinutes;
        seconds = 0;
      });

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            color: Colors.deepPurpleAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$minutes分集中しよう",
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
                buildTimer(),
                const SizedBox(height: 80),
                buildButtons()
              ],
            )));
  }
}
