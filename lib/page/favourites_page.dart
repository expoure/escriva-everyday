import 'package:escriva_everyday/models/Quote.dart';
import 'package:escriva_everyday/page/favourites_page_detailed.dart';
import 'package:escriva_everyday/utils/Database.dart';
import 'package:escriva_everyday/widget/search_widget.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => new _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<Quote> allQuotes = [];
  List<Quote> quotes = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    getQuotes().then((value) => {
          setState(() {
            this.allQuotes = value;
            this.quotes = value;
          })
        });
  }

  Future getQuotes() async {
    var quotes = await DataBaseHelper.db.getBookmarkedQuotes();
    return quotes;
  }

  void searchBook(String query) {
    final quotes = this.allQuotes.where((quote) {
      final chapterLower = quote.chapterName.toLowerCase();
      final quoteLower = quote.quote.toLowerCase();
      final bookLower = quote.bookName.toLowerCase();
      return chapterLower.contains(query.toLowerCase()) ||
          quoteLower.contains(query.toLowerCase()) ||
          bookLower.contains(query.toLowerCase());
    }).toList();
    print(query);
    setState(() {
      this.query = query;
      this.quotes = quotes;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Favoritos'),
          backgroundColor: Color.fromRGBO(10, 30, 80, 1),
          actions: [],
        ),
        body: this.allQuotes.length > 0
            ? Column(
                children: [
                  buildSearch(),
                  Expanded(
                      child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: this.quotes.length,
                    itemBuilder: (context, index) {
                      return this._quoteList(context, index);
                    },
                  )),
                ],
              )
            : Column(
                children: [
                  Image.asset('assets/escriva_pic.png'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Text(
                        'Cumpre o pequeno dever de cada momento; faz o que deves e está no que fazes.',
                        style: TextStyle(
                            fontFamily: 'Baskerville',
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.justify),
                  )
                ],
              ),
      );

  Widget buildSearch() =>
      SearchWidget(text: query, hintText: 'Pesquisar', onChanged: searchBook);

  _quoteList(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
          child: Column(
        children: [
          ListTile(
            title: Text(
                '"${this.quotes[index].quote.substring(0, this.quotes[index].quote.characters.take(40).length).trimRight()}..."',
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
                    body: FavouritesPageDetailed(quote: quote))))
        .then((value) => getQuotes().then((value) => {
              setState(() {
                this.allQuotes = value;
                var stillBookmarked = this
                    .allQuotes
                    .where((quoteContext) => quoteContext.id == quote.id);
                if (stillBookmarked.isEmpty) {
                  this.quotes.removeWhere((value) => value.id == quote.id);
                }
              })
            }));
  }
}
