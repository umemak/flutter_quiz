import 'package:flutter/material.dart';
import 'package:flutter_quiz/TopPage.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("利用登録"),
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
