import 'package:flutter/material.dart';
import 'package:flutter_quiz/TopPage.dart';

class PresenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("主催者用"),
        ),
        body: Center(
            child: TextButton(
                onPressed: () => {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TopPage();
                      }))
                    },
                child: Text("進む", style: TextStyle(fontSize: 80)))));
  }
}