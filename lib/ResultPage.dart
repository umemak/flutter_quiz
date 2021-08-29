import 'package:flutter/material.dart';
import 'package:flutter_quiz/TopPage.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("結果発表"),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Text("1位"),
                title: Text("ふくだ"),
                subtitle: Text("3point"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text("2位"),
                title: Text("むね"),
                subtitle: Text("3point"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text("3位"),
                title: Text("よしだ"),
                subtitle: Text("3point"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text("4位"),
                title: Text("すぎもと"),
                subtitle: Text("3point"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text("5位"),
                title: Text("おかだ"),
                subtitle: Text("3point"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text("6位"),
                title: Text("あだち"),
                subtitle: Text("3point"),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TopPage();
                }))
              },
              child: Text("終了", style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
