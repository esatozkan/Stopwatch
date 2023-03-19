import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Icon icon = const Icon(
    Icons.play_arrow,
    color: Color(0xffD9D7D8),
    size: 54,
  );
  bool isStart = false;
  List<String> list = [];
  int hour = 0;
  int minute = 0;
  int second = 0;
  int milisecond = 0;
  Timer? timer;
  var font = GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400);

  void _start() {
    setState(() {
      isStart = !isStart;
      if (isStart) {
        icon = const Icon(
          Icons.pause,
          color: Color(0xffD9D7D8),
          size: 54,
        );
        const oneSec = const Duration(milliseconds: 1);
        timer = new Timer.periodic(
            oneSec,
            (Timer timer) => setState(() {
                  milisecond++;
                  if (milisecond == 100) {
                    second++;
                    milisecond = 0;
                  }
                  if (second == 60) {
                    second = 0;
                    minute++;
                  }
                  if (minute == 60) {
                    minute = 0;
                    hour++;
                  }
                }));
      } else {
        icon = const Icon(
          Icons.play_arrow,
          color: Color(0xffD9D7D8),
          size: 54,
        );
        timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[600],
        titleTextStyle: GoogleFonts.roboto(
            fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
        centerTitle: true,
        title: const Text("Stopwatch"),
      ),
      body: Center(
        child: Column(children: [
          Container(
            height: 200,
            width: width,
            decoration: BoxDecoration(color: Colors.grey[600]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          hour = 0;
                          minute = 0;
                          second = 0;
                          milisecond = 0;
                          list = [];
                        });
                      },
                      child: Container(
                          height: 65,
                          width: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[500],
                          ),
                          child: Text("Stop", style: font))),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.yellow[500],
                        child: InkWell(
                          splashColor: Colors.yellow[900],
                          child: Container(
                              width: 200,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  icon,
                                  Text(
                                      "$hour : $minute : $second : $milisecond",
                                      style: font)
                                ],
                              )),
                          onTap: _start,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        list.add("$hour : $minute : $second : $milisecond");
                      });
                    },
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow[500],
                      ),
                      child: Text("flag", style: font),
                    ),
                  ),
                ]),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${index + 1}",
                            style: font,
                          ),
                          Text(list[index],
                              style: const TextStyle(
                                fontSize: 24,
                              )),
                          const Icon(
                            Icons.flag_outlined,
                            size: 24,
                          )
                        ],
                      ),
                    );
                  })),
        ]),
      ),
    );
  }
}
