import 'package:fialogs/fialogs.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listas',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List <String> _tareas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listas'),
        ),
        body: ListView(
          children: [
            for(String tarea in _tareas) ListTile(title: Text(tarea))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _nuevaTarea,
        ),
    );
  }

  void _nuevaTarea(){
    singleInputDialog(  
    context,  
    "Nueva tarea",  
    DialogTextField(  
      label: "Ingresa una tarea",  
      obscureText: false,  
      textInputType: TextInputType.text,   
      validator: (value) {  
        if (value.isEmpty) return "Required!";  
        return null;  
      },  
      onEditingComplete: (value) {  
        print(value);  
      }  
    ),  
    positiveButtonText: "Si",  
    positiveButtonAction: (value) {  
      
      setState(() {
        _tareas.add(value);
      });
      print(value);  
    },  
    negativeButtonText: "No",  
    negativeButtonAction: () {},  
    hideNeutralButton: false,  
    closeOnBackPress: true,  
  );
  }
}