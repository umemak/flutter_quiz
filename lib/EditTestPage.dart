import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/EditQuestionPage.dart';
import 'package:flutter_quiz/MyPage.dart';

class EditTestPage extends StatefulWidget {
  EditTestPage(this.user, this.id);
  final User user;
  final String id;

  @override
  _EditTestPageState createState() => _EditTestPageState();
}

class _EditTestPageState extends State<EditTestPage> {
  String testTitle = "";
  String testCount = "";
  String testPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("問題編集"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(32),
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('tests')
                  .doc(widget.id)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('エラー'),
                  );
                }
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Center(
                    child: Text('指定した問題が見つかりません'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: <Widget>[
                      Text("${widget.user.email}"),
                      TextFormField(
                        decoration: InputDecoration(labelText: "タイトル"),
                        initialValue: data['title'],
                        onChanged: (String value) {
                          setState(() {
                            testTitle = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "設問数"),
                        initialValue: data['count'].toString(),
                        onChanged: (String value) {
                          setState(() {
                            testCount = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "参加用パスワード"),
                        initialValue: data['password'],
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
                          child: Text('更新'),
                          onPressed: () async {
                            final date = DateTime.now()
                                .toLocal()
                                .toIso8601String(); // 現在の日時
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
                  );
                }
                // データが読込中の場合
                return Center(
                  child: Text('読込中...'),
                );
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('tests')
                    .doc(widget.id)
                    .delete();
                await Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return MyPage(widget.user);
                }));
              },
            ),
          )
        ],
      ),
    );
  }
}
