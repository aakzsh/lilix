import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilix/home.dart';
import 'package:lilix/login.dart';
import 'package:lilix/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String name, email, password;
    bool flag = true;
    int steps = 0, goal = 0;
    return Scaffold(
        body: Container(
      color: bluesy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 0, 15),
            child: Text(
              'Sign Up',
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
              "Name",
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
                      name = value;
                    },
                  ),
                )),
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
          MaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text("Already an user? signin")),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(
                color: Color.fromRGBO(125, 227, 182, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                minWidth: 150,
                onPressed: () async {
                  await firebaseAuth
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    if (value.user != null) {
                      firestoreInstance
                          .collection("users")
                          .doc(value.user?.uid)
                          .set({
                        "name": name,
                        "flag": flag,
                        "email": email,
                        "steps": steps,
                        "goal": goal,
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    }
                  }).catchError((err) {
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
                  "SignUp",
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
