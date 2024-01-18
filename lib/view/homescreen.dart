import 'package:flutter/material.dart';
import 'package:notesapp/controller/noteprovider.dart';
import 'package:notesapp/sevrices/apiservices.dart';
import 'package:notesapp/view/addnote.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).fetchNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(137, 109, 108, 108),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Notes",
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNotes(id: '',note: '',title: ''),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Center(
          child: Consumer<NoteProvider>(
        builder: (context, pro, child) => FutureBuilder(
            future: NotSevice().getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: pro.noteList.length,
                  itemBuilder: (ctx, index) {
                    final data = pro.noteList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                          title: Text(
                            data.title ?? "title",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data.notes ?? 'description',
                            style: const TextStyle(fontSize: 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing:PopupMenuButton( onSelected: (value) {
                            if(value=="Edit"){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNotes(id:data.id??'',note:data.notes??'',title: data.title??'',),));
                            }else if(value=="Delete"){
                              pro.deletNote(id: data.id);
                            }
                          },
                          itemBuilder: (context) {
                            return[
                              PopupMenuItem(child: Text("Edit"),value:"Edit" ,),
                              PopupMenuItem(child: Text("Delete"),value: "Delete",)
                            ];
                          },) 
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Center(child: Text('Data is not available'));
              }
            }),
      )),
    ));
  }
}
