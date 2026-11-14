import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/core/ui/reading_scaffold.dart';
import 'package:tabriklar/domain/models/happy_model.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';

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
    final List<String>? tableNames = args['tableNames'];

    final CongratulationsModel congratulation = favoriteCongratulations[index];
    final String? tableName = tableNames != null && index < tableNames.length ? tableNames[index] : null;

    return ReadingScaffold(
      title: LocaleKeys.saved.tr(),
      content: congratulation.content,
      saved: tableName == null ? null : congratulation.favourite == 1,
      onToggleSave: tableName == null
          ? null
          : () {
              final willSave = congratulation.favourite == 0;
              context
                  .read<DbServiceProver>()
                  .setFavourite(
                    model: CongratulationsModel(
                      id: congratulation.id,
                      content: congratulation.content,
                      favourite: willSave ? 1 : 0,
                    ),
                    tableName: tableName,
                  )
                  .then((_) {
                if (!mounted) return;
                setState(() => congratulation.favourite = willSave ? 1 : 0);
                showAppSnack(
                  context,
                  willSave ? LocaleKeys.added_to_saved.tr() : LocaleKeys.removed_from_saved.tr(),
                  icon: willSave ? Icons.bookmark_added_rounded : Icons.bookmark_remove_rounded,
                );
              });
            },
      onShare: () async {
        _textLink = congratulation.content;
        await Share.share(_textLink);
      },
    );
  }
}
