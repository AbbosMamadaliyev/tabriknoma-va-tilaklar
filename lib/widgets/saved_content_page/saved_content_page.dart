import 'package:flutter/material.dart';

class SavedContentPage extends StatefulWidget {
  const SavedContentPage({Key? key}) : super(key: key);

  @override
  _SavedContentPageState createState() => _SavedContentPageState();
}

class _SavedContentPageState extends State<SavedContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saqlanganlar'),
      ),
    );
  }
}
