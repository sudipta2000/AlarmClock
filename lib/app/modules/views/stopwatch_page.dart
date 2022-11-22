import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/theme_data.dart';

class StopWatchApp extends StatefulWidget {
  const StopWatchApp({super.key});

  @override
  State<StopWatchApp> createState() => _StopWatchAppState();
}

class _StopWatchAppState extends State<StopWatchApp> {
  int miliSec = 0, seconds = 0, minutes = 0, hours = 0;
  String digitMiliSec = "000",
      digitSeconds = "00",
      digitsMinutes = "00",
      digitHours = "00";
  Timer? timer;
  bool isStarted = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      isStarted = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      miliSec = 0;
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitMiliSec = "000";
      digitSeconds = "00";
      digitsMinutes = "00";
      digitHours = "00";

      isStarted = false;
      laps.clear();
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitsMinutes:$digitSeconds.$digitMiliSec";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    isStarted = true;
    timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      int localMiliSec = miliSec + 1;
      int localSeconds = seconds;
      int localMinutes = minutes;
      int localHours = hours;

      if (localMiliSec > 999) {
        if (localSeconds > 59) {
          if (localMinutes > 59) {
            localHours++;
            localMinutes = 0;
          } else
            localMinutes++;
          localSeconds = 0;
        } else
          localSeconds++;
        localMiliSec = 0;
      } else
        localMiliSec++;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }

      setState(() {
        miliSec = localMiliSec;
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitMiliSec = (miliSec >= 100) ? "$miliSec" : "0$miliSec";
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitsMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: Text(
                  'Stopwatch',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w700,
                      color: CustomColors.primaryTextColor,
                      fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 28.0,
              ),
              Center(
                child: Text(
                  "$digitHours:$digitsMinutes:$digitSeconds.$digitMiliSec",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 300.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2F41),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            "Lap ${index + 1}: ",
                            style: TextStyle(
                                fontFamily: "avenir",
                                fontWeight: FontWeight.w700,
                                color: CustomColors.primaryTextColor,
                                fontSize: 24.0),
                          ),
                          Text(
                            "${laps[index]}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24.0),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!isStarted) ? start() : stop();
                      },
                      fillColor: Colors.grey,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: Text(
                        (!isStarted) ? "Start" : "Pause",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    color: Colors.brown,
                    onPressed: () {
                      addLaps();
                    },
                    icon: const Icon(Icons.flag_circle_rounded),
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.grey,
                      shape: const StadiumBorder(),
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
