import 'package:flutter/material.dart';
import 'package:notesapp/model/notesmodel.dart';
import 'package:notesapp/sevrices/apiservices.dart';

class NoteProvider extends ChangeNotifier{
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController notecontroller=TextEditingController();
  List<NotesModel> noteList=[];
  fetchNote() async{
    try {
      List<NotesModel> notes= await NotSevice().getNotes();
      noteList=notes;
    } catch (error) {
       print('error loading notes:$error');
    }
    notifyListeners();
  }
  addNotes(BuildContext context) async {
  final name = titlecontroller.text;
  final note = notecontroller.text;
  NotSevice().addNotes(NotesModel(title: name, notes: note))
      .then((_) {
        fetchNote();
        Navigator.pop(context);
        notifyListeners();
      })
      .catchError((error) {
        print('Error adding notes: $error');
      });
}

  deletNote({required id})async{
    await NotSevice().deletNotes(id: id);
    fetchNote();
    notifyListeners();
  }

  updateNote({required id}){
   var editTitle=titlecontroller.text;
   var editNote=notecontroller.text;
   fetchNote();
   NotSevice().editNotes(value: NotesModel(title: editTitle, notes: editNote), id: id);
   notifyListeners();
  }
}