import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CaritasPage extends StatefulWidget {
  @override
  _CaritasPageState createState() => new _CaritasPageState();
}

class _CaritasPageState extends State<CaritasPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Deus Caritas Est'),
          backgroundColor: Color.fromRGBO(10, 30, 80, 1),
        ),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: TextStyle(fontFamily: 'Baskerville', fontSize: 17),
                  textAlign: TextAlign.justify),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Text(
                  'Este aplicativo foi desenvolvido utilizando como base o site escrivaworks, sob autorização da Fundação Studium.',
                  style: TextStyle(fontFamily: 'Baskerville', fontSize: 14),
                  textAlign: TextAlign.justify),
            ),
          ]),
        ),
      );
}
