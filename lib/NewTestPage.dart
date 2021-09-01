import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/EditQuestionPage.dart';

class NewTestPage extends StatefulWidget {
  NewTestPage(this.user);
  final User user;

  @override
  _NewTestPageState createState() => _NewTestPageState();
}

class _NewTestPageState extends State<NewTestPage> {
  String testTitle = "";
  String testCount = "";
  String testPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新規問題"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Text("${widget.user.email}"),
              TextFormField(
                decoration: InputDecoration(labelText: "タイトル"),
                onChanged: (String value) {
                  setState(() {
                    testTitle = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "設問数"),
                onChanged: (String value) {
                  setState(() {
                    testCount = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "参加用パスワード"),
                onChanged: (String value) {
                  setState(() {
                    testPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('作成'),
                  onPressed: () async {
                    final date =
                        DateTime.now().toLocal().toIso8601String(); // 現在の日時
                    await FirebaseFirestore.instance
                        .collection('tests')
                        .doc() // ドキュメントID自動生成
                        .set({
                      'author': widget.user.email,
                      'title': testTitle,
                      'count': testCount,
                      'password': testPassword,
                      'date': date
                    });
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return EditQuestionPage(widget.user);
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
