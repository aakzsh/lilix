import 'package:flutter/material.dart';
import 'dart:convert';

class Encrypt extends StatefulWidget {
  const Encrypt({Key? key}) : super(key: key);

  @override
  _EncryptState createState() => _EncryptState();
}

Codec<String, String> stringToBase64 = utf8.fuse(base64);

class _EncryptState extends State<Encrypt> {
  String input = "";
  String encoded = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Put Text Here"),
            TextField(
              onChanged: (value) {
                input = value;
              },
              maxLines: 100,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  encoded = stringToBase64.encode(input);
                });
              },
              child: Text("Encrypt"),
            ),
            SelectableText("$encoded"),
            MaterialButton(child: Text("copy text"), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
