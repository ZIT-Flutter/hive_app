import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/new_note_page.dart';

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
            Expanded(
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    Map noteMap = box.getAt(index);

                    String title = noteMap['title'];
                    String detail = noteMap['detail'];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewNotePage(
                                      noteIndex: index,
                                    )));
                      },
                      child: Card(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
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
                                    box.deleteAt(index);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
