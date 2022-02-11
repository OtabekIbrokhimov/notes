import 'dart:convert';

import 'package:notes/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Prefs{
  static  storeNotes(list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notes', list);
  }

  static Future<String?> loadNotes()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('notes');
  }
}