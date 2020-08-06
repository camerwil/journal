//created with assistance from class lectures
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'dropdown_rating_form_field.dart';
import 'package:journal/models/journal_entry.dart';

const SCHEMA_PATH = 'assets/schema.txt';

class JournalEntryForm extends StatefulWidget {
  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  JournalEntry formEntry = JournalEntry();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'Title', border: OutlineInputBorder()),
                        onSaved: (value) {
                          formEntry.setTitle(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a title';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: 10),
                    TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          formEntry.setDescription(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Description';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: 10),
                    DropdownRatingFormField(
                        maxRating: 4,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a rating';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          formEntry.setRating(value);
                        }),
                    SizedBox(height: 10),
                    RaisedButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            formEntry.setDate();
                            String schema =
                                await rootBundle.loadString(SCHEMA_PATH);
                            final Database database =
                                await openDatabase('journal.db', version: 1,
                                    onCreate: (Database db, int version) async {
                              await db.execute(schema);
                            });
                            await database.transaction((txn) async {
                              await txn.rawInsert(
                                  'INSERT INTO journal_entries(title, body, rating, date) VALUES(?,?,?,?)',
                                  [
                                    formEntry.title,
                                    formEntry.description,
                                    formEntry.rating,
                                    formEntry.date
                                  ]);
                            });
                            await database.close();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Save Entry'))
                  ],
                ))));
  }
}
