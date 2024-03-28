import 'package:flutter/material.dart';

class NoteNotFoundWidget extends StatelessWidget {
  const NoteNotFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.note, size: 64), Text('Note Not Found')],
        ),
      ),
    );
  }
}
