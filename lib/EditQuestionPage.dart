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
  String testPassword = "";
  String q01Title = "";
  String q01Item1 = "";
  String q01Item2 = "";
  String q01Item3 = "";
  String q01Item4 = "";
  String q01Answer = "";
  String q01Explanation = "";

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
                  final _q01TitleController = TextEditingController.fromValue(
                      TextEditingValue(text: data['q01Title']));
                  return Column(
                    children: <Widget>[
                      Text("${widget.user.email}"),
                      Text(data['title']),
                      Text(data['password']),
                      const SizedBox(height: 8),
                      Card(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: "1問目 問題文"),
                              controller: _q01TitleController,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "1問目 選択肢1"),
                              initialValue: data['q01Item1'],
                              onChanged: (String value) {
                                setState(() {
                                  q01Item1 = value;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "1問目 選択肢2"),
                              initialValue: data['q01Item2'],
                              onChanged: (String value) {
                                setState(() {
                                  q01Item2 = value;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "1問目 選択肢3"),
                              initialValue: data['q01Item3'],
                              onChanged: (String value) {
                                setState(() {
                                  q01Item3 = value;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "1問目 選択肢4"),
                              initialValue: data['q01Item4'],
                              onChanged: (String value) {
                                setState(() {
                                  q01Item4 = value;
                                });
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: "1問目 正解"),
                              initialValue: data['q01Answer'],
                              onChanged: (String value) {
                                setState(() {
                                  q01Answer = value;
                                });
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: "1問目 解説"),
                              initialValue: data['q01Explanation'],
                              onChanged: (String value) {
                                setState(() {
                                  q01Explanation = value;
                                });
                              },
                            ),
                          ],
                        ),
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
                                .doc(widget.id)
                                .update({
                              'date': date,
                              'q01Title': q01Title,
                              'q01Item1': q01Item1,
                              'q01Item2': q01Item2,
                              'q01Item3': q01Item3,
                              'q01Item4': q01Item4,
                              'q01Answer': q01Answer,
                              'q01Explanation': q01Explanation
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
