import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBTabungan {
  static Database? _database;

  // Membuat database dan tabel
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Path untuk database
    String path = join(await getDatabasesPath(), 'tabungan.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Membuat tabel Tabungan
        await db.execute(''' 
  CREATE TABLE tabungan(
    id_tabungan INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_tabungan TEXT,
    target_uang REAL,
    tanggal_mulai TEXT,
    tanggal_target TEXT,
    catatan TEXT
  )
''');
      },
    );
    return _database!;
  }

  // Menambahkan data tabungan
  Future<void> insertTabungan(Map<String, dynamic> tabungan) async {
    final db = await database;
    await db.insert(
      'tabungan',
      tabungan,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Mengambil semua data tabungan
  Future<List<Map<String, dynamic>>> getTabungan() async {
    final db = await database;
    return await db.query('tabungan');
  }

  // Menghapus data tabungan berdasarkan ID
  Future<void> deleteTabungan(int id) async {
    final db = await database;
    await db.delete(
      'tabungan',
      where: 'id_tabungan = ?',
      whereArgs: [id],
    );
  }

  // Mengupdate data tabungan berdasarkan ID
  Future<void> updateTabungan(int id, Map<String, dynamic> tabungan) async {
    final db = await database;
    await db.update(
      'tabungan',
      tabungan,
      where: 'id_tabungan = ?',
      whereArgs: [id],
    );
  }
}
