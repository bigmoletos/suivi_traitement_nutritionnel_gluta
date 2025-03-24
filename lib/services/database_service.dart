import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/suivi_journalier.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('suivi_glutamine.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE suivi_journalier(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        poids REAL NOT NULL,
        tensionArterielle TEXT NOT NULL,
        etatDigestif TEXT NOT NULL,
        douleursArticulaires INTEGER NOT NULL,
        evolutionUlceration TEXT NOT NULL,
        priseGlutamine TEXT NOT NULL,
        effetsSecondaires TEXT,
        observations TEXT,
        petitDejeuner INTEGER NOT NULL,
        dejeuner INTEGER NOT NULL,
        collation INTEGER NOT NULL,
        diner INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertSuivi(SuiviJournalier suivi) async {
    final db = await database;
    return await db.insert(
      'suivi_journalier',
      suivi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SuiviJournalier>> getAllSuivis() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'suivi_journalier',
      orderBy: 'date DESC',
    );

    return List.generate(maps.length, (i) {
      return SuiviJournalier.fromMap(maps[i]);
    });
  }

  Future<SuiviJournalier?> getSuivi(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'suivi_journalier',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return SuiviJournalier.fromMap(maps.first);
  }

  Future<int> updateSuivi(SuiviJournalier suivi) async {
    final db = await database;
    return await db.update(
      'suivi_journalier',
      suivi.toMap(),
      where: 'id = ?',
      whereArgs: [suivi.id],
    );
  }

  Future<int> deleteSuivi(int id) async {
    final db = await database;
    return await db.delete(
      'suivi_journalier',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}