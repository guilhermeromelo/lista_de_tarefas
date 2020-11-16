import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Lista de Tarefas", style: TextStyle(color: Colors.white, fontSize: 20),),centerTitle: true,),
      body: Container(

      ),
    );
  }
}
