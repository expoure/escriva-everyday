import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/utils/Database.dart';
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
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: [Text(this.quotes[index].bookName)],
                    ),
                    Column(
                      children: [Text(this.quotes[index].chapterName)],
                    )
                  ],
                ))));
  }
}
