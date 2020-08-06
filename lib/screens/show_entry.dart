import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class ShowEntry extends StatelessWidget {
  static const routeName = 'entry';

  @override
  Widget build(BuildContext context) {
    final JournalEntry entry = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(entry.date.toString())),
      body: ListView(
        children: [
          Text(entry.title, style: Theme.of(context).textTheme.headline5),
          Text(entry.description, style: Theme.of(context).textTheme.subtitle1),
          Text('Rating: ' + entry.rating.toString())
        ],
      ),
    );
  }
}
