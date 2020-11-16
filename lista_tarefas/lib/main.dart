import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final taskController = TextEditingController();

void _taskChanged(String text) {}

class _HomeState extends State<Home> {
  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Lista de Tarefas",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 72,
                    child: buildTextField(
                        "Nova Tarefa", "", taskController, _taskChanged),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 25,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      child: Text(
                        "ADD",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ])));
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String Data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(Data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Widget buildTextField(String label, String prefix,
      TextEditingController controller, Function function) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueAccent),
          border: OutlineInputBorder(),
          prefixText: prefix),
      style: TextStyle(color: Colors.black, fontSize: 25),
      onChanged: function,
    );
  }
}
