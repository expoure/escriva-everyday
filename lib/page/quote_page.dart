import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/utils/Database.dart';
import 'package:flutter/material.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => new _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  Quote quote = new Quote(
      bookmarked: 0,
      bookName: '',
      chapterName: '',
      quote: '',
      id: 1,
      quoteNumber: '',
      readAt: DateTime.now());

  @override
  void initState() {
    super.initState();
    getQuote().then((value) => this.quote = value);
  }

  Future getQuote() async {
    var quote = await DataBaseHelper.db.getRandomQuote();
    return quote;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(this.quote.bookName,
                  style: TextStyle(fontFamily: 'Baskerville', fontSize: 16),
                  textAlign: TextAlign.end),
              SizedBox(height: 4),
              Text(
                this.quote.chapterName,
                style: TextStyle(fontFamily: 'Baskerville', fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                this.quote.quoteNumber,
                style: TextStyle(fontFamily: 'Baskerville', fontSize: 16),
              ),
              SizedBox(height: 24),
            ],
          ),
          Text(
            this.quote.quote,
            style: TextStyle(fontFamily: 'Baskerville', fontSize: 17),
          ),
        ],
      ),
    );
  }
}
