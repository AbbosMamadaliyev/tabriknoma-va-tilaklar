import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ReadingSavedContent extends StatefulWidget {
  const ReadingSavedContent({Key? key}) : super(key: key);

  @override
  State<ReadingSavedContent> createState() => _ReadingSavedContentState();
}

class _ReadingSavedContentState extends State<ReadingSavedContent> {
  String _textLink = '';

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var index = args['index'];
    final favoriteCongratulations = args['favoriteCongratulations'];

    final congratulation = favoriteCongratulations[index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tilak, tabrik, sher'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Text(
            congratulation.content,
            style: const TextStyle(height: 1.3, fontSize: 18),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _textLink = congratulation.content;
          await Share.share(_textLink);
        },
        child: const Icon(Icons.send),
        backgroundColor: const Color(0xff378842),
      ),
    );
  }
}
