import 'dart:io';
import 'package:belleza/feature/server/model/cart_modal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbClint = DBHelper._();
  Database _database;

  static final String tableName = 'cartTable';
  static final String columnId = 'id';
  static final String tradeId = 'tradeId';
  static final String columnName = 'name';
  static final String columnImage = 'image';
  static final String columnPrice = 'price';
  static final String columnQuntitey = 'quantity';

  Future<Database> initilzeDatabase() async {
    if (_database == null) {
      return await initDB();
    } else {
      return _database;
    }
  }
/////////////////////////////////////////////////////////////

  Future<Database> initDB() async {
    Directory appDocDir = await path.getApplicationDocumentsDirectory();
    String appPath = join(appDocDir.path, "CartProduct.db");
    Database db = await openDatabase(
      appPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
          $columnName TEXT NOT NULL,
          $columnImage TEXT NOT NULL,
          $columnPrice TEXT NOT NULL,
          $columnQuntitey INTEGER NOT NULL,
          $columnId INTEGER NOT NULL,
          $tradeId TEXT NOT NULL)''');
      },
    );
    return db;
  }
/////////////////////////////////////////////////////////////

  insertDB(CartProductModel dataCart) async {
    try {
      _database = await initilzeDatabase();

      await _database.insert(tableName, dataCart.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print(tableName);
    } catch (error) {
      throw 'database error $error';
    }
  }
/////////////////////////////////////////////////////////////

  Future<List<CartProductModel>> getAllProductDB() async {
    try {
      _database = await initilzeDatabase();
      List<Map> map = await _database.query(tableName);
      List<CartProductModel> list = map.isNotEmpty
          ? map.map((product) => CartProductModel.fromJson(product)).toList()
          : [];
      return list;
    } catch (error) {
      throw 'database error $error';
    }
  }
/////////////////////////////////////////////////////////////

  updateProduct(CartProductModel dataCart) async {
    try {
      _database = await initilzeDatabase();

      await _database.update(tableName, dataCart.toJson(),
          where: '$columnId = ?', whereArgs: [dataCart.productId]);
    } catch (error) {
      throw 'database error $error';
    }
  }
/////////////////////////////////////////////////////////////

  Future<int> deleteproduct(CartProductModel dataCart) async {
    try {
      _database = await initilzeDatabase();
      print(dataCart.productId);
      int rows = await _database.delete(tableName,
          where: '$columnId = ?', whereArgs: [dataCart.productId]);

      getAllProductDB();
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }
/////////////////////////////////////////////////////////////

  deleteproductAll() async {
    try {
      _database = await initilzeDatabase();
      await _database.delete(
        tableName,
      );
    } catch (error) {
      throw 'database error $error';
    }
  }
}
