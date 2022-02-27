import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/utils/Database.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
    getQuote().then((value) => {
          setState(() {
            this.quote = value;
          })
        });
  }

  Future getQuote() async {
    var quote = await DataBaseHelper.db.getQuoteOfTheDay();
    return quote;
  }

  void _shareContent() {
    String shareQuote =
        '"${this.quote.quote.trimRight()}" \n\n (São Josemaría Escrivá, ${this.quote.bookName}, ${this.quote.quoteNumber})';
    Share.share(shareQuote);
  }

  void _bookmarkQuote(value) async {
    var quote = await DataBaseHelper.db.setBookmarkQuote(this.quote.id, value);
    setState(() {
      this.quote = quote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12.0, 20.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(this.quote.bookName,
                        style: TextStyle(
                            fontFamily: 'Baskerville',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.end),
                    SizedBox(height: 4),
                    Text(
                      this.quote.chapterName,
                      style: TextStyle(
                          fontFamily: 'Baskerville',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Text(
                      this.quote.quoteNumber,
                      style: TextStyle(
                          fontFamily: 'Baskerville',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Text(this.quote.quote,
                    style: TextStyle(fontFamily: 'Baskerville', fontSize: 17),
                    textAlign: TextAlign.justify),
              ),
              SizedBox(height: 48),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "share",
              backgroundColor: Color.fromRGBO(10, 30, 80, 1),
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () => this._shareContent(),
            ),
            SizedBox(width: 8),
            FloatingActionButton(
              heroTag: "bookmark",
              backgroundColor: Colors.red[900],
              child: Icon(
                this.quote.bookmarked == 0
                    ? Icons.favorite_border
                    : Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () => {
                if (this.quote.bookmarked == 0)
                  {this._bookmarkQuote(1)}
                else
                  {this._bookmarkQuote(0)}
              },
            ),
          ],
        ));
  }
}
