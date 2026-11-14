import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';

class WriteContentPage extends StatefulWidget {
  const WriteContentPage({Key? key}) : super(key: key);

  @override
  State<WriteContentPage> createState() => _WriteContentPageState();
}

class _WriteContentPageState extends State<WriteContentPage> {
  final _controller = TextEditingController();

  String _textLink = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showEmptyWarning(BuildContext context) {
    showAppSnack(context, LocaleKeys.please_enter_text.tr(), error: true, icon: Icons.edit_off_rounded);
  }

  void _onShareAppLink(BuildContext context) async {
    _textLink = _controller.text;
    if (_textLink.trim().isNotEmpty) {
      await Share.share(_textLink);
    } else {
      _showEmptyWarning(context);
    }
  }

  void _onCopy(BuildContext context) {
    final text = _controller.text;
    if (text.trim().isEmpty) {
      _showEmptyWarning(context);
      return;
    }
    Clipboard.setData(ClipboardData(text: text));
    HapticFeedback.lightImpact();
    showAppSnack(context, LocaleKeys.copied.tr(), icon: Icons.content_copy_rounded);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.enter_your_text.tr()),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpace.xxl, AppSpace.s, AppSpace.xxl, 0),
              child: TextField(
                autofocus: true,
                expands: true,
                maxLines: null,
                minLines: null,
                controller: _controller,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: AppText.reading(18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: LocaleKeys.write_here.tr(),
                  hintStyle: AppText.reading(18).copyWith(color: AppColors.inkTertiary),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.line)),
            ),
            child: SafeArea(
              top: false,
              bottom: !keyboardOpen,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpace.l, 10, AppSpace.l, 10),
                child: Row(
                  children: [
                    TonalButton(
                      icon: Icons.content_copy_rounded,
                      label: LocaleKeys.copy.tr(),
                      onPressed: () => _onCopy(context),
                    ),
                    const SizedBox(width: AppSpace.s),
                    Expanded(
                      child: PrimaryButton(
                        icon: Icons.send_rounded,
                        label: LocaleKeys.share.tr(),
                        onPressed: () => _onShareAppLink(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
