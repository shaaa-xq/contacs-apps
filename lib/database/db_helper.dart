import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:contacs_app/model/kontak.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnMobileNum = 'mobileNum';
  final String columnEmail = 'email';
  final String columnCompany = 'company';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db async{
    if (_database != null){
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> await _initDb(){
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');

    return await openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreate
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    var sql = "CREATE TABLE $tableName $columnId INTEGER PRIMARY KEY, "
      "$columnName TEXT"
      "$columnMobileNum TEXT"
      "$columnEmail TEXT"
      "$columnCompany TEXT";

    await db.execute(sql);
  }

  // create
  Future<int?> saveKontak(Kontak kontak) async{
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }

  // read
  Future<List?> getAllKontak() async{
    var dbClient = await _db;
    var result = dbClient!.query(
      tableName, 
      columns: [
        columnId,
        columnName,
        columnMobileNum,
        columnEmail,
        columnCompany,
      ]
    );
    return result.toList();
  }

  // update
  Future<int?> updateKontak() async{
    var dbClient = await _db;
    return await dbClient!.update(
      tableName, 
      kontak.toMap(),
      where: '$columnId = ?',
      whereArgs: ['kontak.id'];
    );
  }

  
}
