import 'package:flutter/material.dart';
import 'package:flutter_quiz/ResultPage.dart';

class AnswerPage extends StatelessWidget {
  void _handleRadio(value) => {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("回答"),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("正解", style: TextStyle(fontSize: 40, color: Colors.red)),
            const SizedBox(height: 16),
            Text("あああ\nいいい\nううう"),
            const SizedBox(height: 16),
            new RadioListTile(
              title: Text('1: あいうえおかきくけこ'),
              value: '1',
              groupValue: '',
              onChanged: (value) => _handleRadio(value),
            ),
            new RadioListTile(
              title: Text('2: あいうえおかきくけこ'),
              value: '2',
              groupValue: '',
              onChanged: (value) => _handleRadio(value),
            ),
            new RadioListTile(
              title: Text('3: あいうえおかきくけこ'),
              value: '3',
              groupValue: '',
              onChanged: (value) => _handleRadio(value),
            ),
            new RadioListTile(
              title: Text('4: あいうえおかきくけこ'),
              value: '4',
              groupValue: '',
              onChanged: (value) => _handleRadio(value),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ResultPage();
                }))
              },
              child: Text("結果", style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
