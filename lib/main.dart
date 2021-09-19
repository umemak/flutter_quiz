// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

import 'package:flutter_quiz/SignupPage.dart';
import 'package:flutter_quiz/NewTestPage.dart';
import 'package:flutter_quiz/EntryPage.dart';

class UserState extends ChangeNotifier {
  User? user;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserState userState = UserState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>.value(
      value: userState,
      // create: (context) => UserState(),
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Flutter Quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TopPage(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          MyPage.routeName: (BuildContext context) => MyPage(),
        },
        onGenerateRoute: (settings) {
          final settingsUri = Uri.parse(settings.name!);
          if (settingsUri.path == EntryPage.routeName) {
            final codeID = settingsUri.queryParameters['code'];
            return MaterialPageRoute(
              builder: (context) => EntryPage(codeID!),
            );
          }
          if (settingsUri.path == DetailTestPage.routeName) {
            final testID = settingsUri.queryParameters['testid'];
            return MaterialPageRoute(
              builder: (context) => DetailTestPage(testID!),
            );
          }
          return null;
        },
      ),
    );
  }
}

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
                          return LoginCheck(nextPage: MyPage.routeName);
                        }))
                      },
                  child: Text("問題作成・編集", style: TextStyle(fontSize: 40)))
            ]),
      ),
    );
  }
}

class LoginCheck extends StatefulWidget {
  LoginCheck({Key? key, required this.nextPage}) : super(key: key);
  final String nextPage;

  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  void checkUser() {
    final userState = Provider.of<UserState>(context, listen: false);
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      userState.setUser(FirebaseAuth.instance.currentUser!);
      Navigator.pushReplacementNamed(context, widget.nextPage);
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() {
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String loginUserEmail = "";
  String loginUserPassword = "";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("ログイン"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                        await auth.signInWithEmailAndPassword(
                      email: loginUserEmail,
                      password: loginUserPassword,
                    );
                    // ログインに成功した場合
                    final User user = result.user!;
                    userState.setUser(user);
                    setState(() {
                      infoText = "ログインOK：${user.email}";
                    });
                    await Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return MyPage();
                    }));
                  } catch (e) {
                    // ログインに失敗した場合
                    setState(() {
                      infoText = "ログインNG：${e.toString()}";
                    });
                  }
                },
                child: Text("ログイン"),
              ),
              const SizedBox(height: 8),
              Text(infoText),
              OutlinedButton(
                  onPressed: () => {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SignupPage();
                        }))
                      },
                  child: Text("利用登録"))
            ],
          ),
        ),
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  static const routeName = '/mypage';
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context, listen: false);
    if (userState.user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("マイページ"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text("${userState.user!.email}"),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return NewTestPage(userState.user!);
                        }),
                      ),
                    },
                    child: Text("新規問題作成"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('tests')
                    // .where('author', isEqualTo: widget.user.email)
                    .orderBy('date')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView(
                      children: documents.map((document) {
                        return Card(
                          child: ListTile(
                            title: Text(document['title']),
                            trailing: IconButton(
                              icon: Icon(Icons.arrow_right),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return DetailTestPage(document.id);
                                  }),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: Text("読込中..."),
                  );
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlinedButton(
                    onPressed: () => {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginCheck(nextPage: MyPage.routeName);
                          }))
                        },
                    child: Text("ログイン", style: TextStyle(fontSize: 40)))
              ]),
        ),
      );
    }
  }
}

class DetailTestPage extends StatefulWidget {
  static const routeName = '/mypage';
  DetailTestPage(this.id);
  final String id;

  @override
  _DetailTestPageState createState() => _DetailTestPageState();
}

class _DetailTestPageState extends State<DetailTestPage> {
  @override
  Widget build(BuildContext context) {
    // final UserState userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("問題詳細"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    final _titleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['title'] ?? ""));
                    var _qTitleController = []..length = 11;
                    var _qItem1Controller = []..length = 11;
                    var _qItem2Controller = []..length = 11;
                    var _qItem3Controller = []..length = 11;
                    var _qItem4Controller = []..length = 11;
                    var _qAnswerController = []..length = 11;
                    var _qNoteController = []..length = 11;
                    for (var i = 1; i <= 10; i++) {
                      var ii = "q" + i.toString().padLeft(2, "0");
                      _qTitleController[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Title'] ?? ""));
                      _qItem1Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item1'] ?? ""));
                      _qItem2Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item2'] ?? ""));
                      _qItem3Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item3'] ?? ""));
                      _qItem4Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item4'] ?? ""));
                      _qAnswerController[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Answer'] ?? ""));
                      _qNoteController[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Note'] ?? ""));
                    }
                    TextFormField makeTextFormField(
                        String l, TextEditingController c) {
                      return TextFormField(
                        decoration: InputDecoration(labelText: l),
                        controller: c,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        readOnly: true,
                      );
                    }

                    Card makeCard(int idx) {
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              color: Theme.of(context).primaryColor,
                              width: double.infinity,
                              child: Text("${idx.toString()}問目",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1),
                            ),
                            makeTextFormField("問題文", _qTitleController[idx]),
                            makeTextFormField("選択肢1", _qItem1Controller[idx]),
                            makeTextFormField("選択肢2", _qItem2Controller[idx]),
                            makeTextFormField("選択肢3", _qItem3Controller[idx]),
                            makeTextFormField("選択肢4", _qItem4Controller[idx]),
                            makeTextFormField("正解", _qAnswerController[idx]),
                            makeTextFormField("解説", _qNoteController[idx]),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: <Widget>[
                        // Text("${userState.user!.email}"),
                        TextFormField(
                          decoration: InputDecoration(labelText: "タイトル"),
                          controller: _titleController,
                        ),
                        const SizedBox(height: 8),
                        if (_qTitleController[1].text != "") makeCard(1),
                        if (_qTitleController[2].text != "") makeCard(2),
                        if (_qTitleController[3].text != "") makeCard(3),
                        if (_qTitleController[4].text != "") makeCard(4),
                        if (_qTitleController[5].text != "") makeCard(5),
                        if (_qTitleController[6].text != "") makeCard(6),
                        if (_qTitleController[7].text != "") makeCard(7),
                        if (_qTitleController[8].text != "") makeCard(8),
                        if (_qTitleController[9].text != "") makeCard(9),
                        if (_qTitleController[10].text != "") makeCard(10),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.edit),
                            label: Text('編集'),
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return EditTestPage(widget.id);
                                }),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.share),
                            label: Text("開催"),
                            onPressed: () async {
                              final code = Random().nextInt(100000).toString();
                              final ref = await FirebaseFirestore.instance
                                  .collection('games')
                                  .add({
                                "code": code,
                                "status": 0,
                                "test": widget.id,
                              });
                              await Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return SharePage(widget.id,
                                    _titleController.text, code, ref.id);
                              }));
                            },
                          ),
                        ),
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
      ),
    );
  }
}

class EditTestPage extends StatefulWidget {
  EditTestPage(this.id);
  final String id;

  @override
  _EditTestPageState createState() => _EditTestPageState();
}

class _EditTestPageState extends State<EditTestPage> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("問題編集"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    final _titleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['title'] ?? ""));
                    var _qTitleController = []..length = 11;
                    var _qItem1Controller = []..length = 11;
                    var _qItem2Controller = []..length = 11;
                    var _qItem3Controller = []..length = 11;
                    var _qItem4Controller = []..length = 11;
                    var _qAnswerController = []..length = 11;
                    var _qNoteController = []..length = 11;
                    for (var i = 1; i <= 10; i++) {
                      var ii = "q" + i.toString().padLeft(2, "0");
                      _qTitleController[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Title'] ?? ""));
                      _qItem1Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item1'] ?? ""));
                      _qItem2Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item2'] ?? ""));
                      _qItem3Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item3'] ?? ""));
                      _qItem4Controller[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Item4'] ?? ""));
                      _qAnswerController[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Answer'] ?? ""));
                      _qNoteController[i] = TextEditingController.fromValue(
                          TextEditingValue(text: data[ii + 'Note'] ?? ""));
                    }
                    TextFormField makeTextFormField(
                        String l, TextEditingController c) {
                      return TextFormField(
                        decoration: InputDecoration(labelText: l),
                        controller: c,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        readOnly: false,
                      );
                    }

                    Card makeCard(int idx) {
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              color: Theme.of(context).primaryColor,
                              width: double.infinity,
                              child: Text("${idx.toString()}問目",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1),
                            ),
                            makeTextFormField("問題文", _qTitleController[idx]),
                            makeTextFormField("選択肢1", _qItem1Controller[idx]),
                            makeTextFormField("選択肢2", _qItem2Controller[idx]),
                            makeTextFormField("選択肢3", _qItem3Controller[idx]),
                            makeTextFormField("選択肢4", _qItem4Controller[idx]),
                            makeTextFormField("正解", _qAnswerController[idx]),
                            makeTextFormField("解説", _qNoteController[idx]),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: <Widget>[
                        Text("${userState.user!.email}"),
                        TextFormField(
                          decoration: InputDecoration(labelText: "タイトル"),
                          controller: _titleController,
                        ),
                        const SizedBox(height: 8),
                        makeCard(1),
                        makeCard(2),
                        makeCard(3),
                        makeCard(4),
                        makeCard(5),
                        makeCard(6),
                        makeCard(7),
                        makeCard(8),
                        makeCard(9),
                        makeCard(10),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.save),
                            label: Text('保存'),
                            onPressed: () async {
                              final date = DateTime.now()
                                  .toLocal()
                                  .toIso8601String(); // 現在の日時
                              await FirebaseFirestore.instance
                                  .collection('tests')
                                  .doc(widget.id)
                                  .update({
                                'author': userState.user!.email,
                                'title': _titleController.text,
                                'q01Title': _qTitleController[1].text,
                                'q01Item1': _qItem1Controller[1].text,
                                'q01Item2': _qItem2Controller[1].text,
                                'q01Item3': _qItem3Controller[1].text,
                                'q01Item4': _qItem4Controller[1].text,
                                'q01Answer': _qAnswerController[1].text,
                                'q01Note': _qNoteController[1].text,
                                'q02Title': _qTitleController[2].text,
                                'q02Item1': _qItem1Controller[2].text,
                                'q02Item2': _qItem2Controller[2].text,
                                'q02Item3': _qItem3Controller[2].text,
                                'q02Item4': _qItem4Controller[2].text,
                                'q02Answer': _qAnswerController[2].text,
                                'q02Note': _qNoteController[2].text,
                                'q03Title': _qTitleController[3].text,
                                'q03Item1': _qItem1Controller[3].text,
                                'q03Item2': _qItem2Controller[3].text,
                                'q03Item3': _qItem3Controller[3].text,
                                'q03Item4': _qItem4Controller[3].text,
                                'q03Answer': _qAnswerController[3].text,
                                'q03Note': _qNoteController[3].text,
                                'q04Title': _qTitleController[4].text,
                                'q04Item1': _qItem1Controller[4].text,
                                'q04Item2': _qItem2Controller[4].text,
                                'q04Item3': _qItem3Controller[4].text,
                                'q04Item4': _qItem4Controller[4].text,
                                'q04Answer': _qAnswerController[4].text,
                                'q04Note': _qNoteController[4].text,
                                'q05Title': _qTitleController[5].text,
                                'q05Item1': _qItem1Controller[5].text,
                                'q05Item2': _qItem2Controller[5].text,
                                'q05Item3': _qItem3Controller[5].text,
                                'q05Item4': _qItem4Controller[5].text,
                                'q05Answer': _qAnswerController[5].text,
                                'q05Note': _qNoteController[5].text,
                                'q06Title': _qTitleController[6].text,
                                'q06Item1': _qItem1Controller[6].text,
                                'q06Item2': _qItem2Controller[6].text,
                                'q06Item3': _qItem3Controller[6].text,
                                'q06Item4': _qItem4Controller[6].text,
                                'q06Answer': _qAnswerController[6].text,
                                'q06Note': _qNoteController[6].text,
                                'q07Title': _qTitleController[7].text,
                                'q07Item1': _qItem1Controller[7].text,
                                'q07Item2': _qItem2Controller[7].text,
                                'q07Item3': _qItem3Controller[7].text,
                                'q07Item4': _qItem4Controller[7].text,
                                'q07Answer': _qAnswerController[7].text,
                                'q07Note': _qNoteController[7].text,
                                'q08Title': _qTitleController[8].text,
                                'q08Item1': _qItem1Controller[8].text,
                                'q08Item2': _qItem2Controller[8].text,
                                'q08Item3': _qItem3Controller[8].text,
                                'q08Item4': _qItem4Controller[8].text,
                                'q08Answer': _qAnswerController[8].text,
                                'q08Note': _qNoteController[8].text,
                                'q09Title': _qTitleController[9].text,
                                'q09Item1': _qItem1Controller[9].text,
                                'q09Item2': _qItem2Controller[9].text,
                                'q09Item3': _qItem3Controller[9].text,
                                'q09Item4': _qItem4Controller[9].text,
                                'q09Answer': _qAnswerController[9].text,
                                'q09Note': _qNoteController[9].text,
                                'q10Title': _qTitleController[10].text,
                                'q10Item1': _qItem1Controller[10].text,
                                'q10Item2': _qItem2Controller[10].text,
                                'q10Item3': _qItem3Controller[10].text,
                                'q10Item4': _qItem4Controller[10].text,
                                'q10Answer': _qAnswerController[10].text,
                                'q10Note': _qNoteController[10].text,
                                'date': date
                              });
                              await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return MyPage();
                                }),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text("削除"),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('tests')
                                  .doc(widget.id)
                                  .delete();
                              await Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return MyPage();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, //ボタンの背景色
                            ),
                          ),
                        ),
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
      ),
    );
  }
}

class SharePage extends StatefulWidget {
  SharePage(this.id, this.title, this.code, this.gameid);
  final String id;
  final String title;
  final String code;
  final String gameid;

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    final testUrl =
        "${window.location.protocol}//${window.location.hostname}:${window.location.port}/#/entry?code=" +
            widget.gameid;
    return Scaffold(
      appBar: AppBar(
        title: Text("問題共有"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Text(widget.title),
              const SizedBox(height: 8),
              QrImage(
                data: testUrl,
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(testUrl),
                  IconButton(
                    onPressed: () async {
                      final data = ClipboardData(text: testUrl);
                      await Clipboard.setData(data);
                    },
                    icon: Icon(Icons.content_copy),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('開始'),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('games')
                        .doc(widget.gameid)
                        .update({
                      'status': 1,
                      'current': 1,
                    });
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PresenterPage(widget.id, widget.gameid);
                      }),
                    );
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('games/${widget.gameid}/members')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      return ListView(
                        children: documents.map((document) {
                          return Card(
                            child: CheckboxListTile(
                              title: Text(document['name']),
                              onChanged: (bool? value) async {
                                await FirebaseFirestore.instance
                                    .collection(
                                        'games/${widget.gameid}/members')
                                    .doc(document['uid'])
                                    .update({
                                  'joined': value,
                                });
                              },
                              value: document['joined'],
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Center(
                      child: Text("受付中..."),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PresenterPage extends StatefulWidget {
  PresenterPage(this.testid, this.gameid);
  final String testid;
  final String gameid;

  @override
  _PresenterPageState createState() => _PresenterPageState();
}

class _PresenterPageState extends State<PresenterPage> {
  int current = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主催者用"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(32),
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('tests')
                    .doc(widget.testid)
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
                    var _qTitleController = []..length = 11;
                    var _qItem1Controller = []..length = 11;
                    var _qItem2Controller = []..length = 11;
                    var _qItem3Controller = []..length = 11;
                    var _qItem4Controller = []..length = 11;
                    var _qAnswerController = []..length = 11;
                    for (var i = 1; i <= 10; i++) {
                      var ii = "q" + i.toString().padLeft(2, "0");
                      _qTitleController[i] = data[ii + 'Title'] ?? "";
                      _qItem1Controller[i] = data[ii + 'Item1'] ?? "";
                      _qItem2Controller[i] = data[ii + 'Item2'] ?? "";
                      _qItem3Controller[i] = data[ii + 'Item3'] ?? "";
                      _qItem4Controller[i] = data[ii + 'Item4'] ?? "";
                      _qAnswerController[i] = data[ii + 'Answer'] ?? "";
                    }
                    RadioListTile makeRadioListTile(String text, String value) {
                      return new RadioListTile(
                        title: Text(text),
                        value: value,
                        groupValue: '',
                        onChanged: null,
                      );
                    }

                    Card makeCard(int idx) {
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              color: Theme.of(context).primaryColor,
                              width: double.infinity,
                              child: Text(
                                "第 ${idx.toString()} 問",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                _qTitleController[idx],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 8),
                            makeRadioListTile(_qItem1Controller[idx], "1"),
                            const SizedBox(height: 8),
                            makeRadioListTile(_qItem2Controller[idx], "2"),
                            const SizedBox(height: 8),
                            makeRadioListTile(_qItem3Controller[idx], "3"),
                            const SizedBox(height: 8),
                            makeRadioListTile(_qItem4Controller[idx], "4"),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: <Widget>[
                        makeCard(current),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.share),
                            label: Text("回答表示"),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('games')
                                  .doc(widget.gameid)
                                  .update({
                                'status': 2,
                                'current': 1,
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('games/${widget.gameid}/members')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                print(documents);
                                return ListView(
                                  children: documents.map((document) {
                                    print(document);
                                    return Card(
                                      child: ListTile(
                                        title: Text(document['name'] +
                                            " : " +
                                            document['answer']),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                              return Center(
                                child: Text("回答受付中..."),
                              );
                            },
                          ),
                        ),
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
      ),
    );
  }
}
