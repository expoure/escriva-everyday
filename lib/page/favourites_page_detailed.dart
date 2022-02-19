import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/utils/Database.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class FavouritesPageDetailed extends StatefulWidget {
  Quote quote;
  FavouritesPageDetailed({required this.quote});

  @override
  _FavouritesPageDetailedState createState() =>
      new _FavouritesPageDetailedState();
}

class _FavouritesPageDetailedState extends State<FavouritesPageDetailed> {
  @override
  void initState() {
    super.initState();
  }

  void _shareContent() {
    String shareQuote =
        '"${widget.quote.quote.trimRight()}" \n\n (São Josemaría Escrivá, ${widget.quote.bookName}, ${widget.quote.quoteNumber})';
    Share.share(shareQuote);
  }

  void _bookmarkQuote(value) async {
    var quote =
        await DataBaseHelper.db.setBookmarkQuote(widget.quote.id, value);
    setState(() {
      widget.quote = quote;
    });
  }

  @override
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
                    Text(widget.quote.bookName,
                        style: TextStyle(
                            fontFamily: 'Baskerville',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.end),
                    SizedBox(height: 4),
                    Text(
                      widget.quote.chapterName,
                      style: TextStyle(
                          fontFamily: 'Baskerville',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.quote.quoteNumber,
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
                child: Text(widget.quote.quote,
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
                widget.quote.bookmarked == 0
                    ? Icons.favorite_border
                    : Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () => {
                if (widget.quote.bookmarked == 0)
                  {this._bookmarkQuote(1)}
                else
                  {this._bookmarkQuote(0)}
              },
            ),
          ],
        ));
  }
}
