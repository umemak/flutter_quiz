import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_quiz/TopPage.dart';
import 'package:flutter_quiz/QuestionPage.dart';

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("参加"),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("名前"),
            TextField(),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return QuestionPage();
                }))
              },
              child: Text("参加する", style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
