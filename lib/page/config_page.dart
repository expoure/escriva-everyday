import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => new _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  var isNotificationOn = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Color.fromRGBO(10, 30, 80, 1),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications, color: Colors.grey[600]),
                        SizedBox(width: 12),
                        Text('Notificações',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[900],
                            ),
                            textAlign: TextAlign.start),
                      ],
                    ),
                  ],
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    activeColor: Colors.blue,
                    trackColor: Colors.grey,
                    value: this.isNotificationOn,
                    onChanged: (bool newValue) {
                      setState(() {
                        this.isNotificationOn = !this.isNotificationOn;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time_rounded, color: Colors.grey[600]),
                SizedBox(width: 12),
                Text('Horário',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                    textAlign: TextAlign.start),
                // https://www.youtube.com/watch?v=qYHfI4br0ww
              ],
            ),
          ],
        ),
      ));
}
