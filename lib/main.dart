import 'package:flutter/material.dart';
import 'package:notesapp/controller/noteprovider.dart';
import 'package:notesapp/view/homescreen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ChangeNotifierProvider(create: (context) => NoteProvider(),)],
      child:  MaterialApp(debugShowCheckedModeBanner: false,
      home:HomeScreen(),
      ),
    );
  }
}