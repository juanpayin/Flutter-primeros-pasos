import 'package:fialogs/fialogs.dart';
import 'package:flutter/material.dart';
import 'package:listas/database.dart';
 
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

  TareasDatabase db = TareasDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listas'),
          actions: [
            FlatButton(
              child: Text('Eliminar'),
              textColor: Colors.white,
              onPressed: (){
                 setState(() {
                    db.delete();
                 });
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: db.initDatabase(),
          builder: (BuildContext context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return _showList(context);
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _nuevaTarea,
        ),
    );
  }

  _showList(BuildContext context){
    return FutureBuilder(
      future: db.getTareas(),
      initialData: List<Tarea>(),
      builder: (BuildContext context, AsyncSnapshot<List<Tarea>> snapshot){

    
      if(snapshot.data.length !=0){
          return ListView(
            children: [
              for(Tarea mis_tareas in snapshot.data)
                ListTile(
                  title: Text('${mis_tareas.tarea}'),
                  leading: Icon(
                    mis_tareas.complete == 0 
                    ? Icons.check_box_outline_blank 
                    : Icons.check_box,
                  ),
                  onTap: (){
                    setState(() {
                      db.update(mis_tareas);
                    });
                    
                  },
                )
            ],
          );
        }else{
            return Center(
              child: Text('No tienes tareas'),
            );
        }

      },
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
        setState((){
           Tarea tarea = Tarea(value, 0);
           db.insert(tarea.tarea, tarea.complete);
        });
      }  
    ),  
    positiveButtonText: "Si",  
    positiveButtonAction: (value) {  
     setState((){
           Tarea tarea = Tarea(value, 0);
           db.insert(tarea.tarea, tarea.complete);
        }); 
    },  
    negativeButtonText: "No",  
    negativeButtonAction: () {},  
    hideNeutralButton: false,  
    closeOnBackPress: true,  
  );
  }
}