import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilix/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lilix/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Color bluesy = Color.fromRGBO(6, 9, 29, 1);
Color greensy = Color.fromRGBO(125, 227, 182, 1);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          color: bluesy,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Take a break. Go Out. Unlock messages from your favourite people. Live a wholesome life.',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: MaterialButton(
                      color: Color.fromRGBO(125, 227, 182, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 120,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Checking()));
                      },
                      child: Text("Let's Start",
                          style:
                              GoogleFonts.poppins(color: bluesy, fontSize: 18)),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class Checking extends StatefulWidget {
  @override
  _CheckingState createState() => _CheckingState();
}

class _CheckingState extends State<Checking> {
  @override
  Widget build(BuildContext context) {
    check() {
      if (FirebaseAuth.instance.currentUser != null) {
        return Home();
      } else {
        return Signup();
      }
    }

    return check();
  }
}
