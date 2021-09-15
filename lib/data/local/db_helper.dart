import 'package:earthquake/data/domain/earthquake.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  String _table = 'earthquake';
  int _version = 4;
  static final DatabaseHelper instance = DatabaseHelper._constructor();

  DatabaseHelper._constructor();

  Future<Database> get database async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), "earthquake.db"),
        onCreate: (db, version) => _createTable(db),
        onUpgrade: (db, oldVersion, newVersion) {
          db.execute("DROP TABLE IF EXISTS $_table;");
          _createTable(db);
        },
        version: _version,
      );
      print("created");
    }

    return _database!;
  }

  Future<void> insert(Earthquake item) async {
    print("inserting $item");
    Database db = await instance.database;
    await db.insert(_table, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    Database db = await instance.database;
    return (await db.query(_table));
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(_table, where: "id = ?", whereArgs: [id]);
  }

  void _createTable(Database db) {
    db.execute("""
                CREATE TABLE $_table
                (id TEXT PRIMARY KEY, 
                magintude REAL, 
                depth REAL,
                lat REAL,
                long REAL,
                detail REAL,
                causeTsunami INTEGER,
                url TEXT,
                place TEXT,
                offset TEXT,
                time INTEGER);""");
  }
}
