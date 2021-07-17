import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilix/home.dart';
import 'package:lilix/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String email, password;

    return Scaffold(
        body: Container(
      color: bluesy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 0, 15),
            child: Text(
              'Log In',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Email",
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 2, 20, 20),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(25, 29, 49, 1)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: TextField(
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Password",
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 2, 20, 20),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(25, 29, 49, 1)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: TextField(
                    obscureText: true,
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                color: Color.fromRGBO(125, 227, 182, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                minWidth: 150,
                onPressed: () {
                  auth
                      .signInWithEmailAndPassword(
                          email: email, password: password)
                      .then((result) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  }).catchError((err) {
                    print(err.message);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(err.message),
                            actions: [
                              TextButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  });
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    color: bluesy,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
