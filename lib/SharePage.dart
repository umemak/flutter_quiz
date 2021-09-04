import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/MyPage.dart';

class SharePage extends StatefulWidget {
  SharePage(this.user, this.id);
  final User user;
  final String id;

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  String testTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("問題共有"),
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
                      'date': date
                    });
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return MyPage(widget.user);
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
