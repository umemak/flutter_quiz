import 'package:flutter/material.dart';
import 'package:flutter_quiz/TopPage.dart';
import 'package:flutter_quiz/EntryPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Quiz Home Page'),
      initialRoute: '/',
      // routes: {'/entry': (context) => EntryPage()},
      onGenerateRoute: (settings) {
        print(settings.name);
        final settingsUri = Uri.parse(settings.name!);
        print(settingsUri.path);
        final codeID = settingsUri.queryParameters['code'];
        print(codeID);
        if (settingsUri.path == EntryPage.routeName) {
          return MaterialPageRoute(
            builder: (context) => EntryPage(codeID!),
          );
        }
        return null;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TopPage());
  }
}
