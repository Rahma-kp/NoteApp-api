import 'package:flutter/material.dart';
import 'package:notesapp/controller/noteprovider.dart';
import 'package:provider/provider.dart';

class AddNotes extends StatelessWidget {
  AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            title: const Text(
              "Add Notes",
          style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
            )),
        body: Center(
            child: Card(
                color: Colors.black26,
                child: SizedBox(
                    height:400,
                    width: 400,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40, left: 40),
                            child: Consumer<NoteProvider>(builder: (context, value, child) => 
                               TextFormField(
                                controller:value.titlecontroller,
                                decoration: const InputDecoration(
                                  hintText: "Title",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Consumer<NoteProvider>(builder: (context, value, child) => 
                              TextFormField(
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
                          Consumer<NoteProvider>(builder: (context, value, child) => 
                             GestureDetector(
                              onTap: () async {
                                value.addNotes(context);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 35,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:  Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])))));
  }
}
