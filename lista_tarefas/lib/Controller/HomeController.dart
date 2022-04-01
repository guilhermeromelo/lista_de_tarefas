import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

Future<File> _getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/data.json");
}

Future<File> saveData(_toDoList) async {
  String Data = json.encode(_toDoList);
  final file = await _getFile();
  return file.writeAsString(Data);
}

Future<String> readData() async {
  try {
    final file = await _getFile();
    return file.readAsString();
  } catch (e) {
    return null;
  }
}

void insertInToDoList(_toDoList, _taskController){
  Map<String, dynamic> newToDo = Map();
  newToDo["title"] = _taskController.text;
  _taskController.text = "";
  newToDo["ok"] = false;
  _toDoList.add(newToDo);
  saveData(_toDoList);
}

void ordernateToDoList(_toDoList){
  _toDoList.sort((a,b){
    if(a["ok"] == true && b["ok"]==false)
      return 1;
    else if(a["ok"] == false && b["ok"]==true)
      return -1;
    else
      return 0;
  });
  saveData(_toDoList);
}