// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQLFlite with ChangeNotifier{
  ValueNotifier<List<String>> favsNotifier = ValueNotifier([]);
  late Database db;

  // Private constructor
  SQLFlite._(){startDatabase();}

  // Singleton instance variable
  static final SQLFlite _instance = SQLFlite._();

  // Factory constructor to return the singleton instance
  factory SQLFlite() => _instance;

  bool ifFav(String idName) {
    return favsNotifier.value.contains(idName);
  }

  Future<void> startDatabase() async {
    db = await openDatabase(
      'fav.db',
      version: 1,
      onCreate: (Database dbs, int version) async {
        await dbs.execute(
          'CREATE TABLE favorites (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
    getFav();
  }

  Future<void> getFav() async {
    final values = await db.rawQuery('SELECT * FROM favorites');
    favsNotifier.value = values.map((value) => value['name'] as String).toList();
    favsNotifier.notifyListeners();

    print(favsNotifier);
  }

  Future<void> insertInTodb(String idName) async {
    await db.rawInsert('INSERT INTO favorites(name) VALUES(?)', [idName]);
    favsNotifier.value.add(idName);
    favsNotifier.notifyListeners();
  }

  Future<void> deleteDest(String idName) async {
    await db.rawDelete('DELETE FROM favorites WHERE name = ?', [idName]);
    favsNotifier.value.removeWhere((value) => value == idName);
    favsNotifier.notifyListeners();
  }
}
