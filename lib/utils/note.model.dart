class Note {
  String? _id;
  String title;
  String content;
  DateTime? _date;

  Note({
    this.title = '',
    this.content = '',
    String? id,
    DateTime? date,
  }) {
    _id = id ?? generateID;
    _date = date ?? dateNow;
  }

  //Create instance of Json
  factory Note.ofJson(Map<String, dynamic> map) => Note(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        date: DateTime.tryParse(map['date'].toString()),
      );

  //Convert Instance to Json
  Map<String, dynamic> get json => {
        'id': id,
        'title': title,
        'content': content,
        'date': date.toString(),
      };

  //Getters

  //ID
  String get id => _id ??= generateID;
  //Date
  DateTime get date => _date ??= dateNow;

  //generateID
  String get generateID => dateNow.millisecondsSinceEpoch.toString();

  //DateNow
  DateTime get dateNow => DateTime.now();
}
