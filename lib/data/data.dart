import 'package:flutter/material.dart';
import 'package:realtime_text_recognition/record/record.dart';
import 'package:realtime_text_recognition/violation/violation.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  get details => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          actions: [
            RaisedButton(
              onPressed: () {
                openDialogueBox(context);
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              color: Colors.deepPurple,
            ),
            RaisedButton(
              onPressed: () async {},
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              color: Colors.deepPurple,
            )
          ],
        ),
        body: Container(child: ListView.builder(itemBuilder: (context, index) {
          return Card();
        })));
  }

  RaisedButton(
      {required Function() onPressed,
      required Icon child,
      required MaterialColor color}) {}

  void openDialogueBox(BuildContext context) {}
}

mixin length {}
