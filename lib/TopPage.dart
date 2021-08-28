import 'package:flutter/material.dart';
import 'package:flutter_quiz/LoginPage.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TOP"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
              onPressed: () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }))
                  },
              child: Text("参加", style: TextStyle(fontSize: 80))),
          TextButton(
              onPressed: () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }))
                  },
              child: Text("問題作成・編集", style: TextStyle(fontSize: 80)))
        ]),
      ),
    );
  }
}
