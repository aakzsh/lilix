import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilix/dashboard.dart';
import 'package:lilix/encrypt.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bluesy,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "image here\nlol\nlol\nlol",
              style: TextStyle(color: Colors.white),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      color: Color.fromRGBO(125, 227, 182, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 150,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      },
                      child: Text(
                        "Dashboard",
                        style: GoogleFonts.poppins(
                          color: bluesy,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Color.fromRGBO(125, 227, 182, 1),
                          )),
                      minWidth: 150,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Encrypt()));
                      },
                      child: Text(
                        "New Lilix",
                        style:
                            GoogleFonts.poppins(fontSize: 18, color: greensy),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
