import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String _databaseName = 'restaurantlist.db';
  static const String _tableName = 'restaurant';
  static const int _version = 1;

  Future<void> createTables(Database database) async{
    await database.execute(
      """CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
      )
      """,
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async{
        await createTables(database);
      }
    );
  }

  Future<int> insertItem(Restaurant restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Restaurant>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName, orderBy: "id");

    return results.map((result) => Restaurant.fromJson(result)).toList();
  }

  Future<Restaurant> getItemById(int id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.map((result) => Restaurant.fromJson(result)).first;
  }

  Future<int> updateItem(int id, Restaurant restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();

    final result =
        await db.update(_tableName, data, where: "id = ?", whereArgs: [id]);

    return result;
  }

  Future<int> removeItem(String id) async {
    final db = await _initializeDb();

    final result =
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}