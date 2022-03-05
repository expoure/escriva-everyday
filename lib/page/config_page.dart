import 'package:escriva_everyday/models/Setting.dart';
import 'package:escriva_everyday/utils/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => new _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  var isNotificationOn = true;
  TimeOfDay _time = TimeOfDay.now();
  Setting settings = new Setting(
      sulco: 1, forja: 1, caminho: 1, id: 1, notifications: TimeOfDay.now());

  @override
  void initState() {
    _time = TimeOfDay.now();
    super.initState();
    getSettings().then((value) => {
          setState(() {
            this.settings = value;
            if (this.settings.notifications != null) {
              _time = this.settings.notifications!;
              this.isNotificationOn = true;
            } else {
              this.isNotificationOn = false;
            }
          })
        });
  }

  Future getSettings() async {
    var settings = await DataBaseHelper.db.getConfiguration();
    return settings;
  }

  Future updateSetting() async {
    if (!this.isNotificationOn) {
      await DataBaseHelper.db.disableNotificationTime();
    } else {
      await this.updateNotificationTime(this._time);
    }
    return settings;
  }

  Future updateNotificationTime(time) async {
    var settings = await DataBaseHelper.db.updateNotificationTime(time);
    return settings;
  }

  Future disableNotificationTime() async {
    var settings = await DataBaseHelper.db.disableNotificationTime();
    return settings;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                        this.settings.notifications = null;
                        this.isNotificationOn = newValue;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.access_time_rounded,
                                  color: Colors.grey[600]),
                            ],
                          ),
                          SizedBox(width: 12),
                          Column(
                            children: [
                              Text('Horário',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[900],
                                  ),
                                  textAlign: TextAlign.start),
                              Text(
                                  DataBaseHelper.db
                                      .timeOfDayToString(this._time),
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ],
                      ),
                      onTap: _pickTime,
                    ),
                  ],
                ),
              ],
            ),
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
                Icons.save_rounded,
                color: Colors.white,
              ),
              onPressed: () => {
                    this.updateSetting(),
                    InAppNotification.show(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: [
                                const SizedBox(width: 4),
                                Image.asset(
                                  'assets/escriva_pic_profile_.png',
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('São Josemaria Escrivá:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.start),
                                      ],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                        'As configurações foram salvas, mas você ainda não. Sê santo!')
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        duration: Duration(seconds: 5),
                        context: context)
                  }),
        ],
      ));

  _pickTime() async {
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: _time,
        cancelText: 'CANCELAR',
        hourLabelText: 'Hora',
        minuteLabelText: 'Minuto',
        helpText: 'Selecione o horário');
    if (time != null) {
      setState(() {
        this.settings.notifications = time;
        this._time = time;
      });
    }
  }
}
