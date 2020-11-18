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

final _taskController = TextEditingController();

class _HomeState extends State<Home> {
  List _toDoList = [];


  @override
  void initState() {
    super.initState();
    _readData().then((data){
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _taskController.text;
      _taskController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

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
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 72,
                      child: buildTextField("Nova Tarefa", "", _taskController),
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
                        onPressed: _addToDo,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: _toDoList.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(
                          _toDoList[index]["title"],
                        ),
                        value: _toDoList[index]["ok"],
                        secondary: CircleAvatar(
                          child: Icon(_toDoList[index]["ok"] == true
                              ? Icons.check
                              : Icons.error,),
                        ), onChanged: (c){
                          setState(() {
                            _toDoList[index]["ok"] = c;
                            _saveData();
                          });
                      },
                      );
                    },
                  ),
                )
              ],
            )));
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

  Widget buildTextField(
      String label, String prefix, TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.blueAccent),
            border: OutlineInputBorder(),
            prefixText: prefix),
        style: TextStyle(color: Colors.black, fontSize: 20));
  }
}
