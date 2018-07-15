import 'package:sqflite/sqflite.dart'; // permanent storage
import 'package:path_provider/path_provider.dart'; // underlying filesystem -- mobile device temporary
import 'dart:io'; // filesystem
import 'package:path/path.dart'; // filesystem
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
          (
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
            descendant INTEGER
          )
        """);
      },
    );
  }

  fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  addItem(ItemModel item) {
    return db.insert('Items', item.toMapForDb());
  }
}
