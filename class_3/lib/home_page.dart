import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/new_note_page.dart';

import 'components/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var box = Hive.box('note_box');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber, shape: const CircleBorder()),
        child: const Icon(
          Icons.add,
          color: Colors.pink,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewNotePage()));
        },
      ),
      appBar: AppBar(
        title: const Text("Hive App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            box.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note, size: 64),
                          Text('Note Not Found')
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          Map noteMap = box.getAt(index);
                          return NoteCard(
                            noteMap: noteMap,
                            index: index,
                            onDelete: () {
                              setState(() {});
                            },
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
