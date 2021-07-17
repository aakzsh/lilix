import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilix/generate.dart';
import 'package:lilix/main.dart';
import 'dart:convert';

Codec<String, String> stringToBase64 = utf8.fuse(base64);

// String encoded = stringToBase64.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
// String decoded = stringToBase64.decode(encoded);
class Encrypt extends StatefulWidget {
  @override
  _EncryptState createState() => _EncryptState();
}

String title = "", content = "";
String output = "";
int level = 1;

class _EncryptState extends State<Encrypt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          color: bluesy,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                homebtn(context),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
                  child: Text(
                    'Create Lilix',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(25, 29, 49, 1)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        child: TextField(
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16),
                          onChanged: (value) {
                            title = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Title",
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(25, 29, 49, 1)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        child: TextField(
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16),
                          onChanged: (value) {
                            content = value;
                          },
                          maxLines: 7,
                          decoration:
                              InputDecoration(hintText: "Write a short letter"),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              Text("$level"),
                              DropdownButton<String>(
                                items: <String>["1", "2", "3", "4"]
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      level = int.parse(value);
                                    });
                                  }
                                },
                              ),
                            ],
                          )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(25, 29, 49, 1),
                          ),
                          width: 150,
                          height: 40,
                        )
                      ],
                    ),
                    MaterialButton(
                      color: Color.fromRGBO(125, 227, 182, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: 120,
                      onPressed: () {
                        for (int i = 1; i <= level; i++) {
                          title = stringToBase64.encode(title);

                          content = stringToBase64.encode(content);
                        }
                        output = ("$level" + "$title" + "^" + "$content");
                        setState(() {
                          title = "";
                          content = "";
                          level = 1;
                        });

                        print(output);
                        // print(stringToBase64.decode(output));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Generate()));
                      },
                      child: Text(
                        "Encrypt",
                        style: GoogleFonts.poppins(
                          color: bluesy,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

homebtn(context) {
  return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
            (Route<dynamic> route) => false);
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        greensy.withOpacity(1),
                        bluesy.withOpacity(0.4)
                      ]),
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(40)),
            )
          ],
        ),
      ));
}
