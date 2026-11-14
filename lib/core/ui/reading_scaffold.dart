import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/data/singletons/storage.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';

/// Full-screen reader for one greeting / poem.
///
/// Bottom bar: [save] · [copy] · [Share ▸]. Text size is adjustable and remembered.
class ReadingScaffold extends StatefulWidget {
  const ReadingScaffold({
    super.key,
    required this.title,
    required this.content,
    required this.onShare,
    this.saved,
    this.onToggleSave,
    this.bannerAdUnitId,
  });

  final String title;
  final String content;
  final Future<void> Function() onShare;

  /// Null hides the save action.
  final bool? saved;
  final VoidCallback? onToggleSave;

  final String? bannerAdUnitId;

  @override
  State<ReadingScaffold> createState() => _ReadingScaffoldState();
}

class _ReadingScaffoldState extends State<ReadingScaffold> {
  static const double _minSize = 15;
  static const double _maxSize = 27;
  static const double _defaultSize = 19;

  late double _fontSize =
      StorageRepository.getDouble(StorageKeys.readingFontSize, defValue: _defaultSize).clamp(_minSize, _maxSize);

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.content));
    HapticFeedback.lightImpact();
    showAppSnack(context, LocaleKeys.copied.tr(), icon: Icons.content_copy_rounded);
  }

  void _openTextSize() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      barrierColor: Colors.black.withValues(alpha: 0.12),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpace.xxl, 0, AppSpace.xxl, AppSpace.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.text_size.tr(), style: AppText.title),
                    const SizedBox(height: AppSpace.l),
                    Row(
                      children: [
                        const Text('A', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        Expanded(
                          child: Slider(
                            value: _fontSize,
                            min: _minSize,
                            max: _maxSize,
                            divisions: ((_maxSize - _minSize) / 2).round(),
                            onChanged: (value) {
                              if (value == _fontSize) return;
                              HapticFeedback.selectionClick();
                              setState(() => _fontSize = value);
                              setSheetState(() {});
                            },
                            onChangeEnd: (value) {
                              StorageRepository.putDouble(StorageKeys.readingFontSize, value);
                            },
                          ),
                        ),
                        const Text('A', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final saved = widget.saved;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            onPressed: _openTextSize,
            tooltip: LocaleKeys.text_size.tr(),
            icon: const Icon(Icons.text_fields_rounded),
          ),
          const SizedBox(width: AppSpace.xs),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(AppSpace.xxl, AppSpace.s, AppSpace.xxl, AppSpace.xxxl),
        child: SelectableText(
          widget.content.trim(),
          style: AppText.reading(_fontSize),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.line)),
            ),
            child: SafeArea(
              top: false,
              bottom: widget.bannerAdUnitId == null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpace.s, 10, AppSpace.l, 10),
                child: Row(
                  children: [
                    if (saved != null)
                      StackedActionButton(
                        icon: saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        label: saved ? LocaleKeys.saved_one.tr() : LocaleKeys.save.tr(),
                        active: saved,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          widget.onToggleSave?.call();
                        },
                      ),
                    StackedActionButton(
                      icon: Icons.content_copy_rounded,
                      label: LocaleKeys.copy.tr(),
                      onTap: _copy,
                    ),
                    const SizedBox(width: AppSpace.s),
                    Expanded(
                      child: PrimaryButton(
                        icon: Icons.send_rounded,
                        label: LocaleKeys.share.tr(),
                        onPressed: widget.onShare,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.bannerAdUnitId != null) BottomBannerBar(adUnitId: widget.bannerAdUnitId!),
        ],
      ),
    );
  }
}
