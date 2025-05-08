import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBTransaksi {
  static Database? _database;

  // Membuat database dan tabel
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Path untuk database
    String path = join(await getDatabasesPath(), 'transaksi.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Membuat tabel Pemasukan
        await db.execute('''
          CREATE TABLE pemasukan(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tanggal TEXT,
            waktu TEXT,
            uang_masuk REAL,
            maggot_terjual_kg REAL,
            keterangan TEXT
          )
        ''');

        // Membuat tabel Pengeluaran
        await db.execute('''
          CREATE TABLE pengeluaran(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tanggal TEXT,
            waktu TEXT,
            nominal_pengeluaran REAL,
            keterangan TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  // Menambahkan data pemasukan
  Future<void> insertPemasukan(Map<String, dynamic> pemasukan) async {
    final db = await database;
    await db.insert(
      'pemasukan',
      pemasukan,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Menambahkan data pengeluaran
  Future<void> insertPengeluaran(Map<String, dynamic> pengeluaran) async {
    final db = await database;
    await db.insert(
      'pengeluaran',
      pengeluaran,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Mengambil semua data pemasukan
  Future<List<Map<String, dynamic>>> getPemasukan() async {
    final db = await database;
    return await db.query('pemasukan');
  }

  // Mengambil semua data pengeluaran
  Future<List<Map<String, dynamic>>> getPengeluaran() async {
    final db = await database;
    return await db.query('pengeluaran');
  }

  // Menghapus data pemasukan berdasarkan ID
  Future<void> deletePemasukan(int id) async {
    final db = await database;
    await db.delete(
      'pemasukan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Menghapus data pengeluaran berdasarkan ID
  Future<void> deletePengeluaran(int id) async {
    final db = await database;
    await db.delete(
      'pengeluaran',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
