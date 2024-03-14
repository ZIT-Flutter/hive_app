import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/home_page.dart';

class NewNotePage extends StatefulWidget {
  final Map? noteMap;

  const NewNotePage({super.key, this.noteMap});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  Map? noteMap;

  var box = Hive.box('note_box');

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (noteMap != null) {
      titleController.text = noteMap!['title'];
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (noteMap != null) {
                  box.add(noteMap);
                }
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              icon: const Icon(Icons.save))
        ],
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text('New Note'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
        ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onChanged: (String value) {
                noteMap?['title'] = value;
              },
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                onChanged: (String value) {
                  noteMap?['detail'] = value;
                },
                maxLines: 15,
                decoration: const InputDecoration(
                    hintText: 'Note', border: InputBorder.none),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
