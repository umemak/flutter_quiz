import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/PresenterPage.dart';
import 'package:flutter_quiz/EntryPage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class SharePage extends StatefulWidget {
  SharePage(this.user, this.id, this.title, this.code, this.gameid);
  final User user;
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
        "https://${window.location.hostname}/#/entry?code=" + widget.gameid;
    return Scaffold(
      appBar: AppBar(
        title: Text("問題共有"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
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
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PresenterPage(widget.user, widget.gameid);
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
