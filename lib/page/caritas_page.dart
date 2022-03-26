import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Text(
                  'Escreves-me: - \“Regra geral, os homens são pouco generosos com o seu dinheiro. Conversas, entusiasmos ruidosos, promessas, planos. À hora do sacrifício, são poucos os que "metem ombros\". E, se dão, há de ser com uma diversão de permeio - baile, bingo, cinema, coquetel - ou com anúncio e lista de donativos na imprensa\”. - O quadro é triste, mas tem exceções. Sê tu também dos que não deixam que a mão esquerda saiba o que faz a direita, quando dão esmola.',
                  style: TextStyle(
                      fontFamily: 'Baskerville',
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.justify),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
              child: Text(
                  '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nVocê é desenvolvedor e gostaria de contribuir com código ou UX? ',
                  style: TextStyle(fontFamily: 'Baskerville', fontSize: 14),
                  textAlign: TextAlign.justify),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
              child: new InkWell(
                  child: new Text('Visite o repositório no github',
                      style: TextStyle(
                          fontFamily: 'Baskerville',
                          fontSize: 14,
                          color: Colors.blue.shade900),
                      textAlign: TextAlign.left),
                  onTap: () =>
                      launch('https://github.com/expoure/escriva-everyday')),
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
