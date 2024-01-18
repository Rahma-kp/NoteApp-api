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
            builder: (context) => AddNotes(),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Center(
          child: Consumer<NoteProvider>(
        builder: (context, value, child) => FutureBuilder(
            future: NotSevice().getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: value.noteList.length,
                  itemBuilder: (ctx, index) {
                    final data = value.noteList[index];
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit,
                                    color: Color.fromARGB(255, 81, 142, 83)),
                              ),
                              IconButton(
                                onPressed: () {value.deletNote(id: data.id);},
                                icon: const Icon(Icons.delete,
                                    color: Color.fromARGB(255, 175, 62, 54)),
                              ),
                            ],
                          ),
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
