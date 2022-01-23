import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class WriteContentPage extends StatelessWidget {
  WriteContentPage({Key? key}) : super(key: key);

  final _controller = TextEditingController();
  String _textLink = '';

  void _onShareAppLink(BuildContext context) async {
    print(1);
    _textLink = _controller.text;
    if (_textLink.isNotEmpty) {
      print('text : ${_textLink}');
      await Share.share(_textLink);
      print(3);
    } else {
      const snackBar = SnackBar(
        content: Text('Iltimos matn kiriting!'),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabrik matningizni kiriting'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: TextField(
          expands: true,
          maxLines: null,
          minLines: null,
          controller: _controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Shu yerga yozing',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onShareAppLink(context);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.send),
      ),
    );
  }
}
