import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_cruddemo/models/recipe.dart';
import 'package:fl_cruddemo/page/addpage.dart';
import 'package:fl_cruddemo/page/editpage.dart';
import 'package:fl_cruddemo/page/viewpage.dart';
import 'package:fl_cruddemo/screens/home/home.dart';
import 'package:flutter/material.dart';

import '../services/firebase_crud.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readRecipe();
  //FirebaseFirestore.instance.collection('Employee').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("List of Recipe"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.attribution_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => Home(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                      child: Column(children: [
                    ListTile(
                      title: Text(e["recipe_name"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Time Consume : " + e['takes_time'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Detailed Steps: " + e['description'],
                                style: const TextStyle(fontSize: 12)),
                          ],
                        )),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Color.fromARGB(255, 235, 243, 240),
                            backgroundColor: Color.fromARGB(255, 58, 92, 243),
                          ),
                          child: const Text('Edit'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => EditPage(
                                  recipe: Recipe(
                                      uid: e.id,
                                      recipename: e["recipe_name"],
                                      takestime: e["takes_time"],
                                      description: e["description"]),
                                ),
                              ),
                              (route) =>
                                  false, //if you want to disable back feature set to false
                            );
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Color.fromARGB(255, 235, 243, 240),
                            backgroundColor: Color.fromARGB(255, 58, 92, 243),
                          ),
                          child: const Text('View'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => ViewPage(
                                  recipe: Recipe(
                                      recipename: e["recipe_name"],
                                      takestime: e["takes_time"],
                                      description: e["description"]),
                                ),
                              ),
                              (route) =>
                                  false, //if you want to disable back feature set to false
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Delete"),
                                content: const Text(
                                    "Are You really want to Delete this "),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      var response =
                                          await FirebaseCrud.deleteRecipe(
                                              docId: e.id);
                                      if (response.code != 200) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(response.message
                                                    .toString()),
                                              );
                                            });
                                      }
                                    },
                                    child: Container(
                                      color: Color.fromARGB(255, 11, 12, 11),
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  ]));
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => AddPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
