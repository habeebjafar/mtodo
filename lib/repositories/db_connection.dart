import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{

  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var mPath = join(directory.path, 'db_mtodo');
    var database = await openDatabase(mPath, version: 1, onCreate:_onCreatingDatabase);
    return database;

  }

  _onCreatingDatabase(Database db, int version) async{
    db.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
    await db.execute("CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)");

  }

}