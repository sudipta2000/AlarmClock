import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextViewNew extends StatefulWidget {
  const TextViewNew({Key? key}) : super(key: key);

  @override
  State<TextViewNew> createState() => _TextViewNewState();
}

class _TextViewNewState extends State<TextViewNew> {
  final editorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: const Text("Enter Your Alarm Lable"),
                backgroundColor: Colors.blueGrey),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Label',
                    ),
                  ),
                ),
              ]),
            )));
  }
}
