import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/components/note_not_found.dart';

import 'components/floating_button.dart';
import 'components/my_drawer.dart';
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
      floatingActionButton: const MyFloatingButton(),
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Hive App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            box.isEmpty
                ? const NoteNotFoundWidget()
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
