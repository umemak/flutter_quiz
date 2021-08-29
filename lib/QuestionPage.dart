import 'package:flutter/material.dart';
import 'package:flutter_quiz/AnswerPage.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第n問',
      home: Scaffold(
        appBar: AppBar(
          title: Text('第n問'),
        ),
        body: Center(
          child: ChangeForm(),
        ),
      ),
    );
  }
}

class ChangeForm extends StatefulWidget {
  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  String _type = '';
  void _handleRadio(value) => setState(() {
        _type = value;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("あああ\nいいい\nううう"),
            const SizedBox(height: 16),
            new RadioListTile(
              title: Text('1: あいうえおかきくけこ'),
              value: '1',
              groupValue: _type,
              onChanged: (value) => _handleRadio(value),
            ),
            new RadioListTile(
              title: Text('2: あいうえおかきくけこ'),
              value: '2',
              groupValue: _type,
              onChanged: (value) => _handleRadio(value),
            ),
            new RadioListTile(
              title: Text('3: あいうえおかきくけこ'),
              value: '3',
              groupValue: _type,
              onChanged: (value) => _handleRadio(value),
            ),
            new RadioListTile(
              title: Text('4: あいうえおかきくけこ'),
              value: '4',
              groupValue: _type,
              onChanged: (value) => _handleRadio(value),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AnswerPage();
                }))
              },
              child: Text("決定", style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
