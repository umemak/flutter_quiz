import 'package:flutter/material.dart';
import 'package:flutter_quiz/ResultPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'QuestionPage.dart';

class AnswerPage extends StatefulWidget {
  AnswerPage(this.gameid, this.testid);
  final String gameid;
  final String testid;
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
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
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.share),
                label: Text("つぎへ"),
                onPressed: () async {
                  final FirebaseFirestore store = FirebaseFirestore.instance;
                  store
                      .collection('games')
                      .doc(widget.gameid)
                      .snapshots()
                      .listen((event) {
                    print(event.data().toString());
                    Map<String, dynamic> data = event.data()!;
                    if (data['status'] == 1) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return QuestionPage(widget.gameid, widget.testid);
                      }));
                    }
                    if (data['status'] == 3) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ResultPage(widget.gameid, widget.testid);
                      }));
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
