import 'package:flutter/material.dart';
import 'package:projet/utils/note.model.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final Function()? onPressed;

  const NoteWidget({super.key, required this.note, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  note.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  MaterialLocalizations.of(context).formatShortDate(note.date),
                  style: TextStyle(color: Colors.grey[300]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  note.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
