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
                    final _q01TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q01Title'] ?? ""));
                    final _q01Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q01Item1'] ?? ""));
                    final _q01Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q01Item2'] ?? ""));
                    final _q01Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q01Item3'] ?? ""));
                    final _q01Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q01Item4'] ?? ""));
                    final _q01AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q01Answer'] ?? ""));
                    final _q01ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q01Explanation'] ?? ""));
                    final _q02TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q02Title'] ?? ""));
                    final _q02Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q02Item1'] ?? ""));
                    final _q02Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q02Item2'] ?? ""));
                    final _q02Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q02Item3'] ?? ""));
                    final _q02Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q02Item4'] ?? ""));
                    final _q02AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q02Answer'] ?? ""));
                    final _q02ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q02Explanation'] ?? ""));
                    final _q03TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q03Title'] ?? ""));
                    final _q03Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q03Item1'] ?? ""));
                    final _q03Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q03Item2'] ?? ""));
                    final _q03Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q03Item3'] ?? ""));
                    final _q03Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q03Item4'] ?? ""));
                    final _q03AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q03Answer'] ?? ""));
                    final _q03ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q03Explanation'] ?? ""));
                    final _q04TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q04Title'] ?? ""));
                    final _q04Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q04Item1'] ?? ""));
                    final _q04Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q04Item2'] ?? ""));
                    final _q04Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q04Item3'] ?? ""));
                    final _q04Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q04Item4'] ?? ""));
                    final _q04AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q04Answer'] ?? ""));
                    final _q04ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q04Explanation'] ?? ""));
                    final _q05TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q05Title'] ?? ""));
                    final _q05Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q05Item1'] ?? ""));
                    final _q05Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q05Item2'] ?? ""));
                    final _q05Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q05Item3'] ?? ""));
                    final _q05Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q05Item4'] ?? ""));
                    final _q05AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q05Answer'] ?? ""));
                    final _q05ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q05Explanation'] ?? ""));
                    final _q06TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q06Title'] ?? ""));
                    final _q06Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q06Item1'] ?? ""));
                    final _q06Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q06Item2'] ?? ""));
                    final _q06Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q06Item3'] ?? ""));
                    final _q06Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q06Item4'] ?? ""));
                    final _q06AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q06Answer'] ?? ""));
                    final _q06ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q06Explanation'] ?? ""));
                    final _q07TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q07Title'] ?? ""));
                    final _q07Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q07Item1'] ?? ""));
                    final _q07Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q07Item2'] ?? ""));
                    final _q07Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q07Item3'] ?? ""));
                    final _q07Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q07Item4'] ?? ""));
                    final _q07AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q07Answer'] ?? ""));
                    final _q07ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q07Explanation'] ?? ""));
                    final _q08TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q08Title'] ?? ""));
                    final _q08Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q08Item1'] ?? ""));
                    final _q08Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q08Item2'] ?? ""));
                    final _q08Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q08Item3'] ?? ""));
                    final _q08Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q08Item4'] ?? ""));
                    final _q08AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q08Answer'] ?? ""));
                    final _q08ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q08Explanation'] ?? ""));
                    final _q09TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q09Title'] ?? ""));
                    final _q09Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q09Item1'] ?? ""));
                    final _q09Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q09Item2'] ?? ""));
                    final _q09Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q09Item3'] ?? ""));
                    final _q09Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q09Item4'] ?? ""));
                    final _q09AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q09Answer'] ?? ""));
                    final _q09ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q09Explanation'] ?? ""));
                    final _q10TitleController = TextEditingController.fromValue(
                        TextEditingValue(text: data['q10Title'] ?? ""));
                    final _q10Item1Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q10Item1'] ?? ""));
                    final _q10Item2Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q10Item2'] ?? ""));
                    final _q10Item3Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q10Item3'] ?? ""));
                    final _q10Item4Controller = TextEditingController.fromValue(
                        TextEditingValue(text: data['q10Item4'] ?? ""));
                    final _q10AnswerController =
                        TextEditingController.fromValue(
                            TextEditingValue(text: data['q10Answer'] ?? ""));
                    final _q10ExplanationController =
                        TextEditingController.fromValue(TextEditingValue(
                            text: data['q10Explanation'] ?? ""));
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
                                controller: _q01TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q01Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q01Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q01Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q01Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q01AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q01ExplanationController,
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
                                controller: _q02TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q02Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q02Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q02Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q02Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q02AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q02ExplanationController,
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
                                controller: _q03TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q03Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q03Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q03Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q03Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q03AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q03ExplanationController,
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
                                controller: _q04TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q04Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q04Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q04Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q04Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q04AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q04ExplanationController,
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
                                controller: _q05TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q05Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q05Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q05Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q05Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q05AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q05ExplanationController,
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
                                controller: _q06TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q06Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q06Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q06Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q06Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q06AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q06ExplanationController,
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
                                controller: _q07TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q07Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q07Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q07Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q07Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q07AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q07ExplanationController,
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
                                controller: _q08TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q08Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q08Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q08Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q08Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q08AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q08ExplanationController,
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
                                controller: _q09TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q09Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q09Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q09Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q09Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q09AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q09ExplanationController,
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
                                controller: _q10TitleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢1"),
                                controller: _q10Item1Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢2"),
                                controller: _q10Item2Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢3"),
                                controller: _q10Item3Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "選択肢4"),
                                controller: _q10Item4Controller,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "正解"),
                                controller: _q10AnswerController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: "解説"),
                                controller: _q10ExplanationController,
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
                                'q01Title': _q01TitleController.text,
                                'q01Item1': _q01Item1Controller.text,
                                'q01Item2': _q01Item2Controller.text,
                                'q01Item3': _q01Item3Controller.text,
                                'q01Item4': _q01Item4Controller.text,
                                'q01Answer': _q01AnswerController.text,
                                'q01Explanation':
                                    _q01ExplanationController.text,
                                'q02Title': _q02TitleController.text,
                                'q02Item1': _q02Item1Controller.text,
                                'q02Item2': _q02Item2Controller.text,
                                'q02Item3': _q02Item3Controller.text,
                                'q02Item4': _q02Item4Controller.text,
                                'q02Answer': _q02AnswerController.text,
                                'q02Explanation':
                                    _q02ExplanationController.text,
                                'q03Title': _q03TitleController.text,
                                'q03Item1': _q03Item1Controller.text,
                                'q03Item2': _q03Item2Controller.text,
                                'q03Item3': _q03Item3Controller.text,
                                'q03Item4': _q03Item4Controller.text,
                                'q03Answer': _q03AnswerController.text,
                                'q03Explanation':
                                    _q03ExplanationController.text,
                                'q04Title': _q04TitleController.text,
                                'q04Item1': _q04Item1Controller.text,
                                'q04Item2': _q04Item2Controller.text,
                                'q04Item3': _q04Item3Controller.text,
                                'q04Item4': _q04Item4Controller.text,
                                'q04Answer': _q04AnswerController.text,
                                'q04Explanation':
                                    _q04ExplanationController.text,
                                'q05Title': _q05TitleController.text,
                                'q05Item1': _q05Item1Controller.text,
                                'q05Item2': _q05Item2Controller.text,
                                'q05Item3': _q05Item3Controller.text,
                                'q05Item4': _q05Item4Controller.text,
                                'q05Answer': _q05AnswerController.text,
                                'q05Explanation':
                                    _q05ExplanationController.text,
                                'q06Title': _q06TitleController.text,
                                'q06Item1': _q06Item1Controller.text,
                                'q06Item2': _q06Item2Controller.text,
                                'q06Item3': _q06Item3Controller.text,
                                'q06Item4': _q06Item4Controller.text,
                                'q06Answer': _q06AnswerController.text,
                                'q06Explanation':
                                    _q06ExplanationController.text,
                                'q07Title': _q07TitleController.text,
                                'q07Item1': _q07Item1Controller.text,
                                'q07Item2': _q07Item2Controller.text,
                                'q07Item3': _q07Item3Controller.text,
                                'q07Item4': _q07Item4Controller.text,
                                'q07Answer': _q07AnswerController.text,
                                'q07Explanation':
                                    _q07ExplanationController.text,
                                'q08Title': _q08TitleController.text,
                                'q08Item1': _q08Item1Controller.text,
                                'q08Item2': _q08Item2Controller.text,
                                'q08Item3': _q08Item3Controller.text,
                                'q08Item4': _q08Item4Controller.text,
                                'q08Answer': _q08AnswerController.text,
                                'q08Explanation':
                                    _q08ExplanationController.text,
                                'q09Title': _q09TitleController.text,
                                'q09Item1': _q09Item1Controller.text,
                                'q09Item2': _q09Item2Controller.text,
                                'q09Item3': _q09Item3Controller.text,
                                'q09Item4': _q09Item4Controller.text,
                                'q09Answer': _q09AnswerController.text,
                                'q09Explanation':
                                    _q09ExplanationController.text,
                                'q10Title': _q10TitleController.text,
                                'q10Item1': _q10Item1Controller.text,
                                'q10Item2': _q10Item2Controller.text,
                                'q10Item3': _q10Item3Controller.text,
                                'q10Item4': _q10Item4Controller.text,
                                'q10Answer': _q10AnswerController.text,
                                'q10Explanation':
                                    _q10ExplanationController.text,
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
