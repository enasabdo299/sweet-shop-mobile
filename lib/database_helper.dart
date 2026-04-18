import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sweetshop.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
////// هنا الجداول //
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      role TEXT NOT NULL
    );
  ''');

    await db.execute('''
    CREATE TABLE cart (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productId INTEGER,
      name TEXT,
      price REAL,
      quantity INTEGER,
      image TEXT
    );
  ''');

    await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productName TEXT,
            price TEXT,
            quantity TEXT,
            image TEXT
          )
        ''');
  }

  // Update email and password
  Future<int> insertOrUpdateUser(String email, String password, String role) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return await db.update(
        'users',
        {'password': password, 'role': role},
        where: 'email = ?',
        whereArgs: [email],
      );
    } else {
      return await db.insert(
        'users',
        {'email': email, 'password': password, 'role': role},
      );
    }
  }

  // ✅ New Method: Update User Credentials
  Future<int> updateUserCredentials(String oldEmail, String newEmail, String newPassword) async {
    final db = await database;

    return await db.update(
      'users',
      {
        'email': newEmail,
        'password': newPassword,
      },
      where: 'email = ?',
      whereArgs: [oldEmail],
    );
  }

  // Get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    return result.isNotEmpty ? result.first : null;
  }
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users'); // Retrieve all users from the users table
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<void> addToCart(Map<String, dynamic> product) async {
    final db = await database;
    await db.insert('cart', product, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return await db.query('cart');
  }

  Future<void> removeFromCart(int id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    return await db.insert(
      'products',
      product,
      conflictAlgorithm: ConflictAlgorithm.replace, // استبدال القيم إذا كانت موجودة
    );
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db.query('products');
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }


}
