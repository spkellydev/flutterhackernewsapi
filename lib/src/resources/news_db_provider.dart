import 'package:sqflite/sqflite.dart'; // permanent storage
import 'package:path_provider/path_provider.dart'; // underlying filesystem -- mobile device temporary
import 'dart:io'; // filesystem
import 'package:path/path.dart'; // filesystem
import 'dart:async' show Future;
import '../models/item_model.dart';
import 'repository.dart' show Source, Cache;

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
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

  // TODO - store and fetch top ids;
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
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

  Future<int> addItem(ItemModel item) {
    return db.insert('Items', item.toMapForDb());
  }
}

final newsDbProvider = NewsDbProvider();
