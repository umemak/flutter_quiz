import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/QuestionPage.dart';

class EntryArguments {
  final String code;

  EntryArguments(this.code);
}

class EntryPage extends StatefulWidget {
  static const routeName = '/entry';
  EntryPage(this.arguments);
  final Object? arguments;

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EntryArguments;
    final _codeController = TextEditingController(text: args.code);
    final _nameController = TextEditingController(text: "");
    return Scaffold(
      appBar: AppBar(
        title: Text("参加"),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              onPressed: () async {
                try {
                  // メール/パスワードでユーザー登録
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final UserCredential result = await auth.signInAnonymously();
                  final User user = result.user!;
                  // 参加コード確認
                  final FirebaseFirestore store = FirebaseFirestore.instance;
                  final QuerySnapshot ss = await store
                      .collection('games')
                      .where('code', isEqualTo: _codeController.text)
                      .get();
                  if (ss.docs.isEmpty) {
                    //   NG->再入力
                    print("game is not exists");
                  }
                  //   OK->ドキュメントID取得
                  final gameId = ss.docs.first.reference.id;
                  print("gameid: $gameId");
                  // 参加登録 games.docID.members.userID
                  await store
                      .collection('games')
                      .doc(gameId)
                      .collection('members')
                      .doc(user.uid)
                      .set({
                    'uid': user.uid,
                    'name': _nameController.text,
                  });
                  // 開始ステータス待ち
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return QuestionPage();
                  }));
                } catch (e) {
                  // 登録に失敗した場合
                }
              },
              child: Text("参加する"),
            ),
          ],
        ),
      ),
    );
  }
}
