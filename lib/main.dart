import 'package:escriva_everyday/page/quote_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:escriva_everyday/widget/navigation_drawer_widget.dart';
import 'package:in_app_notification/in_app_notification.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Ponto do dia';

  @override
  Widget build(BuildContext context) => InAppNotification(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MainPage(),
          //   darkTheme: ThemeData(
          //     brightness: Brightness.dark,
          //     /* dark theme settings */
          //   ),
          //   themeMode: ThemeMode.light,
          //   /* ThemeMode.system to follow system theme,
          //    ThemeMode.light for light theme,
          //    ThemeMode.dark for dark theme
          // */
        ),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(MyApp.title),
        backgroundColor: Color.fromRGBO(10, 30, 80, 1),
      ),
      body: QuotePage());
}
