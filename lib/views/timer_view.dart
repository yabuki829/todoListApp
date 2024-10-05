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
  var isRunning = false;
  final timeController = TextEditingController();

  void startTimer({bool reset = true}) {
    debugPrint(timeController.text);
    isRunning = true;
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
    isRunning = false;
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("集中しよう"),
        ),
        body: Container(
            width: double.infinity,
            color: Colors.deepPurpleAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
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
                        child: isRunning
                            ? Text(
                                '$minutes:${seconds.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 60,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: false, decimal: false),
                                  controller: timeController,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (value) {
                                    startTimer();
                                  },
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                // buildButtons()
                ElevatedButton(
                    onPressed: () {
                      if (isRunning) {
                        stopTimer(reset: true);
                      } else {
                        maxMinutes = int.parse(timeController.text);
                        startTimer();
                      }
                    },
                    child: isRunning
                        ? const Text("やめる",
                            style: TextStyle(color: Colors.black))
                        : const Text("スタート",
                            style: TextStyle(color: Colors.black)))
              ],
            )));
  }
}
