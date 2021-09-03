import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/MyPage.dart';

class EditQuestionPage extends StatefulWidget {
  EditQuestionPage(this.user, this.id);
  final User user;
  final String id;

  @override
  _EditQuestionPageState createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {
  String testTitle = "";
  String testCount = "";
  String testPassword = "";
  var questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("設問編集"),
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
                      Text(data['title']),
                      Text(data['count'].toString()),
                      Text(data['password']),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(labelText: "1問目 問題文"),
                        // initialValue: data['questions'].contains([0]['title'],
                        onChanged: (String value) {
                          setState(() {
                            questions[0]['title'] = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "1問目 選択肢1"),
                        // initialValue: data['questions'][0]['item1'],
                        onChanged: (String value) {
                          setState(() {
                            questions[0]['item1'] = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "1問目 選択肢2"),
                        // initialValue: data['questions'][0]['item2'],
                        onChanged: (String value) {
                          setState(() {
                            questions[0]['item2'] = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "1問目 選択肢3"),
                        // initialValue: data['questions'][0]['item3'],
                        onChanged: (String value) {
                          setState(() {
                            questions[0]['item3'] = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "1問目 選択肢4"),
                        // initialValue: data['questions'][0]['item4'],
                        onChanged: (String value) {
                          setState(() {
                            questions[0]['item4'] = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "1問目 正解"),
                        // initialValue: data['questions'][0]['answer'],
                        onChanged: (String value) {
                          setState(() {
                            questions[0]['answer'] = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "1問目 解説"),
                        // initialValue: data['questions'][0]['explanation'],
                        onChanged: (String value) {
                          setState(() {
                            questions[0]['explanation'] = value;
                          });
                        },
                      ),
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
                              'date': date,
                              'questions': questions
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
                  );
                }
                // データが読込中の場合
                return Center(
                  child: Text('読込中...'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
