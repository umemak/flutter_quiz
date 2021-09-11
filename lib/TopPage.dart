import 'package:flutter/material.dart';
import 'package:flutter_quiz/LoginPage.dart';
import 'package:flutter_quiz/EntryPage.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TOP"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OutlinedButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                        EntryPage.routeName,
                        arguments: {'code': ''},
                      ),
                  child: Text("参加する", style: TextStyle(fontSize: 40))),
              OutlinedButton(
                  onPressed: () => {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }))
                      },
                  child: Text("問題作成・編集", style: TextStyle(fontSize: 40)))
            ]),
      ),
    );
  }
}
