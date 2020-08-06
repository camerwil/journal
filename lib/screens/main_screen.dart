import 'package:flutter/material.dart';
import 'journal_list.dart';

class MainScreen extends StatelessWidget {
  final String title;
  final double padding = 20;
  static const routeName = '/';

  MainScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JournalList(title: 'Welcome');
  }
}
