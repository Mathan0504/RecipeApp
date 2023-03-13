// ignore: prefer_typing_uninitialized_variables
import 'package:fl_cruddemo/page/listpage.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../services/firebase_crud.dart';

class ViewPage extends StatefulWidget {
  final Recipe? recipe;
  ViewPage({this.recipe});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ViewPage();
  }
}

class _ViewPage extends State<ViewPage> {
  final _recipe_name = TextEditingController();
  final _recipe_takes_time = TextEditingController();
  final _recipe_description = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.recipe!.uid.toString());
    _recipe_name.value =
        TextEditingValue(text: widget.recipe!.recipename.toString());
    _recipe_takes_time.value =
        TextEditingValue(text: widget.recipe!.takestime.toString());
    _recipe_description.value =
        TextEditingValue(text: widget.recipe!.description.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        style: TextStyle(fontSize: 20),
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nameField = TextFormField(
        style: TextStyle(fontSize: 20),
        controller: _recipe_name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 147, 216, 233).withOpacity(0.6),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final takestimeField = TextFormField(
        controller: _recipe_takes_time,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 147, 216, 233).withOpacity(0.6),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "takes_time",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final descriptionField = TextFormField(
        style: TextStyle(fontFamily: 'Montserrat-Regular', fontSize: 20),
        maxLines: 5,
        minLines: 1,
        controller: _recipe_description,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 147, 216, 233).withOpacity(0.6),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Description",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('View List of Recipe'));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('My Recipe Collection'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 25.0),
                  takestimeField,
                  const SizedBox(height: 35.0),
                  descriptionField,
                  viewListbutton,
                  const SizedBox(height: 45.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
