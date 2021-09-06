import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/NewTestPage.dart';
import 'package:flutter_quiz/DetailTestPage.dart';

class MyPage extends StatelessWidget {
  MyPage(this.user);
  final User user;
  @override
  Widget build(BuildContext context) {
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
                Text("${user.email}"),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return NewTestPage(this.user);
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
                  .where('author', isEqualTo: this.user.email)
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
                                  return DetailTestPage(this.user, document.id);
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
