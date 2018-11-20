import 'package:news/src/provider/source_provider.dart';
import 'package:news/src/provider/cache_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:io';
import 'dart:async';

import '../models/item.dart';

class NewsDatabaseProvider implements SourceProvider, CacheProvider {

  Database database;


  NewsDatabaseProvider() {

    init();
  }

  void init() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "database.db");

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          """
          CREATE TABLE items(
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
          """
        );
      },
    );
  }

  @override
  Future<Item> fetchItem(int id) async {

    final maps = await database.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return Item.fromDatabase(maps.first);
    }

    return null;
  }

  @override
  Future<int> addItem(Item item) {

    return database.insert(
        "items",
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<int>> fetchTopIds() {

    return null;
  }

  @override
  Future<int> clear() {

    return database.delete("items");
  }
}

final newsDatabaseProvider = NewsDatabaseProvider();