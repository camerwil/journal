import 'package:flutter/material.dart';
import 'package:journal/app.dart';

class SettingsDrawer extends StatefulWidget {
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    AppState appstate = context.findAncestorStateOfType<AppState>();

    return SafeArea(
        child: Drawer(
            child: ListView(children: [
      SizedBox(height: 50, child: DrawerHeader(child: Text('Settings'))),
      SwitchListTile(
          title: Text('Dark Theme'),
          value: appstate.isDark,
          onChanged: (bool value) {
            setState(() {
              appstate.updateTheme(value);
            });
          })
    ])));
  }
}
