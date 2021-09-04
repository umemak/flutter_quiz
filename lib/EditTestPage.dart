import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/MyPage.dart';

class EditTestPage extends StatefulWidget {
  EditTestPage(this.user, this.id);
  final User user;
  final String id;

  @override
  _EditTestPageState createState() => _EditTestPageState();
}

class _EditTestPageState extends State<EditTestPage> {
  @override
  Widget build(BuildContext context) {
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
                    final _passwordController = TextEditingController.fromValue(
                        TextEditingValue(text: data['password'] ?? ""));
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
                    return Column(
                      children: <Widget>[
                        Text("${widget.user.email}"),
                        TextFormField(
                          decoration: InputDecoration(labelText: "タイトル"),
                          controller: _titleController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "参加用パスワード"),
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 8),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("1問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[1],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[1],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[1],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[1],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[1],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[1],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[1],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("2問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[2],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[2],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[2],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[2],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[2],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[2],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[2],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("3問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[3],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[3],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[3],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[3],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[3],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[3],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[3],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("4問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[4],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[4],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[4],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[4],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[4],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[4],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[4],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("5問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[5],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[5],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[5],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[5],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[5],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[5],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[5],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("6問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[6],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[6],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[6],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[6],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[6],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[6],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[6],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("7問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[7],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[7],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[7],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[7],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[7],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[7],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[7],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("8問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[8],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[8],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[8],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[8],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[8],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[8],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[8],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("9問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[9],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[9],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[9],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[9],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[9],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[9],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[9],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Theme.of(context).primaryColor,
                                width: double.infinity,
                                child: Text("10問目",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "問題文"),
                                controller: _qTitleController[10],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _qItem1Controller[10],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _qItem2Controller[10],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _qItem3Controller[10],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _qItem4Controller[10],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _qAnswerController[10],
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _qNoteController[10],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
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
                                'author': widget.user.email,
                                'title': _titleController.text,
                                'password': _passwordController.text,
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
            Container(
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('tests')
                      .doc(widget.id)
                      .delete();
                  await Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return MyPage(widget.user);
                  }));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
