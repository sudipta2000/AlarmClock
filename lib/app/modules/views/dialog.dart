import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  TextEditingController alertController = TextEditingController();
  Future<void> dialogInput(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(''),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: alertController,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                style: TextButton.styleFrom(foregroundColor: Colors.lightGreen),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: Text("OK"),
                style: TextButton.styleFrom(foregroundColor: Colors.lightGreen),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String codeDialog = "";
  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (codeDialog == "123456") ? Colors.green : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Alarm Label'),
      ),
      body: Center(
        child: TextButton(
          child: Text("OK"),
          style: TextButton.styleFrom(foregroundColor: Colors.lightGreen),
          onPressed: () {
            dialogInput(context);
          },
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Container();
}
