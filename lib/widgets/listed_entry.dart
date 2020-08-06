import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/screens/show_entry.dart';

class ListedEntry extends StatefulWidget {
  final JournalEntry entry;

  ListedEntry(this.entry);

  @override
  _ListedEntryState createState() => _ListedEntryState();
}

class _ListedEntryState extends State<ListedEntry> {
  @override
  Widget build(BuildContext context) {
    final JournalEntry data = widget.entry;
    return ListTile(
        title: Text(data.title),
        subtitle: Text(data.date),
        onTap: () => Navigator.of(context)
            .pushNamed(ShowEntry.routeName, arguments: data));
  }
}
