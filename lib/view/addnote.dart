import 'package:flutter/material.dart';
import 'package:notesapp/controller/noteprovider.dart';
import 'package:provider/provider.dart';

class AddNotes extends StatefulWidget {
  String id;
  String title;
  String note;
  AddNotes({super.key,required this.id,required this.title,required this.note});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  void initState() {
    final editpro = Provider.of<NoteProvider>(context,listen: false);
    editpro.titlecontroller=TextEditingController(text: widget.title);
    editpro.notecontroller=TextEditingController(text: widget.note);
    super.initState();
  }
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            title: Text(
              isEdit ? "Add Notes" : "Edit Note",
              style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            )),
        body: Center(
            child: Card(
                color: Colors.black26,
                child: SizedBox(
                    height: 400,
                    width: 400,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40, left: 40),
                            child: Consumer<NoteProvider>(
                              builder: (context, value, child) => TextFormField(
                                controller: value.titlecontroller,
                                decoration: const InputDecoration(
                                  hintText: "Title",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Consumer<NoteProvider>(
                              builder: (context, value, child) => TextFormField(
                                controller: value.notecontroller,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  hintText: "Notes",
                                  prefixStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Consumer<NoteProvider>(
                            builder: (context, value, child) => GestureDetector(
                              onTap: () async {
                                isEdit
                                    ? value.addNotes(context)
                                    : value.updateNote(id:widget.id);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    isEdit ? "Add" : "Update",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])))));
  }
}
