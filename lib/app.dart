import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journal/screens/new_entry.dart';
import 'screens/main_screen.dart';
import 'screens/show_entry.dart';

class App extends StatefulWidget {
  final String title;
  static final routes = {
    MainScreen.routeName: (context) => MainScreen(),
    NewEntry.routeName: (context) => NewEntry(),
    ShowEntry.routeName: (context) => ShowEntry()
  };

  const App({Key key, this.title}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  bool isDark;

  void initState() {
    super.initState();
    isDark = false;
    initIsDark();
  }

  void initIsDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('isDark');
      if (isDark == null) isDark = false;
    });
  }

  void updateTheme(bool val) async {
    setState(() {
      isDark = val;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      routes: App.routes,
    );
  }
}
