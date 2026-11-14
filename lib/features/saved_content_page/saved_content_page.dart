import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/themes/theme.dart';
import 'package:tabriklar/core/ui/app_ui.dart';
import 'package:tabriklar/domain/models/happy_model.dart';
import 'package:tabriklar/generated/locale_keys.g.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/view_models/database/db_service_provider.dart';
import 'package:tabriklar/view_models/db_table_model_provider/db_table_model_provider.dart';

class SavedContentPage extends StatefulWidget {
  const SavedContentPage({Key? key}) : super(key: key);

  @override
  _SavedContentPageState createState() => _SavedContentPageState();
}

class _SavedContentPageState extends State<SavedContentPage> {
  List<CongratulationsModel> favoriteCongratulations = [];

  /// Table of each item in [favoriteCongratulations] (same order).
  List<String> favoriteTables = [];

  bool _loading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    final service = context.read<DbServiceProver>();
    Future.wait([
      service.getFavoriteData('day'),
      service.getFavoriteData('birthday'),
      service.getFavoriteData('family'),
      service.getFavoriteData('mart8'),
      service.getFavoriteData('ramazan'),
      service.getFavoriteData('kurban'),
      service.getFavoriteData('love14'),
      service.getFavoriteData('friend'),
      service.getFavoriteData('january14'),
      service.getFavoriteData('girl'),
      service.getFavoriteData('teacher'),
    ]).whenComplete(() {
      if (mounted) setState(() => _loading = false);
    });
  }

  void addToList() {
    final service = context.watch<DbServiceProver>();
    favoriteCongratulations.clear();
    favoriteTables.clear();

    void add(List<CongratulationsModel> items, String table) {
      favoriteCongratulations.addAll(items);
      favoriteTables.addAll(List.filled(items.length, table));
    }

    add(service.days, 'day');
    add(service.families, 'family');
    add(service.birthdays, 'birthday');
    add(service.mart8, 'mart8');
    add(service.ramazans, 'ramazan');
    add(service.kurbans, 'kurban');
    add(service.love, 'love14');
    add(service.friend, 'friend');
    add(service.january14, 'january14');
    add(service.girlNames, 'girl');
    add(service.teachers, 'teacher');
  }

  @override
  Widget build(BuildContext context) {
    addToList();

    final categories = context.watch<CategoryModelProvider>().categories(context.locale.languageCode);
    final tables = context.watch<DbTableModelProvider>().dbTables;

    String categoryOf(String table) {
      final index = tables.indexWhere((t) => t.tableName == table);
      return index >= 0 && index < categories.length ? categories[index].category : '';
    }

    final Widget body;
    if (_loading && favoriteCongratulations.isEmpty) {
      body = ListView.separated(
        padding: const EdgeInsets.only(top: AppSpace.xs, bottom: AppSpace.xxl),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpace.l),
          child: SkeletonBox(height: 104),
        ),
      );
    } else if (favoriteCongratulations.isEmpty) {
      body = Center(
        child: SingleChildScrollView(
          child: AppEmptyState(
            icon: Icons.bookmark_border_rounded,
            title: LocaleKeys.saved_empty_title.tr(),
            message: LocaleKeys.saved_empty_desc.tr(),
          ),
        ),
      );
    } else {
      body = ListView.separated(
        padding: const EdgeInsets.only(top: AppSpace.xs, bottom: AppSpace.xxl),
        itemCount: favoriteCongratulations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return _SavedCard(
            label: categoryOf(favoriteTables[index]),
            content: favoriteCongratulations[index].content,
            onTap: () async {
              await Navigator.of(context).pushNamed(MainNavigationNames.readingFavorite, arguments: {
                'favoriteCongratulations': List<CongratulationsModel>.of(favoriteCongratulations),
                'index': index,
                'tableNames': List<String>.of(favoriteTables),
              });
              if (mounted) getData();
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.saved.tr()),
      ),
      body: body,
    );
  }
}

class _SavedCard extends StatelessWidget {
  const _SavedCard({required this.label, required this.content, required this.onTap});

  final String label;
  final String content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.l),
      child: Material(
        color: AppColors.fill,
        borderRadius: BorderRadius.circular(AppRadius.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.l, 14, AppSpace.m, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (label.isNotEmpty) ...[
                        Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppText.caption.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        greetingPreview(content),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.preview,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpace.s),
                const Icon(Icons.chevron_right_rounded, size: 22, color: AppColors.inkTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
