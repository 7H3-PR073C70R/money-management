class NoteField {
  static const id = '_id';
  static const title = 'title';
  static const text = 'text';
  static const date = 'date';
}

class Note {
  int? id;
  String? title;
  DateTime? date;
  String? text;


  Note(
      {
      this.id,
      this.title,
      this.date,
      this.text,});

  Note copyWith({
    int? id,
    String? title,
    String? text,
    DateTime? date,
  }) {
    return Note(
      id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        text: text ?? this.text);
  }

  Note fromJson(Map<String, dynamic> json) =>
     Note(
       id: json[NoteField.id],
      title: json[NoteField.title],
      date: DateTime.tryParse(json[NoteField.date]),
      text: json[NoteField.text],
    );
  

  Map<String, dynamic> toJson() => {
    NoteField.id: id,
    NoteField.title: title,
    NoteField.date: date!.toIso8601String(),
    NoteField.text: text,
  };

  final List<String> columns = [NoteField.id, NoteField.title, NoteField.text, NoteField.date,];
}
