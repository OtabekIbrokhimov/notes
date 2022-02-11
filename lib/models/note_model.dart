import 'dart:convert';

class Notes {
  String? id;
  String? notesTime;
  String? notesContent;
  bool? isSelected;
  bool? isLigth;
  Notes({this.id,this.notesTime,this.notesContent,this.isSelected,this.isLigth});
Notes.fromJson(Map<dynamic,dynamic> json)
 : id = json["id"],
  notesTime = json['notesTime'],
  notesContent = json["notesContent"],
  isSelected = json['isSelected'],
  isLigth = json['isSelect'];
  Map<String,dynamic> toJson() => {
    'id':id,
    "notesTime": notesTime,
    'notesContent': notesContent,
    'isSelested': isSelected,
    'isLigth': isLigth,
  };

  static String encode(List<Notes> notes) => json.encode(
      notes.map<Map<dynamic, dynamic>>((note) => note.toJson()).toList());

  static List<Notes> decode(String notes) =>
      json.decode(notes).map<Notes>((item) => Notes.fromJson(item)).toList();
}