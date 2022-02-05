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
      );
}
