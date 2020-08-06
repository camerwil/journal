import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class RightEntry extends StatelessWidget {
  final JournalEntry entry;

  RightEntry({this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
