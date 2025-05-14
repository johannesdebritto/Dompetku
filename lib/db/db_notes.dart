import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBNotes {
  static Database? _database;

  // Inisialisasi database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Path untuk database
    String path = join(await getDatabasesPath(), 'notes.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Membuat tabel Notes
        await db.execute('''
          CREATE TABLE notes(
            id_noted INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT,
            isi_catatan TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  // Menambahkan catatan
  Future<void> insertNote(Map<String, dynamic> note) async {
    final db = await database;
    await db.insert(
      'notes',
      note,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Mengambil semua catatan
  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return await db.query('notes');
  }

  // Menghapus catatan berdasarkan ID
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete(
      'notes',
      where: 'id_noted = ?',
      whereArgs: [id],
    );
  }

  // Mengupdate catatan berdasarkan ID
  Future<void> updateNote(int id, Map<String, dynamic> note) async {
    final db = await database;
    await db.update(
      'notes',
      note,
      where: 'id_noted = ?',
      whereArgs: [id],
    );
  }
}
