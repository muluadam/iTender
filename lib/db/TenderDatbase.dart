import 'dart:io';

import 'dart:async';
import 'dart:io';

import 'package:itenders/db/SavedTender.dart';
import 'package:itenders/model/ModelTender.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TenderDatabase {
  static final TenderDatabase _instance = TenderDatabase._();
  static Database _database;

  TenderDatabase._();

  factory TenderDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'itenderdb.db');
    var database = openDatabase(
        dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }


  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE itender (
ID	INTEGER PRIMARY KEY AUTOINCREMENT,
TENDER_ID	TEXT UNIQUE,
TENDER_NAME	TEXT,
ORGANIZATION	TEXT,
CPO	TEXT,
PHONE_NUMBER	TEXT,
POSTED_DATE_EC	TEXT,
POSTED_DATE_GC	TEXT,
DEADLINE_EC	TEXT,
DEADLINE_GC	TEXT,
SOURCE_NAME	TEXT,
CATEGORY TEXT,
PLACE_OF_WORK TEXT
)
    ''');
    print("Database was created!");
  }





  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

    Future<int> addTender(ModelTender  tender) async {
    var client = await db;
    return client.insert('itender', tender.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<ModelTender> fetchSavedTender(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps = client.query('itender', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return ModelTender.fromJson(maps.first);
    }

    return null;
  }
//  TenderDatabase database = new TenderDatabase();
//  List<ModelTender> tenders=  await database.fetchAll();
  Future<List<ModelTender>> fetchAll() async {
    var client = await db;
    var res = await client.query('itender');

    if (res.isNotEmpty) {
      var cars = res.map((carMap) => ModelTender.fromJson(carMap)).toList();
      return cars;
    }
    return [];
  }

  Future<int> updateSavedTender(SavedTender newCar) async {
    var client = await db;
    return client.update('itender', newCar.toMapForDb(),
        where: 'id = ?', whereArgs: [newCar.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeCar(int id) async {
    var client = await db;
    return client.delete('itender', where: 'id = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }



}