import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'encrypt.dart';
import 'package:clipboard/clipboard.dart';

class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

String msg = "Copy Text";

class _GenerateState extends State<Generate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bluesy,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            homebtn(context),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
              child: Text(
                'Generate',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(25, 29, 49, 1)),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: SelectableText("$output",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 16)))),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      color: Color.fromRGBO(125, 227, 182, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 120,
                      onPressed: () {
                        setState(() {
                          msg = "copied!!";
                        });
                        FlutterClipboard.copy(output);
                      },
                      child: Text(
                        "$msg",
                        style: GoogleFonts.poppins(
                          color: bluesy,
                          fontSize: 15,
                        ),
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
