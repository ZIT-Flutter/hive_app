import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;

  var box = Hive.box('name_box');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Text',
                    ),
                    onChanged: (String value) {
                      name = value;
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (name != null) {
                        box.add(name);
                        print('$name is Added into HiveBox');

                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    var name = box.getAt(index);

                    return Card(
                      child: Center(
                        child: Text('$name'),
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
