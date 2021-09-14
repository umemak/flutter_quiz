import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_quiz/SignupPage.dart';
import 'package:flutter_quiz/NewTestPage.dart';
import 'package:flutter_quiz/EntryPage.dart';
import 'package:flutter_quiz/DetailTestPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        debugShowCheckedModeBanner: false,
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
                          return LoginCheck();
                        }))
                      },
                  child: Text("問題作成・編集", style: TextStyle(fontSize: 40)))
            ]),
      ),
    );
  }
}

class LoginCheck extends StatefulWidget {
  LoginCheck({Key? key}) : super(key: key);

  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  //ログイン状態のチェック(非同期で行う)
  void checkUser() {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userState = Provider.of<UserState>(context, listen: false);
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      userState.setUser(currentUser);
      Navigator.pushReplacementNamed(context, MyPage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
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
    final UserState userState = Provider.of<UserState>(context);
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
    final UserState userState = Provider.of<UserState>(context);
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
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return NewTestPage(userState.user!);
                      }),
                    );
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
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                          title: Text(document['title']),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return DetailTestPage(
                                      userState.user!, document.id);
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
  }
}
