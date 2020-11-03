import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  int contador = 0;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hola Mundo',
      debugShowCheckedModeBanner: false,
      home: Contador(),
    );
  }
}

class Contador extends StatefulWidget {
  Contador({Key key}) : super(key: key);

  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {

  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
        appBar: AppBar(
          title: Text('Hola Mundo'),
        ),
        body: Center(
          child: Container(
            child: Text(contador.toString()),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            contador++;
            setState(() {});
          },
        ),
      ),
    );
  }
}