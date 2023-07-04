import 'package:food_ordering/common/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();
  Database? db;
  final String dbName = "food.db";
  final String tableName = "product";
  final String colId = "id";
  final String colName = "name";
  final String colPrice = "price";
  final String colQuantity = "quantity";
  final String colLike = "like";
  final String colImage = "image";

  Future<void> initDB() async {
    var directoryPath = await getDatabasesPath();
    String path = join(directoryPath,dbName);
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db,int version) async {
        String query = "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT ,$colName TEXT,$colPrice NUMERIC ,$colImage TEXT,$colQuantity INTEGER,$colLike TEXT)";
        await db.execute(query);
      }
    );
  }

  Future<int?> insertRecode({required Product data}) async {
    await initDB();
    String query = "INSERT INTO $tableName($colName,$colPrice,$colImage,$colQuantity,$colLike)VALUES(?,?,?,?,?)";
    List args = [
      data.name,
      data.price,
      data.image,
      data.quantity,
      data.like
    ];
    int? id = await db?.rawInsert(query,args);
    return id;
  }

  Future<List<Product>> fetchAllRecode() async {
    await initDB();
    String query = "SELECT * FROM $tableName";
    List<Map<String,dynamic>> data = await db!.rawQuery(query);
    List<Product> allProduct = data.map(
      (e) => Product.fromMap(data: e)
    ).toList();
    return allProduct;
  }

  Future<int> deleteRecode({required int id}) async {
    await initDB();
    String query = "DELETE FROM $tableName WHERE $colId=?";
    List args = [id];
    return db!.rawDelete(query,args);
  }

  Future<int> updateRecode({required Product data,required int id}) async {
    await initDB();
    String query = "UPDATE $tableName SET $colName=?, $colPrice=?, $colImage=?, $colQuantity=?, $colLike=? WHERE $colId=?";
    List args = [
      data.name,
      data.price,
      data.image,
      data.quantity,
      data.like,
      id
    ];
    return await db!.rawUpdate(query,args);
  }

  Future<List<Product>> fetchSearchedRecode({required String data}) async {
    await initDB();
    String query = "SELECT * FROM $tableName WHERE $colName LIKE '%$data'";
    List<Map<String,dynamic>> ProductData = await db!.rawQuery(query);
    List<Product> allProduct = ProductData.map(
      (e) => Product.fromMap(data: e)
    ).toList();
    return allProduct;
  }
}