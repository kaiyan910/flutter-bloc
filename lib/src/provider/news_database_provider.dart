import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:io';
import 'dart:async';

import '../models/item.dart';

class NewsDatabaseProvider {

  Database database;

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

  Future<int> addItem(Item item) {

    return database.insert("items", item.toMap());
  }
}