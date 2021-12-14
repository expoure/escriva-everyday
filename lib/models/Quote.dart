import 'dart:convert';

class Quote {
  Quote({
    required this.id,
    required this.bookName,
    required this.chapterName,
    required this.quoteNumber,
    required this.bookmarked,
    required this.readAt,
  });

  int id;
  String bookName;
  String chapterName;
  String quoteNumber;
  bool bookmarked;
  DateTime readAt;

  factory Quote.fromRawJson(String str) => Quote.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    id: json["id"] as int,
    bookName: json["book_name"] as String,
    chapterName: json["chapter_name"] as String,
    quoteNumber: json["quote_number"] as String,
    bookmarked: json["bookmarked"] as bool,
    readAt: new DateTime(json["read_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_name": bookName,
    "chapter_name": chapterName,
    "quote_number": quoteNumber,
    "bookmarked": bookmarked,
    "read_at": readAt,
  };
}