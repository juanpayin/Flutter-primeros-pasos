
import 'package:sqflite/sqflite.dart';

class TareasDatabase{
  Database _db;

  initDatabase() async{
    _db = await openDatabase(
      'test.db',
      version: 1,
      onCreate: (Database db, int version){
        db.execute("CREATE TABLE misTareas (id INTEGER PRIMARY KEY, tarea TEXT NOT NULL, complete INTEGER NOT NULL);");
      }
    );
    print("--------- BASE DE DATOS CREADA ---------");
  }



  void insert(String tarea, int complete) async{
    await _db.rawInsert('INSERT INTO misTareas VALUES(null, "$tarea", $complete);');
  }

  void update(Tarea tarea) async{
    if(tarea.complete ==0){
      tarea.complete =1;
    }else{
       tarea.complete =0;
    }

    await _db.rawUpdate("UPDATE misTareas SET complete = ${tarea.complete} WHERE id = ${tarea.id};");
  }

  void delete() async{
    await _db.rawDelete("DELETE FROM misTareas WHERE complete = 1;");
  }

  Future <List<Tarea>> getTareas() async{
    List<Map<String, dynamic>> resultado = await _db.rawQuery("SELECT * FROM misTareas;");
    return resultado.map((e) => Tarea.fromMap(e)).toList();
  }
  
}

class Tarea{
  int id;
  String tarea;
  int complete;

  Tarea(this.tarea, this.complete);

  Tarea.fromMap(Map<String, dynamic> map){
    id = map['id'];
    tarea = map['tarea'];
    complete = map['complete'];
  }

}
