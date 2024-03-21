import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/home_page.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({
    super.key,
  });

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  // Map? noteMap;

  var box = Hive.box('note_box');

  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                String title = titleController.text;

                String detail = detailController.text;

                if (title.isEmpty || detail.isEmpty) {
                  print('Title or Details is missing');

                  //Showing alert snackbar

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Title or Details is missing')));
                } else {
                  Map newNote = {'title': title, 'detail': detail};
                  box.add(newNote);

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
              // onChanged: (String value) {
              //   noteMap?['title'] = value;
              // },
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                controller: detailController,
                // onChanged: (String value) {
                //   noteMap?['detail'] = value;
                // },
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
