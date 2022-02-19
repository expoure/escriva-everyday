import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/page/favourites_page_detailed.dart';
import 'package:escriva_everyday/utils/Database.dart';
import 'package:escriva_everyday/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => new _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<Quote> quotes = [];

  @override
  void initState() {
    super.initState();
    getQuotes().then((value) => {
          setState(() {
            this.quotes = value;
          })
        });
  }

  Future getQuotes() async {
    var quotes = await DataBaseHelper.db.getBookmarkedQuotes();
    return quotes;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Color.fromRGBO(10, 30, 80, 1),
        actions: [],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: this.quotes.length,
        itemBuilder: (context, index) {
          print(this.quotes.length);
          return this._quoteList(context, index);
        },
      ));

  _quoteList(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
          child: Column(
        children: [
          ListTile(
            title: Text('"${this.quotes[index].quote.substring(0, 40)} ..."',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                )),
            subtitle: Text(
                '${this.quotes[index].bookName}, ${this.quotes[index].chapterName}, ${this.quotes[index].quoteNumber}',
                style: TextStyle(
                    fontFamily: 'Baskerville',
                    fontSize: 12,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.start),
            onTap: () => showFavouriteQuoteDetail(quote: this.quotes[index]),
          ),
        ],
      )),
    );
  }

  void showFavouriteQuoteDetail({required Quote quote}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Detalhe'),
                  backgroundColor: Color.fromRGBO(10, 30, 80, 1),
                ),
                body: FavouritesPageDetailed(quote: quote))));
  }
}
