import 'package:flutter/material.dart';
import 'package:lilix/encrypt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilix/main.dart';
import 'package:pedometer/pedometer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

int steps;
int goal = 0;
double percent = 0.0;

class _DashboardState extends State<Dashboard> {
  Stream<StepCount> _stepCountStream;
  String _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'err';
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bluesy,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                homebtn(context),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
                  child: Text(
                    'Dashboard',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          greensy.withOpacity(1),
                          bluesy.withOpacity(0.4)
                        ])),
                height: 160,
                width: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total Steps:",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Text("$_steps",
                        style: GoogleFonts.poppins(
                            fontSize: 40, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Level of Encryption",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset("assets/steps.png"),
                          Text("$goal",
                              style: GoogleFonts.poppins(fontSize: 20))
                        ],
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(25, 29, 49, 1),
                      ),
                      width: 150,
                      height: 50,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Progress",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset("assets/refresh.png"),
                          Text("$percent %",
                              style: GoogleFonts.poppins(fontSize: 20))
                        ],
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(25, 29, 49, 1),
                      ),
                      width: 150,
                      height: 50,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
