import 'dart:async';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/servises/servise_prefs.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textcontoller = TextEditingController();
  bool isloading = true;
  List<Notes> list = [];
  List remover = [];
  bool selecting = false;
  bool mode = true;

  void _storeInfo() async {
    String notesContents = textcontoller.text.toString().trim();
    list.add(Notes(
      id: "151651546515",
      notesContent: notesContents,
      notesTime: DateTime.now().toString(),
      isSelected: false,
      isLigth: mode,
    ));
    loadInfo();

  }
 Future  <void> loadInfo() async {
String notes  =Notes.encode(list);
Prefs.storeNotes(notes);
list = Notes.decode(await Prefs.loadNotes() as String);
setState(() {
  isloading = false;
});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(milliseconds: 500),
            () => setState(() {
          isloading = false;
        }));
    loadInfo();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "notes".tr(),
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        actions: [
          selecting?IconButton(onPressed: (){
            for(int i = 0; i < list.length; i++){
              if(list[i].isSelected == true){
                list.remove(list[i]);
              }
           }
          }, icon: Icon(Icons.delete,color: Colors.blue,)):Container(height: 5,),
         //  IconButton(onPressed: (){
         //    setState(() {
         //     list[0].isLigth = !list[0].isLigth!;
         //    });
         //  }, icon:(list[0].isLigth == true)?Icon(Icons.nightlight_round,color: Colors.white,):Icon(Icons.wb_sunny,color: Colors.white,))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _notes(index);
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);

                        },
                        child: Text(
                          "cancel".tr(),
                        )),
                    TextButton(
                        onPressed: () {
                         _storeInfo();
                         Navigator.pop(context);
                         textcontoller.clear();

                          setState(() {

                          });
                          textcontoller.clear();
                        },
                        child: Text(
                          "save".tr(),
                        )),
                  ],
                  title: Text(
                    "new note".tr(),
                    style: TextStyle(color: Colors.grey),
                  ),
                  content: TextFormField(
                    controller: textcontoller,
                    decoration: InputDecoration(
                        hintText: 'enter your note'.tr(), border: InputBorder.none),
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _notes(int index) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: (BuildContext context) {
              list.removeAt(index);
              loadInfo();
              setState(() {});
            },
            icon: Icons.delete,
          ),
          SlidableAction(
              backgroundColor: Colors.blue,
              onPressed: (BuildContext context) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        title: Text(
                          "new note".tr(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        content: TextField(
                          controller: textcontoller..text = list[index].notesContent!,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "Enter your note!",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child:  Text(
                                "cancel".tr(),
                                style: TextStyle(
                                    color: Colors.greenAccent, fontSize: 16),
                              )),
                          TextButton(
                              onPressed: () {
                                list[index].notesContent = textcontoller.text;
                                list[index].notesTime = DateTime.now().toString();
                                loadInfo();
                                Navigator.pop(context);
                                textcontoller.clear();
                                setState(() {});
                              },
                              child: Text(
                                "save".tr(),
                                style: TextStyle(
                                    color: Colors.greenAccent, fontSize: 16),
                              )),
                        ],
                      );
                    });
              },
              icon: Icons.edit),
        ],
      ),
      child:ListTile(
        onLongPress: (){
          setState(() {
          });
         selecting = !selecting;
        },
        subtitle: Text(list[index].notesContent.toString(),style: TextStyle(fontSize: 15, color: Colors.black),),
        title: Text(list[index].notesTime!),
        trailing: selecting?IconButton(onPressed: (){setState(() {
          list[index].isSelected = !list[index].isSelected!;
        });} ,icon:list[index].isSelected==true? Icon(Icons.check_circle_outline_outlined):Icon(Icons.check_circle_sharp)):Container(height: 5,width: 5,),
        leading: Container(
          margin: EdgeInsets.all(15),
          child: CircleAvatar(
          radius: 5,

          backgroundColor: Colors.grey,
        ),),
      ),
    );
  }
}
