import 'package:escriva_everyday/models/Quote.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;


class DictionaryDataBaseHelper {
  late Database _db;

  Future<void> init() async {
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

    this._db = await openDatabase(dbPathEnglish);
  }

  /// get all the words from english dictionary
  Future<void> getRandomQuote() async {
    if (_db == null) {
      throw "bd is not initiated, initiate using [init(db)] function";
    }
    List<Map> quotes = [];

    await _db.transaction((txn) async {
      quotes = await txn.query(
        "quotes",
        limit: 1
      );
    });
    print(quotes.first);
    // return Quote.fromJson(quotes.first as Map<String, dynamic>);
  }
}
