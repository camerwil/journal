class JournalEntry {
  String title = 'blank title';
  String description = 'blank description';
  int rating;
  int id;
  String date;
  DateTime dateTime;
  JournalEntry(
      {this.title, this.description, this.rating, this.date, this.dateTime});

  setTitle(String title) {
    this.title = title;
  }

  setDescription(String description) {
    this.description = description;
  }

  setRating(int rating) {
    this.rating = rating;
  }

  void setDate() {
    this.date = DateTime.now().toString();
  }
}
