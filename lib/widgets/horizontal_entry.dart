import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/screens/journal_list.dart';

class HorizontalEntry extends StatefulWidget {
  final JournalEntry entry;

  HorizontalEntry(this.entry);

  @override
  _HorizontalEntryState createState() => _HorizontalEntryState();
}

class _HorizontalEntryState extends State<HorizontalEntry> {
  @override
  Widget build(BuildContext context) {
    final JournalEntry data = widget.entry;
    return ListTile(
        title: Text(data.title),
        subtitle: Text(data.date),
        onTap: () => updateRight(context, widget.entry));
  }
}

void updateRight(BuildContext context, JournalEntry entry) {
  HorizontalLayoutState horizState =
      context.findAncestorStateOfType<HorizontalLayoutState>();

  horizState.rightEntry = entry;
  horizState.reload();
}
