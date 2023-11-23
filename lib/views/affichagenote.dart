import 'package:flutter/material.dart';
import 'package:projet/utils/db.util.dart';
import 'package:projet/utils/note.model.dart';
import 'package:projet/views/note.view.dart';
import 'package:projet/widget/loading.widget.dart';
import 'package:projet/widget/note.widget.dart';

class AffichageNote extends StatefulWidget {
  const AffichageNote({super.key});

  @override
  State<AffichageNote> createState() => _AffichageNote();
}

class _AffichageNote extends State<AffichageNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
            child: FutureBuilder<List<Note>>(
                future: DB.instance.future,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const LoadingWidget();

                  List<Note> notes = snapshot.data ?? [];
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
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

  //show note
  showNote(Note note) async {
    await push(NoteView(note: note));
    setState(() {});
  }

  //push View
  push(Widget view) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
}
