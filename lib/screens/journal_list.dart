import 'package:flutter/material.dart';
import 'package:journal/widgets/horizontal_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:journal/widgets/settings_drawer.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/listed_entry.dart';
import 'package:journal/widgets/right_entry.dart';

const SCHEMA_PATH = 'assets/schema.txt';

class JournalList extends StatefulWidget {
  final String title;

  JournalList({Key key, this.title}) : super(key: key);

  @override
  JournalListState createState() => JournalListState();
}

class JournalListState extends State<JournalList> {
  Journal journal;

  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    String schema = await rootBundle.loadString(SCHEMA_PATH);
    final Database database = await openDatabase('journal.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(schema);
    });
    List<Map> journalRecords =
        await database.rawQuery('SELECT * FROM journal_entries');
    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
          title: record['title'],
          description: record['body'],
          rating: record['rating'],
          date: new DateFormat.yMMMMd('en_US')
              .format(DateTime.parse(record['date']))
              .toString());
    }).toList();
    setState(() {
      journal = Journal(entries: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (journal == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
              title: journal.entries.isEmpty
                  ? Text('Welcome')
                  : Text('Journal Entries'),
              actions: [
                Builder(
                    builder: (context) => IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () => Scaffold.of(context).openEndDrawer())),
              ]),
          endDrawer: SettingsDrawer(),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(NewEntry.routeName)
                    .then((_) => setState(() {
                          loadJournal();
                        }));
              }),
          body: LayoutBuilder(
            builder: layout,
          ));
    }
  }
}

Widget layout(BuildContext context, BoxConstraints contraints) =>
    contraints.maxWidth < 700 ? VerticalLayout() : HorizontalLayout();

class VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JournalListState listState =
        context.findAncestorStateOfType<JournalListState>();
    return Container(
      child: listState.journal.entries.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Icon(
                    Icons.book,
                    size: 100,
                  )
                ])
          : ListView.builder(
              itemCount: listState.journal.entries.length,
              itemBuilder: (context, index) {
                return Container(
                    child: ListedEntry(listState.journal.entries[index]));
              }),
    );
  }
}

class HorizontalLayout extends StatefulWidget {
  @override
  HorizontalLayoutState createState() => HorizontalLayoutState();
}

class HorizontalLayoutState extends State<HorizontalLayout> {
  JournalEntry rightEntry;

  void reload() {
    setState(() {
      //print(rightEntry.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    JournalListState listState =
        context.findAncestorStateOfType<JournalListState>();
    return Row(children: [
      Container(
        child: listState.journal.entries.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    Icon(
                      Icons.book,
                      size: 100,
                    )
                  ])
            : Flexible(
                child: ListView.builder(
                    itemCount: listState.journal.entries.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: HorizontalEntry(
                              listState.journal.entries[index]));
                    })),
      ),
      rightEntry == null
          ? Flexible(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Icon(
                    Icons.book,
                    size: 100,
                  ),
                  Text('Please select an Entry',
                      style: Theme.of(context).textTheme.subtitle2)
                ]))
          : Flexible(child: RightEntry(entry: rightEntry)),
    ]);
  }
}
