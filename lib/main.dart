import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'EntryPage.dart';
import 'LoginPage.dart';
import 'UserState.dart';
import 'MyPage.dart';
import 'DetailTestPage.dart';
import 'TopPage.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserState userState = UserState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>.value(
      value: userState,
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
          return null;
        },
      ),
    );
  }
}
