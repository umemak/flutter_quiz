import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/TopPage.dart';

class PresenterPage extends StatefulWidget {
  PresenterPage(this.user, this.gameid);
  final User user;
  final String gameid;

  @override
  _PresenterPageState createState() => _PresenterPageState();
}

class _PresenterPageState extends State<PresenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("主催者用"),
        ),
        body: Center(
            child: TextButton(
                onPressed: () => {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TopPage();
                      }))
                    },
                child: Text("進む", style: TextStyle(fontSize: 80)))));
  }
}
