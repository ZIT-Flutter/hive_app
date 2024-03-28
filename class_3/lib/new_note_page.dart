import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/home_page.dart';

class NoteEditingPage extends StatefulWidget {
  final int? noteIndex;
  const NoteEditingPage({super.key, this.noteIndex});

  @override
  State<NoteEditingPage> createState() => _NoteEditingPageState();
}

class _NoteEditingPageState extends State<NoteEditingPage> {
  // Map? noteMap;

  var box = Hive.box('note_box');

  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.noteIndex != null) {
      Map myNote = box.getAt(widget.noteIndex!);

      titleController.text = myNote['title'];
      detailController.text = myNote['detail'];
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                String title = titleController.text;

                String detail = detailController.text;

                if (title.isEmpty || detail.isEmpty) {
                  //Showing alert snackbar
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Title or Details is missing')));
                } else {
                  Map newNote = {'title': title, 'detail': detail};

                  if (widget.noteIndex != null) {
                    box.putAt(widget.noteIndex!, newNote);
                  } else {
                    box.add(newNote);
                  }

                  print('New note added');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }
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
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                controller: detailController,
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
