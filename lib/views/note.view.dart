import 'package:flutter/material.dart';
import 'package:projet/utils/db.util.dart';
import 'package:projet/utils/note.model.dart';
import 'package:projet/widget/loading.widget.dart';

class NoteView extends StatefulWidget {
  final Note? note;
  const NoteView({super.key, this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _contentCtrl = TextEditingController();

  //Is loading variable
  bool _isLoading = false;
  @override
  void initState() {
    //initialize Note Data
    _titleCtrl.text = widget.note?.title ?? '';
    _contentCtrl.text = widget.note?.content ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                  )),
              title: Text(
                MaterialLocalizations.of(context).formatShortDate(
                  widget.note?.date ?? DateTime.now(),
                ),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              actions: [
                widget.note == null
                    ? const SizedBox()
                    :

                    //Supprimer note
                    IconButton(
                        onPressed: delete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                //Enregistrer une note
                IconButton(
                  onPressed: () => {
                    save(),
                  },
                  icon: const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Titre :',
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    controller: _contentCtrl,
                    maxLength: 3000,
                    maxLines: 300,
                    decoration: const InputDecoration(
                      hintText: 'Contenu',
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
          );
  }

  //Save Note
  save() async {
    final note = Note(
      id: widget.note?.id,
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
    );
    setLoading(true);

    if (widget.note == null) {
      await insert(note);
    } else {
      await update(note);
    }
  }

  //Insert Note
  insert(Note note) async {
    await DB.instance.insert(note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  //update note
  update(Note note) async {
    await DB.instance.insert(note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  //Delete note
  delete() async {
    setLoading(true);
    await DB.instance.delete(widget.note!);
    if (!mounted) return;
    Navigator.pop(context);
  }

  setLoading([bool enabled = false]) {
    _isLoading = enabled;
    setState(() {});
  }
}
