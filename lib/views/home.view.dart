import 'package:flutter/material.dart';
import 'package:projet/utils/db.util.dart';
import 'package:projet/utils/note.model.dart';
import 'package:projet/views/note.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: newNote,
        child: const Center(child: Icon(Icons.add_rounded)),
      ),
      body: const SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Ajouter une nouvelle note:',
                style: TextStyle(fontSize: 26, color: Colors.green),
              ),
            ),
          ),
        ],
      )),
    );
  }

  //New note
  newNote() async {
    await push(const NoteView());
    setState(() {});
  }

  // Show note
  showNote(Note note) async {
    await push(NoteView(note: note));
    setState(() {});
  }

  //delete note
  deleteNote(Note note) async {
    await DB.instance.delete(note);
    setState(() {});
  }

  //push View
  push(Widget view) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
}
