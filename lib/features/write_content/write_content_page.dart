import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';

class WriteContentPage extends StatefulWidget {
  const WriteContentPage({Key? key}) : super(key: key);

  @override
  State<WriteContentPage> createState() => _WriteContentPageState();
}

class _WriteContentPageState extends State<WriteContentPage> {
  final _controller = TextEditingController();

  String _textLink = '';

  void _onShareAppLink(BuildContext context) async {
    _textLink = _controller.text;
    if (_textLink.isNotEmpty) {
      await Share.share(_textLink);
    } else {
      final snackBar = SnackBar(
        content: Text(LocaleKeys.please_enter_text.tr()),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(LocaleKeys.enter_your_text.tr()),
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
            hintText: LocaleKeys.write_here.tr(),
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
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }
}
