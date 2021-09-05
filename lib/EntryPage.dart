import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/QuestionPage.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _codeController = TextEditingController(text: "");
  final _nameController = TextEditingController(text: "");
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<User> signInAnon() async {
    UserCredential result = await auth.signInAnonymously();
    return result.user!;
  }

  // _EntryPageState() {
  //   signInAnon().then((User user) {
  //     this.user = user;
  //   });
  // }
  Future<User> user = signInAnon();

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
            Text(user.uid),
            TextFormField(
              decoration: InputDecoration(labelText: "参加コード"),
              controller: _codeController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "表示名"),
              controller: _nameController,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => {
                // 参加コード確認
                //   NG->再入力
                //   OK->ドキュメントID取得
                // 参加登録 games.docID.members.userID
                // 開始ステータス待ち
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return QuestionPage();
                }))
              },
              child: Text("参加する"),
            ),
          ],
        ),
      ),
    );
  }
}
