import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/models/Setting.dart';
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

    String dbPathEnglish = path.join(applicationDirectory.path, "escriva.db");

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

  Future<Setting> getConfiguration() async {
    final db = await this.database;
    List<Map> settings = [];

    await db.transaction((txn) async {
      settings = await txn.query("settings", limit: 1);
    });

    return Setting.fromJson(settings.first as Map<String, dynamic>);
  }

  Future<void> updateNotificationTime(time) async {
    final db = await this.database;
    String timeFormmated = timeOfDayToString(time);
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'UPDATE settings set notifications = ?', ['$timeFormmated:00']);
    });
  }

  String timeOfDayToString(time) {
    var timeFormmated = time.toString();
    const start = "(";
    const end = ")";
    final startIndex = timeFormmated.indexOf(start);
    final endIndex = timeFormmated.indexOf(end, startIndex + start.length);
    timeFormmated =
        '${timeFormmated.substring(startIndex + start.length, endIndex)}';
    return timeFormmated;
  }

  Future<void> disableNotificationTime() async {
    final db = await this.database;
    await db.transaction((txn) async {
      await txn.rawUpdate('UPDATE settings set notifications = null');
    });
  }

  Future<Quote> getQuoteOfTheDay() async {
    final db = await this.database;
    List<Map> quotes = [];

    await verifyIfAllQuotesAreRead(db);

    String todayFormmatedDate = getTodayFormmatedDate();

    quotes = await getTodayQuoteIfExist(db, quotes, todayFormmatedDate);

    if (quotes.length == 0) {
      quotes = await getRandomQuoteAndSetAsRead(db, quotes, todayFormmatedDate);
    }

    return Quote.fromJson(quotes.first as Map<String, dynamic>);
  }

  Future<List<Map<dynamic, dynamic>>> getRandomQuoteAndSetAsRead(Database db,
      List<Map<dynamic, dynamic>> quotes, String todayFormmatedDate) async {
    await db.transaction((txn) async {
      quotes = await txn.query("quotes",
          orderBy: 'RANDOM()', limit: 1, where: 'read_at is null');
      await txn.rawUpdate('UPDATE quotes set read_at = ? where id = ?',
          [todayFormmatedDate, quotes.first["id"]]);
    });
    return quotes;
  }

  Future<List<Map<dynamic, dynamic>>> getTodayQuoteIfExist(Database db,
      List<Map<dynamic, dynamic>> quotes, String todayFormmatedDate) async {
    await db.transaction((txn) async {
      quotes = await txn.query("quotes",
          limit: 1, where: 'read_at = ?', whereArgs: [todayFormmatedDate]);
    });
    return quotes;
  }

  String getTodayFormmatedDate() {
    var date = DateTime.now();
    var dateFormmated =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
            .trim();
    return dateFormmated;
  }

  Future<Quote> getRandomQuote() async {
    final db = await this.database;
    List<Map> quotes = [];

    await db.transaction((txn) async {
      quotes = await txn.query("quotes",
          orderBy: 'RANDOM()', limit: 1, where: 'read_at is null');
    });
    return Quote.fromJson(quotes.first as Map<String, dynamic>);
  }

  Future<List<Quote>> getBookmarkedQuotes() async {
    final db = await this.database;
    List<Map> quotes = [];

    await db.transaction((txn) async {
      quotes =
          await txn.query('quotes', where: 'bookmarked = ?', whereArgs: [1]);
    });

    return quotes
        .map((quote) => Quote.fromJson(quote as Map<String, dynamic>))
        .toList();
  }

  Future<Quote> setBookmarkQuote(id, value) async {
    final db = await this.database;
    List<Map> quotes = [];

    await db.transaction((txn) async {
      await txn.rawUpdate(
          'UPDATE quotes set bookmarked = ? where id = ?', [value, id]);
      quotes = await txn.query('quotes', where: 'id = ?', whereArgs: [id]);
    });
    return Quote.fromJson(quotes.first as Map<String, dynamic>);
  }

  Future verifyIfAllQuotesAreRead(Database db) async {
    var nullQuotes;
    await db.transaction((txn) async {
      nullQuotes = await txn.rawQuery(
          'SELECT count(*) as count FROM quotes where read_at is null');
    });

    if (nullQuotes[0]['count'] == 0) {
      await db.transaction((txn) async {
        await txn.rawUpdate('UPDATE quotes set read_at = null');
      });
    }
  }
}
