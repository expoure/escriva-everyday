import 'package:escriva_everyday/models/Quote.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;


class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper db = DataBaseHelper._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await init();
    if (_db != null) {
      return _db!;
    }
    throw new Exception("Database not initialized");
  }

  Future<Database> init() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    String dbPathEnglish =
        path.join(applicationDirectory.path, "escriva.db");

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data = await rootBundle.load(path.join("assets", "escriva.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    var db = await openDatabase(dbPathEnglish);
    this._db = db;
    return db;
  }

  Future<void> getRandomQuote() async {
    final db = await this.database;
    List<Map> quotes = [];

    await db.transaction((txn) async {
      quotes = await txn.query(
        "quotes",
        limit: 1
      );
    });
    print(quotes.first);
    // return Quote.fromJson(quotes.first as Map<String, dynamic>);
  }
}
