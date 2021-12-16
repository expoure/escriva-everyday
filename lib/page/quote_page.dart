import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/utils/Database.dart';
import 'package:flutter/material.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => new _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  Quote quote = new Quote(bookmarked: false, bookName: '', chapterName: '', id: 1, quoteNumber: '', readAt: DateTime.now()); 

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  Future getQuote() async {
    await DataBaseHelper.db.getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

     );
  }
}