import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

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
    var args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var index = args['index'];
    final favoriteCongratulations = args['favoriteCongratulations'];

    final congratulation = favoriteCongratulations[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tilak, tabrik, sher'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Text(
            congratulation.content,
            style: TextStyle(height: 1.3, fontSize: 18.sp),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _textLink = congratulation.content;
          await Share.share(_textLink);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.send,
          color: AppColors.green,
        ),
      ),
    );
  }
}
