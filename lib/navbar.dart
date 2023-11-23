import 'package:flutter/material.dart';
import 'package:projet/utils/db.util.dart';
import 'package:projet/utils/note.model.dart';
import 'package:projet/views/note.view.dart';
import 'package:projet/widget/loading.widget.dart';
import 'package:projet/widget/note.widget.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 4, 228, 161),
            ),
            child: FutureBuilder<List<Note>>(
                future: DB.instance.future,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const LoadingWidget();

                  List<Note> notes = snapshot.data ?? [];
                  return ListView.builder(
                    // padding: const EdgeInsets.only(
                    //     left: 10, top: 10, right: 10, bottom: 50),
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 15, vertical: 40),

                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      var note = notes[index];
                      return NoteWidget(
                        note: note,
                        onPressed: () => showNote(note),
                      );
                    },
                  );
                })));
  }

// Show note
  showNote(Note note) async {
    await push(NoteView(note: note));
    setState(() {});
  }

  //push View
  push(Widget view) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
}
