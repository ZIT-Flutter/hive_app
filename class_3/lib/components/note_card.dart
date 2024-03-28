import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../new_note_page.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
      {super.key,
      required this.noteMap,
      required this.index,
      required this.onDelete});

  final int index;
  final Map noteMap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('note_box');

    String title = noteMap['title'];
    String detail = noteMap['detail'];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteEditingPage(
              noteIndex: index,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('আপনি কি নিশ্চিত?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      box.deleteAt(index);
                                      onDelete();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes')),
                              ],
                            ));
                  },
                  icon: const Icon(
                    Icons.delete,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
