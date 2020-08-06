import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_entry_form.dart';

class NewEntry extends StatelessWidget {
  static const routeName = 'Form';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Journal Entry'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                popForm(context);
              }),
        ),
        body: JournalEntryForm());
  }
}

void popForm(BuildContext context) {
  Navigator.of(context).pop();
}
